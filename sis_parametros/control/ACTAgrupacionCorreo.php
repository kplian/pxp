<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTAgrupacionCorreo.php
*@author  (egutierrez)
*@date 26-11-2020 15:27:53
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                26-11-2020 15:27:53    egutierrez             Creacion    
  #
*****************************************************************************************/

class ACTAgrupacionCorreo extends ACTbase{    
            
    function listarAgrupacionCorreo(){
		$this->objParam->defecto('ordenacion','id_agrupacion_correo');

        if ($this->objParam->getParametro('id_tipo_envio_correo') != '') {
            $this->objParam->addFiltro("cor.id_tipo_envio_correo = ". $this->objParam->getParametro('id_tipo_envio_correo'));
        }
        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODAgrupacionCorreo','listarAgrupacionCorreo');
        } else{
        	$this->objFunc=$this->create('MODAgrupacionCorreo');
            
        	$this->res=$this->objFunc->listarAgrupacionCorreo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarAgrupacionCorreo(){
        $this->objFunc=$this->create('MODAgrupacionCorreo');    
        if($this->objParam->insertar('id_agrupacion_correo')){
            $this->res=$this->objFunc->insertarAgrupacionCorreo($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarAgrupacionCorreo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarAgrupacionCorreo(){
        	$this->objFunc=$this->create('MODAgrupacionCorreo');    
        $this->res=$this->objFunc->eliminarAgrupacionCorreo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>