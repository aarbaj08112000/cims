<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Barcode_gen {

    public function generate($text, $file_path) {
        if (!defined('APPPATH')) {
            return false;
        }
        
        require_once APPPATH . 'libraries/phpqrcode/qrlib.php';
        
        // Generate QR Code with Error Correction Level L, size 4, margin 1.
        // Keeping the generated image size natively perfect prevents dompdf from dropping pixels!
        QRcode::png($text, $file_path, QR_ECLEVEL_L, 4, 1);
        
        return true;
    }
}

