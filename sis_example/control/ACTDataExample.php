<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTDataExample.php
*@author  (admin)
*@date 12-06-2020 16:37:18
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                12-06-2020 16:37:18    admin             Creacion    
  #
*****************************************************************************************/

class ACTDataExample extends ACTbase{    
            
    function listarDataExample(){
		$this->objParam->defecto('ordenacion','id_data_example');

        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODDataExample','listarDataExample');
        } else{
        	$this->objFunc=$this->create('MODDataExample');
            
        	$this->res=$this->objFunc->listarDataExample($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

                
    function insertarDataExample(){
        $this->objFunc=$this->create('MODDataExample');    
        if($this->objParam->insertar('id_data_example')){
            $this->res=$this->objFunc->insertarDataExample($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarDataExample($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarDataExample(){
        	$this->objFunc=$this->create('MODDataExample');    
        $this->res=$this->objFunc->eliminarDataExample($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listarDataExampleChat(){
        $this->objParam->defecto('ordenacion','id_data_example');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODDataExample','listarDataExampleChat');
        } else{
            $this->objFunc=$this->create('MODDataExample');

            $this->res=$this->objFunc->listarDataExampleChat($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

            
}

?>