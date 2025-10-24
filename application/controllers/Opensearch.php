<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Opensearch extends CI_Controller {

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Opensearch_model');
    }

    public function IfDisclosureOpenSearch()
    {       
        $page_no    = $this->input->get('page_no') ?: 1;
        $page_count = $this->input->get('page_count') ?: 10;
        $corp_code  = $this->input->get('corp_code');
        $search_word  = $this->input->get('search_word');
        $bgn_de     = $this->input->get('bgn_de');
        $end_de     = $this->input->get('end_de');
        $offset     = ($page_no - 1) * $page_count;
        $fg         = $this->input->get('fg');

        $result = $this->Opensearch_model->get_disclosure_search(
            $page_count, $bgn_de, $end_de, $offset, $corp_code, $search_word, $fg
        );
        
        $this->send_json($result);
    }

    private function send_json($data)
    {
        $this->output
            ->set_content_type('application/json')
            ->set_output(json_encode($data, JSON_UNESCAPED_UNICODE));
    }
}