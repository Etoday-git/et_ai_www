<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Schema extends CI_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->model('Schema_model');
    }

    public function index() {
        $data['tables'] = $this->Schema_model->get_tables();
        $data['schema'] = [];

        foreach ($data['tables'] as $table) {
            $table_name = $table['name'];
            $data['schema'][$table_name] = $this->Schema_model->get_table_structure($table_name);
        }

        $this->load->view('schema_view', $data);
    }
}
