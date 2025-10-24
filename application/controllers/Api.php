<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Api extends ETD_Controller {

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Api_model');
    }

    // 공통 JSON 응답 함수
    private function send_json($data)
    {
        header('Content-Type: application/json; charset=utf-8');    
        try {
            $isEmpty = function($arr) use (&$isEmpty) {
                if (is_array($arr)) {
                    foreach ($arr as $v) {
                        if (!$isEmpty($v)) {
                            return false;
                        }
                    }
                    return true;
                }
                return empty($arr);
            };    
            // 정상
            $response = [
                'status'  => '00',
                'message' => '정상',
                'DataList' => $data
            ];    
            // 데이터 없음
            if ($isEmpty($data)) {
                $response['status']  = '98';
                $response['message'] = '데이터 없음';
            }    
        } catch (Exception $e) {
            // Exception
            $response = [
                'status'  => '99',
                'message' => 'Exception: ' . $e->getMessage(),
                'DataList' => []
            ];
        }    
        echo json_encode($response, JSON_UNESCAPED_UNICODE);
        exit;
    }
       
    // 지배구조 그래프 기본 리스팅
    public function index()
    {
        $this->load->view('index');
    }   

    // 기업명 검색
    public function SearchCorp()
    {
        $corp_name = $this->input->get('corp_name', TRUE);        
        $corp_list = $this->Api_model->get_corp_name($corp_name);

        $this->send_json($corp_list);
    }

    // 지배구조 그래프 기본 리스팅 기업 리스트
    public function IfGovernanceGraphList()
    {
        $limit = $this->input->get('limit');
        $result = $this->Api_model->get_governance_graph_list($limit);
        $this->send_json($result);
    }

    // 지배구조 그래프
    public function IfGovernanceGraph() 
    {
        $corp_code = $this->input->get('corp_code', TRUE);
        $page_count = (int)$this->input->get('page_count');
        $detail_flag = $this->input->get('detail_flag');
        $page_count = $page_count ? $page_count : 0;
    
        $in_corp_list  = $this->Api_model->get_in_corp_list($corp_code, $page_count, $detail_flag);  // MART_CORP_HOLDER
        $out_corp_list = $this->Api_model->get_out_corp_list($corp_code, $page_count, $detail_flag); // MART_CORP_OWNERSHIP
        // print_r($in_corp_list);
        $dataList = [
            'In_corp_list'  => $in_corp_list,
            'Out_corp_list' => $out_corp_list
        ];

        $this->send_json($dataList);
    }

    // 기업 기본 정보
    public function IfCorpCompanyProfile()
    {
        $corp_code = $this->input->get('corp_code', TRUE);
        
        $result = $this->Api_model->get_ifCorpCompanyProfile($corp_code);
        $this->send_json($result);

    }
    // 기업 임원 정보
    public function IfCorpExecutive()
    {
        $corp_code = $this->input->get('corp_code', TRUE);  

        $mideungi_count = $this->Api_model->get_ifCorpExecutive_mideungi_count($corp_code);        
        $result = $this->Api_model->get_ifCorpExecutive($corp_code);

        $dataList = [
            'mideungi_count' => $mideungi_count,
            'result' => $result
        ];
        // print_r($dataList);
        $this->send_json($dataList);

    }

    // 기업 대주주 정보
    public function IfCorpMajorShareholders()
    {
        $corp_code = $this->input->get('corp_code', TRUE);

        $result = $this->Api_model->get_ifCorpMajorShareholders($corp_code);
        $this->send_json($result);
    }

    // 타법인 출자 현황 (투자회사 분석)
    public function IfCorpCrossOwnership()
    {
        $corp_code = $this->input->get('corp_code', TRUE);
        
        $result = $this->Api_model->get_ifCorpCrossOwnership($corp_code);
        $this->send_json($result);
    }

    // 매출 및 영업 이익
    public function IfCorpRevenueProfit()
    {
        $curYear = date('Y');
        $corp_code = $this->input->get('corp_code', TRUE);
        $detail_flag = $this->input->get('detail_flag');

        if($detail_flag == 'true') {
            $bgn_de = ($curYear - 4);
            $end_de = ($curYear - 1);
        } else {
            $bgn_de = ($curYear - 3);
            $end_de = ($curYear - 1);
        }

        $result = $this->Api_model->get_ifCorpRevenueProfit($corp_code, $bgn_de, $end_de);
        $this->send_json($result);

    }

    // 공시 안내
    public function IfDisclosureSearch()
    {       
        $page_no    = $this->input->get('page_no') ?: 1;
        $page_count = $this->input->get('page_count') ?: 10;
        $corp_code  = $this->input->get('corp_code');
        $search_word  = $this->input->get('search_word');        
        $bgn_de     = $this->input->get('bgn_de');
        $end_de     = $this->input->get('end_de');
        $offset     = ($page_no - 1) * $page_count;
        $fg         = $this->input->get('fg');
        $result = $this->Api_model->get_ifDisclosureSearch($page_count, $corp_code, $search_word, $bgn_de, $end_de, $offset, $fg);
        
        $this->send_json($result);
    }

    // 공시 요약
    public function IfDisclosureSummary()
    {
        $rcept_no = $this->input->get('rcept_no', TRUE);

        $result = $this->Api_model->get_ifDisclosureSummary($rcept_no);
        $this->send_json($result);
    }

    // 이상 감지 (대주주변동내역)
    public function IfAnomalyDetection()
    {
        $corp_code = $this->input->get('corp_code', TRUE);
        $relation_flag = $this->input->get('relation_flag');    //SR:특수관계인(Specially related), MS:대주주(major shareholder)
        $result = $this->Api_model->get_ifAnomalyDetection($corp_code, $relation_flag);
        $this->send_json($result);    
    }


    // 매출 상위
    public function IfTopRevenue()
    {
        $bsns_year = (int) $this->input->get('bsns_year');
        $corp_code = $this->input->get('corp_code') ?: null;
        $detail_flag = $this->input->get('detail_flag') ?: null;
        
        // 전체 매출액 상위 10개 조회용
        $result = $this->Api_model->get_ifTopRevenue($bsns_year, $corp_code, $detail_flag);

        // 상세페이지 자기자신 매출액 조회용
        if($detail_flag === 'Y' && !empty($corp_code)) {
            $me = $this->Api_model->get_ifTopRevenue_me($bsns_year, $corp_code);
            
            return $this->send_json([
                'me'     => $me,
                'result' => $result,
            ]);
        }        
        // 메인은 me 데이터 제외하고 return
        $this->send_json($result);
    }

    // 당기순이익 상위
    public function IfTopNetIncome()
    {
        $bsns_year = (int) $this->input->get('bsns_year');
        $corp_code = $this->input->get('corp_code') ?: null;
        $detail_flag = $this->input->get('detail_flag') ?: null;

        $result = $this->Api_model->get_ifTopNetIncome($bsns_year, $corp_code, $detail_flag);

        if($detail_flag === 'Y' && !empty($corp_code)) {
            $me = $this->Api_model->get_ifTopNetIncome_me($bsns_year, $corp_code);
            return $this->send_json([
                'me'     => $me,
                'result' => $result,
            ]);
        }
        // 메인은 me 데이터 제외하고 return
        $this->send_json($result);
    }

    // 자기 주식 취득 수량 상위
    public function IfTopTreasuryStock()
    {
        $bsns_year = (int) $this->input->get('bsns_year');
        $result = $this->Api_model->get_ifTopTreasuryStock($bsns_year);
        $this->send_json($result);
    }

    // 소액 주주 비율
    public function IfTopMinorityShareholders()
    {
        $bsns_year = (int) $this->input->get('bsns_year');
        $result = $this->Api_model->get_ifTopMinorityShareholders($bsns_year);
        $this->send_json($result);
    }

    // 상장 자회사 수
    public function IfTopListedSubsidiaries()
    {
        $result = $this->Api_model->get_ifTopListedSubsidiaries();
        $this->send_json($result);
    }

    // 최대 주주와 특수 관계인 지분율
    public function IfTopMajorOwnership()
    {
        $bsns_year = (int) $this->input->get('bsns_year');
        $result = $this->Api_model->get_ifTopMajorOwnership($bsns_year);
        $this->send_json($result);
    }

    // 무상 증자
    public function IfTopBonusIssue()
    {
        $bsns_year = (int) $this->input->get('bsns_year');
        $result =  $this->Api_model->get_ifTopBonusIssue($bsns_year);
        $this->send_json($result);
    }

    // 국민연금이 많이 출자한 기업
    public function IfTopNPSInvestedCompanies()
    {
        $bsns_year = (int) $this->input->get('bsns_year') + 1;
        $result = $this->Api_model->get_ifTopNPSInvestedCompanies($bsns_year);
        $this->send_json($result);
    }
    
    // 정규직 근로자 수 상위 랭킹
    public function IfTopPermanentEmployee()
    {
        $result = $this->Api_model->get_ifTopPermanentEmployee();
        $this->send_json($result);
    }
    
    // 기업개황정보
    public function ifCorpInfo()
    {
        $corp_code = $this->input->get('corp_code');
        $result = $this->Api_model->get_ifCorpInfo($corp_code);
        
        $this->send_json($result);
    }

    // 지배 구조 전체보기
    public function IfCorpGovernanceAll()
    {
        $corp_code = $this->input->get('corp_code');
        $std_year = (int) $this->input->get('std_year');
        $result = $this->Api_model->get_ifCorpGovernanceAll($corp_code, $std_year);
        $this->send_json($result);
    }
}