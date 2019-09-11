<?php
/**
*@package pXP
*@file gen-ACTCodigoFuncionario.php
*@author  (miguel.mamani)
*@date 10-09-2019 19:35:19
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCodigoFuncionario extends ACTbase{    
			
	function listarCodigoFuncionario(){
		$this->objParam->defecto('ordenacion','id_codigo_funcionario');
		$this->objParam->defecto('dir_ordenacion','asc');
        if ($this->objParam->getParametro('id_funcionario') != '') {
            $this->objParam->addFiltro("cfo.id_funcionario = ". $this->objParam->getParametro('id_funcionario'));
        }
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCodigoFuncionario','listarCodigoFuncionario');
		} else{
			$this->objFunc=$this->create('MODCodigoFuncionario');
			
			$this->res=$this->objFunc->listarCodigoFuncionario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCodigoFuncionario(){
		$this->objFunc=$this->create('MODCodigoFuncionario');	
		if($this->objParam->insertar('id_codigo_funcionario')){
			$this->res=$this->objFunc->insertarCodigoFuncionario($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCodigoFuncionario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCodigoFuncionario(){
			$this->objFunc=$this->create('MODCodigoFuncionario');	
		$this->res=$this->objFunc->eliminarCodigoFuncionario($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>