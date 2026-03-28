<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Banner extends MY_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->model('Banner_model');
    }
	public function index() {
		$data['base_url'] = base_url();
		$this->smarty->loadView('login.tpl',$data,'No','No');
	}
	/* add update user module */
	
	public function banner()
	{
		$data['banner'] = $this->Banner_model->get_banner();
		$this->smarty->loadView('banner.tpl', $data,'Yes','Yes');
	}


	
	public function add_banner()
{
	
    $ret_arr = [];
    $msg = '';
    $success = 1;

    $config['upload_path'] = './public/uploads/banner/'; 
    $config['allowed_types'] = 'jpg|jpeg|png|gif';
    $config['max_size'] = 2048;
    $config['encrypt_name'] = TRUE;

    $this->load->library('upload', $config);

    if (!$this->upload->do_upload('banner_image')) {
        $ret_arr['msg'] = $this->upload->display_errors();
        $ret_arr['success'] = 0;
        echo json_encode($ret_arr);
        return; 
    }

    $upload_data = $this->upload->data();
    $image_path = $upload_data['file_name'];

    $data = [
        
        'banner_image' => $image_path,
        'added_date' => date("Y-m-d H:i:s"),
        'added_by' => $this->session->userdata('user_id'),
    ];
	// pr($data,1);
    $insert_query = $this->Banner_model->add_banner($data);
	// pr($this->db->last_query(),1);
    if ($insert_query) {
        $msg = 'Banner added successfully.';
    } else {
        $msg = 'Error occurred while adding the Banner. Please try again.';
        $success = 0;
    }

    $ret_arr['msg'] = $msg;
    $ret_arr['success'] = $success;
    echo json_encode($ret_arr);
}

public function update_banner()
{
    $ret_arr = [];
    $msg = '';
    $success = 1;
    
    $banners_id = $this->input->post("banners_id");
    $hidden_banner_image = $this->input->post("hidden_banner_image"); 
    
    $image_path = $hidden_banner_image; 

    if (!empty($_FILES['banner_image']['name'])) {
       
        $config['upload_path'] = './public/uploads/banner/';
        $config['allowed_types'] = 'jpg|jpeg|png|gif';
        $config['max_size'] = 2048;
        $config['encrypt_name'] = TRUE;

        $this->load->library('upload', $config);

        if ($this->upload->do_upload('banner_image')) {
          
            $upload_data = $this->upload->data();
            $image_path = $upload_data['file_name'];

            if (!empty($hidden_banner_image) && file_exists($hidden_banner_image)) {
                unlink($hidden_banner_image);
            }
        } 
    }

    $data = [
       
        'banner_image' => $image_path,
        'update_date' => date("Y-m-d H:i:s"),
        'update_by' => $this->session->userdata('user_id'),
        'status' => $this->input->post("status"),
    ];

    $update_query = $this->Banner_model->update_banner($data, $banners_id);

    if ($update_query) {
        $msg = 'Banner updated successfully.';
    } else {
        $msg = 'Error occurred while updating the Banner. Please try again.';
        $success = 0;
    }

    $ret_arr['msg'] = $msg;
    $ret_arr['success'] = $success;
    echo json_encode($ret_arr);
}
	

public function delete_banners()
{
   
    $ret_arr = [];
    $msg = '';
    $success = 1;
	$banners_id = $this->input->post("banners_id");
    $data = array(
        'is_delete'  => "1",
        'update_date'=> date("Y-m-d H:i:s"),
        'update_by'=> $this->session->userdata('user_id'),
        
    );
    $update_query = $this->Banner_model->update_banner($data, $banners_id);
   
    if ($update_query) {
        $msg = 'Banners delete successfully.';
    } else {
        $msg = 'Error occurred while delete the Banners. Please try again.';
        $success = 0;
    }
    $ret_arr['msg'] = $msg;
    $ret_arr['success'] = $success;
    echo json_encode($ret_arr);
}
	
	
}

