<?php
/**
*@package pXP
*@file gen-ACTDeptoDepto.php
*@author  (admin)
*@date 08-09-2015 14:02:42
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDeptoDepto extends ACTbase{    
			
	function listarDeptoDepto(){
		$this->objParam->defecto('ordenacion','id_depto_depto');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_depto')!=''){
            $this->objParam->addFiltro("dede.id_depto_origen = ".$this->objParam->getParametro('id_depto'));    
        }
		
		if($this->objParam->getParametro('id_depto_destino')!=''){
            $this->objParam->addFiltro("dede.id_depto_destino = ".$this->objParam->getParametro('id_depto_destino'));    
        }
		
		
		if($this->objParam->getParametro('id_subsistema')!=''){
            $this->objParam->addFiltro("ddes.id_subsistema = ".$this->objParam->getParametro('id_subsistema'));    
        }
		
		
		if($this->objParam->getParametro('codigo_sis_des')!=''){
            $this->objParam->addFiltro("sdes.codigo = ''".$this->objParam->getParametro('codigo_sis_des')."''");    
        }
		
		
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDeptoDepto','listarDeptoDepto');
		} else{
			$this->objFunc=$this->create('MODDeptoDepto');
			
			$this->res=$this->objFunc->listarDeptoDepto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDeptoDepto(){
		$this->objFunc=$this->create('MODDeptoDepto');	
		if($this->objParam->insertar('id_depto_depto')){
			$this->res=$this->objFunc->insertarDeptoDepto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDeptoDepto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDeptoDepto(){
			$this->objFunc=$this->create('MODDeptoDepto');	
		$this->res=$this->objFunc->eliminarDeptoDepto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>