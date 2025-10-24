<?php
/*
| -------------------------------------------------------------------
| @ TITLE   공용 컨트롤러
| -------------------------------------------------------------------
*/

class ETD_Controller extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('ETD_Model');
    }

    public function getParam(string $key, $default = null) {
        return $this->input->get($key, true) ?: $default;
    }
}