<?php
/**
*@package pXP
*@file gen-ACTUsuarioExterno.php
*@author  (miguel.mamani)
*@date 27-09-2017 13:33:32
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUsuarioExterno extends ACTbase{    
			
	function listarUsuarioExterno(){
		$this->objParam->defecto('ordenacion','id_usuario_externo');
		$this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('id_usuario') != '') {
            $this->objParam->addFiltro(" ueo.id_usuario = " . $this->objParam->getParametro('id_usuario'));
        }
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODUsuarioExterno','listarUsuarioExterno');
		} else{
			$this->objFunc=$this->create('MODUsuarioExterno');
			
			$this->res=$this->objFunc->listarUsuarioExterno($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUsuarioExterno(){
		$this->objFunc=$this->create('MODUsuarioExterno');	
		if($this->objParam->insertar('id_usuario_externo')){
			$this->res=$this->objFunc->insertarUsuarioExterno($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarUsuarioExterno($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUsuarioExterno(){
			$this->objFunc=$this->create('MODUsuarioExterno');	
		$this->res=$this->objFunc->eliminarUsuarioExterno($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

    function generarUsuarioAmedeos(){
        $this->objFunc=$this->create('MODUsuarioExterno');
        $this->res=$this->objFunc->GenerarUsuarioAmadeus($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
			
}

?>