<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Llmsumy extends ETD_Controller {

    private const GOV_SYSTEM_PROMPT = '너는 기업의 지배구조 분석 전문가이다. 
    오픈다트 공시에서 이사회, 감사, 주요 주주, 임원 인사 변동과 관련된 사항을 빠짐없이 찾아내고 요약한다. 
    결과는 날짜, 변동 주체(인물·조직), 변동 유형(선임/해임/변경 등), 의미(지배구조 영향)를 간결하게 5줄 이내로 정리한다.';
    private const GOV_USER_PROMPT = '다음 오픈다트 공시 문서를 지배구조 변동 관점에서 요약해줘:\n';
    private const ANALYST_SYSTEM_PROMPT = '너는 입력된 긴 문장을 간결하고 핵심만 남기는 요약기로 동작한다.';
    private const ANALYST_USER_PROMPT = '아래 텍스트를 3줄 이내로 요약하라:\n';
    private const OUTPUT_FORMAT_NL = ' 각 핵심 내용은 줄바꿈으로 구분해줘.';
            

    public function __construct()
    {
        parent::__construct();
        $this->load->config('openai', true);
        $this->cfg = $this->config->item('openai')['openai'];
        
        if (empty($this->cfg['api_key'])) {
            show_error('OPENAI_API_KEY 환경변수를 설정하세요.', 500);
        }

        $this->load->model('Llmsumy_model');

        // 폼 테스트용
        $this->load->helper(['url', 'html', 'form']);
        //$this->load->library('security'); // XSS Filtering
    }

    public function index()
    {
        exit;
        //$this->load->view();
    }

    public function make()
    {
        $param = $this->input->post();

        $pro_system=$param["pro_system"];
        $pro_user=$param["pro_user"];
        $rcept_no=$param["rce_no"];        
        $raw_data=array();

        if ($pro_system==""){
                $pro_system = '너는 입력된 긴 문장을 간결하고 핵심만 남기는 요약기로 동작한다.';
                
//                 $pro_system = '너는 기업의 지배구조 분석 전문가이다.  
// 오픈다트 공시에서 이사회, 감사, 주요 주주, 임원 인사 변동과 관련된 사항을 빠짐없이 찾아내고 요약한다.  
// 결과는 날짜, 변동 주체(인물·조직), 변동 유형(선임/해임/변경 등), 의미(지배구조 영향)를 간결하게  5줄 이내로 정리한다.  ';


        }

        if ($pro_user==""){
                $pro_user = '아래 텍스트를 3줄 이내로 요약하라:\n';
                // $pro_user = '다음 오픈다트 공시 문서를 지배구조 변동 관점에서 요약해줘.\n';


        }else{
                $pro_user = $pro_user.'\n';
        }

        if (isset($param["raw_data"])){
            $raw_data=$param["raw_data"];              
        }else{
            array_push($raw_data, "total_info");
        }

        $set_data=array();
        $set_data["pro_system"]=$pro_system;
        $set_data["pro_user"]=$pro_user;
        $set_data["rcept_no"]=$rcept_no;
        $set_data["raw_data"]=$raw_data;     
        
        $data=$this->set_llm($set_data);
        // var_dump($data);
        // exit;
        
        if(isset($data['output'])){
            $summary = $data['output'];
            $result_flag=true;
        }else{
            $result_flag=false;
            $summary = "요약실패 : ".$data;
        }

        return $this->json([
            'ok'=>$result_flag,
            'summary'=>$summary,
            'usage'=>$data['usage'] ?? null,
        ]);
    }

    public function make_summary($rcept_no = null)
    {
        if (empty($rcept_no)) {
            $rcept_no = $this->input->post('rcept_no');
        }

        if (!$rcept_no) {
            return $this->json([
                'ok' => false,
                'summary' => '접수번호가 없습니다.'
            ]);
        }

        $summary = $this->Llmsumy_model->get_summary($rcept_no);

        if ($summary) {
            $summary_text = $summary['summary'] ?? $summary['MgDecsn_info_sumy'] ?? '';
            return $this->json([
                'ok' => true,
                'summary' => $summary_text
            ]);
        }

        $pro_system = self::GOV_SYSTEM_PROMPT . self::OUTPUT_FORMAT_NL;
        $pro_user = self::GOV_USER_PROMPT;

        $set_data = array(
            "pro_system" => $pro_system,
            "pro_user" => $pro_user,
            "rcept_no" => $rcept_no
        );

        $data = $this->set_llm($set_data);


        if ($data['ok']) {
            $disclosure = $this->Llmsumy_model->get_report_info($rcept_no);
            $pblntf_ty = $disclosure[0]['pblntf_ty'] ?? '';

            $this->Llmsumy_model->save_summary($rcept_no, $pblntf_ty, $data['summary']);
            
            return $this->json([
                'ok' => true,
                'summary' => $data['summary'],
                'usage' => $data['usage']
            ]);
        } else {
            return $this->json([
                'ok' => false,
                'summary' => $data['summary'],
                'usage' => $data['usage']
            ]);
        }
    }

    // AI분석 내용 생성
    // URL: /llmsumy/corp_summary/00164618
public function corp_summary($corp_code = null)
{
    if ($this->input->method() == 'post') {
        $corp_code = $this->input->post('corp_code', TRUE);
    }

    if (empty($corp_code) || !preg_match('/^[0-9]{8}$/', $corp_code)) {
        return $this->json(['success' => false, 'message' => '유효하지 않은 기업 코드입니다.'], 400);
    }

    try {
        $data = $this->Llmsumy_model->get_corp_data($corp_code);

        if (empty($data['ceo_data'])) {
            return $this->json([
                'success' => false, 
                'message' => '존재하지 않은 기업 코드입니다.'
            ], 404);
        }

        $corp_name = '';
        if (!empty($data['ceo_data'][0]['corp_name'])) {
            $corp_name = strip_tags($data['ceo_data'][0]['corp_name']);
        }
        
            $new_raw_data_hash = md5(json_encode($data));

            $cache = $this->Llmsumy_model->get_corp_summary_cache($corp_code);
        
            if (!empty($cache) && isset($cache['raw_data_hash']) && $cache['raw_data_hash'] === $new_raw_data_hash) {

                $disclosure_list = $this->Llmsumy_model->get_disclosure_summaries($data['disclosure_data']);
                $disclosure_summaries = [];
                foreach ($disclosure_list as $item) {
                    if ($item['from_db']) {
                        $disclosure_summaries[] = "[" . trim($item['report_nm']) . "]\n{$item['summary']}";
                    }
                }
                $disclosure_summary = implode("\n\n", $disclosure_summaries);
                
                return $this->json([
                    'success' => true,
                    'data' => [
                        'corp_name'           => $corp_name,
                        'executive_summary'   => strip_tags($cache['executive_summary']),
                        'shareholder_summary' => strip_tags($cache['shareholder_summary']),
                        'disclosure_summary'  => strip_tags($disclosure_summary),
                        'final_summary'       => strip_tags($cache['final_summary']),
                        'token_usage'         => ['cached_at' => $cache['last_updated'], 'hash_match' => true]
                    ]
                ]);
            }

        $executive_text = $this->Llmsumy_model->get_executive_summary(
            $data['ceo_data'], 
            $data['executive_data']
        );
        $exec_result = $this->get_llm(
            self::ANALYST_SYSTEM_PROMPT,
            self::ANALYST_USER_PROMPT . $executive_text
        );
        $executive_summary = $exec_result['ok'] ? $exec_result['summary'] : "";

        $shareholder_text = $this->Llmsumy_model->make_shareholder_summary(
            $data['in_corp_list'],
            $data['out_corp_list'],
            $data['major_shareholder'],
            $data['ownership']
        );
        $share_result = $this->get_llm(
            self::ANALYST_SYSTEM_PROMPT,
            self::ANALYST_USER_PROMPT . $shareholder_text
        );
        $shareholder_summary = $share_result['ok'] ? $share_result['summary'] : "";

        $disclosure_list = $this->Llmsumy_model->get_disclosure_summaries($data['disclosure_data']);
        $disclosure_summaries = [];
        
        
        foreach ($disclosure_list as $item) {
            if ($item['from_db']) {
                $disclosure_summaries[] = "[" . trim($item['report_nm']) . "]\n{$item['summary']}";            
            } else if (isset($item['need_generation']) && $item['need_generation']) {
                $llm_result = $this->set_llm([
                        'pro_system' => self::GOV_SYSTEM_PROMPT . self::OUTPUT_FORMAT_NL,
                        'pro_user'   => self::GOV_USER_PROMPT,
                        'rcept_no'   => $item['rcept_no']
                    ]);
                
                    if ($llm_result['ok']) {
                        $summary = $llm_result['summary'];
                        $this->Llmsumy_model->save_summary($item['rcept_no'], $item['pblntf_ty'], $summary);
                        $disclosure_summaries[] = "[" . trim($item['report_nm']) . "][LLM]\n{$summary}";
                    }
                }
            }
            $disclosure_summary = implode("\n\n", $disclosure_summaries);
        
            $combined_text = "대표이사 및 임원 현황:{$executive_summary}\n\n" .
            "주주 구성:{$shareholder_summary}\n\n" .
            "최근 공시 5개:{$disclosure_summary}";

            $final_prompt = str_replace('5줄', '10줄', self::GOV_SYSTEM_PROMPT);
            $final_result = $this->get_llm(
            $final_prompt . self::OUTPUT_FORMAT_NL,
            self::GOV_USER_PROMPT . $combined_text
            );

            $final_summary = $final_result['ok'] ? $final_result['summary'] : "";
            $token_usage = $final_result['usage'] ?? null;

            $cache_data = [
                'executive_summary'   => $executive_summary,
                'shareholder_summary' => $shareholder_summary,
                'final_summary'       => $final_summary,
                'raw_data_hash'       => $new_raw_data_hash
            ];
            $this->Llmsumy_model->save_corp_summary_cache($corp_code, $cache_data);


            return $this->json([
                'success' => true,
                'data' => [
                    'corp_name'           => $corp_name,
                    'executive_summary'   => strip_tags($executive_summary),
                    'shareholder_summary' => strip_tags($shareholder_summary),
                    'disclosure_summary'  => strip_tags($disclosure_summary),
                    'final_summary'       => strip_tags($final_summary),
                    'token_usage'         => $token_usage
                ]
            ]);

    } catch (Exception $e) {
        return $this->json(['success' => false, 'message' => '요약 생성 중 오류가 발생했습니다.'], 500);
    }
}

    public function set_llm($params)
    {
        $pro_system = $params["pro_system"] ?? '';
        $pro_user   = $params["pro_user"] ?? '';
        $rcept_no   = $params["rcept_no"] ?? '';    
        
        if (empty($pro_system)) {
            return ['ok' => false, 'summary' => "System prompt를 입력해주세요.", 'usage' => null];
        }
        if (empty($pro_user)) {
            return ['ok' => false, 'summary' => "User prompt를 입력해주세요.", 'usage' => null];
        }
        if (empty($rcept_no)) {
            return ['ok' => false, 'summary' => "원문 번호를 입력해주세요.", 'usage' => null];
        }

        $disclosure = $this->Llmsumy_model->get_report_info($rcept_no);

        if (empty($disclosure)) {
            return ['ok' => false, 'summary' => "공시 원문 정보가 없습니다.", 'usage' => null];
        }
        $disclosure = $disclosure[0];

        $data = $this->Llmsumy_model->get_report($rcept_no, $disclosure["pblntf_ty"]);

        $text = '';
        if (isset($data[0])) {
            if ($disclosure["pblntf_ty"] == "A"){
                $text = "기업개황:".($data[0]["corp_info_raw"] ?? '')."\n";
                $text .= "주주 현황보고:".($data[0]["stock_info_raw"] ?? '')."\n";
                $text .= "타법인출자현황:".($data[0]["CprInvstmnt_info_raw"] ?? '')."\n";
                $text .= "최대주주현황:".($data[0]["majorstock_info_raw"] ?? '')."\n";
                $text .= "주요재무지표:".($data[0]["CmpnyIndx_info_raw"] ?? '');
            } else {
                $text = $data[0]["content"] ?? '';
            }
        } else {
            return ['ok' => false, 'summary' => '원문 데이터가 없습니다.', 'usage' => null];
        }

        if (empty(trim($text))) {
            return ['ok' => false, 'summary' => '요약할 원문 텍스트가 비어있습니다.', 'usage' => null];
        }

        $pro_user = $pro_user.'\n'.$text;
        $pro_user_combined = $pro_user . '\n' . $text;
        return $this->get_llm($pro_system, $pro_user_combined);
    }

    public function get_llm($pro_system, $pro_user)
    {
        $payload = [
            'model' => $this->cfg['model'], // gpt-4.1-mini
            'input' => [
                ['role'=>'system','content'=>$pro_system],
                ['role'=>'user','content'=>$pro_user],
            ],
            'max_output_tokens' => 1500,
        ];

        $res = $this->call_openai('/responses', $payload);

        if(!$res['ok']){
            return ['ok'=>false, 'summary'=>$res['error'], 'usage' => null];
        }

        $data = $res['data'];
        $usage = $data['usage'] ?? null;

        if (isset($data['output'][0]['content'][0]['text'])) {
            $summary_text = $data['output'][0]['content'][0]['text'];
            return ['ok' => true, 'summary' => $summary_text, 'usage' => $usage];
        } else if (isset($data['output']) && is_string($data['output'])) {
           return ['ok' => true, 'summary' => $data['output'], 'usage' => $usage];
        } else {
            return [
                'ok' => false, 
                'summary' => "요약 실패: 알 수 없는 API 응답 형식입니다. " . json_encode($data, JSON_UNESCAPED_UNICODE), 
                'usage' => $usage
            ];
        }
    }

    private function call_openai($path, array $payload)
    {
        $url = rtrim($this->cfg['base_url'],'/').$path;
        $headers = [
            'Authorization: Bearer '.$this->cfg['api_key'],
            'Content-Type: application/json',
        ];

        $ch = curl_init($url);
        $options = [
            CURLOPT_POST=>true,
            CURLOPT_RETURNTRANSFER=>true,
            CURLOPT_HTTPHEADER=>$headers,
            CURLOPT_POSTFIELDS=>json_encode($payload,JSON_UNESCAPED_UNICODE),
            CURLOPT_TIMEOUT=>(int)($this->cfg['timeout'] ?? 60),
        ];
        
        curl_setopt_array($ch, $options);

        $resp=curl_exec($ch);
        $http=curl_getinfo($ch,CURLINFO_RESPONSE_CODE);
        $err=curl_error($ch);
        curl_close($ch);

        if($resp===false){
            return ['ok'=>false,'error'=>$err];
        }

        if($http<200||$http>=300){
            return ['ok'=>false,'error'=>"HTTP {$http}:{$resp}"];
        }

        $data=json_decode($resp,true);
        return ['ok'=>true,'data'=>$data];
    }

    private function json($data, $status = 200){
        if ($status === 200 && (isset($data['ok']) && $data['ok'] === false) || (isset($data['success']) && $data['success'] === false)) {
            $status = 400;
        }
        
        return $this->output
            ->set_status_header($status)
            ->set_content_type('application/json','utf-8')
            ->set_output(json_encode($data,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES));
    }

    // 원문 데이터 존재 여부
    public function check_data()
    {
        $rcept_no_list = $this->input->post('rcept_no_list');
        
        if (empty($rcept_no_list) || !is_array($rcept_no_list)) {
            return $this->json(['results' => []]);
        }
        
        $results = [];
        
        foreach ($rcept_no_list as $rcept_no) {
            $disclosure = $this->Llmsumy_model->get_report_info($rcept_no);
            
            if (empty($disclosure)) {
                $results[$rcept_no] = false;
                continue;
            }
            $pblntf_ty = $disclosure[0]["pblntf_ty"];
            $data = $this->Llmsumy_model->get_report($rcept_no, $pblntf_ty);
            
            $text_exists = false;
            if (!empty($data) && isset($data[0])) {
                if ($pblntf_ty == 'A') {
                    $text_exists = !empty($data[0]["corp_info_raw"]) ||
                                   !empty($data[0]["stock_info_raw"]) ||
                                   !empty($data[0]["CprInvstmnt_info_raw"]) ||
                                   !empty($data[0]["majorstock_info_raw"]) ||
                                   !empty($data[0]["CmpnyIndx_info_raw"]);
                } else {
                    $text_exists = !empty($data[0]["content"]);
                }
            }
            $results[$rcept_no] = $text_exists;
        }
        
        return $this->json(['results' => $results]);
    }
}