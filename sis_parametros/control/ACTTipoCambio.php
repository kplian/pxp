<?php
/**
*@package pXP
*@file ACTTipoCambio.php
*@author  Gonzalo Sarmiento Sejas
*@date 08-03-2013 15:30:14
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoCambio extends ACTbase{    
			
	function listarTipoCambio(){
		$this->objParam->defecto('ordenacion','id_tipo_cambio');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoCambio','listarTipoCambio');
		} else{
			$this->objFunc=$this->create('MODTipoCambio');
			
			$this->res=$this->objFunc->listarTipoCambio($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoCambio(){
		$this->objFunc=$this->create('MODTipoCambio');	
		if($this->objParam->insertar('id_tipo_cambio')){
			$this->res=$this->objFunc->insertarTipoCambio($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoCambio($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoCambio(){
			$this->objFunc=$this->create('MODTipoCambio');	
		$this->res=$this->objFunc->eliminarTipoCambio($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function obtenerTipoCambio(){
            $this->objFunc=$this->create('MODTipoCambio');  
        $this->res=$this->objFunc->obtenerTipoCambio($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
			
}

?>