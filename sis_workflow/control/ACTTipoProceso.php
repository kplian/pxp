<?php
/**
*@package pXP
*@file gen-ACTTipoProceso.php
*@author  (admin)
*@date 21-02-2013 15:52:52
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 ISSUE				FECHA				AUTHOR				DESCRIPCION
  #44				01/08/2019			EGS					Se agrego filtro por codigo
*/

class ACTTipoProceso extends ACTbase{    
			
	function listarTipoProceso(){
		$this->objParam->defecto('ordenacion','id_tipo_proceso');

		$this->objParam->defecto('dir_ordenacion','asc');

		$this->objParam->defecto('cantidad',1000000000);
		$this->objParam->defecto('puntero', 0);
		
        
         if($this->objParam->getParametro('id_tipo_proceso')!=''){
            $this->objParam->addFiltro("tipproc.id_tipo_proceso = ".$this->objParam->getParametro('id_tipo_proceso'));    
        }
         if($this->objParam->getParametro('codigo')!=''){ //#44
            $this->objParam->addFiltro("tipproc.codigo = ''".$this->objParam->getParametro('codigo')."''");    
        }
        
         if($this->objParam->getParametro('inicio')!=''){
            $inicio=$this->objParam->getParametro('inicio');    
            $this->objParam->addFiltro("tipproc.inicio = ''$inicio''");    
        }
        		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoProceso','listarTipoProceso');
		} else{
			$this->objFunc=$this->create('MODTipoProceso');
			
			$this->res=$this->objFunc->listarTipoProceso($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoProceso(){
		$this->objFunc=$this->create('MODTipoProceso');	
		if($this->objParam->insertar('id_tipo_proceso')){
			$this->res=$this->objFunc->insertarTipoProceso($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoProceso($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoProceso(){
		$this->objFunc=$this->create('MODTipoProceso');	
		$this->res=$this->objFunc->eliminarTipoProceso($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function obtenerSubsistemaTipoProceso(){
		$this->objFunc=$this->create('MODTipoProceso');	
		$this->res=$this->objFunc->obtenerSubsistemaTipoProceso($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>