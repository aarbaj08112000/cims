<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Settings extends MY_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Settings_model');
    }

    public function index()
    {
        $settings = $this->Settings_model->get_all_settings();
        $data['settings'] = [];
        foreach ($settings as $setting) {
            $data['settings'][$setting['name']] = $setting;
        }
        $data['base_url'] = base_url();
        $this->smarty->loadView('settings.tpl', $data, 'Yes', 'Yes');
    }

    public function update_settings()
    {
        header('Content-Type: application/json');

        $post_data = $this->input->post();

        // Handle File Uploads
        $upload_dir = 'public/uploads/settings/';
        $upload_path = FCPATH . $upload_dir;

        if (!is_dir($upload_path)) {
            mkdir($upload_path, 0777, true);
        }

        foreach ($_FILES as $key => $file) {
            if (!empty($file['name'])) {
                $file_name = time() . '_' . $file['name'];
                $config['upload_path'] = $upload_path;
                $config['allowed_types'] = 'jpg|jpeg|png|ico|pdf';
                $config['file_name'] = $file_name;

                $this->load->library('upload', $config);
                $this->upload->initialize($config);

                if ($this->upload->do_upload($key)) {
                    $post_data[$key] = $upload_dir . $file_name;
                } else {
                    $error = $this->upload->display_errors('', '');
                    echo json_encode(['success' => 0, 'msg' => $key . ': ' . $error]);
                    return;
                }
            }
        }

        $success_count = 0;
        foreach ($post_data as $name => $value) {
            if ($this->Settings_model->update_setting($name, $value)) {
                $success_count++;
            }
        }

        if ($success_count > 0) {
            echo json_encode(['success' => 1, 'msg' => 'Settings updated successfully']);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'No changes made or update failed']);
        }
    }
}
