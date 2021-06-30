<?php
/****************************************************************************************
*@package pXP
*@file ACTNotificaciones.php
*@author  (valvarado)
*@date 30-03-2021 15:12:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                30-03-2021 15:12:35    valvarado             Creacion    
  #
*****************************************************************************************/

class ACTNotificaciones extends ACTbase{    
            
    function listarNotificaciones(){
		$this->objParam->defecto('ordenacion','id');

        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODNotificaciones','listarNotificaciones');
        } else{
        	$this->objFunc=$this->create('MODNotificaciones');
            
        	$this->res=$this->objFunc->listarNotificaciones($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarNotificaciones(){
        $this->objFunc=$this->create('MODNotificaciones');    
        if($this->objParam->insertar('id')){
            $this->res=$this->objFunc->insertarNotificaciones($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarNotificaciones($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarNotificaciones(){
        	$this->objFunc=$this->create('MODNotificaciones');    
        $this->res=$this->objFunc->eliminarNotificaciones($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listar(){
        $this->objParam->defecto('ordenacion','id');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODNotificaciones','listarNotificaciones');
        } else{
            $this->objFunc=$this->create('MODNotificaciones');

            $this->res=$this->objFunc->listarNotificaciones($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>