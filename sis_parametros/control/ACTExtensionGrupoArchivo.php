<?php
/**
*@package pXP
*@file gen-ACTExtensionGrupoArchivo.php
*@author  (admin)
*@date 23-12-2013 20:33:46
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTExtensionGrupoArchivo extends ACTbase{    
			
	function listarExtensionGrupoArchivo(){
		$this->objParam->defecto('ordenacion','id_extension_grupo_archivo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_extension')!='')
		{
					$this->objParam-> addFiltro('ext_g_ar.id_extension ='.$this->objParam->getParametro('id_extension'));
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODExtensionGrupoArchivo','listarExtensionGrupoArchivo');
		} else{
			$this->objFunc=$this->create('MODExtensionGrupoArchivo');
			
			$this->res=$this->objFunc->listarExtensionGrupoArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarExtensionGrupoArchivo(){
		$this->objFunc=$this->create('MODExtensionGrupoArchivo');	
		if($this->objParam->insertar('id_extension_grupo_archivo')){
			$this->res=$this->objFunc->insertarExtensionGrupoArchivo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarExtensionGrupoArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarExtensionGrupoArchivo(){
			$this->objFunc=$this->create('MODExtensionGrupoArchivo');	
		$this->res=$this->objFunc->eliminarExtensionGrupoArchivo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>