<?php
/**
*@package pXP
*@file gen-ACTDeptoUoEp.php
*@author  (admin)
*@date 03-06-2013 15:15:03
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDeptoUoEp extends ACTbase{    
			
	function listarDeptoUoEp(){
		$this->objParam->defecto('ordenacion','id_depto_uo_ep');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_depto')!=''){
            $this->objParam->addFiltro("id_depto = ".$this->objParam->getParametro('id_depto'));    
        }
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDeptoUoEp','listarDeptoUoEp');
		} else{
			$this->objFunc=$this->create('MODDeptoUoEp');
			
			$this->res=$this->objFunc->listarDeptoUoEp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDeptoUoEp(){
		$this->objFunc=$this->create('MODDeptoUoEp');	
		if($this->objParam->insertar('id_depto_uo_ep')){
			$this->res=$this->objFunc->insertarDeptoUoEp($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDeptoUoEp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDeptoUoEp(){
		$this->objFunc=$this->create('MODDeptoUoEp');	
		$this->res=$this->objFunc->eliminarDeptoUoEp($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function sincUoEp(){
        $this->objFunc=$this->create('MODDeptoUoEp');   
        $this->res=$this->objFunc->sincUoEp($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	
	
			
}

?>