<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Krxdata extends ETD_Controller {
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Krx_model');
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

    public function index()
    {   
        // $stk_id = "005930"; // 삼성전자
        $result = $this->Krx_model->get_bizcode();
        
        if (!empty($result['BIZCODE_INFO'])) {
            foreach ($result['BIZCODE_INFO'] as $row) {
                $data = array(
                    'MARKET_SEC'        => $row['MARKET_SEC'],
                    'BIZCODE'           => $row['BIZCODE'],
                    'INDEX_TYPE_ID'     => $row['INDEX_TYPE_ID'],
                    'INDEX_TYPE_NM'     => $row['INDEX_TYPE_NM']
                );

                $this->db->insert('ET_KRX_BIZCODE', $data);
            }            
        }
        
    }

    public function import_stk_list() {
        $result = $this->Krx_model->get_stk_list();
        $exist_stk_cd = $this->db->select('STK_CD')->get('ET_KRX_STK_LIST')->result_array();
        $exist_stk_cds = array_column($exist_stk_cd, 'STK_CD');

        if (!empty($result['STK_INFO'])) {
            foreach ($result['STK_INFO'] as $row) {
                
                if (in_array($row['STK_CD'], $exist_stk_cds)) {
                    continue;
                }

                $data = array(
                    'STK_TPCD'                      => $row['STK_TPCD'],
                    'BIZDATE'                       => $row['BIZDATE'],
                    'STK_CD'                        => $row['STK_CD'],
                    'KIND_CODE'                     => $row['KIND_CODE'],
                    'SHORT_CODE'                    => $row['SHORT_CODE'],
                    'NAME_KOREAN'                   => $row['NAME_KOREAN'],
                    'NAME_ENGLISH'                  => $row['NAME_ENGLISH'],
                    'BIZ_ID'                        => $row['BIZ_ID'],
                    'BASIC_PRICE'                   => $row['BASIC_PRICE'],
                    'YESTERDAY_ENDPRICE_CODE'       => $row['YESTERDAY_ENDPRICE_CODE'],
                    'YESTERDAY_DEALING_AMOUNT'      => $row['YESTERDAY_DEALING_AMOUNT'],
                    'YESTERDAY_DEALING_MONEY'       => $row['YESTERDAY_DEALING_MONEY'],
                    'UPPER_LIMIT_PRICE'             => $row['UPPER_LIMIT_PRICE'],
                    'LOWER_LIMIT_PRICE'             => $row['LOWER_LIMIT_PRICE'],
                    'FACE_PRICE'                    => $row['FACE_PRICE'],
                    'INDEX_TYPE'                    => is_array($row['INDEX_TYPE']) ? null : $row['INDEX_TYPE'],
                    'INDEX_TYPE_BIG'                => is_array($row['INDEX_TYPE_BIG']) ? null : $row['INDEX_TYPE_BIG'],
                    'INDEX_TYPE_MID'                => is_array($row['INDEX_TYPE_MID']) ? null : $row['INDEX_TYPE_MID'],
                    'INDEX_TYPE_SML'                => is_array($row['INDEX_TYPE_SML']) ? null : $row['INDEX_TYPE_SML'],
                    'STOCK_TOTAL_AMOUNT'            => $row['STOCK_TOTAL_AMOUNT'],
                    'CAPITAL_AMT'                   => $row['CAPITAL_AMT']
                );

                $this->db->insert('ET_KRX_STK_LIST', $data);
            }            
        }
    }

    // 종목 정보(당일)
    public function import_stk_info() {
        // $stk_id = "005930"; // 삼성전자
        $stk_id = $this->input->get('stk_id');
        $data = $this->Krx_model->get_stk_info($stk_id);

        $this->send_json($data);
    }

    // 종목 정보(3개월)
    public function import_stk_3mnt() {       
        // $stk_id = "005930"; // 삼성전자
        $stk_id = $this->input->get('stk_id');
        $data = $this->Krx_model->get_stk_3mnt($stk_id);
        
        $this->send_json($data);
        // echo "<pre>";
        // print_r($result);        
        // echo "</pre>";
        // exit;

        if (!empty($result['BIZCODE_INFO'])) {
            foreach ($result['BIZCODE_INFO'] as $row) {
                $data = array(
                    'STK_CD'                        => $row['STK_CD'],
                    'BIZDATE'                       => $row['BIZDATE'],
                    'COMPARE_YESTERDAY'             => $row['COMPARE_YESTERDAY'],
                    'COMPARE_YESTERDAY_PRICE'       => $row['COMPARE_YESTERDAY_PRICE'],
                    'YESTERDAY_PRICE'               => $row['YESTERDAY_PRICE'],
                    'CHAGE_RATE'                    => $row['CHAGE_RATE'],
                    'DEALLING_PRICE'                => $row['DEALLING_PRICE'],
                    'DEALLING_AMOUNT'               => $row['DEALLING_AMOUNT'],
                    'MARKET_PRICE'                  => $row['MARKET_PRICE'],
                    'HIGH_PRICE'                    => $row['HIGH_PRICE'],
                    'LOW_PRICE'                     => $row['LOW_PRICE'],
                    'ACCUMULATED_DEALING_PRICE'     => $row['ACCUMULATED_DEALING_PRICE'],
                    'ACCUMULATED_DEALING_AMOUNT'    => $row['ACCUMULATED_DEALING_AMOUNT'],
                );

                $this->db->insert('ET_KRX_STK_3MNT', $data);
            }            
        }
    }

    // 최신 종목 뉴스
    public function import_stk_atc() {
        $stk_id = $this->input->get('stk_id');   
        $result = $this->Krx_model->get_stk_atc($stk_id);
        $data = array_slice($result, 0, 5);

        $this->send_json($data);
    }
}