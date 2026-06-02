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
		$data['base_url'] = base_url();
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

	public function get_brands_ajax() {
		$postData = $this->input->post();
		$data = $this->Brand_model->get_brands_ssp($postData);

		$result = array();
		$i = $postData['start'] + 1;
		foreach ($data as $val) {
			$status_color = ($val['status'] == 'Active') ? 'green' : 'red';
			$status_html = '<td style="font-weight: bold; color: ' . $status_color . ';">' . $val['status'] . '</td>';

			$action_html = '<a type="button" class="" data-bs-toggle="modal" data-bs-target="#updateBrand' . $i . '" title="Edit">
                                <i class="ti ti-edit edit-part" ></i>
                            </a>
                            <span class="delete_data" title="Delete Record" data-id="' . $val['brand_id'] . '"><i class="ti ti-trash"></i></span>';

            $modal_html = '<div class="modal fade" id="updateBrand' . $i . '" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                         <div class="modal-dialog  modal-dialog-centered" role="document">
                            <div class="modal-content">
                               <div class="modal-header">
                                  <h5 class="modal-title" id="exampleModalLabel">Update Brand</h5>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                               </div>
                               <form action="' . base_url('update_brands') . '" method="POST" enctype="multipart/form-data" id="update_brands' . $i . '" class="update_brands update_brands' . $i . ' custom-form">
                                <input type="hidden" name="brand_id" value="' . $val['brand_id'] . '">
                               <div class="modal-body">
                                  <div class="form-group">
                                    <label for="brand_name">Brand Name<span class="text-danger">*</span></label> <br>
                                    <input  type="text" name="brand_name" placeholder="Enter Brand Name" class="form-control required-input" value="' . htmlspecialchars($val['brand_name']) . '" >
                                  </div>
                                   <div class="form-group">
                                        <label for="status">Status<span class="text-danger">*</span></label> <br>
                                        <select name="status" class="form-control select2 required-input" id="update_status' . $i . '">
                                        <option value="Active" ' . ($val['status'] == 'Active' ? 'selected' : '') . '>Active</option>
                                        <option value="Inactive" ' . ($val['status'] == 'Inactive' ? 'selected' : '') . '>Inactive</option>
                                    </select>
                                    </div>
                               </div>
                               <div class="modal-footer">
                               <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                               <button type="submit" class="btn btn-primary">Save changes</button>
                               </div>
                               </form>
                            </div>
                         </div>
                    </div>';

            $action_html .= $modal_html;

			$row = array();
			$row[] = htmlspecialchars($val['brand_name']);
			$row[] = $status_html;
			$row[] = $action_html;

			$result[] = $row;
			$i++;
		}

		$output = array(
			"draw" => isset($postData['draw']) ? intval($postData['draw']) : 0,
			"recordsTotal" => $this->Brand_model->count_all(),
			"recordsFiltered" => $this->Brand_model->count_filtered($postData),
			"data" => $result,
		);

		$this->output->set_content_type('application/json')->set_output(json_encode($output));
	}

}
