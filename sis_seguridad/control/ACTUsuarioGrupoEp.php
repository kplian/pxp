<?php
/**
*@package pXP
*@file gen-ACTUsuarioGrupoEp.php
*@author  (admin)
*@date 22-04-2013 15:53:08
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUsuarioGrupoEp extends ACTbase{    
			
	function listarUsuarioGrupoEp(){
		$this->objParam->defecto('ordenacion','id_usuario_grupo_ep');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		 if($this->objParam->getParametro('id_usuario')!=''){
            $this->objParam->addFiltro("uep.id_usuario = ".$this->objParam->getParametro('id_usuario'));    
        }
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODUsuarioGrupoEp','listarUsuarioGrupoEp');
		} else{
			$this->objFunc=$this->create('MODUsuarioGrupoEp');
			
			$this->res=$this->objFunc->listarUsuarioGrupoEp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUsuarioGrupoEp(){
		$this->objFunc=$this->create('MODUsuarioGrupoEp');	
		if($this->objParam->insertar('id_usuario_grupo_ep')){
			$this->res=$this->objFunc->insertarUsuarioGrupoEp($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarUsuarioGrupoEp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUsuarioGrupoEp(){
			$this->objFunc=$this->create('MODUsuarioGrupoEp');	
		$this->res=$this->objFunc->eliminarUsuarioGrupoEp($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>