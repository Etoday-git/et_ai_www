<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Api_model extends ETD_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
        $this->load->model('Krx_model');
    }

    public function get_corp_name($corp_name) {
        $like = $this->db->escape('%'.$corp_name.'%');      // SQL 인젝션 방지용

        $sql = "
            SELECT *
            FROM (
                SELECT t.*,
                    ROW_NUMBER() OVER (PARTITION BY t.corp_name ORDER BY t.corp_code DESC) AS rn
                FROM MART_CORP_NAME_MAP t
                WHERE (t.corp_name LIKE {$like}
                    OR JSON_SEARCH(t.corp_same_name, 'one', {$like}) IS NOT NULL)
            ) ranked
            WHERE rn = 1
            ORDER BY corp_name ASC
            LIMIT 20
        ";

        $query = $this->db->query($sql);
        return $query->result_array();        
    }

    public function get_governance_graph_list($limit)
    {
        $sub = $this->db->select("corp_code, MAX(CONCAT(rcept_dt, '-', rcept_no)) AS max_key", false)
            ->from('MART_DISCLOSURE_SEARCH')
            ->where_in('corp_cls', ['Y','K'])
            ->group_by('corp_code')
            ->get_compiled_select();

        $this->db->select('m.*')
                ->from('MART_DISCLOSURE_SEARCH as m')
                ->join("($sub) x", "x.corp_code = m.corp_code AND x.max_key = CONCAT(m.rcept_dt, '-', m.rcept_no)", 'inner', false)
                ->order_by('m.rcept_dt', 'DESC')
                ->order_by('m.rcept_no', 'DESC')
                ->limit($limit);
        
        $query = $this->db->get();
        return $query->result_array();
    }
    
    public function get_in_corp_list($corp_code, $page_count, $detail_flag)
    {
        $codes = is_array($corp_code) ? array_values(array_filter($corp_code)) : array_filter([$corp_code]);
        if (empty($codes)) return [];

        $in = implode(',', array_fill(0, count($codes), '?'));  // SQL 인젝션 방지용

        $limit_small = ($detail_flag === 'Y') ? '' : 'WHERE rn6 <= 6';
        $limit_big   = ($detail_flag === 'Y') ? '' : 'LIMIT 5';

        $small_holder_query = "
                        SELECT *                
                        FROM (
                        WITH base AS (
                            SELECT h.*
                            FROM MART_CORP_HOLDER h
                            WHERE h.corp_code IN ($in)
                            AND h.holder_type = '특수관계인'
                        ),
                        ranked AS (
                            SELECT
                            b.*,
                            ROW_NUMBER() OVER (
                                PARTITION BY b.corp_code, b.nm
                                ORDER BY b.rcept_no DESC, CAST(b.stkrt AS DECIMAL(20,6)) DESC
                            ) AS rn_nm,
                            ROW_NUMBER() OVER (
                                PARTITION BY b.corp_code
                                ORDER BY b.rcept_no DESC, CAST(b.stkrt AS DECIMAL(20,6)) DESC
                            ) AS rn_corp
                            FROM base b
                        ),
                        latest AS (
                            SELECT corp_code, holder_type, MAX(rcept_no) AS max_rcept_no
                            FROM base
                            GROUP BY corp_code, holder_type
                        ),
                        picked AS (
                            SELECT r.*
                            FROM ranked r
                            JOIN latest l
                            ON l.corp_code    = r.corp_code
                            AND l.holder_type  = r.holder_type
                            AND l.max_rcept_no = r.rcept_no
                        ),
                        capped AS (
                            SELECT
                            p.*,
                            ROW_NUMBER() OVER (
                                PARTITION BY p.corp_code
                                ORDER BY CAST(REPLACE(p.stkqy, ',', '') AS UNSIGNED) DESC,
                                        p.rcept_no DESC,
                                        p.dm_id DESC
                            ) AS rn6
                            FROM picked p
                        )
                        SELECT
                            c.*,
                            nmmap.corp_name AS _corp_name,
                            nmmap.corp_code AS _corp_code,
                            cls.corp_cls    AS _corp_cls
                        FROM capped c
                        LEFT JOIN MART_CORP_NAME_MAP nmmap
                            ON JSON_CONTAINS(CAST(nmmap.corp_same_name AS JSON), JSON_QUOTE(c.nm))
                        LEFT JOIN STG_OP_DA_AP_1_2 cls
                            ON cls.corp_code = nmmap.corp_code
                        $limit_small AND (cls.corp_cls IS NULL OR cls.corp_cls <> 'E')  -- 기타 주식은 제외
                        ) AS x
                        ORDER BY x.corp_code,
                        CAST(REPLACE(x.stkqy, ',', '') AS UNSIGNED) DESC,
                        x.rcept_no DESC;
            ";
        $sql = $this->db->query($small_holder_query, $codes);
        $small_holder_list = $sql->result_array();

        if (!empty($small_holder_list)) {
            $rcept_list = array_values(array_unique(array_column($small_holder_list, 'rcept_no')));

            foreach ($rcept_list as $rcept_no) {
                $big_holder_list = $this->db->query("
                    SELECT a.rcept_no, a.corp_code, a.corp_name, a.stkqy, a.stkrt, a.repror AS nm, nmmap.corp_code AS _corp_code,
                            cls.corp_cls AS _corp_cls, IF(c.corp_code IS NULL, 'N', 'Y') AS gongsi_fg, '대주주' AS holder_type
                    FROM MART_BIG_MAJOR_HOLDER AS a
                    LEFT JOIN MART_CORP_NAME_MAP AS nmmap
                    ON JSON_CONTAINS(CAST(nmmap.corp_same_name AS JSON), JSON_QUOTE(a.repror))
                    LEFT JOIN STG_OP_DA_AP_1_2 AS cls
                    ON cls.corp_code = nmmap.corp_code
                    LEFT JOIN STG_OP_DA_AP_1_1 AS c
                    ON c.corp_code = nmmap.corp_code
                    WHERE a.rcept_no = '".$rcept_no."'
                    GROUP BY a.repror
                    {$limit_big}
                ");
                $small_holder_list = array_merge($small_holder_list, $big_holder_list->result_array());
            }
        }
        return $small_holder_list;        
    }

    public function get_out_corp_list($corp_code, $page_count, $detail_flag)
    {
        $codes = is_array($corp_code) ? array_values(array_filter($corp_code)) : array_filter([$corp_code]);
        if (empty($codes)) return [];
        $in = implode(',', array_fill(0, count($codes), '?'));  // SQL 인젝션 방지용
        $limit = ($detail_flag === 'Y') ? '' : 'WHERE rn_amt <= 10';

        $sql = "
            WITH base AS (
                SELECT
                    a.rcept_no,
                    a.corp_code,
                    a.corp_name,
                    a.frst_acqs_de,
                    a.trmend_blce_qy,
                    a.recent_bsns_year_fnnr_sttus_tot_assets,
                    a.recent_bsns_year_fnnr_sttus_thstrm_ntpf,
                    a.corp_cls,
                    a.inv_prm,
                    a.invstmnt_purps,
                    a.stlm_dt,
                    a.trmend_blce_acntbk_amount,
                    a.trmend_blce_qota_rt,
                    a.inv_corp_code  AS _corp_code,
                    a.inv_corp_name  AS _corp_name,
                    a.inv_corp_cls   AS _corp_cls,
                    CAST(REGEXP_REPLACE(a.trmend_blce_acntbk_amount, '[^0-9-]', '') AS SIGNED) AS trmend_amt_num,
                    CAST(REGEXP_REPLACE(a.frst_acqs_amount,          '[^0-9-]', '') AS SIGNED) AS frst_amt_num,
                    CASE
                        WHEN a.trmend_blce_qota_rt IS NULL OR a.trmend_blce_qota_rt IN ('','-')
                            THEN NULL
                        ELSE CAST(REGEXP_REPLACE(a.trmend_blce_qota_rt, '[^0-9.]', '') AS DECIMAL(10,4))
                    END AS qota_rt_num
                FROM MART_CORP_OWNERSHIP a
                WHERE a.corp_code IN ($in)
                AND (
                        CAST(REGEXP_REPLACE(a.trmend_blce_acntbk_amount, '[^0-9]', '') AS UNSIGNED) > 0
                    OR (
                            (a.trmend_blce_acntbk_amount IS NULL OR a.trmend_blce_acntbk_amount = '')
                        AND CAST(REGEXP_REPLACE(a.frst_acqs_amount, '[^0-9]', '') AS UNSIGNED) > 0
                        )
                )
            ),
            dedup AS (
                SELECT
                    b.*,
                    ROW_NUMBER() OVER (
                        PARTITION BY b.corp_code, b.inv_prm
                        ORDER BY b.rcept_no DESC
                    ) AS rn_invest
                FROM base b
            ),
            latest_rcept AS (
                SELECT corp_code, MAX(rcept_no) AS max_rcept_no
                FROM base
                GROUP BY corp_code
            ),
            picked AS (
                SELECT
                    d.*,
                    ROW_NUMBER() OVER (
                        PARTITION BY d.corp_code
                        ORDER BY d.trmend_amt_num DESC, d.rcept_no DESC
                    ) AS rn_amt
                FROM dedup d
                JOIN latest_rcept l
                ON l.corp_code    = d.corp_code
                AND l.max_rcept_no = d.rcept_no
                WHERE d.rn_invest = 1
            )
                SELECT * FROM picked 
                $limit
                ORDER BY corp_code DESC,
                CAST(REGEXP_REPLACE(trmend_blce_acntbk_amount, '[^0-9]', '') AS UNSIGNED) DESC,
                rcept_no DESC;
        ";

        $query = $this->db->query($sql, $codes);
        return $query->result_array();
    }

    public function get_ifCorpCompanyProfile($corp_code)
    {
        $this->db->select("*");
        $this->db->from('MART_CORP_INFO_BASE');
        $this->db->where_in('corp_code', $corp_code);

        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_ifCorpExecutive_mideungi_count($corp_code)
    {
        $this->db->select('nmpr AS mideungi_count');
        $this->db->from('STG_OP_DA_AP_2_24 a');
        $this->db->where('a.corp_code', $corp_code);
        $this->db->where('a.nmpr <>', '-');
        $this->db->where('a.rcept_no = (
            SELECT MAX(rcept_no)
            FROM STG_OP_DA_AP_2_24
            WHERE corp_code = ' . $this->db->escape($corp_code) . '
        )');

        $query = $this->db->get();
        $row = $query->row();
        
        if (!$row || !isset($row->mideungi_count)) {
            return 0;
        }

        return $row->mideungi_count;
    }

    public function get_ifCorpExecutive($corp_code)
    {
        $corp_code = trim((string)$corp_code);
        if (!preg_match('/^\d{5,12}$/', $corp_code)) {
            return [];
        }

        $sub = $this->db->select('MAX(rcept_no)', false)
                    ->from('MART_CORP_EXECUTIVE')
                    ->where('corp_code', $corp_code)
                    ->get_compiled_select();

                $this->db->select("a.*, a.hffc_pd AS tenure_start_on", false);
                $this->db->from('MART_CORP_EXECUTIVE AS a');
                $this->db->where('a.corp_code', $corp_code);
                $this->db->where_not_in('a.rgist_exctv_at', ['미등기', '미등기임원']);
                $this->db->where("a.rcept_no = ($sub)", null, false);
                $this->db->order_by('a.rgist_exctv_at', 'ASC');

        $query = $this->db->get();
        return $query->result_array();  
    }

    public function get_ifCorpMajorShareholders($corp_code)
    {        
        $codes = is_array($corp_code) ? array_values(array_filter($corp_code)) : array_filter([$corp_code]);
        if (empty($codes)) return [];
        $in = implode(',', array_fill(0, count($codes), '?'));  // SQL 인젝션 방지용
      
        $sql = "         
                WITH latest AS (
                    SELECT
                        corp_code,
                        MAX(CAST(rcept_no AS UNSIGNED)) AS latest_rcept_no
                    FROM MART_CORP_MAJOR_SHAREHOLDERS
                    WHERE corp_code IN ($in)
                    GROUP BY corp_code
                    ),
                    ranked AS (
                    SELECT
                        a.*,
                        ROW_NUMBER() OVER (
                            PARTITION BY a.corp_code, a.rcept_no
                            ORDER BY CAST(REPLACE(a.trmend_posesn_stock_co, ',', '') AS DECIMAL(32,8)) DESC, a.nm ASC
                        ) AS rn
                    FROM MART_CORP_MAJOR_SHAREHOLDERS a
                    JOIN latest l
                        ON a.corp_code = l.corp_code
                    AND CAST(a.rcept_no AS UNSIGNED) = l.latest_rcept_no
                    )
                    SELECT *
                    FROM ranked
                    WHERE rn <= 4
                    ORDER BY
                    corp_code,
                    CAST(REPLACE(trmend_posesn_stock_co, ',', '') AS DECIMAL(32,8)) DESC;        
                ";

        $query = $this->db->query($sql, $codes);
        return $query->result_array();
    }

    public function get_ifCorpCrossOwnership($corp_code)
    {
        $sql = "WITH base AS (
                    SELECT
                        a.rcept_no,
                        a.corp_code,
                        a.corp_name,
                        a.frst_acqs_de,
                        a.trmend_blce_qy,
                        a.recent_bsns_year_fnnr_sttus_tot_assets,
                        a.recent_bsns_year_fnnr_sttus_thstrm_ntpf,
                        a.corp_cls,
                        a.inv_prm,
                        a.invstmnt_purps,
                        a.stlm_dt,
                        a.trmend_blce_acntbk_amount,
                        a.trmend_blce_qota_rt,
                        CAST(REGEXP_REPLACE(a.trmend_blce_acntbk_amount, '[^0-9]', '') AS UNSIGNED) AS trmend_amt_num,
                        CAST(REGEXP_REPLACE(a.frst_acqs_amount,          '[^0-9]', '') AS UNSIGNED) AS frst_amt_num,
                        CASE
                        WHEN a.trmend_blce_qota_rt IS NULL OR a.trmend_blce_qota_rt IN ('','-')
                            THEN NULL
                        ELSE CAST(REGEXP_REPLACE(a.trmend_blce_qota_rt, '[^0-9.]', '') AS DECIMAL(10,4))
                        END AS qota_rt_num
                    FROM MART_CORP_OWNERSHIP a
                    WHERE a.corp_code = ?
                        AND (
                        CAST(REGEXP_REPLACE(a.trmend_blce_acntbk_amount, '[^0-9]', '') AS UNSIGNED) > 0
                        OR (
                            (a.trmend_blce_acntbk_amount IS NULL OR a.trmend_blce_acntbk_amount = '')
                            AND CAST(REGEXP_REPLACE(a.frst_acqs_amount, '[^0-9]', '') AS UNSIGNED) > 0
                        )
                        )
                    ),
                    dedup AS (
                    SELECT
                        b.*,
                        ROW_NUMBER() OVER (
                        PARTITION BY b.corp_code, b.inv_prm
                        ORDER BY b.rcept_no DESC
                        ) AS rn_invest
                    FROM base b
                    ),
                    /* 최신 rcept_no */
                    latest_rcept AS (
                    SELECT corp_code, MAX(rcept_no) AS max_rcept_no
                    FROM base
                    GROUP BY corp_code
                    )
                    /* 최신 rcept_no = max_rcept_no 인 행 전부 + 금액 내림차순 */
                    SELECT d.*
                    FROM dedup d
                    JOIN latest_rcept l
                    ON l.corp_code = d.corp_code
                    AND l.max_rcept_no = d.rcept_no
                    ORDER BY d.corp_code DESC, d.trmend_amt_num DESC, d.rcept_no DESC;
                ";

        $query = $this->db->query($sql, [$corp_code]);
        return $query->result_array();
    }

    public function get_ifCorpRevenueProfit($corp_code, $bgn_de, $end_de)
    {
        $this->db->select("
                    *,
                    COALESCE(
                        MAX(CASE WHEN fs_div='CFS' THEN CAST(REGEXP_REPLACE(thstrm_amount,'[^0-9-]','') AS SIGNED) END),
                        MAX(CASE WHEN fs_div='OFS' THEN CAST(REGEXP_REPLACE(thstrm_amount,'[^0-9-]','') AS SIGNED) END)
                    ) AS amt_order
                    ", FALSE);
        $this->db->from('MART_CORP_REVENUE_PROFIT');
        $this->db->where_in('corp_code', $corp_code);
        $this->db->where('bsns_year >=', 2021);
        $this->db->where('bsns_year <=', 2024);
        $this->db->where_in('account_nm', ['매출액','영업이익']);
        $this->db->group_by(['corp_code','bsns_year','account_nm']);
        $this->db->order_by('corp_code','ASC')->order_by('bsns_year','ASC')->order_by('account_nm','ASC');

        $query = $this->db->get();
        return $query->result_array();
    }

    
    public function get_ifDisclosureSearch($page_count, $corp_code=null, $search_word=null, $bgn_de, $end_de, $offset, $fg=null)
    {
        if($fg == 'detail') {
            $whereSql = function() use ($corp_code) {
                $this->db->from('MART_DISCLOSURE_SEARCH as a');    
                if ($corp_code !== '') { $this->db->like('a.corp_code', $corp_code); }
            };
        } else {
            $whereSql = function() use ($search_word, $bgn_de, $end_de) {
                $this->db->from('MART_DISCLOSURE_SEARCH as a');    
                if ($search_word !== '') {  $this->db->group_start()
                    ->like('flr_nm', $search_word)
                    ->or_like('report_nm', $search_word)
                    ->group_end(); }
                if (!empty($bgn_de)) { $this->db->where('rcept_dt >=', $bgn_de); }
                if (!empty($end_de)) { $this->db->where('rcept_dt <=', $end_de); }  
            };
        }
        $whereSql();
        $this->db->select('COUNT(*) AS cnt', false);
        $total_count = (int) $this->db->get()->row()->cnt;

        $whereSql();
        $this->db->select('b.corp_name, a.*');
        $this->db->join('STG_OP_DA_AP_1_2 AS b', 'a.corp_code = b.corp_code', 'left');
        $this->db->order_by('rcept_dt', 'DESC');
        $this->db->limit($page_count, $offset);     // LIMIT offset, count
        $list = $this->db->get()->result_array();

        return [
            'list'        => $list,
            'total_count' => $total_count
        ];
    }

    public function get_ifDisclosureSummary($rcept_no)
    {
        $this->db->select("*");
        $this->db->from('MART_DISCLOSURE_SUMMARY');
        $this->db->where('rcept_no', $rcept_no);

        $query = $this->db->get();
        
        return $query->result_array();
    }

    public function get_ifAnomalyDetection($corp_code, $relation_flag)
    {  
        if ($relation_flag == 'MS') {
            // 대주주변동내역
            $this->db->select("*");
            $this->db->from('STG_OP_DA_AP_4_1');
            $this->db->where('corp_code', $corp_code);
            $this->db->order_by('rcept_no', 'DESC');
            $this->db->limit(10);
        } else if ($relation_flag == 'SR') {
            // 특수관계인변동내역
            $this->db->select("*");
            $this->db->from('MART_ANOMALY_DETECTION');
            $this->db->where('corp_code', $corp_code);
            $this->db->where('corp_cls IS NOT NULL');
            $this->db->where('relate LIKE', '%특수%');
            $this->db->order_by('rcept_no', 'DESC');
            $this->db->limit(10);
        }
        $query = $this->db->get();
        return $query->result_array();
    }    

    // 매출액 상위
    public function get_ifTopRevenue($bsns_year, $corp_code=null, $detail_flag=null)
    {
        if ($detail_flag === 'Y' && !empty($corp_code)) {            
            $index_type = $this->db->select('INDEX_TYPE')
                                   ->from('MART_CORP_INFO_BASE')
                                   ->where('corp_code', $corp_code)
                                   ->get()->row('INDEX_TYPE');
    
            if ($index_type !== null) {
                $this->db->select("
                    a.*,
                    b.INDEX_TYPE,
                    b.INDEX_TYPE_NM,
                    COALESCE(
                        MAX(CASE WHEN a.fs_div = 'CFS'
                            THEN CAST(REGEXP_REPLACE(a.thstrm_amount, '[^0-9-]', '') AS SIGNED) END),
                        MAX(CASE WHEN a.fs_div = 'OFS'
                            THEN CAST(REGEXP_REPLACE(a.thstrm_amount, '[^0-9-]', '') AS SIGNED) END)
                    ) AS amt_order
                ", false);
                $this->db->from('MART_CORP_REVENUE_TAKE a');
                $this->db->join('MART_CORP_INFO_BASE b', 'a.corp_code = b.corp_code');
                $this->db->where('b.corp_cls <>', 'E');
                $this->db->where('a.bsns_year', (int)$bsns_year);
                $this->db->where('b.INDEX_TYPE', $index_type);
                $this->db->group_by('a.corp_code');
                $this->db->order_by('amt_order', 'DESC');
                $this->db->limit(10);
    
                $query = $this->db->get();
                return $query->result_array();
            }
        }

        $this->db->select("a.*,
                            COALESCE(
                                MAX(CASE WHEN fs_div = 'CFS' 
                                THEN CAST(REGEXP_REPLACE(thstrm_amount, '[^0-9-]', '') AS SIGNED) END),
                                MAX(CASE WHEN fs_div = 'OFS' 
                                THEN CAST(REGEXP_REPLACE(thstrm_amount, '[^0-9-]', '') AS SIGNED) END)
                            ) AS amt_order", FALSE);
        $this->db->from('MART_CORP_REVENUE_TAKE as a');
        $this->db->join('STG_OP_DA_AP_1_2 as b', 'a.corp_code = b.corp_code');
        $this->db->where('bsns_year', $bsns_year);
        $this->db->where('b.corp_cls <>', 'E');
        $this->db->group_by('a.corp_code');
        $this->db->order_by('amt_order', 'DESC');
        $this->db->limit(10);

        $query = $this->db->get();
        return $query->result_array();
    }

    // 매출액 상위(상세페이지 해당회사)
    public function get_ifTopRevenue_me($bsns_year, $corp_code) {
        $this->db->select("
                    a.*,
                    COALESCE(
                        MAX(CASE WHEN a.fs_div = 'CFS'
                            THEN CAST(REGEXP_REPLACE(a.thstrm_amount, '[^0-9-]', '') AS SIGNED) END),
                        MAX(CASE WHEN a.fs_div = 'OFS'
                            THEN CAST(REGEXP_REPLACE(a.thstrm_amount, '[^0-9-]', '') AS SIGNED) END)
                    ) AS amt_order
                ", false);
        $this->db->from('MART_CORP_REVENUE_TAKE a');
        $this->db->join('STG_OP_DA_AP_1_2 as b', 'a.corp_code = b.corp_code');
        $this->db->where('b.corp_cls <>', 'E');
        $this->db->where('a.corp_code', $corp_code);
        $this->db->where('a.bsns_year', (int)$bsns_year);
        $this->db->group_by('a.corp_code');

        $meRow = $this->db->get()->row_array();
        return $meRow;
    }

    // 당기순이익
    public function get_ifTopNetIncome($bsns_year, $corp_code=null, $detail_flag=null)
    {
        if ($detail_flag === 'Y' && !empty($corp_code)) {
            $index_type = $this->db->select('INDEX_TYPE')
                                   ->from('MART_CORP_INFO_BASE')
                                   ->where('corp_code', $corp_code)
                                   ->get()->row('INDEX_TYPE');
    
            if ($index_type !== null) {
                $this->db->select("
                    a.*,
                    b.INDEX_TYPE,
                    b.INDEX_TYPE_NM,
                    COALESCE(
                        MAX(CASE WHEN a.fs_div = 'CFS'
                            THEN CAST(REGEXP_REPLACE(a.thstrm_amount, '[^0-9-]', '') AS SIGNED) END),
                        MAX(CASE WHEN a.fs_div = 'OFS'
                            THEN CAST(REGEXP_REPLACE(a.thstrm_amount, '[^0-9-]', '') AS SIGNED) END)
                    ) AS amt_order
                ", false);
                $this->db->from('MART_CORP_REVENUE a');
                $this->db->join('MART_CORP_INFO_BASE b', 'a.corp_code = b.corp_code');
                $this->db->where('a.bsns_year', (int)$bsns_year);
                $this->db->where('b.INDEX_TYPE', $index_type);
                $this->db->where('b.corp_cls <>', 'E');
                $this->db->group_by('a.corp_code');
                $this->db->order_by('amt_order', 'DESC');
                $this->db->limit(10);
    
                $query = $this->db->get();
                return $query->result_array();
            }
        }

        $this->db->select("a.*,
                            COALESCE(
                                MAX(CASE WHEN fs_div = 'CFS' 
                                THEN CAST(REGEXP_REPLACE(thstrm_amount, '[^0-9-]', '') AS SIGNED) END),
                                MAX(CASE WHEN fs_div = 'OFS' 
                                THEN CAST(REGEXP_REPLACE(thstrm_amount, '[^0-9-]', '') AS SIGNED) END)
                            ) AS amt_order", FALSE);
        $this->db->from('MART_CORP_REVENUE as a');
        $this->db->join('STG_OP_DA_AP_1_2 as b', 'a.corp_code = b.corp_code');
        $this->db->where('bsns_year', $bsns_year);
        $this->db->where('b.corp_cls <>', 'E');
        $this->db->group_by('a.corp_code');
        $this->db->order_by('amt_order', 'DESC');
        $this->db->limit(10);

        $query = $this->db->get();
        return $query->result_array();
    }
    public function get_ifTopNetIncome_me($bsns_year, $corp_code) {
        // 해당 회사의 전년도 당기순이익
        $this->db->select("
                    a.*,
                    COALESCE(
                        MAX(CASE WHEN a.fs_div = 'CFS'
                            THEN CAST(REGEXP_REPLACE(a.thstrm_amount, '[^0-9-]', '') AS SIGNED) END),
                        MAX(CASE WHEN a.fs_div = 'OFS'
                            THEN CAST(REGEXP_REPLACE(a.thstrm_amount, '[^0-9-]', '') AS SIGNED) END)
                    ) AS amt_order
                ", false);
        $this->db->from('MART_CORP_REVENUE as a');
        $this->db->join('STG_OP_DA_AP_1_2 as b', 'a.corp_code = b.corp_code');
        $this->db->where('b.corp_cls <>', 'E');
        $this->db->where('a.corp_code', $corp_code);
        $this->db->where('a.bsns_year', (int)$bsns_year);
        $this->db->group_by('a.corp_code');

        $meRow = $this->db->get()->row_array();
        return $meRow;
    }
    
    // 자기 주식율 취득
    public function get_ifTopTreasuryStock($bsns_year)
    {
        $this->db->select('a.*');
        $this->db->from('MART_SELF_STOCK_RANK AS a');
        $this->db->group_by('a.corp_code');
        $this->db->order_by("CAST(REPLACE(a.change_qy_acqs, ',', '') AS UNSIGNED)", 'DESC', false);
        $this->db->limit(10);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_ifTopMinorityShareholders($bsns_year)
    {
        $this->db->select('a.*, b.corp_cls');
        $this->db->from('MART_MINORITY_HOLDERS_RATE AS a');
        $this->db->join('STG_OP_DA_AP_1_2 AS b', 'a.corp_code = b.corp_code');
        $this->db->where('a.bsns_year', $bsns_year);
        $this->db->where('LEFT(a.stlm_dt, 7) =', $bsns_year.'-12');
        $this->db->where('b.corp_cls <>', 'E');
        $this->db->group_by('a.corp_code');
        $this->db->order_by('a.hold_stock_rate', 'DESC');
        $this->db->limit(10);

        $query = $this->db->get();
    
        return $query->result_array();
    }

    public function get_ifTopListedSubsidiaries()
    {
        $this->db->select("a.corp_code,a.unityGrupCode,a.unityGrupNm,COUNT(*) as cnt");
        $this->db->from('MART_CORP_INFO_BASE as a');
        $this->db->where_in('a.corp_cls', ['Y', 'K']);
        $this->db->where('a.unityGrupNm IS NOT NULL', null, false);
        $this->db->group_by('a.unityGrupNm');
        $this->db->order_by('4', 'DESC');
        $this->db->limit(10);

        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_ifTopMajorOwnership($bsns_year)
    {
        $this->db->select("a.*, b.corp_cls, CAST(REGEXP_REPLACE(trmend_posesn_stock_co, '[^0-9-]', '') AS SIGNED) AS amt_order");
        $this->db->join('STG_OP_DA_AP_1_2 as b', 'a.corp_code = b.corp_code');
        $this->db->from('MART_PRV_MAJOR_HOLDER_RATE as a');
        $this->db->where('LEFT(stlm_dt, 7) =', $bsns_year.'-12');
        $this->db->where('b.corp_cls =', 'Y');
        $this->db->group_by('corp_code');
        $this->db->order_by("CAST(REGEXP_REPLACE(a.trmend_posesn_stock_qota_rt, '[^0-9]', '') AS UNSIGNED) DESC");
        $this->db->limit(10);

        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_ifTopBonusIssue($bsns_year)
    {
        $this->db->select("a.*");
        $this->db->from('MART_BONUS_ISSUE AS a');
        $this->db->join('STG_OP_DA_AP_1_2 AS b', 'a.corp_code = b.corp_code');
        $this->db->where('LEFT(a.bddd, 4) =', $bsns_year);
        $this->db->where('b.corp_cls <>', 'E');
        $this->db->order_by('a.own_stock_amount', 'DESC');
        $this->db->limit(10);

        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_ifTopNPSInvestedCompanies($bsns_year)
    {   
        $this->db->select('a.*', false);
        $this->db->from('MART_BIG_MAJOR_HOLDER AS a');
        $this->db->join('STG_OP_DA_AP_1_2 AS b', 'a.corp_code = b.corp_code', 'inner');
        $this->db->like('a.repror', '국민연금');
        $this->db->like('a.rcept_no', $bsns_year.'03');
        $this->db->where('b.corp_cls <>', 'E');       
        $this->db->group_by('a.corp_code');
        $this->db->order_by("a.stkrt", 'DESC', false);
        $this->db->limit(10);
        

        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_ifTopPermanentEmployee()
    {
        $sql = "
            WITH ranked AS (
                SELECT
                    a.rcept_no,
                    a.corp_code,        
                    MAX(a.corp_name) AS corp_name,
                    SUM(CAST(REPLACE(a.rgllbr_co, ',', '') AS UNSIGNED)) AS total_rgllbr_co,
                    a.stlm_dt,
                    b.corp_cls,
                    ROW_NUMBER() OVER (PARTITION BY a.corp_code ORDER BY a.stlm_dt DESC) AS rn
                FROM MART_PERMANENT_EMPLOYEE AS a
                JOIN STG_OP_DA_AP_1_2 AS b 
                ON a.corp_code = b.corp_code
                WHERE YEAR(a.stlm_dt) = YEAR(CURDATE()) - 1
                AND b.corp_cls <> 'E'
                GROUP BY a.corp_code, a.rcept_no, a.stlm_dt
            )
            SELECT
                rcept_no,
                corp_code,
                corp_name,
                total_rgllbr_co,
                stlm_dt,
                corp_cls
            FROM ranked
            WHERE rn = 1
            ORDER BY total_rgllbr_co DESC
            LIMIT 10;
        ";

            $query = $this->db->query($sql);
            return $query->result_array();
    }

    public function get_ifCorpInfo($corp_code)
    {
        $this->db->select("a.*, base.INDEX_TYPE, base.INDEX_TYPE_NM");
        $this->db->from('STG_OP_DA_AP_1_2 as a');
        $this->db->join('MART_CORP_INFO_BASE as base', 'a.corp_code = base.corp_code');
        $this->db->where('a.corp_code', $corp_code);

        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_ifCorpGovernanceAll($corp_code, $std_year)
    {
        $this->db->select("file_path, file_page, corp_code, group_code");
        $this->db->from('STG_OP_GOVE_MAP');
        $this->db->where('corp_code', $corp_code);
        $this->db->where('std_year', $std_year);
        $query = $this->db->get();
        return $query->result_array();
    }
}