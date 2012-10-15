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
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarDeptoUsuario');
		} else{
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->listarDeptoUsuario($this->objParam);
			$this->res->imprimirRespuesta($this->res->generarJson());
		}
	}
				
	function insertarDeptoUsuario(){
		$this->objFunc=new FuncionesParametros();	
		if($this->objParam->insertar('id_depto_usuario')){
			$this->res=$this->objFunc->insertarDeptoUsuario($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDeptoUsuario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDeptoUsuario(){
		$this->objFunc=new FuncionesParametros();	
		$this->res=$this->objFunc->eliminarDeptoUsuario($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>