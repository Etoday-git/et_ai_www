<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Opensearch_model extends CI_Model {

    // OpenSearch 설정
    private $domain;
    private $username;
    private $password;
    private $index;
    private $CI;

    public function __construct()
    {
        parent::__construct();

        $this->CI =& get_instance();
        $this->CI->config->load('opensearch', TRUE);
    
        $this->domain = $this->CI->config->item('opensearch_domain', 'opensearch');
        $this->username = $this->CI->config->item('opensearch_username', 'opensearch');
        $this->password = $this->CI->config->item('opensearch_password', 'opensearch');
        $this->index = $this->CI->config->item('opensearch_index', 'opensearch');

    }
    public function get_disclosure_search($page_count, $bgn_de, $end_de, $offset, $corp_code=null, $search_word=null, $fg=null)
    {

        $search_word = trim((string)$search_word);
        $search_word = mb_substr($search_word, 0, 100);
        
        $corp_code = trim((string)$corp_code);
        $corp_code = mb_substr($corp_code, 0, 20);
        
        $page_count = max(1, min(100, (int)$page_count));
        $offset = max(0, (int)$offset);
        
        $bgn_de = preg_match('/^\d{8}$/', $bgn_de) ? $bgn_de : '';
        $end_de = preg_match('/^\d{8}$/', $end_de) ? $end_de : '';
        
        $fg = (string)$fg;
        
        $filters = [];

        if($fg == 'detail') {
            if (!empty($corp_code)) {
                $filters[] = [
                    'match' => [
                        'corp_code' => $corp_code
                    ]
                ];
            }
        } else {
            if (!empty($search_word)) {
            $keywords = array_filter(preg_split('/\s+/', trim($search_word)));
            
            if (count($keywords) > 1) {
                $must_conditions = [];
                
                foreach ($keywords as $keyword) {
                    $must_conditions[] = [
                        'bool' => [
                            'should' => [
                                ['match_phrase' => ['corp_name' => $keyword]],
                                ['match' => ['stock_code' => $keyword]],
                                ['wildcard' => ['report_nm.keyword' => '*' . $keyword . '*']]
                            ],
                            'minimum_should_match' => 1
                        ]
                    ];
                }
                
                $filters[] = [
                    'bool' => [
                        'must' => $must_conditions
                    ]
                ];
                
            } else {
                $filters[] = [
                    'bool' => [
                        'should' => [
                            ['match_phrase' => ['corp_name' => $search_word]],
                            ['match' => ['stock_code' => $search_word]],
                            ['wildcard' => ['report_nm.keyword' => '*' . $search_word . '*']]
                        ],
                        'minimum_should_match' => 1
                    ]
                ];
            }
        }
            
            if (!empty($bgn_de) || !empty($end_de)) {
                $range = [];
                if (!empty($bgn_de) && preg_match('/^\d{8}$/', $bgn_de)) {
                    $range['gte'] = $bgn_de;
                }
                if (!empty($end_de) && preg_match('/^\d{8}$/', $end_de)) {
                    $range['lte'] = $end_de;
                }                

                if (!empty($range)) {
                    $filters[] = [
                        'range' => [
                            'rcept_dt' => $range
                        ]
                    ];
                }
            }
        }

        $result = $this->execute_search($filters, $page_count, $offset);
        
        if ($result === false) {
            return [
                'status' => 'error',
                'DataList' => [
                    'list' => [],
                    'total_count' => 0
                ]
            ];
        }

        $list = [];
        foreach ($result['docs'] as $doc) {
            $list[] = [
                'corp_code' => $doc['corp_code'] ?? '',
                'corp_name' => $doc['corp_name'] ?? '',
                'corp_cls' => $doc['corp_cls'] ?? '',
                'report_nm' => $doc['report_nm'] ?? '',
                'rcept_no' => $doc['rcept_no'] ?? '',
                'rcept_dt' => $doc['rcept_dt'] ?? '',
                'flr_nm' => $doc['flr_nm'] ?? '',
            ];
        }

        return [
            'status' => '00',
            'DataList' => [
                'list' => $list,
                'total_count' => $result['total']
            ]
        ];
    }

    private function execute_search($filters, $size, $from)
    {
        $query = [];
        
        if (empty($filters)) {
            $query = ['match_all' => new stdClass()];
        } else {
            $query = [
                'bool' => [
                    'must' => $filters
                ]
            ];
        }

        $search_body = [
            'query' => $query,
            'from' => $from,
            'size' => $size,
            'sort' => [
                ['rcept_no' => ['order' => 'desc']]
            ]
        ];

        $url = 'https://' . $this->domain . '/' . $this->index . '/_search';
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_USERPWD, $this->username . ':' . $this->password);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // 개발환경
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false); // 개발환경
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($search_body));
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json'
        ]);

        $response = curl_exec($ch);
        $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);
        curl_close($ch);

        if ($error) {
            log_message('error', 'OpenSearch cURL error: ' . $error);
            return false;
        }

        if ($http_code != 200) {
            log_message('error', 'OpenSearch HTTP error: ' . $http_code . ' - ' . $response);
            return false;
        }

        $result = json_decode($response, true);
        
        if (!$result || !isset($result['hits'])) {
            return false;
        }

        $total = isset($result['hits']['total']['value']) 
                ? $result['hits']['total']['value'] 
                : $result['hits']['total'];

        $docs = [];
        if (isset($result['hits']['hits'])) {
            foreach ($result['hits']['hits'] as $hit) {
                $docs[] = $hit['_source'];
            }
        }

        return [
            'total' => $total,
            'docs' => $docs
        ];
    }

}