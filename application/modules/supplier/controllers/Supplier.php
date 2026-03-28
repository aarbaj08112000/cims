<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Supplier extends MY_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Supplier_model');
    }

    public function index() {
        $data['suppliers'] = $this->Supplier_model->get_suppliers();
        $data['base_url'] = base_url();
        $this->smarty->loadView('suppliers.tpl', $data, 'Yes', 'Yes');
    }

    public function add_supplier() {
        $ret_arr = [];
        $msg = '';
        $success = 1;

        $data = array(
            'supplier_name'  => $this->input->post("supplier_name"),
            'contact_person' => $this->input->post("contact_person"),
            'email'          => $this->input->post("email"),
            'phone'          => $this->input->post("phone"),
            'address'        => $this->input->post("address"),
            'gst_number'     => $this->input->post("gst_number"),
            'status'         => $this->input->post("status") ? $this->input->post("status") : 'Active',
            'added_date'     => date("Y-m-d H:i:s"),
            'added_by'       => $this->session->userdata('user_id'),
        );

        $insert_id = $this->Supplier_model->add_supplier($data);
        if ($insert_id > 0) {
            $msg = 'Supplier added successfully.';
        } else if ($insert_id == -1) {
            $msg = 'Supplier already exists.';
            $success = 0;
        } else {
            $msg = 'Error occurred while adding the supplier.';
            $success = 0;
        }

        $ret_arr['msg'] = $msg;
        $ret_arr['success'] = $success;
        $this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
    }

    public function update_supplier() {
        $ret_arr = [];
        $msg = '';
        $success = 1;
        $supplier_id = $this->input->post("supplier_id");

        $data = array(
            'supplier_name'  => $this->input->post("supplier_name"),
            'contact_person' => $this->input->post("contact_person"),
            'email'          => $this->input->post("email"),
            'phone'          => $this->input->post("phone"),
            'address'        => $this->input->post("address"),
            'gst_number'     => $this->input->post("gst_number"),
            'status'         => $this->input->post("status"),
        );

        $update_status = $this->Supplier_model->update_supplier($data, $supplier_id);
        if ($update_status) {
            $msg = 'Supplier updated successfully.';
        } else {
            $msg = 'No changes made or error occurred.';
            $success = 0;
        }

        $ret_arr['msg'] = $msg;
        $ret_arr['success'] = $success;
        $this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
    }

    public function delete_supplier() {
        $ret_arr = [];
        $msg = '';
        $success = 1;
        $supplier_id = $this->input->post("supplier_id");

        $data = array(
            'is_delete' => 1
        );

        $delete_status = $this->Supplier_model->update_supplier($data, $supplier_id);
        if ($delete_status) {
            $msg = 'Supplier deleted successfully.';
        } else {
            $msg = 'Error occurred while deleting the supplier.';
            $success = 0;
        }

        $ret_arr['msg'] = $msg;
        $ret_arr['success'] = $success;
        $this->output->set_content_type('application/json')->set_output(json_encode($ret_arr));
    }
}
