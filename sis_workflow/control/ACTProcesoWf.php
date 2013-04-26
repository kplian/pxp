<?php
/**
*@package pXP
*@file gen-ACTProcesoWf.php
*@author  (admin)
*@date 18-04-2013 09:01:51
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProcesoWf extends ACTbase{    
			
	function listarProcesoWf(){
		$this->objParam->defecto('ordenacion','id_proceso_wf');

		$this->objParam->defecto('dir_ordenacion','asc');
		 
		 if($this->objParam->getParametro('id_proceso_macro')!=''){
            $this->objParam->addFiltro("pm.id_proceso_macro = ".$this->objParam->getParametro('id_proceso_macro'));    
        }
		
		 $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODProcesoWf','listarProcesoWf');
		} else{
			$this->objFunc=$this->create('MODProcesoWf');
			
			$this->res=$this->objFunc->listarProcesoWf($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProcesoWf(){
	    $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
		$this->objFunc=$this->create('MODProcesoWf');	
		
		
		
		if($this->objParam->insertar('id_proceso_wf')){
			$this->res=$this->objFunc->insertarProcesoWf($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProcesoWf($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProcesoWf(){
			$this->objFunc=$this->create('MODProcesoWf');	
		$this->res=$this->objFunc->eliminarProcesoWf($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function siguienteEstadoProcesoWf(){
        $this->objFunc=$this->create('MODProcesoWf');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->siguienteEstadoProcesoWf($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function anteriorEstadoProcesoWf(){
        $this->objFunc=$this->create('MODProcesoWf');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->anteriorEstadoProcesoWf($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    
			
}

?>