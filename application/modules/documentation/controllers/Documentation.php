<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Documentation extends MY_Controller {

    public function __construct() {
        parent::__construct();
        // Check if user is logged in (standard check in your app)
        if (!$this->session->userdata('user_id')) {
            redirect('auth');
        }
    }

    public function index() {
        $data['title'] = 'System Documentation Guide';
        $this->smarty->loadView('user_guide.tpl', $data, 'Yes', 'Yes');
    }
}
