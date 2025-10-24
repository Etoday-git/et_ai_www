<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Schema_model extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->load->database(); // ✅ DB 수동 로드
    }

    // ✅ 테이블명 + 코멘트 가져오기
    public function get_tables() {
        $db_name = $this->db->database; // 현재 DB명

        $query = $this->db->query("
            SELECT 
                table_name AS name,
                table_comment AS comment
            FROM information_schema.tables
            WHERE table_schema = '{$db_name}'
            ORDER BY table_name
        ");

        return $query->result_array();
    }

    // ✅ 컬럼 구조 조회
    public function get_table_structure($table) {
        $query = $this->db->query("SHOW FULL COLUMNS FROM `$table`");
        return $query->result_array();
    }
}
