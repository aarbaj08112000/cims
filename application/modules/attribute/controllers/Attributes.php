<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Attributes extends MY_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('Attribute_model');
	}

	public function index()
	{
		$data['base_url'] = base_url();
		$this->smarty->loadView('login.tpl', $data, 'No', 'No');
	}

	public function attribute()
	{
		$data['attributes'] = $this->Attribute_model->get_attributes();
		$data['base_url'] = base_url();
		$this->smarty->loadView('attributes.tpl', $data, 'Yes', 'Yes');
	}

	public function add_attribute()
	{
		$attribute_count = count($this->Attribute_model->get_attributes());
		$ret_arr = [];
		$msg = '';
		$success = 1;
		$data = array(
			'attribute_name' => $this->input->post("attribute_name"),
			'attribute_code' => 'ATT-' . date("Ymd") . ($attribute_count + 1),
			'added_date' => date("Y-m-d H:i:s"),
			'added_by' => $this->session->userdata('user_id'),
		);
		$insert_query = $this->Attribute_model->add_attribute($data);
		if ($insert_query > 0) {
			$msg = 'Attribute added successfully.';
		} else if ($insert_query == -1) {
			$msg = 'Attribute already exists.';
			$success = 0;
		} else {
			$msg = 'Error occurred while adding the attribute. Please try again.';
			$success = 0;
		}
		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;
		$this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
	}

	public function update_attributes()
	{
		$ret_arr = [];
		$msg = '';
		$success = 1;
		$attribute_id = $this->input->post("attribute_id");
		$data = array(
			'attribute_name' => $this->input->post("attribute_name"),
			'updated_date' => date("Y-m-d H:i:s"),
			'updated_by' => $this->session->userdata('user_id'),
			'status' => $this->input->post("status"),
		);

		$update_query = $this->Attribute_model->update_attributes($data, $attribute_id);
		if ($update_query) {
			$msg = 'Attribute updated successfully.';
		} else {
			$msg = 'Error occurred while updating the attribute. Please try again.';
			$success = 0;
		}
		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;
		$this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
	}

	public function delete_attribute()
	{
		$ret_arr = [];
		$msg = '';
		$success = 1;

		$attribute_id = $this->input->post("attribute_id");

		if (!$attribute_id) {
			$ret_arr['msg'] = 'Attribute ID is missing.';
			$ret_arr['success'] = 0;
			echo json_encode($ret_arr);
			return;
		}

		$data = array(
			'is_delete' => 1,
			'updated_date' => date("Y-m-d H:i:s"),
			'updated_by' => $this->session->userdata('user_id'),
		);

		$update_query = $this->Attribute_model->update_attributes($data, $attribute_id);

		if ($update_query) {
			$msg = 'Attribute deleted successfully.';
		} else {
			$msg = 'No change made or error occurred. Please try again.';
			$success = 0;
		}

		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;

		$this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
	}

	public function export_pdf()
	{
		$data['attributes'] = $this->Attribute_model->get_attributes();
		$data['base_url'] = base_url();

		$html = $this->smarty->loadView('export_attribute_pdf.tpl', $data, 'No', 'No', TRUE);

		$this->load->library('Pdf');
		$pdf = new Pdf();
		$pdf->loadHtml($html);
		$pdf->setPaper('A4', 'portrait');
		$pdf->render();
		$pdf->stream('Attribute_Report_' . date('Y-m-d') . '.pdf', array('Attachment' => 0));
	}

	public function get_attributes_ajax()
	{
		$postData = $this->input->post();
		$data = $this->Attribute_model->get_attributes_ssp($postData);

		$result = array();
		$i = $postData['start'] + 1;
		foreach ($data as $val) {
			$status_color = ($val['status'] == 'Active') ? 'green' : 'red';
			$status_html = '<td style="font-weight: bold; color: ' . $status_color . ';">' . $val['status'] . '</td>';

			$action_html = '<a type="button" class="" data-bs-toggle="modal" data-bs-target="#updateAttribute' . $i . '" title="Edit">
                                <i class="ti ti-edit edit-part" ></i>
                            </a>
                            <span class="delete_data" title="Delete Record" data-id="' . $val['attribute_id'] . '"><i class="ti ti-trash"></i></span>';

			$modal_html = '<div class="modal fade" id="updateAttribute' . $i . '" tabindex="-1" role="dialog" aria-labelledby="updateAttributeLabel' . $i . '" aria-hidden="true">
                         <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                               <div class="modal-header">
                                  <h5 class="modal-title" id="updateAttributeLabel' . $i . '">Update Attribute</h5>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                               </div>
                               <form action="' . base_url('update_attributes') . '" method="POST" enctype="multipart/form-data" id="update_attributes' . $i . '" class="update_attributes update_attributes' . $i . ' custom-form">
                                <input type="hidden" name="attribute_id" value="' . $val['attribute_id'] . '">
                               <div class="modal-body">
                                  <div class="form-group mb-3">
                                    <label for="attribute_name">Attribute Name<span class="text-danger">*</span></label> <br>
                                    <input type="text" name="attribute_name" placeholder="Enter Attribute Name" class="form-control required-input" value="' . htmlspecialchars($val['attribute_name']) . '" >
                                  </div>
                                   <div class="form-group mb-3">
                                        <label for="status">Status<span class="text-danger">*</span></label> <br>
                                        <select name="status" class="form-control select2 required-input" id="update_attr_status' . $i . '">
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
			$row[] = htmlspecialchars($val['attribute_name']);
			$row[] = htmlspecialchars($val['attribute_code'] ?? '-');
			$row[] = $status_html;
			$row[] = $action_html;

			$result[] = $row;
			$i++;
		}

		$output = array(
			"draw" => isset($postData['draw']) ? intval($postData['draw']) : 0,
			"recordsTotal" => $this->Attribute_model->count_all(),
			"recordsFiltered" => $this->Attribute_model->count_filtered($postData),
			"data" => $result,
		);

		$this->output->set_content_type('application/json')->set_output(json_encode($output));
	}
}
