<?php
/**
*@package pXP
*@file gen-ACTProgramador.php
*@author  (rarteaga)
*@date 08-01-2020 19:46:59
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #102			08-01-2020 19:46:59		RAC					CREACION

*/

class ACTProgramador extends ACTbase{    
			
	function listarProgramador(){
		$this->objParam->defecto('ordenacion','id_programador');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODProgramador','listarProgramador');
		} else{
			$this->objFunc=$this->create('MODProgramador');
			
			$this->res=$this->objFunc->listarProgramador($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProgramador(){
		$this->objFunc=$this->create('MODProgramador');	
		if($this->objParam->insertar('id_programador')){
			$this->res=$this->objFunc->insertarProgramador($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProgramador($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProgramador(){
			$this->objFunc=$this->create('MODProgramador');	
		$this->res=$this->objFunc->eliminarProgramador($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>