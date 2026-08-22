<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Barcode_gen {

    public function generate($text, $file_path) {
        if (!defined('APPPATH')) {
            return false;
        }
        
        require_once APPPATH . 'libraries/phpqrcode/qrlib.php';
        
        // Generate QR Code with Error Correction Level L (less dense, larger blocks for small printing), size 10 (sharp), margin 2
        QRcode::png($text, $file_path, QR_ECLEVEL_L, 10, 2);
        
        return true;
    }
}

