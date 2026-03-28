<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Company extends MY_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->model('Company_model');
    }

    public function company() {
        $company = $this->Company_model->get_company();
        if (empty($company)) {
            redirect(base_url('add_company'));
        }
        $data['company'] = $company;
        $data['base_url'] = base_url();
        $this->smarty->loadView('company_details.tpl', $data, 'Yes', 'Yes');
    }

    public function add_company($id = null) {
        $data = [];
        $company = $this->Company_model->get_company();
        if (!empty($company)) {
            $data['company'] = $company;
        }
        
        $data['base_url'] = base_url();
        $this->smarty->loadView('add_company.tpl', $data, 'Yes', 'Yes');
    }

    public function save_company_data() {
        $post_data = $this->input->post();
        unset($post_data['company_id']);

        // Define upload paths
        $upload_path = 'public/uploads/company/';
        if (!is_dir($upload_path)) {
            mkdir($upload_path, 0777, true);
        }

        // Handle File Uploads
        $files = ['company_logo', 'gst_certificate', 'pan_card_img'];
        foreach ($files as $file_key) {
            if (!empty($_FILES[$file_key]['name'])) {
                $file_name = time() . '_' . $_FILES[$file_key]['name'];
                $config['upload_path'] = $upload_path;
                $config['allowed_types'] = 'jpg|jpeg|png|pdf';
                $config['file_name'] = $file_name;
                
                $this->load->library('upload', $config);
                $this->upload->initialize($config);

                if ($this->upload->do_upload($file_key)) {
                    $post_data[$file_key] = $file_name;
                } else {
                    $error = $this->upload->display_errors();
                    $this->output->set_content_type('application/json')->set_output(json_encode(['success' => 0, 'msg' => $file_key . ': ' . $error]));
                    return;
                }
            }
        }

        $res = $this->Company_model->insert_company($post_data);
        if ($res) {
            $this->output->set_content_type('application/json')->set_output(json_encode(['success' => 1, 'msg' => 'Company added successfully']));
        } else {
            $this->output->set_content_type('application/json')->set_output(json_encode(['success' => 0, 'msg' => 'Failed to save company']));
        }
    }

    public function update_company_data() {
        $post_data = $this->input->post();
        $id = $post_data['company_id'];
        unset($post_data['company_id']);

        // Handle File Uploads (preserving old files if new ones aren't uploaded)
        $upload_path = 'public/uploads/company/';
        $files = [
            'company_logo' => 'hidden_company_logo',
            'gst_certificate' => 'hidden_gst_certificate',
            'pan_card_img' => 'hidden_pan_card_img'
        ];

        foreach ($files as $file_key => $hidden_key) {
            if (!empty($_FILES[$file_key]['name'])) {
                $file_name = time() . '_' . $_FILES[$file_key]['name'];
                $config['upload_path'] = $upload_path;
                $config['allowed_types'] = 'jpg|jpeg|png|pdf';
                $config['file_name'] = $file_name;
                
                $this->load->library('upload', $config);
                $this->upload->initialize($config);

                if ($this->upload->do_upload($file_key)) {
                    $post_data[$file_key] = $file_name;
                } else {
                    $error = $this->upload->display_errors();
                    $this->output->set_content_type('application/json')->set_output(json_encode(['success' => 0, 'msg' => $file_key . ': ' . $error]));
                    return;
                }
            } else {
                // Use hidden value if no new file uploaded
                $post_data[$file_key] = $post_data[$hidden_key];
            }
            unset($post_data[$hidden_key]);
        }

        $res = $this->Company_model->update_company($post_data, $id);
        if ($res) {
            $this->output->set_content_type('application/json')->set_output(json_encode(['success' => 1, 'msg' => 'Company updated successfully']));
        } else {
            $this->output->set_content_type('application/json')->set_output(json_encode(['success' => 0, 'msg' => 'Failed to update company']));
        }
    }

    public function delete_company_data() {
        $id = $this->input->post('company_id');
        $this->Company_model->update_company(['is_delete' => 1], $id);
        $this->output->set_content_type('application/json')->set_output(json_encode(['success' => 1, 'msg' => 'Company deleted successfully']));
    }
}
