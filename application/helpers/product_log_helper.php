<?php
defined('BASEPATH') OR exit('No direct script access allowed');

if (!function_exists('log_product_activity')) {
    function log_product_activity($data) {
        $CI =& get_instance();
        $CI->load->database();

        if (empty($data['created_by'])) {
            $data['created_by'] = $CI->session->userdata('user_id') ?: ($CI->session->userdata('iUserId') ?: ($CI->session->userdata('id') ?: NULL));
        }

        if (empty($data['user_name'])) {
            $user_name = $CI->session->userdata('user_name') ?: ($CI->session->userdata('name') ?: ($CI->session->userdata('vFirstName') ?: NULL));
            if (!$user_name && !empty($data['created_by'])) {
                $query = $CI->db->select('user_name')->get_where('userinfo', array('id' => $data['created_by']));
                if ($query->num_rows() > 0) {
                    $user_name = $query->row()->user_name;
                } else {
                    $query2 = $CI->db->select('name')->get_where('users', array('id' => $data['created_by']));
                    if ($query2->num_rows() > 0) {
                        $user_name = $query2->row()->name;
                    }
                }
            }
            $data['user_name'] = $user_name ?: 'System Admin';
        }

        if (empty($data['ip_address'])) {
            $data['ip_address'] = $CI->input->ip_address();
        }

        if (isset($data['old_values']) && is_array($data['old_values'])) {
            $data['old_values'] = json_encode($data['old_values']);
        }

        if (isset($data['new_values']) && is_array($data['new_values'])) {
            $data['new_values'] = json_encode($data['new_values']);
        }

        $insert_data = array(
            'product_id'   => isset($data['product_id']) ? $data['product_id'] : NULL,
            'product_name' => isset($data['product_name']) ? $data['product_name'] : '',
            'action_type'  => isset($data['action_type']) ? $data['action_type'] : 'updated',
            'old_values'   => isset($data['old_values']) ? $data['old_values'] : NULL,
            'new_values'   => isset($data['new_values']) ? $data['new_values'] : NULL,
            'qty_change'   => isset($data['qty_change']) ? $data['qty_change'] : 0.00,
            'price_change' => isset($data['price_change']) ? $data['price_change'] : 0.00,
            'reference_no' => isset($data['reference_no']) ? $data['reference_no'] : NULL,
            'remarks'      => isset($data['remarks']) ? $data['remarks'] : NULL,
            'created_by'   => isset($data['created_by']) ? $data['created_by'] : NULL,
            'user_name'    => isset($data['user_name']) ? $data['user_name'] : NULL,
            'ip_address'   => isset($data['ip_address']) ? $data['ip_address'] : NULL,
            'created_at'   => date('Y-m-d H:i:s')
        );

        return $CI->db->insert('product_activity_logs', $insert_data);
    }
}
