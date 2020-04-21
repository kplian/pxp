<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTLenguaje.php
*@author  (admin)
*@date 21-04-2020 01:50:14
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                21-04-2020 01:50:14    admin             Creacion    
  #
*****************************************************************************************/

class ACTLenguaje extends ACTbase{    
            
    function listarLenguaje(){
		$this->objParam->defecto('ordenacion','id_lenguaje');

        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODLenguaje','listarLenguaje');
        } else{
        	$this->objFunc=$this->create('MODLenguaje');
            
        	$this->res=$this->objFunc->listarLenguaje($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarLenguaje(){
        $this->objFunc=$this->create('MODLenguaje');    
        if($this->objParam->insertar('id_lenguaje')){
            $this->res=$this->objFunc->insertarLenguaje($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarLenguaje($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarLenguaje(){
        	$this->objFunc=$this->create('MODLenguaje');    
        $this->res=$this->objFunc->eliminarLenguaje($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>