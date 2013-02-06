<?php
/**
*@package pXP
*@file gen-ACTDeptoUsuario.php
*@author  (mzm)
*@date 24-11-2011 18:26:47
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDeptoUsuario extends ACTbase{    
			
	function listarDeptoUsuario(){
		$this->objParam->defecto('ordenacion','id_depto_usuario');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODDeptoUsuario','listarDeptoUsuario');
		} else{
			$this->objFunc=$this->create('MODDeptoUsuario');	
			$this->res=$this->objFunc->listarDeptoUsuario();
			$this->res->imprimirRespuesta($this->res->generarJson());
		}
	}
				
	function insertarDeptoUsuario(){
		$this->objFunc=$this->create('MODDeptoUsuario');	
		if($this->objParam->insertar('id_depto_usuario')){
			$this->res=$this->objFunc->insertarDeptoUsuario();			
		} else{			
			$this->res=$this->objFunc->modificarDeptoUsuario();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDeptoUsuario(){
		$this->objFunc=$this->create('MODDeptoUsuario');	
		$this->res=$this->objFunc->eliminarDeptoUsuario();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>