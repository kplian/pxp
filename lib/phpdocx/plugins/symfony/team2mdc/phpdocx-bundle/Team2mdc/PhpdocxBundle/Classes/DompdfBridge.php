<?php
namespace Team2mdc\PhpdocxBundle\Classes;

require_once(dirname(__FILE__) . "/../src/lib/pdf/dompdf_config.inc.php");

class DompdfBridge
{
	public function createDompdf()
	{
		return new \DOMPDF();
	}
}