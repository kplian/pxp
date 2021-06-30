<?php
/****************************************************************************************
*@package pXP
*@file ACTFuncionarioDispositivo.php
*@author  (valvarado)
*@date 30-03-2021 15:11:51
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                30-03-2021 15:11:51    valvarado             Creacion    
  #
*****************************************************************************************/

class ACTFuncionarioDispositivo extends ACTbase{    
            
    function listarFuncionarioDispositivo(){
		$this->objParam->defecto('ordenacion','id');

        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODFuncionarioDispositivo','listarFuncionarioDispositivo');
        } else{
        	$this->objFunc=$this->create('MODFuncionarioDispositivo');
            
        	$this->res=$this->objFunc->listarFuncionarioDispositivo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarFuncionarioDispositivo(){
        $this->objFunc=$this->create('MODFuncionarioDispositivo');    
        if($this->objParam->insertar('id')){
            $this->res=$this->objFunc->insertarFuncionarioDispositivo($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarFuncionarioDispositivo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarFuncionarioDispositivo(){
        	$this->objFunc=$this->create('MODFuncionarioDispositivo');    
        $this->res=$this->objFunc->eliminarFuncionarioDispositivo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>