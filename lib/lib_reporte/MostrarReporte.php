<?php
class MostrarReporte
{
	
	function __construct($parametro){
		
		
		header("Content-type: application/xls");
		header('Content-Disposition: inline; filename="'.$parametro.'"');
		readfile(dirname(__FILE__)."/../../../reportes_generados/".$parametro);
		//echo dirname(__FILE__)."/../../reportes_generados/".$parametro; exit;
		unlink(dirname(__FILE__)."/../../../reportes_generados/".$parametro);
		exit;
	}
		
}
?>