<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTGrupoIdioma.php
*@author  (admin)
*@date 21-04-2020 02:29:46
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                21-04-2020 02:29:46    admin             Creacion    
  #
*****************************************************************************************/

class ACTGrupoIdioma extends ACTbase{    
            
    function listarGrupoIdioma(){
		$this->objParam->defecto('ordenacion','id_grupo_idioma');

        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODGrupoIdioma','listarGrupoIdioma');
        } else{
        	$this->objFunc=$this->create('MODGrupoIdioma');
            
        	$this->res=$this->objFunc->listarGrupoIdioma($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarGrupoIdioma(){
        $this->objFunc=$this->create('MODGrupoIdioma');    
        if($this->objParam->insertar('id_grupo_idioma')){
            $this->res=$this->objFunc->insertarGrupoIdioma($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarGrupoIdioma($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarGrupoIdioma(){
        	$this->objFunc=$this->create('MODGrupoIdioma');    
        $this->res=$this->objFunc->eliminarGrupoIdioma($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>