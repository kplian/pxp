<?php
/**
*@package pXP
*@file gen-ACTTipoColumna.php
*@author  (admin)
*@date 07-05-2014 21:41:15
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoColumna extends ACTbase{    
			
	function listarTipoColumna(){
		$this->objParam->defecto('ordenacion','id_tipo_columna');

		$this->objParam->defecto('dir_ordenacion','asc');
		if ($this->objParam->getParametro('id_tabla') != '') {
			$this->objParam->addFiltro("tipcol.id_tabla = ". $this->objParam->getParametro('id_tabla'));
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoColumna','listarTipoColumna');
		} else{
			$this->objFunc=$this->create('MODTipoColumna');
			
			$this->res=$this->objFunc->listarTipoColumna($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

    function listarColumnasFormulario(){
        $this->objParam->defecto('ordenacion','nombre_columna');

        $this->objParam->defecto('dir_ordenacion','asc');

        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTipoColumna','listarColumnasFormulario');
        } else{
            $this->objFunc=$this->create('MODTipoColumna');

            $this->res=$this->objFunc->listarColumnasFormulario($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
				
	function insertarTipoColumna(){
		$this->objFunc=$this->create('MODTipoColumna');	
		if($this->objParam->insertar('id_tipo_columna')){
			$this->res=$this->objFunc->insertarTipoColumna($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoColumna($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoColumna(){
			$this->objFunc=$this->create('MODTipoColumna');	
		$this->res=$this->objFunc->eliminarTipoColumna($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>