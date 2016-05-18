<?php
/**
*@package pXP
*@file gen-ACTFuncionarioCuentaBancaria.php
*@author  (admin)
*@date 20-01-2014 14:16:37
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFuncionarioCuentaBancaria extends ACTbase{    
			
	function listarFuncionarioCuentaBancaria(){
		$this->objParam->defecto('ordenacion','id_funcionario_cuenta_bancaria');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('id_funcionario') != '') {
			$this->objParam->addFiltro("funcue.id_funcionario = ". $this->objParam->getParametro('id_funcionario'));
		}
		
		if ($this->objParam->getParametro('fecha') != '') {
			$this->objParam->addFiltro("(funcue.fecha_ini <= ''". $this->objParam->getParametro('fecha')."''"." and (funcue.fecha_fin is null or funcue.fecha_fin >= ''". $this->objParam->getParametro('fecha')."''))");
		}	
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODFuncionarioCuentaBancaria','listarFuncionarioCuentaBancaria');
		} else{
			$this->objFunc=$this->create('MODFuncionarioCuentaBancaria');
			
			$this->res=$this->objFunc->listarFuncionarioCuentaBancaria($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFuncionarioCuentaBancaria(){
		$this->objFunc=$this->create('MODFuncionarioCuentaBancaria');	
		if($this->objParam->insertar('id_funcionario_cuenta_bancaria')){
			$this->res=$this->objFunc->insertarFuncionarioCuentaBancaria($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarFuncionarioCuentaBancaria($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFuncionarioCuentaBancaria(){
			$this->objFunc=$this->create('MODFuncionarioCuentaBancaria');	
		$this->res=$this->objFunc->eliminarFuncionarioCuentaBancaria($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>