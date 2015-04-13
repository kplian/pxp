<?php
require_once(dirname(__FILE__).'/../../lib/tcpdf/tcpdf.php');
// Extend the TCPDF class to create custom MultiRow
class RNumeroTramite extends  TCPDF {
	protected $objParam;
	function __construct(CTParametro $objParam){
		$this->objParam=$objParam;
		parent::__construct('L', 'mm', array(150,200), true, 'UTF-8', false);
	}
	function header(){}
	function footer(){}
	
	function generarReporte() {
		$this->SetAutoPageBreak(true,0);
		$this->AddPage();
		$this->SetMargins(0,0,0);
		$this->setxy(98,142);
 		$this->SetFont('','B',6);
 		//--------------------$v_setdetalle[$i][0]
 		$this->cell(60,5,$this->objParam->getParametro('nro_tramite'),'T',0,'C',0);
					
	}
	
    
}
?>