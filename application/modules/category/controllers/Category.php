<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Category extends MY_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->model('Categories_model');
    }
	public function index() {
		$data['base_url'] = base_url();
		$this->smarty->loadView('login.tpl',$data,'No','No');
	}
	/* add update user module */
	
	public function category()
	{ 
		$data['categories'] = $this->Categories_model->get_categories();
		$data['base_url'] = base_url();
		// pr($data);
		$this->smarty->loadView('categories.tpl', $data,'Yes','Yes');
	}
	

	public function add_categories()
	{
		$ret_arr = [];
		$msg = '';
		$success = 1;
		$data = array(
			'category_name'       => $this->input->post("category_name"),
			'parent_category_id'  => $this->input->post("parent_category_id"),
			'added_date'          => date("Y-m-d H:i:s"),
			'added_by'            => $this->session->userdata('user_id'),
		);
		$insert_query = $this->Categories_model->add_categories($data);
		// pr($insert_query);
		// pr($this->db->last_query());
		if ($insert_query > 0) {
			$msg = 'Category added successfully.';
		} else if($insert_query == -1){
			$msg = 'Category already exit.';
			$success = 0;
		}else {
			$msg = 'Error occurred while adding the category. Please try again.';
			$success = 0;
		}
		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;
		$this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
	}

	public function update_categories()
	{
		$ret_arr = [];
		$msg = '';
		$success = 1;
		$category_id = $this->input->post("category_id");
		$data = array(
			'category_name'       => $this->input->post("category_name"),
			'parent_category_id'  => $this->input->post("parent_category_id"),
			'updated_date'          => date("Y-m-d H:i:s"),
			'updated_by'            => $this->session->userdata('user_id'),
			'status'            => $this->input->post("status"),
		);

		$update_query = $this->Categories_model->update_categories($data,$category_id);
		// pr($this->db->last_query());
		if ($update_query) {
			$msg = 'Category update successfully.';
		} else {
			$msg = 'Error occurred while updating the category. Please try again.';
			$success = 0;
		}
		$ret_arr['msg'] = $msg;
		$ret_arr['success'] = $success;
		$this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
	}
	public function delete_category()
{
    $ret_arr = [];
    $msg = '';
    $success = 1;

    $category_id = $this->input->post("category_id");

    if (!$category_id) {
        $ret_arr['msg'] = 'Category ID is missing.';
        $ret_arr['success'] = 0;
        echo json_encode($ret_arr);
        return;
    }

    $data = array(
        'is_delete'    => 1,
        'updated_date' => date("Y-m-d H:i:s"),
        'updated_by'   => $this->session->userdata('user_id'),
    );

    
    $update_query = $this->Categories_model->update_categories($data, $category_id);

    if ($update_query) {
        $msg = 'Category deleted successfully.';
    } else {
        $msg = 'No change made or error occurred. Please try again.';
        $success = 0;
    }

    $ret_arr['msg'] = $msg;
    $ret_arr['success'] = $success;

    $this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
}

	
	

	public function get_categories_ajax() {
		$postData = $this->input->post();
		$data = $this->Categories_model->get_categories_ssp($postData);
		$all_categories = $this->Categories_model->get_categories(); // For the modal dropdown

		$result = array();
		$i = $postData['start'] + 1;
		foreach ($data as $val) {
			$status_color = ($val['status'] == 'Active') ? 'green' : 'red';
			$status_html = '<td style="font-weight: bold; color: ' . $status_color . ';">' . $val['status'] . '</td>';

			// Build the action HTML and the modal
			$action_html = '<a type="button" class="" data-bs-toggle="modal" data-bs-target="#updateCategoryModal' . $i . '" title="Edit">
                              <i class="ti ti-edit edit-part"></i>
                            </a>
                            <span class="delete_data" title="Delete Record" data-id="' . $val['category_id'] . '">
                              <i class="ti ti-trash"></i>
                            </span>';

            $modal_html = '<div class="modal fade" id="updateCategoryModal' . $i . '" tabindex="-1" role="dialog" aria-labelledby="updateCategoryModalLabel' . $i . '" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="updateCategoryModalLabel' . $i . '">Update Category</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <form action="' . base_url('update_categories') . '" method="POST" enctype="multipart/form-data" id="updateCategoryForm' . $i . '" class="update_categories custom-form">
                            <input type="hidden" name="category_id" value="' . $val['category_id'] . '">
                            <div class="modal-body">
                              <div class="form-group mb-3">
                                <label for="category_name_' . $i . '">Category Name<span class="text-danger">*</span></label>
                                <input type="text" name="category_name" id="category_name_' . $i . '" placeholder="Enter Category Name" class="form-control required-input" value="' . htmlspecialchars($val['category_name']) . '">
                              </div>

                              <div class="form-group mb-3" style="display: none;">
                                <label for="parent_category_id_' . $i . '">Parent Category</label>
                                <select name="parent_category_id" class="form-control select2" id="parent_category_id_' . $i . '">
                                  <option value="0" ' . ($val['parent_category_id'] == 0 ? 'selected' : '') . '>Select Parent Category</option>';
            
            foreach ($all_categories as $p_val) {
            	$selected = ($p_val['category_id'] == $val['parent_category_id']) ? 'selected' : '';
            	$modal_html .= '<option value="' . $p_val['category_id'] . '" ' . $selected . '>' . htmlspecialchars($p_val['category_name']) . '</option>';
            }

            $modal_html .= '      </select>
                              </div>

                              <div class="form-group mb-3">
                                <label for="status_' . $i . '">Status<span class="text-danger">*</span></label>
                                <select name="status" class="form-control select2 required-input" id="status_' . $i . '">
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
			$row[] = htmlspecialchars($val['category_name']);
			$row[] = $status_html;
			$row[] = $action_html;

			$result[] = $row;
			$i++;
		}

		$output = array(
			"draw" => isset($postData['draw']) ? intval($postData['draw']) : 0,
			"recordsTotal" => $this->Categories_model->count_all(),
			"recordsFiltered" => $this->Categories_model->count_filtered($postData),
			"data" => $result,
		);

		$this->output->set_content_type('application/json')->set_output(json_encode($output));
	}

}
