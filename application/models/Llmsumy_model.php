<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Llmsumy_model extends ETD_Model {

    private $domain;
    private $username;
    private $password;
    private $index;
    private $CI;
    public function __construct()
    {
        parent::__construct();
        $this->load->database();        
        $this->load->model('Api_model');        


        $this->CI =& get_instance();
        $this->CI->config->load('opensearch', TRUE);
    
        $this->domain = $this->CI->config->item('opensearch_domain', 'opensearch');
        $this->username = $this->CI->config->item('opensearch_username', 'opensearch');
        $this->password = $this->CI->config->item('opensearch_password', 'opensearch');
        $this->index = $this->CI->config->item('opensearch_index', 'opensearch');

    }

    public function get_corp_data($corp_code)
    {
        $ceo_data = $this->Api_model->get_ifCorpCompanyProfile($corp_code);
        $executive_data = $this->Api_model->get_ifCorpExecutive($corp_code);
        
        $in_corp_list = $this->Api_model->get_in_corp_list($corp_code, 0, 'Y');
        $out_corp_list = $this->Api_model->get_out_corp_list($corp_code, 0, 'Y');
        $major_shareholder = $this->Api_model->get_ifCorpMajorShareholders($corp_code);
        $ownership = $this->Api_model->get_ifCorpCrossOwnership($corp_code);
        
        $disclosure_data = $this->Api_model->get_ifDisclosureSearch(5, $corp_code, null, null, null, 0, 'detail');
        
        return [
            'ceo_data' => $ceo_data,
            'executive_data' => $executive_data,
            'in_corp_list' => $in_corp_list,
            'out_corp_list' => $out_corp_list,
            'major_shareholder' => $major_shareholder,
            'ownership' => $ownership,
            'disclosure_data' => $disclosure_data
        ];
    }

    public function get_executive_summary($ceo_data, $executive_data)
    {
        if (empty($ceo_data) && empty($executive_data)) {
            return "대표이사 및 임원 정보가 없습니다.";
        }
        
        $text = "대표이사 정보\n";
        if (!empty($ceo_data)) {
            foreach ($ceo_data as $ceo) {
                $text .= "회사명: " . ($ceo['corp_name'] ?? '') . "\n";
                $text .= ", 대표이사: " . ($ceo['ceo_nm'] ?? '') . "\n";
            }
        }
        
        $text .= "\n임원현황\n";
        if (!empty($executive_data)) {
            foreach ($executive_data as $exec) {
                $text .= "성명: " . ($exec['nm'] ?? '') . 
                        ", 성별: " . ($exec['sexdstn'] ?? '') . 
                        ", 직위: " . ($exec['ofcps'] ?? '') . 
                        ", 재직 기간: " . ($exec['hffc_pd'] ?? '') . 
                        ", 등기 임원 여부: " . ($exec['rgist_exctv_at'] ?? '') . "\n";
            }
        }
        
        return $text;
    }

    public function make_shareholder_summary($in_corp_list, $out_corp_list, $major_shareholder, $ownership)
    {
        if (empty($in_corp_list) && empty($out_corp_list) && empty($major_shareholder) && empty($ownership)) {
            return "주주 구성 정보가 없습니다.";
        }
        
        $text = "5% 이상 대주주:\n";
        if (!empty($in_corp_list)) {
            foreach ($in_corp_list as $in) {
                $text .= "성명: " . ($in['nm'] ?? '') . 
                        ", 지분율: " . ($in['stkrt'] ?? '') . "%\n";
            }
        }

        $text .= "\n타법인 투자 내역:\n";
        if (!empty($out_corp_list)) {
            foreach ($out_corp_list as $out) {
                $text .= "투자처: " . ($out['inv_prm'] ?? '') . 
                        ", 지분율: " . ($out['trmend_blce_qota_rt'] ?? '') . "%\n";
            }
        }

        $text .= "\n최대주주 및 특수관계인\n";
        if (!empty($major_shareholder)) {
            foreach ($major_shareholder as $major) {
                $text .= "이름: " . ($major['nm'] ?? '') . 
                        ", 지분율: " . ($major['trmend_posesn_stock_qota_rt'] ?? '') . "\n";
            }
        }

        $text .= "\n타법인 출자 현황\n";
        if (!empty($ownership)) {
            foreach ($ownership as $owner) {
                $text .= "법인명: " . ($owner['inv_prm'] ?? '') . "\n";
                $text .= ", 최초취득일자: " . ($owner['frst_acqs_de'] ?? '') . "\n";
                $text .= ", 출자목적: " . ($owner['invstmnt_purps'] ?? '') . "\n";
                $text .= ", 기말잔액(수량): " . ($owner['trmend_blce_qy'] ?? '') . "\n";
                $text .= ", 기말잔액(지분율): " . ($owner['trmend_blce_qota_rt'] ?? '') . "\n";
                $text .= ", 기말잔액(장부가액): " . ($owner['trmend_blce_acntbk_amount'] ?? '') . "\n";
                $text .= ", 최근사업연도 재무현황(총자산): " . ($owner['recent_bsns_year_fnnr_sttus_tot_assets'] ?? '') . "\n";
                $text .= ", 최근사업연도 재무현황(당기순이익): " . ($owner['recent_bsns_year_fnnr_sttus_thstrm_ntpf'] ?? '') . "\n";
            }
        }
        
        return $text;
    }

    public function get_disclosure_summaries($disclosure_data, $llm_callback = null)
    {
        if (empty($disclosure_data) || !isset($disclosure_data['list'])) {
            return ["최근 공시 정보가 없습니다."];
        }
        
        $summaries = [];
        
        foreach ($disclosure_data['list'] as $disclosure) {
            $rcept_no = $disclosure['rcept_no'];
            $report_nm = $disclosure['report_nm'] ?? '공시';
            $pblntf_ty = $disclosure['pblntf_ty'] ?? 'A';
            
            $check_summary = $this->get_summary($rcept_no);
            
            if (!empty($check_summary)) {
                $summary = $check_summary['summary'] ?? $check_summary['MgDecsn_info_sumy'] ?? '';
                $summaries[] = [
                    'rcept_no' => $rcept_no,
                    'report_nm' => $report_nm,
                    'summary' => $summary,
                    'from_db' => true
                ];
            } else {
                $summaries[] = [
                    'rcept_no' => $rcept_no,
                    'report_nm' => $report_nm,
                    'pblntf_ty' => $pblntf_ty,
                    'summary' => null,
                    'from_db' => false,
                    'need_generation' => true
                ];
            }
        }
        
        return $summaries;
    }
    public function get_report($rcept_no, $pblntf_ty) {
        $like = $this->db->escape('%'.$rcept_no.'%');      // SQL 인젝션 방지용
        if($pblntf_ty=="A"){ 
            $sql = "SELECT a.corp_info_raw, a.stock_info_raw, a.CprInvstmnt_info_raw, a.majorstock_info_raw, a.CmpnyIndx_info_raw from MART_DISCLOSURE_TEXT AS a WHERE a.rcept_no='$rcept_no'";
        }else if ($pblntf_ty=="B"){
            $sql = "SELECT a.MgDecsn_info_raw as content from MART_MGDECSN_TEXT AS a WHERE a.rcept_no='$rcept_no' ";
        }else{
            $sql = "SELECT REGEXP_REPLACE(a.file_content, '<[^>]+>', '') as content from STG_OP_DA_AP_1_3 AS a WHERE a.rcept_no='$rcept_no'";
        }

        $query = $this->db->query($sql);
        return $query->result_array();        
    }

    public function get_report_info($rcept_no) {
        $like = $this->db->escape('%'.$rcept_no.'%');

        $sql = "SELECT * from STG_OP_DA_AP_1_1 AS a 
                JOIN STG_OP_DA_AP_1_3 AS b ON a.rcept_no=b.rcept_no
                WHERE a.rcept_no='$rcept_no'";

        $query = $this->db->query($sql);
        return $query->result_array();        
    }

    public function get_summary($rcept_no)
    {
        $query = $this->db->get_where('MART_LLM_SUMMARY', ['rcept_no' => $rcept_no]);
        return $query->row_array();
    }

    public function save_summary($rcept_no, $pblntf_ty, $summary)
    {

        $exists = $this->db->where('rcept_no', $rcept_no)->count_all_results('MART_LLM_SUMMARY') > 0;
        if ($exists) {
            return true;
        }

        if ($pblntf_ty == 'B') {
            $data = [
                'rcept_no' => $rcept_no,
                'pblntf_ty' => $pblntf_ty,
                'MgDecsn_info_sumy' => $summary
            ];
        } else {
            $data = [
                'rcept_no' => $rcept_no,
                'pblntf_ty' => $pblntf_ty,
                'summary' => $summary
            ];
        }
        
        $db_insert = $this->db->insert('MART_LLM_SUMMARY', $data);

        if ($db_insert) {
            $this->update_opensearch($rcept_no, $summary);
        }

        return $db_insert;
    }

    public function update_opensearch($rcept_no, $summary) 
    {

        $update_body = [
            'doc' => [
                'total_sumy' => $summary,
            ]
        ];

        $url = 'https://' . $this->domain . '/' . $this->index . '/_update/'. $rcept_no;
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_USERPWD, $this->username . ':' . $this->password);
        // 개발환경
        // curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); 
        // curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false); 
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($update_body));
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json'
        ]);

        $response = curl_exec($ch);
        $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $curl_error = curl_error($ch);
        curl_close($ch);

        if ($curl_error) {
            log_message('error', 'Opensearch Error: ' . $curl_error);
            return false;
        }
        
        if ($http_code < 200 || $http_code >= 300) {
            log_message('error', 'Opensearch failed: ' . $http_code);
            return false;
        }
        
        return true;
    }

    public function get_corp_summary_cache($corp_code)
    {
        $query = $this->db->get_where('MART_CORP_SUMMARY', ['corp_code' => $corp_code]);
        return $query->row_array();
    }

    public function save_corp_summary_cache($corp_code, $data)
    {
        $exists = $this->db->where('corp_code', $corp_code)->count_all_results('MART_CORP_SUMMARY') > 0;
        
        if ($exists) {
            $this->db->where('corp_code', $corp_code);
            $this->db->update('MART_CORP_SUMMARY', $data);
        } else {
            $data['corp_code'] = $corp_code;
            $this->db->insert('MART_CORP_SUMMARY', $data);
        }
    }

}