<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Unit_master extends MY_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('Unit_master_model');
	}

	public function index()
	{
		$data['base_url'] = base_url();
		$this->smarty->loadView('login.tpl', $data, 'No', 'No');
	}

	public function unit_master()
	{
		$data['base_url'] = base_url();
		$this->smarty->loadView('unit_master.tpl', $data, 'Yes', 'Yes');
	}

	public function add_unit()
	{
		$unit_count = $this->Unit_master_model->count_all();
		$ret_arr = [];
		$msg = '';
		$success = 1;
		$data = array(
			'unit_name'  => $this->input->post("unit_name"),
			'unit_code'  => 'UNT-' . date("Ymd") . ($unit_count + 1),
			'added_date' => date("Y-m-d H:i:s"),
			'added_by'   => $this->session->userdata('user_id'),
		);
		$insert_query = $this->Unit_master_model->add_unit($data);
		if ($insert_query > 0) {
			$msg = 'Unit added successfully.';
		} else if ($insert_query == -1) {
			$msg = 'Unit already exists.';
			$success = 0;
		} else {
			$msg = 'Error occurred while adding the unit. Please try again.';
			$success = 0;
		}
		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;
		$this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
	}

	public function update_unit()
	{
		$ret_arr = [];
		$msg = '';
		$success = 1;
		$unit_id = $this->input->post("unit_id");
		$data = array(
			'unit_name'    => $this->input->post("unit_name"),
			'updated_date' => date("Y-m-d H:i:s"),
			'updated_by'   => $this->session->userdata('user_id'),
			'status'       => $this->input->post("status"),
		);
		$update_query = $this->Unit_master_model->update_unit($data, $unit_id);
		if ($update_query) {
			$msg = 'Unit updated successfully.';
		} else {
			$msg = 'Error occurred while updating the unit. Please try again.';
			$success = 0;
		}
		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;
		$this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
	}

	public function delete_unit()
	{
		$ret_arr = [];
		$msg = '';
		$success = 1;
		$unit_id = $this->input->post("unit_id");
		if (!$unit_id) {
			$ret_arr['msg'] = 'Unit ID is missing.';
			$ret_arr['success'] = 0;
			echo json_encode($ret_arr);
			return;
		}
		$data = array(
			'is_delete'    => 1,
			'updated_date' => date("Y-m-d H:i:s"),
			'updated_by'   => $this->session->userdata('user_id'),
		);
		$update_query = $this->Unit_master_model->update_unit($data, $unit_id);
		if ($update_query) {
			$msg = 'Unit deleted successfully.';
		} else {
			$msg = 'No change made or error occurred. Please try again.';
			$success = 0;
		}
		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;
		$this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
	}

	public function get_units_ajax()
	{
		$postData = $this->input->post();
		$data = $this->Unit_master_model->get_units_ssp($postData);

		$result = array();
		$i = $postData['start'] + 1;
		foreach ($data as $val) {
			$action_html = '<a type="button" class="" data-bs-toggle="modal" data-bs-target="#updateUnit' . $i . '" title="Edit">
                                <i class="ti ti-edit edit-part"></i>
                            </a>
                            <span class="delete_data" title="Delete Record" data-id="' . $val['unit_id'] . '"><i class="ti ti-trash"></i></span>';

			$modal_html = '<div class="modal fade" id="updateUnit' . $i . '" tabindex="-1" role="dialog" aria-labelledby="updateUnitLabel' . $i . '" aria-hidden="true">
                         <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                               <div class="modal-header">
                                  <h5 class="modal-title" id="updateUnitLabel' . $i . '">Update Unit</h5>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                               </div>
                               <form action="' . base_url('update_unit') . '" method="POST" enctype="multipart/form-data" id="update_unit' . $i . '" class="update_unit update_unit' . $i . ' custom-form">
                                <input type="hidden" name="unit_id" value="' . $val['unit_id'] . '">
                               <div class="modal-body">
                                  <div class="form-group mb-3">
                                    <label for="unit_name">Unit Name<span class="text-danger">*</span></label> <br>
                                    <input type="text" name="unit_name" placeholder="Enter Unit Name" class="form-control required-input" value="' . htmlspecialchars($val['unit_name']) . '">
                                  </div>
                                   <div class="form-group mb-3">
                                        <label for="status">Status<span class="text-danger">*</span></label> <br>
                                        <select name="status" class="form-control select2 required-input" id="update_unit_status' . $i . '">
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
			$row[] = htmlspecialchars($val['unit_name']);
			$row[] = htmlspecialchars($val['unit_code'] ?? '-');
			$row[] = $val['status'];
			$row[] = $action_html;

			$result[] = $row;
			$i++;
		}

		$output = array(
			"draw"            => isset($postData['draw']) ? intval($postData['draw']) : 0,
			"recordsTotal"    => $this->Unit_master_model->count_all(),
			"recordsFiltered" => $this->Unit_master_model->count_filtered($postData),
			"data"            => $result,
		);

		$this->output->set_content_type('application/json')->set_output(json_encode($output));
	}
}
