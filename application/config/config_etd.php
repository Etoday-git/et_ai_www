<?php
defined('BASEPATH') OR exit('No direct script access allowed');

// OPENDART API
$config['opendart_url'] = 'https://opendart.fss.or.kr/api';
$config['opendart_api_key'] = '';                       // 오픈다트 API 키 넣는곳입니다.

// 오픈다트 활용 API 목록
$config['opendart_api'] = [
    // 공시정보 주요정보
    'OP_DA_AP_1_1' => 'list.json',                      // 공시검색
    'OP_DA_AP_1_2' => 'company.json',                   // 기업 대시보드
    'OP_DA_AP_1_3' => 'document.xml',                   // 공시서류원본파일 (바이너리파일>xml) >> DB화 필요
    'OP_DA_AP_1_4' => 'corpCode.xml',                   // 기업 고유번호  (바이너리파일>xml) >> DB화 필요

    // 정기보고서 주요정보
    'OP_DA_AP_2_1' => 'irdsSttus.json',                 // 증자(감자) 현황
    'OP_DA_AP_2_3' => 'tesstkAcqsDspsSttus.json',       // 자기주식 취득 및 처분 현황
    'OP_DA_AP_2_4' => 'hyslrSttus.json',                // 최대주주 현황
    'OP_DA_AP_2_5' => 'hyslrChgSttus.json',             // 최대주주 변동현황
];

$config['openai'] = [
    'api_key'  => '',                                   // OPENAI API 키 넣는곳입니다.   
    'base_url' => 'https://api.openai.com/v1',
    'model'    => 'gpt-4.1-mini',                       // OPENAI 모델 넣는곳입니다. (gpt-4.1-mini, gpt-4.1-turbo ... etc)
    'timeout'  => 60,                                   // seconds
];

$config['opensearch_domain'] = '';                      // OPENSEARCH 도메인 넣는곳입니다.
$config['opensearch_username'] = '';                    // OPENSEARCH 사용자 넣는곳입니다.
$config['opensearch_password'] = '';                    // OPENSEARCH 비밀번호 넣는곳입니다.
$config['opensearch_index'] = 'dart-docs';              
