<?php
/**
*@package pXP
*@file gen-ACTUoFuncionarioOpe.php
*@author  (admin)
*@date 19-05-2015 17:53:09
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUoFuncionarioOpe extends ACTbase{    
			
	function listarUoFuncionarioOpe(){
		$this->objParam->defecto('ordenacion','id_uo_funcionario_ope');
		
		if($this->objParam->getParametro('id_uo')!=''){
            $this->objParam->addFiltro("uofo.id_uo= ".$this->objParam->getParametro('id_uo'));    
        }	
		
		

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODUoFuncionarioOpe','listarUoFuncionarioOpe');
		} else{
			$this->objFunc=$this->create('MODUoFuncionarioOpe');
			
			$this->res=$this->objFunc->listarUoFuncionarioOpe($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUoFuncionarioOpe(){
		$this->objFunc=$this->create('MODUoFuncionarioOpe');	
		if($this->objParam->insertar('id_uo_funcionario_ope')){
			$this->res=$this->objFunc->insertarUoFuncionarioOpe($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarUoFuncionarioOpe($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUoFuncionarioOpe(){
			$this->objFunc=$this->create('MODUoFuncionarioOpe');	
		$this->res=$this->objFunc->eliminarUoFuncionarioOpe($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>