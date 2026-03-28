<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Settings_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    /**
     * Get all settings
     */
    public function get_all_settings() {
        return $this->db->get('config_setting')->result_array();
    }

    /**
     * Get settings grouped by type or name if needed
     */
    public function get_settings_by_name($name) {
        $this->db->where('name', $name);
        return $this->db->get('config_setting')->row_array();
    }

    /**
     * Update setting value by name
     */
    public function update_setting($name, $value) {
        $this->db->where('name', $name);
        return $this->db->update('config_setting', ['value' => $value]);
    }
}
