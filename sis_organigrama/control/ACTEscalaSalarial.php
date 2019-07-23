<?php
/**
*@package pXP
*@file gen-ACTEscalaSalarial.php
*@author  (admin)
*@date 14-01-2014 00:28:29
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 ISSUE		FECHA			AUTHOR				DESCRIPCION		
  #35		23/07/2019		EGS					Se agrega filtros para el historial
 * */

class ACTEscalaSalarial extends ACTbase{    
			
	function listarEscalaSalarial(){
		$this->objParam->defecto('ordenacion','id_escala_salarial');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('id_categoria_salarial') != '') {
			$this->objParam->addFiltro("escsal.id_categoria_salarial = ". $this->objParam->getParametro('id_categoria_salarial'));
		}
		
		if ($this->objParam->getParametro('nombreVista') == 'EscalaSalarial') {//#35
			$this->objParam->addFiltro("escsal.estado_reg = ''activo'' ");
		}
		
		if ($this->objParam->getParametro('nombreVista') == 'EscalaSalarialHistorial') {//#35
			
			$this->objParam->parametros_consulta['ordenacion'] = 'fecha_reg desc';	
			$this->objParam->addFiltro("escsal.estado_reg = ''inactivo'' ");
			
		}
		
		if ($this->objParam->getParametro('id_escala_padre') != '') {//#35
			$this->objParam->addFiltro("escsal.id_escala_padre =''". $this->objParam->getParametro('id_escala_padre')."''");
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODEscalaSalarial','listarEscalaSalarial');
		} else{
			$this->objFunc=$this->create('MODEscalaSalarial');
			
			$this->res=$this->objFunc->listarEscalaSalarial($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEscalaSalarial(){
		$this->objFunc=$this->create('MODEscalaSalarial');	
		if($this->objParam->insertar('id_escala_salarial')){
			$this->res=$this->objFunc->insertarEscalaSalarial($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEscalaSalarial($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEscalaSalarial(){
			$this->objFunc=$this->create('MODEscalaSalarial');	
		$this->res=$this->objFunc->eliminarEscalaSalarial($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>