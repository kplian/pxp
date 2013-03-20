<?php
/**
*@package pXP
*@file gen-ACTFuncionarioTipoEstado.php
*@author  (admin)
*@date 15-03-2013 16:19:04
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFuncionarioTipoEstado extends ACTbase{    
			
	function listarFuncionarioTipoEstado(){
		$this->objParam->defecto('ordenacion','id_funcionario_tipo_estado');
        
        if($this->objParam->getParametro('id_tipo_estado')!=''){
            $this->objParam->addFiltro("functest.id_tipo_estado = ".$this->objParam->getParametro('id_tipo_estado'));    
        }
        

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODFuncionarioTipoEstado','listarFuncionarioTipoEstado');
		} else{
			$this->objFunc=$this->create('MODFuncionarioTipoEstado');
			
			$this->res=$this->objFunc->listarFuncionarioTipoEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFuncionarioTipoEstado(){
		$this->objFunc=$this->create('MODFuncionarioTipoEstado');	
		if($this->objParam->insertar('id_funcionario_tipo_estado')){
			$this->res=$this->objFunc->insertarFuncionarioTipoEstado($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarFuncionarioTipoEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFuncionarioTipoEstado(){
			$this->objFunc=$this->create('MODFuncionarioTipoEstado');	
		$this->res=$this->objFunc->eliminarFuncionarioTipoEstado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>