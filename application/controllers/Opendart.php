<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Opendart extends ETD_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->helper('url');
    }

    public function index()
    {
        $this->findCorpGongsi();
    }

    /**
     * 공시검색 (OP_DA_AP_1_1)
     * URL 파라미터: corp_code, bgn_de, end_de, last_reprt_at, pblntf_ty, pblntf_detail_ty, corp_cls, sort, sort_mth, page_no, page_count
     * 참고 : https://opendart.fss.or.kr/guide/detail.do?apiGrpCd=DS001&apiId=2019001
     */
    public function findCorpGongsi()
    {
        $corpCode  = $this->getParam('corp_code', '00126380');
        $bgnDe     = $this->getParam('bgn_de', '20250101');
        $endDe     = $this->getParam('end_de', date('Ymd'));
        $pageCount = $this->getParam('page_count', 10);

        $this->db->select('corp_code');
        $this->db->from('STG_OP_DA_AP_1_1');
        $this->db->order_by('corp_code', 'asc');
        $this->db->limit(10);
        $query = $this->db->get();
        $result = $query->result_array();

        print_r('result');
        exit;

        try {
            $result = $this->ETD_Model->call_opendart_api('OP_DA_AP_1_1', [
                'corp_code' => $corpCode,
                'bgn_de' => $bgnDe,
                'end_de' => $endDe,
                'page_count' => $pageCount,
            ]);

            print_r($result);

            // foreach($result['list'] as $item) {
            //     echo $item['corp_name'] . '<br>';
            // }

        } catch (Exception $e) {
            echo json_encode(['error' => $e->getMessage()]);
        }
    }

    /**
     * 기업 대시보드 (OP_DA_AP_1_2)
     * URL 파라미터: corp_code
     * 참고 : https://opendart.fss.or.kr/guide/detail.do?apiGrpCd=DS001&apiId=2019002
     */
    public function corpDashboard()
    {
        $corpCode = $this->input->get('corp_code', true) ?: '00126380';

        try {
            $result = $this->ETD_Model->call_opendart_api('OP_DA_AP_1_2', [
                'corp_code' => $corpCode,
            ]);

            echo json_encode($result);
            // $this->output
            //      ->set_content_type('application/json')
            //      ->set_output(json_encode($result));
        } catch (Exception $e) {
            log_message('error', $e->getMessage());
            show_error('OpenDART Dashboard 호출 중 오류가 발생했습니다.', 500);
        }

    }
}