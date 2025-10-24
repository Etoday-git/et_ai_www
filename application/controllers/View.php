<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class View extends ETD_Controller {

    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        $this->load->view('index');
    }

    public function detail($corp_code = null)
    {
        $this->load->view('detail', ['corp_code' => $corp_code]);
    }


}