<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTChat.php
*@author  (admin)
*@date 05-06-2020 16:50:02
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                05-06-2020 16:50:02    admin             Creacion    
  #
*****************************************************************************************/

class ACTChat extends ACTbase{    
            
    function listarChat(){
		$this->objParam->defecto('ordenacion','id_chat');

        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODChat','listarChat');
        } else{
        	$this->objFunc=$this->create('MODChat');
            
        	$this->res=$this->objFunc->listarChat($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarChat(){
        $this->objFunc=$this->create('MODChat');    
        if($this->objParam->insertar('id_chat')){
            $this->res=$this->objFunc->insertarChat($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarChat($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarChat(){
        	$this->objFunc=$this->create('MODChat');    
        $this->res=$this->objFunc->eliminarChat($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>