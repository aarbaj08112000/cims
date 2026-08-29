<?php 
if (!defined('BASEPATH')) exit('No direct script access allowed');  
 
require_once 'vendor/autoload.php';

use Dompdf\Dompdf;
use Dompdf\Options;

class Pdf extends Dompdf
{
	public function __construct($options = null)
	{
        if ($options === null) {
            $options = new Options();
            $options->set('isRemoteEnabled', true);
            $options->set('isHtml5ParserEnabled', true);
            $options->set('defaultFont', 'sans-serif');
        }

		parent::__construct($options);
	} 
}


?>