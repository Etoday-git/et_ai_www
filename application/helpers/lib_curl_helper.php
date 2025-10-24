<?php 
    defined('CRPD_API_ACC_KEY') OR define("CRPD_API_ACC_KEY","");       //KRX API 키 넣는곳입니다.
    defined('CRPD_API_SEC_KEY') OR define("CRPD_API_SEC_KEY","");       //KRX API 시크릿 키 넣는곳입니다.

    function setHttpHeader($varAccesskey, $varSingnature, $varQueryTimestamp) {
        $http_header = array();
        
        $http_header[0] = "Content-Type:application/json";
        $http_header[1] = "x-etd-apigw-timestamp:".$varQueryTimestamp."";
        $http_header[2] = "x-etd-iam-access-key:".$varAccesskey."";
        $http_header[3] = "x-etd-apigw-signature-v2:".$varSingnature."";
        
        return $http_header;
    }

    function getTimeStamp_13digit() {
        list($microtime, $timestamp) = explode(' ',microtime());
        $time = $timestamp.substr($microtime, 2, 3);
        return $time;
    }

    function getSignature($access_key, $secret_key, $queryTimestamp, $method="GET") {
        $message = $method;
        $message .= " ";
        $message .= $queryTimestamp;
        $message .= "\n";
        $message .= $access_key;
        
        $signature = base64_encode(hash_hmac('sha256', $message, $secret_key, true));
        
        return $signature;
    }
?>