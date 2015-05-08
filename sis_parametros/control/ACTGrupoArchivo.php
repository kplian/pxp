<?php
/**
*@package pXP
*@file gen-ACTGrupoArchivo.php
*@author  (admin)
*@date 23-12-2013 20:27:13
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTGrupoArchivo extends ACTbase{    
			
	function listarGrupoArchivo(){
		$this->objParam->defecto('ordenacion','id_grupo_archivo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODGrupoArchivo','listarGrupoArchivo');
		} else{
			$this->objFunc=$this->create('MODGrupoArchivo');
			
			$this->res=$this->objFunc->listarGrupoArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarGrupoArchivo(){
		$this->objFunc=$this->create('MODGrupoArchivo');	
		if($this->objParam->insertar('id_grupo_archivo')){
			$this->res=$this->objFunc->insertarGrupoArchivo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarGrupoArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarGrupoArchivo(){
			$this->objFunc=$this->create('MODGrupoArchivo');	
		$this->res=$this->objFunc->eliminarGrupoArchivo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>