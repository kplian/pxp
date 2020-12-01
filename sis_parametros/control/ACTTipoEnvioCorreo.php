<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTTipoEnvioCorreo.php
*@author  (egutierrez)
*@date 26-11-2020 15:26:10
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                26-11-2020 15:26:10    egutierrez             Creacion    
  #
*****************************************************************************************/

class ACTTipoEnvioCorreo extends ACTbase{
            
    function listarTipoEnvioCorreo(){
		$this->objParam->defecto('ordenacion','id_tipo_envio_correo');

        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTipoEnvioCorreo','listarTipoEnvioCorreo');
        } else{
        	$this->objFunc=$this->create('MODTipoEnvioCorreo');
            
        	$this->res=$this->objFunc->listarTipoEnvioCorreo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarTipoEnvioCorreo(){
        $this->objFunc=$this->create('MODTipoEnvioCorreo');
        if($this->objParam->insertar('id_tipo_envio_correo')){
            $this->res=$this->objFunc->insertarTipoEnvioCorreo($this->objParam);
        } else{            
            $this->res=$this->objFunc->modificarTipoEnvioCorreo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarTipoEnvioCorreo(){
        	$this->objFunc=$this->create('MODTipoEnvioCorreo');
        $this->res=$this->objFunc->eliminarTipoEnvioCorreo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>