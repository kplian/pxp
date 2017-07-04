<?php
/**
*@package pXP
*@file gen-ACTOficina.php
*@author  (admin)
*@date 15-01-2014 16:05:34
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTOficina extends ACTbase{    
			
	function listarOficina(){
		$this->objParam->defecto('ordenacion','id_oficina');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODOficina','listarOficina');
		} else{
			$this->objFunc=$this->create('MODOficina');
			
			$this->res=$this->objFunc->listarOficina($this->objParam);
		}
        if($this->objParam->getParametro('_adicionar')!=''){

            $respuesta = $this->res->getDatos();


            array_unshift ( $respuesta, array(  'id_oficina'=>'0',
                'nombre'=>'Todos',
                'codigo'=>'Todos'));
            $this->res->setDatos($respuesta);
        }
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarOficina(){
		$this->objFunc=$this->create('MODOficina');	
		if($this->objParam->insertar('id_oficina')){
			$this->res=$this->objFunc->insertarOficina($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarOficina($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarOficina(){
			$this->objFunc=$this->create('MODOficina');	
		$this->res=$this->objFunc->eliminarOficina($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>