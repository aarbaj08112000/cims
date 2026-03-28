<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Brand extends MY_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->model('Brand_model');
    }
	public function index() {
		$data['base_url'] = base_url();
		$this->smarty->loadView('login.tpl',$data,'No','No');
	}
	
	public function brand()
	{ 
		$data['brands'] = $this->Brand_model->get_brands();
		$this->smarty->loadView('brands.tpl', $data,'Yes','Yes');
	}
	

	public function add_brand()
	{
		$ret_arr = [];
		$msg = '';
		$success = 1;
		$data = array(
			'brand_name'    => $this->input->post("brand_name"),
			'added_date'    => date("Y-m-d H:i:s"),
			'added_by'      => $this->session->userdata('user_id'),
		);
		$insert_query = $this->Brand_model->add_brand($data);
		if ($insert_query > 0) {
			$msg = 'Brand added successfully.';
		} else if($insert_query == -1){
			$msg = 'Brand already exists.';
			$success = 0;
		}else {
			$msg = 'Error occurred while adding the brand. Please try again.';
			$success = 0;
		}
		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;
		$this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
	}

	public function update_brands()
	{
		$ret_arr = [];
		$msg = '';
		$success = 1;
		$brand_id = $this->input->post("brand_id");
		$data = array(
			'brand_name'    => $this->input->post("brand_name"),
			'updated_date'  => date("Y-m-d H:i:s"),
			'updated_by'    => $this->session->userdata('user_id'),
			'status'        => $this->input->post("status"),
		);

		$update_query = $this->Brand_model->update_brands($data,$brand_id);
		if ($update_query) {
			$msg = 'Brand updated successfully.';
		} else {
			$msg = 'Error occurred while updating the brand. Please try again.';
			$success = 0;
		}
		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;
		$this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
	}

	public function delete_brand()
    {
        $ret_arr = [];
        $msg = '';
        $success = 1;

        $brand_id = $this->input->post("brand_id");

        if (!$brand_id) {
            $ret_arr['msg'] = 'Brand ID is missing.';
            $ret_arr['success'] = 0;
            echo json_encode($ret_arr);
            return;
        }

        $data = array(
            'is_delete'    => 1,
            'updated_date' => date("Y-m-d H:i:s"),
            'updated_by'   => $this->session->userdata('user_id'),
        );

        $update_query = $this->Brand_model->update_brands($data, $brand_id);

        if ($update_query) {
            $msg = 'Brand deleted successfully.';
        } else {
            $msg = 'No change made or error occurred. Please try again.';
            $success = 0;
        }

        $ret_arr['msg'] = $msg;
        $ret_arr['success'] = $success;

        $this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
    }
}
