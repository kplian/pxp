<?php
/**
*@package pXP
*@file gen-ACTTabla.php
*@author  (admin)
*@date 07-05-2014 21:39:40
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTabla extends ACTbase{    
			
	function listarTabla(){
		$this->objParam->defecto('ordenacion','id_tabla');

		$this->objParam->defecto('dir_ordenacion','asc');
		if ($this->objParam->getParametro('id_tipo_proceso') != '') {
			$this->objParam->addFiltro("TABLA.id_tipo_proceso = ". $this->objParam->getParametro('id_tipo_proceso'));
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTabla','listarTabla');
		} else{
			$this->objFunc=$this->create('MODTabla');
			
			$this->res=$this->objFunc->listarTabla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTabla(){
		$this->objFunc=$this->create('MODTabla');	
		if($this->objParam->insertar('id_tabla')){
			$this->res=$this->objFunc->insertarTabla($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTabla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function ejecutarScriptTabla(){
		$this->objFunc=$this->create('MODTabla');	
				
		$this->res=$this->objFunc->ejecutarScriptTabla($this->objParam);
		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTabla(){
			$this->objFunc=$this->create('MODTabla');	
		$this->res=$this->objFunc->eliminarTabla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function cargarDatosTablaProceso(){
		$this->objParam->defecto('ordenacion','id_tabla');

		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->addFiltro("tp.codigo = ''". $this->objParam->getParametro('tipo_proceso')."''");
		$this->objParam->addFiltro("TABLA.vista_id_tabla_maestro is null");
		
		
		$this->objFunc=$this->create('MODTabla');
			
		$this->res=$this->objFunc->cargarDatosTablaProceso();
		
		$_SESSION['_wf_'.$this->objParam->getParametro('tipo_proceso').'_'.$this->objParam->getParametro('tipo_estado')] = $this->res->getDatos();
		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>