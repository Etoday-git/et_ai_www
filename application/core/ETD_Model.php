<?php

class ETD_Model extends CI_Model
{
    protected $baseUrl;
    protected $apiKey;
    protected $apiMap = [];   // DB에서 읽어온 엔드포인트 정보

    public function __construct()
    {
        parent::__construct();

        $this->load->database();

        $this->baseUrl = $this->config->item('opendart_url');
        $this->apiKey  = $this->config->item('opendart_api_key');

        // DB에서 활성화된 API 모두 읽어오기
        $rows = $this->db
                     ->select('AP_KEY, AP_PATH, AP_REQUIRE_PARAMS, AP_OPTIONAL_PARAMS')
                     ->where('AP_IS_ACTIVE', 1)
                     ->get('OP_AP_INFO')
                     ->result_array();

        foreach ($rows as $row) {
            $this->apiMap[$row['AP_KEY']] = [
                'AP_PATH'            => $row['AP_PATH'],
                'AP_REQUIRE_PARAMS'  => is_string($row['AP_REQUIRE_PARAMS']) ? json_decode($row['AP_REQUIRE_PARAMS'], true) : [],
                'AP_OPTIONAL_PARAMS' => is_string($row['AP_OPTIONAL_PARAMS']) ? json_decode($row['AP_OPTIONAL_PARAMS'], true) : [],
            ];
        }
    }

    public function call_opendart_api($apiName, array $params = [])
    {
        if (!isset($this->apiMap[$apiName])) {
            throw new Exception("정의되지 않은 API: {$apiName}");
        }

        $selected_api = $this->apiMap[$apiName];                // 선택한 API 정보 (DB OP_AP_INFO 테이블에서 가져옴)

        // 필수 파라미터 검증
        foreach ($selected_api['AP_REQUIRE_PARAMS'] as $key) {
            if (! array_key_exists($key, $params)) {
                throw new Exception("누락된 필수 파라미터: {$key}");
            }
        }

        $url = $this->baseUrl . '/' . $selected_api['AP_PATH'] . '?crtfc_key=' . $this->apiKey . '&' . http_build_query($params);

        return $this->opendart_api_request($url);
    }

    protected function opendart_api_request($url, $headers = [])
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, ['Accept: application/json',]);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0');

        if (!empty($headers)) {
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        }    
        
        $response = curl_exec($ch);

        if (curl_errno($ch)) {
            throw new Exception("CURL 오류: " . curl_error($ch));
        }

        curl_close($ch);        

        return json_decode($response, true);
    }

}