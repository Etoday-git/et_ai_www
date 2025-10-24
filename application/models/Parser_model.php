<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Parser_model extends ETD_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
    }
    
    // DB에서 file_content 가져오기
    public function get_xml_content($rcept_no) {
        $this->db->select('file_content');
        $this->db->where('rcept_no', $rcept_no);
        $this->db->where('file_name', $rcept_no . '.xml');
        $query = $this->db->get('STG_OP_DA_AP_1_3');
        $result = $query->row();
        if (!$result || empty($result->file_content)) {
            throw new Exception('파일을 찾을 수 없습니다.');
        }
        return $result->file_content;
    }
        
    // 최대주주현황 (ATOCID=25)
    private function extract_majorstock_content($xml_content) {
        $title_pattern = '/<TITLE[^>]*ATOCID="25"[^>]*>(.*?)<\/TITLE>/s';
        
        if (!preg_match($title_pattern, $xml_content, $title_match, PREG_OFFSET_CAPTURE)) {
            return '';
        }
        
        $title_end = $title_match[0][1] + strlen($title_match[0][0]);
        
        // TABLE-GROUP 찾기
        $after_title = substr($xml_content, $title_end);
        $table_pattern = '/<TABLE-GROUP[^>]*>(.*?)<\/TABLE-GROUP>/s';
        
        if (preg_match($table_pattern, $after_title, $table_match)) {
            $table_content = $table_match[1];
            return $this->xml_to_text($table_content);
        }
        
        return '';
    }

    private function extract_single_content($xml_content, $target_atocid) {
        $title_pattern = '/<TITLE[^>]*ATOCID="' . preg_quote($target_atocid, '/') . '"[^>]*>(.*?)<\/TITLE>/s';
        
        if (!preg_match($title_pattern, $xml_content, $title_match, PREG_OFFSET_CAPTURE)) {
            return null;
        }
        
        $title_start = $title_match[0][1];
        $before_title = substr($xml_content, 0, $title_start);
        
        if (preg_match_all('/<SECTION-(\d+)[^>]*>/', $before_title, $section_matches, PREG_OFFSET_CAPTURE)) {
            $last_section = end($section_matches[0]);
            $section_start = $last_section[1];
            $section_level = end($section_matches[1])[0];
            
            $section_end_pattern = '/<\/SECTION-' . $section_level . '>/';
            $after_section_start = substr($xml_content, $section_start);
            
            if (preg_match($section_end_pattern, $after_section_start, $end_match, PREG_OFFSET_CAPTURE)) {
                $section_end = $section_start + $end_match[0][1];
                
                $section_content = substr($xml_content, $section_start, $section_end - $section_start + strlen($end_match[0][0]));
                
                return $this->xml_to_text($section_content);
            }
        }
        
        return null;
    }

    public function get_total_info($rcept_no) {
        $xml_content = $this->validate_and_get_xml($rcept_no);
        
        // 기업개황 (ATOCID 4~7)
        $corp_info_sections = [];
        $corp_target_atocids = [
            '4' => '회사의 개요',
            '5' => '회사의 연혁', 
            '6' => '자본금 변동사항',
            '7' => '주식의 총수 등'
        ];
        
        foreach ($corp_target_atocids as $atocid => $section_name) {
            $section_content = $this->extract_single_content($xml_content, $atocid);
            if ($section_content) {
                $corp_info_sections[] = [
                    'title' => $section_name,
                    'content' => $section_content
                ];
            }
        }

        $stock_info_content = $this->extract_single_content($xml_content, '25');
        $cpr_invstmnt_content = $this->extract_single_content($xml_content, '39');
        $cmpny_indx_content = $this->extract_single_content($xml_content, '11');
        $majorstock_content = $this->extract_majorstock_content($xml_content);

        if (
            empty($corp_info_sections) &&
            empty($stock_info_content) &&
            empty($cpr_invstmnt_content) &&
            empty($cmpny_indx_content) &&
            empty($majorstock_content)
        ) {
            throw new Exception('데이터가 없습니다.');
        }

        return [
            'rcept_no' => $rcept_no,
            'corp_info_raw' => $this->format_sections_to_text($corp_info_sections),
            'stock_info_raw' => $stock_info_content ?: '',
            'majorstock_info_raw' => $majorstock_content,
            'CprInvstmnt_info_raw' => $cpr_invstmnt_content ?: '',
            'CmpnyIndx_info_raw' => $cmpny_indx_content ?: ''
        ];

    }

    // 주요사항보고서 
    public function get_mgdecsn_data($rcept_no) {
        $tables = [
            'STG_OP_DA_AP_5_2', 'STG_OP_DA_AP_5_3', 'STG_OP_DA_AP_5_4', 'STG_OP_DA_AP_5_5',
            'STG_OP_DA_AP_5_6', 'STG_OP_DA_AP_5_7', 'STG_OP_DA_AP_5_8', 'STG_OP_DA_AP_5_9',
            'STG_OP_DA_AP_5_10', 'STG_OP_DA_AP_5_11', 'STG_OP_DA_AP_5_12', 'STG_OP_DA_AP_5_13',
            'STG_OP_DA_AP_5_25', 'STG_OP_DA_AP_5_26', 'STG_OP_DA_AP_5_33', 'STG_OP_DA_AP_5_34',
            'STG_OP_DA_AP_5_35', 'STG_OP_DA_AP_5_36'
        ];
        
        $all_content = '';
        $found_rcept_nos = [];
        
        foreach ($tables as $table) {
            $this->db->select('rcept_no');
            $this->db->from($table);
            $this->db->where('rcept_no', $rcept_no);
            $query = $this->db->get();
            
            if ($query === false) {
                continue;
            }
            
            $results = $query->result_array();
            foreach ($results as $row) {
                if (!in_array($row['rcept_no'], $found_rcept_nos)) {
                    $found_rcept_nos[] = $row['rcept_no'];
                }
            }
        }
        
        foreach ($found_rcept_nos as $found_rcept_no) {
            $this->db->select('file_content');
            $this->db->from('STG_OP_DA_AP_1_3');
            $this->db->where('rcept_no', $found_rcept_no);
            $this->db->where('file_name', $found_rcept_no . '.xml');
            $query = $this->db->get();
            
            if ($query && $query->num_rows() > 0) {
                $result = $query->row();
                if (!empty($result->file_content)) {
                    $clean_content = $this->xml_to_text($result->file_content);
                    $all_content .= $clean_content . ' ';
                }
            }
        }
        
        if (empty(trim($all_content))) {
            throw new Exception('데이터가 없습니다.');
        }

        return [
            'rcept_no' => $rcept_no,
            'type' => 'MgDecsn_info',
            'type_name' => '주요사항보고서',
            'content' => trim($all_content)
        ];
    }

    // 5% 이상 대주주 현황
    public function get_big_major_holder_info($rcept_no) {
        $xml_content = $this->validate_and_get_xml($rcept_no);
        $major_holder_data = $this->extract_major_holder_array($xml_content);

        if (empty($major_holder_data)) {
            throw new Exception('데이터가 없습니다.');
        }

        return [
            'rcept_no' => $rcept_no,
            'type' => 'major_holder_info',
            'type_name' => '5% 이상 대주주 현황',
            'data' => $major_holder_data
        ];
    }

    // 5% 이상 대주주 현황 배열
    private function extract_major_holder_array($xml_content) {
        // ACLASS="SH5_PRE_STT"를 가진 TABLE-GROUP 찾기
        $table_pattern = '/<TABLE-GROUP[^>]*ACLASS="SH5_PRE_STT"[^>]*>(.*?)<\/TABLE-GROUP>/s';
        
        if (!preg_match($table_pattern, $xml_content, $table_match)) {
            return [];
        }
        
        $table_content = $table_match[1];
        
        // SH5_NM, SH5_TOT_CNT, SH5_TOT_RT 순서로 데이터 추출
        $nm_pattern = '/<TE[^>]*ACODE="SH5_NM"[^>]*>(.*?)<\/TE>/s';
        $cnt_pattern = '/<TE[^>]*ACODE="SH5_TOT_CNT"[^>]*>(.*?)<\/TE>/s';
        $rt_pattern = '/<TE[^>]*ACODE="SH5_TOT_RT"[^>]*>(.*?)<\/TE>/s';
        
        preg_match_all($nm_pattern, $table_content, $nm_matches);
        preg_match_all($cnt_pattern, $table_content, $cnt_matches);
        preg_match_all($rt_pattern, $table_content, $rt_matches);
        
        $result_array = [];
        $count = max(count($nm_matches[1]), count($cnt_matches[1]), count($rt_matches[1]));
        
        for ($i = 0; $i < $count; $i++) {
            $nm = isset($nm_matches[1][$i]) ? $this->xml_to_text($nm_matches[1][$i]) : '';
            $cnt = isset($cnt_matches[1][$i]) ? str_replace(',', '', $this->xml_to_text($cnt_matches[1][$i])) : '';
            $rt = isset($rt_matches[1][$i]) ? str_replace('%', '', $this->xml_to_text($rt_matches[1][$i])) : '';
            $rt = isset($rt_matches[1][$i]) ? (float) str_replace(' ', '', $this->xml_to_text($rt_matches[1][$i])) : '';

            if (!empty($nm) && $nm !== '-' && !empty($cnt) && $cnt !== '-' && !empty($rt) && $rt !== '-') {
                $result_array[] = [
                    'holder_name' => $nm,
                    'stock_count' => $cnt,
                    'stock_ratio' => $rt
                ];
            }
        }
        
        return $result_array;
    }

    private function xml_to_text($xml) {
        $text = strip_tags($xml);
        $text = preg_replace('/\s+/', ' ', $text);
        $text = str_replace(['&nbsp;', '&lt;', '&gt;', '&amp;', '&#160;'], [' ', '<', '>', '&', ' '], $text);
        return trim($text);
    }

    // 텍스트 변환
    private function format_sections_to_text($sections) {
        if (empty($sections)) {
            return '';
        }
        
        $text = '';
        foreach ($sections as $section) {
            $text .= $section['title'] . ' ' . $section['content'] . ' ';
        }
        
        return trim($text);
    }
    
    private function validate_and_get_xml($rcept_no) {
        $xml_content = $this->get_xml_content($rcept_no);
        if (!$xml_content) {
            throw new Exception('파일을 찾을 수 없습니다.');
        }
        return $xml_content;
}

}
