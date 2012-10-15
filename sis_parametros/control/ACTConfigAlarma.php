<?php
/**
*@package pXP
*@file gen-ACTConfigAlarma.php
*@author  (fprudencio)
*@date 18-11-2011 11:59:10
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTConfigAlarma extends ACTbase{    
			
	function listarConfigAlarma(){
		$this->objParam->defecto('ordenacion','id_config_alarma');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarConfigAlarma');
		} else{
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->listarConfigAlarma($this->objParam);
			
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarAlarmaTabla(){
		$this->objParam->defecto('ordenacion','table_name');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('esquema')!='')
		{
			$this->objParam->addFiltro("table_schema = lower(''".$this->objParam->getParametro('esquema')."'')");	
		}
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->listarAlarmaTabla($this->objParam);
			$this->res->imprimirRespuesta($this->res->generarJson());
		
	}		
	function insertarConfigAlarma(){
		$this->objFunc=new FuncionesParametros();	
		if($this->objParam->insertar('id_config_alarma')){
			$this->res=$this->objFunc->insertarConfigAlarma($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarConfigAlarma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarConfigAlarma(){
		$this->objFunc=new FuncionesParametros();	
		$this->res=$this->objFunc->eliminarConfigAlarma($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>