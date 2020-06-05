<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTTipoChat.php
*@author  (admin)
*@date 05-06-2020 16:49:24
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                05-06-2020 16:49:24    admin             Creacion    
  #
*****************************************************************************************/

class ACTTipoChat extends ACTbase{    
            
    function listarTipoChat(){
		$this->objParam->defecto('ordenacion','id_tipo_chat');

        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTipoChat','listarTipoChat');
        } else{
        	$this->objFunc=$this->create('MODTipoChat');
            
        	$this->res=$this->objFunc->listarTipoChat($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarTipoChat(){
        $this->objFunc=$this->create('MODTipoChat');    
        if($this->objParam->insertar('id_tipo_chat')){
            $this->res=$this->objFunc->insertarTipoChat($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarTipoChat($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarTipoChat(){
        	$this->objFunc=$this->create('MODTipoChat');    
        $this->res=$this->objFunc->eliminarTipoChat($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>