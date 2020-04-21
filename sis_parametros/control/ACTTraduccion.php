<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTTraduccion.php
*@author  (RAC)
*@date 21-04-2020 03:41:52
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                21-04-2020 03:41:52    RAC             Creacion    
  #
*****************************************************************************************/

class ACTTraduccion extends ACTbase{    
            
    function listarTraduccion(){
        $this->objParam->defecto('ordenacion','id_traduccion');
        
        if($this->objParam->getParametro('id_palabra_clave')!=''){
	    	$this->objParam->addFiltro("tra.id_palabra_clave = ".$this->objParam->getParametro('id_palabra_clave'));	
		}

        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTraduccion','listarTraduccion');
        } else{
        	$this->objFunc=$this->create('MODTraduccion');
            
        	$this->res=$this->objFunc->listarTraduccion($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarTraduccion(){
        $this->objFunc=$this->create('MODTraduccion');    
        if($this->objParam->insertar('id_traduccion')){
            $this->res=$this->objFunc->insertarTraduccion($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarTraduccion($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarTraduccion(){
        	$this->objFunc=$this->create('MODTraduccion');    
        $this->res=$this->objFunc->eliminarTraduccion($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>