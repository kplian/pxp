<?php
/**
*@package pXP
*@file gen-ACTClasificacionProveedor.php
*@author  (gsarmiento)
*@date 06-10-2014 13:31:43
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTClasificacionProveedor extends ACTbase{    
			
	function listarClasificacionProveedor(){
		$this->objParam->defecto('ordenacion','id_clasificacion_proveedor');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODClasificacionProveedor','listarClasificacionProveedor');
		} else{
			$this->objFunc=$this->create('MODClasificacionProveedor');
			
			$this->res=$this->objFunc->listarClasificacionProveedor($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarClasificacionProveedor(){
		$this->objFunc=$this->create('MODClasificacionProveedor');	
		if($this->objParam->insertar('id_clasificacion_proveedor')){
			$this->res=$this->objFunc->insertarClasificacionProveedor($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarClasificacionProveedor($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarClasificacionProveedor(){
			$this->objFunc=$this->create('MODClasificacionProveedor');	
		$this->res=$this->objFunc->eliminarClasificacionProveedor($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>