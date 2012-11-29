<?php
/**
*@package pXP
*@file gen-ACTFuncionarioEspecialidad.php
*@author  (admin)
*@date 17-08-2012 17:48:38
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFuncionarioEspecialidad extends ACTbase{    
			
	function listarFuncionarioEspecialidad(){
		$this->objParam->defecto('ordenacion','id_funcionario_especialidad');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_funcionario')!=''){
			$this->objParam->addFiltro("rhesfu.id_funcionario = ".$this->objParam->getParametro('id_funcionario'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODFuncionarioEspecialidad','listarFuncionarioEspecialidad');
		} else{
			$this->objFunc=$this->create('MODFuncionarioEspecialidad');	
			$this->res=$this->objFunc->listarFuncionarioEspecialidad();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFuncionarioEspecialidad(){
		$this->objFunc=$this->create('MODFuncionarioEspecialidad');	
		if($this->objParam->insertar('id_funcionario_especialidad')){
			$this->res=$this->objFunc->insertarFuncionarioEspecialidad();			
		} else{			
			$this->res=$this->objFunc->modificarFuncionarioEspecialidad();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFuncionarioEspecialidad(){
		$this->objFunc=$this->create('MODFuncionarioEspecialidad');	
		$this->res=$this->objFunc->eliminarFuncionarioEspecialidad();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>