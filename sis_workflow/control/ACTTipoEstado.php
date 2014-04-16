<?php
/**
*@package pXP
*@file gen-ACTTipoEstado.php
*@author  (admin)
*@date 21-02-2013 15:36:11
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoEstado extends ACTbase{    
			
	function listarTipoEstado(){
		$this->objParam->defecto('ordenacion','id_tipo_estado');

        if($this->objParam->getParametro('id_tipo_proceso')!=''){
	    	$this->objParam->addFiltro("tipes.id_tipo_proceso = ".$this->objParam->getParametro('id_tipo_proceso'));	
		}
		
		if($this->objParam->getParametro('id_proceso_macro')!=''){
            $this->objParam->addFiltro("tp.id_proceso_macro = ".$this->objParam->getParametro('id_proceso_macro'));    
        }
		
		
		 if($this->objParam->getParametro('estados')!=''){
            $this->objParam->addFiltro("tipes.id_tipo_estado in (".$this->objParam->getParametro('estados').")");    
        }
        
         if($this->objParam->getParametro('disparador')!=''){
            $this->objParam->addFiltro("tipes.disparador =  ''".$this->objParam->getParametro('disparador')."''");    
        }
        
        if($this->objParam->getParametro('inicio')!=''){
            $this->objParam->addFiltro("tipes.inicio = ''".$this->objParam->getParametro('inicio')."''");    
        }
        
        
		
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoEstado','listarTipoEstado');
		} else{
			$this->objFunc=$this->create('MODTipoEstado');
			
			$this->res=$this->objFunc->listarTipoEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
	function listarFuncionarioWf(){
            
        $this->objParam->defecto('ordenacion','id_funcionario');
        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTipoEstado','listarFuncionarioWf');
        } else{
            $this->objFunc=$this->create('MODTipoEstado');
            
            $this->res=$this->objFunc->listarFuncionarioWf($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function listarDeptoWf(){
            
        $this->objParam->defecto('ordenacion','id_depto');
        $this->objParam->defecto('subsistema','asc');
        
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTipoEstado','listarDeptoWf');
        } else{
            $this->objFunc=$this->create('MODTipoEstado');
            
            $this->res=$this->objFunc->listarDeptoWf($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
				
	function insertarTipoEstado(){
		$this->objFunc=$this->create('MODTipoEstado');	
		if($this->objParam->insertar('id_tipo_estado')){
			$this->res=$this->objFunc->insertarTipoEstado($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
	function modificarPlantillaCorreo(){
        $this->objFunc=$this->create('MODTipoEstado');  
        $this->res=$this->objFunc->modificarPlantillaCorreo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
	function eliminarTipoEstado(){
			$this->objFunc=$this->create('MODTipoEstado');	
		$this->res=$this->objFunc->eliminarTipoEstado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarEstadoSiguiente(){
		$this->objParam->defecto('ordenacion','id_tipo_estado');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoEstado','listarEstadoSiguiente');
		} else{
			$this->objFunc=$this->create('MODTipoEstado');
			
			$this->res=$this->objFunc->listarEstadoSiguiente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>