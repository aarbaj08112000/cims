<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Activity_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
    }

    /**
     * Log an activity generically across the project.
     *
     * @param string $activity_code The unique code from activity_master
     * @param array $data Dynamic data for message placeholders and references.
     *                    Special keys: reference_id, reference_no, old_data, new_data
     * @return bool
     */
    public function log_activity($activity_code, $data = [])
    {
        try {
            // Get activity master configuration
            $this->db->where('activity_code', $activity_code);
            $this->db->where('status', 'Active');
            $master = $this->db->get('activity_master')->row_array();

            if (!$master) {
                log_message('error', 'Activity Log Error: Activity code not found or inactive: ' . $activity_code);
                return false;
            }

            // Get standard session variables safely
            $user_id = $this->session->userdata('user_id') ?: 0;
            $user_name = $this->session->userdata('user_name') ?: 'System';
            $company_id = $this->session->userdata('company_id') ?: null;
            $branch_id = $this->session->userdata('branch_id') ?: null;
            
            // Build placeholder array mapping for template
            $placeholders = $data;
            $placeholders['session_user_id'] = $user_id;
            $placeholders['session_user_name'] = $user_name;
            $placeholders['date'] = date('Y-m-d');
            $placeholders['time'] = date('H:i:s');
            $placeholders['datetime'] = date('Y-m-d H:i:s');
            
            // Generate message dynamically
            $message = $master['message_template'];
            foreach ($placeholders as $key => $value) {
                if (is_scalar($value)) {
                    $message = str_replace('{' . $key . '}', $value, $message);
                }
            }

            // Diff generation (optional display utility inside the message, if needed)
            if (isset($data['old_data']) && isset($data['new_data'])) {
                $diff_message = $this->generate_diff_message($data['old_data'], $data['new_data']);
                if ($diff_message) {
                    $message .= "\n\nChanges:\n" . $diff_message;
                }
            }

            // Prepare log data
            $log_data = [
                'activity_code' => $activity_code,
                'module' => $master['module'],
                'action' => $master['action'],
                'reference_id' => isset($data['reference_id']) ? $data['reference_id'] : null,
                'reference_no' => isset($data['reference_no']) ? $data['reference_no'] : null,
                'message' => $message,
                'old_data' => isset($data['old_data']) ? json_encode($data['old_data']) : null,
                'new_data' => isset($data['new_data']) ? json_encode($data['new_data']) : null,
                'user_id' => $user_id,
                'user_name' => $user_name,
                'company_id' => $company_id,
                'branch_id' => $branch_id,
                'ip_address' => $this->input->ip_address(),
                'user_agent' => $this->input->user_agent(),
                'created_at' => date('Y-m-d H:i:s')
            ];

            return $this->db->insert('activity_log_new', $log_data);
            
        } catch (Exception $e) {
            log_message('error', 'Activity Log Exception: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Generates a readable string of changed fields between two arrays.
     */
    private function generate_diff_message($old_data, $new_data)
    {
        if (!is_array($old_data) || !is_array($new_data)) {
            return '';
        }

        $diff = [];
        // Only track fields present in new_data to avoid noise.
        foreach ($new_data as $key => $new_val) {
            $old_val = isset($old_data[$key]) ? $old_data[$key] : null;
            if ($old_val != $new_val && !is_array($new_val)) {
                // Formatting key to readable label (e.g., "credit_limit" -> "Credit Limit")
                $label = ucwords(str_replace('_', ' ', $key));
                $diff[] = "{$label}: " . ($old_val ?: 'Empty') . " -> " . ($new_val ?: 'Empty');
            }
        }

        return implode("\n", $diff);
    }
}
