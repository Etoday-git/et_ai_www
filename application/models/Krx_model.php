<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Krx_Model extends ETD_Model {
    public function __construct()
    {
        parent::__construct();
    }

    public function get_bizcode()
    {
        $url = "https://restapi.etoday.co.kr/crpd/etoday_crpd_bizcode.php";

        $varQueryTimestamp = getTimeStamp_13digit();
        $varApiSignature   = getSignature(CRPD_API_ACC_KEY, CRPD_API_SEC_KEY, $varQueryTimestamp);
        $http_header       = setHttpHeader(CRPD_API_ACC_KEY, $varApiSignature, $varQueryTimestamp);

        // 공통 curl요청 함수
        return $this->opendart_api_request($url, $http_header);
    }

    public function get_stk_list()
    {
        $url	= "https://restapi.etoday.co.kr/crpd/etoday_crpd_stk_list.php";   // KRX 기업리스트        

        $varQueryTimestamp = getTimeStamp_13digit();
        $varApiSignature   = getSignature(CRPD_API_ACC_KEY, CRPD_API_SEC_KEY, $varQueryTimestamp);
        $http_header       = setHttpHeader(CRPD_API_ACC_KEY, $varApiSignature, $varQueryTimestamp);

        // 공통 curl요청 함수
        return $this->opendart_api_request($url, $http_header);
    }

    public function get_stk_info($skt_id)
    {
        $data   = array();
        $data['stk_id'] = $skt_id;
        $varParam = http_build_query($data);
        
        $url	= "https://restapi.etoday.co.kr/crpd/etoday_crpd_stk_info.php?".$varParam;   // KRX 기업정보      

        $varQueryTimestamp = getTimeStamp_13digit();
        $varApiSignature   = getSignature(CRPD_API_ACC_KEY, CRPD_API_SEC_KEY, $varQueryTimestamp);
        $http_header       = setHttpHeader(CRPD_API_ACC_KEY, $varApiSignature, $varQueryTimestamp);

        // 공통 curl요청 함수
        return $this->opendart_api_request($url, $http_header);
    }

    public function get_stk_3mnt($skt_id)
    {
        $data   = array();
        $data['stk_id'] = $skt_id;
        $varParam = http_build_query($data);

        $url	= "https://restapi.etoday.co.kr/crpd/etoday_crpd_stk_3mnt.php?".$varParam; // 3개월 주가        

        $varQueryTimestamp = getTimeStamp_13digit();
        $varApiSignature   = getSignature(CRPD_API_ACC_KEY, CRPD_API_SEC_KEY, $varQueryTimestamp);
        $http_header       = setHttpHeader(CRPD_API_ACC_KEY, $varApiSignature, $varQueryTimestamp);

        // 공통 curl요청 함수
        return $this->opendart_api_request($url, $http_header);
    }

    public function get_stk_atc($skt_id)
    {
        $data   = array();
        $data['stk_id'] = $skt_id;
        $varParam = http_build_query($data);

        $url	= "https://restapi.etoday.co.kr/crpd/etoday_crpd_stk_atc.php?".$varParam; // 관련기사
        
        $varQueryTimestamp = getTimeStamp_13digit();
        $varApiSignature   = getSignature(CRPD_API_ACC_KEY, CRPD_API_SEC_KEY, $varQueryTimestamp);
        $http_header       = setHttpHeader(CRPD_API_ACC_KEY, $varApiSignature, $varQueryTimestamp);

        // 공통 curl요청 함수
        return $this->opendart_api_request($url, $http_header);
    }
}