<?php
/**
*@package pXP
*@file gen-ACTGrupoEp.php
*@author  (admin)
*@date 22-04-2013 14:49:40
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTGrupoEp extends ACTbase{    
			
	function listarGrupoEp(){
		$this->objParam->defecto('ordenacion','id_grupo_ep');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		 if($this->objParam->getParametro('id_grupo')!=''){
            $this->objParam->addFiltro("id_grupo = ".$this->objParam->getParametro('id_grupo'));    
        }
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODGrupoEp','listarGrupoEp');
		} else{
			$this->objFunc=$this->create('MODGrupoEp');
			
			$this->res=$this->objFunc->listarGrupoEp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarGrupoEp(){
		$this->objFunc=$this->create('MODGrupoEp');	
		if($this->objParam->insertar('id_grupo_ep')){
			$this->res=$this->objFunc->insertarGrupoEp($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarGrupoEp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarGrupoEp(){
			$this->objFunc=$this->create('MODGrupoEp');	
		$this->res=$this->objFunc->eliminarGrupoEp($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function sincUoEp(){
        $this->objFunc=$this->create('MODGrupoEp');   
        $this->res=$this->objFunc->sincUoEp($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
			
}

?>