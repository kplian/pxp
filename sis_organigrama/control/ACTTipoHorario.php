<?php
/**
*@package pXP
*@file gen-ACTTipoHorario.php
*@author  (admin)
*@date 17-08-2012 16:28:19
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoHorario extends ACTbase{    
			
	function listarTipoHorario(){
		$this->objParam->defecto('ordenacion','id_tipo_horario');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesRecursosHumanos','listarTipoHorario');
		} else{
			$this->objFunc=new FuncionesOrganigrama();	
			$this->res=$this->objFunc->listarTipoHorario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoHorario(){
		$this->objFunc=new FuncionesOrganigrama();	
		if($this->objParam->insertar('id_tipo_horario')){
			$this->res=$this->objFunc->insertarTipoHorario($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoHorario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoHorario(){
		$this->objFunc=new FuncionesOrganigrama();	
		$this->res=$this->objFunc->eliminarTipoHorario($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>