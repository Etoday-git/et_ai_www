<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Parser extends ETD_Controller {
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Parser_model');
    }

    public function index() {
        $this->load->view('index');
    }
    
    private function validate_rcept_no($rcept_no) {
        // 숫자만 허용, 14자리 고정
        if (!ctype_digit($rcept_no) || strlen($rcept_no) !== 14) {
            throw new Exception('잘못된 접수번호 형식입니다.');
        }
        return $rcept_no;
    }

    // 공통 JSON 응답 처리
    private function json_response($method_name, $rcept_no) {
        header('Content-Type: application/json; charset=utf-8');
        
        try {
            $rcept_no = $this->validate_rcept_no($rcept_no);
            $data = $this->Parser_model->$method_name($rcept_no);
            
            // 정상
            $response = [
                'status'  => '00',
                'message' => '정상',
                'DataList' => $data
            ];
            
            // 데이터 없음 체크
            if (empty($data) || (isset($data['content']) && empty($data['content'])) || 
                (isset($data['data']) && empty($data['data']))) {
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
    }

    // 공시전체요약
    // 기업개황, 주주 현황보고, 타법인출자현황, 최대주주현황, 주요재무지표 
    public function total_info($rcept_no) {
        $this->json_response('get_total_info', $rcept_no);
    }
    
    // 주요사항보고서
    public function MgDecsn_info($rcept_no) {
        $this->json_response('get_mgdecsn_data', $rcept_no);
    }

    // 5% 이상 대주주 현황
    public function big_major_holder_info($rcept_no) {
        $this->json_response('get_big_major_holder_info', $rcept_no);
    }      
}
