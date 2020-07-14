<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTMensaje.php
*@author  (favio)
*@date 15-06-2020 21:17:46
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                15-06-2020 21:17:46    favio             Creacion    
  #
*****************************************************************************************/

class ACTMensaje extends ACTbase{    
            
    function listarMensaje(){
		$this->objParam->defecto('ordenacion','id_mensaje');

        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objParam->addFiltro("men.id_chat = ''".$this->objParam->getParametro('id_chat')."'' ");

        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODMensaje','listarMensaje');
        } else{
        	$this->objFunc=$this->create('MODMensaje');
            
        	$this->res=$this->objFunc->listarMensaje($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarMensaje(){
        $this->objFunc=$this->create('MODMensaje');    
        if($this->objParam->insertar('id_mensaje')){
            $this->res=$this->objFunc->insertarMensaje($this->objParam);
            if ($this->res->getTipo() == 'ERROR') {
                $this->res->imprimirRespuesta($this->res->generarJson());
                exit;
            }

        } else{            
            $this->res=$this->objFunc->modificarMensaje($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarMensaje(){
        	$this->objFunc=$this->create('MODMensaje');    
        $this->res=$this->objFunc->eliminarMensaje($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>