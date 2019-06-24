<?php
/**
*@package pXP
*@file gen-ACTPlantillaGrilla.php
*@author  (egutierrez)
*@date 17-06-2019 21:25:26
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
	ISSUE		FECHA 			AUTHOR			DESCRIPCION
 *  #24			17/06/2019		EGS				Crecion y filtro por codigo 
 
 * */

class ACTPlantillaGrilla extends ACTbase{    
			
	function listarPlantillaGrilla(){
		$this->objParam->defecto('ordenacion','id_plantilla_grilla');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('codigo')!=''){//#24
			$this->objParam->addFiltro("plgri.codigo = ''".$this->objParam->getParametro('codigo')."'' ");	
		}		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPlantillaGrilla','listarPlantillaGrilla');
		} else{
			$this->objFunc=$this->create('MODPlantillaGrilla');
			
			$this->res=$this->objFunc->listarPlantillaGrilla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPlantillaGrilla(){
		$this->objFunc=$this->create('MODPlantillaGrilla');	
		if($this->objParam->insertar('id_plantilla_grilla')){
			$this->res=$this->objFunc->insertarPlantillaGrilla($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPlantillaGrilla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPlantillaGrilla(){
			$this->objFunc=$this->create('MODPlantillaGrilla');	
		$this->res=$this->objFunc->eliminarPlantillaGrilla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>