<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Barcode_gen {

    private $patterns = array(
        0 => '212222', 1 => '222122', 2 => '222221', 3 => '121223', 4 => '121322',
        5 => '131222', 6 => '122213', 7 => '122312', 8 => '132212', 9 => '221213',
        10 => '221312', 11 => '231212', 12 => '112232', 13 => '122132', 14 => '122231',
        15 => '113222', 16 => '123122', 17 => '123221', 18 => '223211', 19 => '221132',
        20 => '221231', 21 => '213212', 22 => '223112', 23 => '312131', 24 => '311222',
        25 => '321122', 26 => '321221', 27 => '312212', 28 => '322112', 29 => '322211',
        30 => '212123', 31 => '212321', 32 => '232121', 33 => '111323', 34 => '131123',
        35 => '131321', 36 => '112313', 37 => '132113', 38 => '132311', 39 => '211313',
        40 => '231113', 41 => '231311', 42 => '112133', 43 => '112331', 44 => '132131',
        45 => '113123', 46 => '113321', 47 => '133121', 48 => '313121', 49 => '211331',
        50 => '231131', 51 => '213113', 52 => '213311', 53 => '213131', 54 => '311123',
        55 => '311321', 56 => '331121', 57 => '312113', 58 => '312311', 59 => '332111',
        60 => '314111', 61 => '221411', 62 => '431111', 63 => '111224', 64 => '111422',
        65 => '121124', 66 => '121421', 67 => '141122', 68 => '141221', 69 => '112214',
        70 => '112412', 71 => '122114', 72 => '122411', 73 => '142112', 74 => '142211',
        75 => '241211', 76 => '221114', 77 => '413111', 78 => '241112', 79 => '134111',
        80 => '111242', 81 => '121142', 82 => '121241', 83 => '114212', 84 => '124112',
        85 => '124211', 86 => '411212', 87 => '421112', 88 => '421211', 89 => '212141',
        90 => '214121', 91 => '412121', 92 => '111143', 93 => '111341', 94 => '131141',
        95 => '114113', 96 => '114311', 97 => '411113', 98 => '411311', 99 => '113141',
        100 => '114131', 101 => '311141', 102 => '411131', 103 => '211412', 104 => '211214',
        105 => '211232', 106 => '2331112' 
    );

    public function generate($text, $file_path) {
        $code = $this->get_code128_data($text);
        if (!$code) {
            return false;
        }

        $module_width = 2; 
        $bar_height = 60;
        $font = 5; 
        $padding = 20;

        $total_modules = 0;
        foreach ($code as $val) {
             for($i=0; $i<strlen($val); $i++) {
                 $total_modules += (int)$val[$i];
             }
        }
        
        $image_width = ($total_modules * $module_width) + ($padding * 2);
        $image_height = $bar_height + 40; 

        $img = imagecreate($image_width, $image_height);
        $white = imagecolorallocate($img, 255, 255, 255);
        $black = imagecolorallocate($img, 0, 0, 0);

        imagefilledrectangle($img, 0, 0, $image_width, $image_height, $white);

        $x = $padding;
        $y = 10;

        foreach ($code as $pattern) {
            $bars = true; 
            $len = strlen($pattern);
            for ($i = 0; $i < $len; $i++) {
                $w = (int)$pattern[$i] * $module_width;
                if ($bars) {
                    imagefilledrectangle($img, $x, $y, $x + $w - 1, $y + $bar_height, $black);
                }
                $x += $w;
                $bars = !$bars;
            }
        }

        // Draw Text
        $text_width = imagefontwidth($font) * strlen($text);
        $text_x = ($image_width - $text_width) / 2;
        imagestring($img, $font, $text_x, $y + $bar_height + 5, $text, $black);

        imagepng($img, $file_path);
        imagedestroy($img);
        return true;
    }

    private function get_code128_data($text) {
        // Start Code B (104)
        $data = array($this->patterns[104]);
        $checksum = 104;
        $len = strlen($text);

        for ($i = 0; $i < $len; $i++) {
            $char = ord($text[$i]);
            $val = $char - 32;
            if ($val < 0 || $val > 95) {
                // If not in range, skip or replace. For now skip.
                return false; 
            }
            if (isset($this->patterns[$val])) {
                $data[] = $this->patterns[$val];
            }
            $checksum += ($val * ($i + 1));
        }

        $checksum_val = $checksum % 103;
        if (isset($this->patterns[$checksum_val])) {
            $data[] = $this->patterns[$checksum_val];
        }

        // Stop (106)
        $data[] = $this->patterns[106];

        return $data;
    }
}
