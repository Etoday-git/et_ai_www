<?php

class OPENDART_Model extends ETD_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    private function _get_param_url($url, $param)
    {
        // return $url . '?' . http_build_query($param);
    }
}