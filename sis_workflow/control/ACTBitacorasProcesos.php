<?php
/**
*@package pXP
*@file gen-ACTBitacotasProcesos.php
*@author  (admin)
*@date 21-03-2017 16:31:09
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTBitacorasProcesos extends ACTbase{
			
	function listarBitacotasProcesos(){
		$this->objParam->defecto('ordenacion','id_tipo_proceso');

        if($this->objParam->getParametro('id_tipo_proceso')!=''){
            $this->objParam->addFiltro("bts.id_tipo_proceso = ".$this->objParam->getParametro('id_tipo_proceso'));
        }
        if($this->objParam->getParametro('id_funcionario')!=''){
            $this->objParam->addFiltro("bts.id_funcionario = ".$this->objParam->getParametro('id_funcionario'));
        }
        
        if($this->objParam->getParametro('desde')!='' && $this->objParam->getParametro('hasta')!=''){
            $this->objParam->addFiltro("(bts.fecha_ini::date  BETWEEN ''%".$this->objParam->getParametro('desde')."%''::date  and ''%".$this->objParam->getParametro('hasta')."%''::date)");
        }

        if($this->objParam->getParametro('desde')!='' && $this->objParam->getParametro('hasta')==''){
            $this->objParam->addFiltro("(bts.fecha_ini::date  >= ''%".$this->objParam->getParametro('desde')."%''::date)");
        }

        if($this->objParam->getParametro('desde')=='' && $this->objParam->getParametro('hasta')!=''){
            $this->objParam->addFiltro("(bts.fecha_ini::date  <= ''%".$this->objParam->getParametro('hasta')."%''::date)");
        }



		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODBitacorasProcesos','listarBitacotasProcesos');
		} else{
			$this->objFunc=$this->create('MODBitacorasProcesos');
			
			$this->res=$this->objFunc->listarBitacotasProcesos($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarBitacotasProcesos(){
		$this->objFunc=$this->create('MODBitacorasProcesos');
		if($this->objParam->insertar('id_bitacora')){
			$this->res=$this->objFunc->insertarBitacotasProcesos($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarBitacotasProcesos($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarBitacotasProcesos(){
			$this->objFunc=$this->create('MODBitacorasProcesos');
		$this->res=$this->objFunc->eliminarBitacotasProcesos($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    function listarBitacorasProceso(){

        $this->objFunc=$this->create('MODBitacorasProcesos');
        $this->res=$this->objFunc->listarBitacorasProceso($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function getDatos(){
        $this->objParam->defecto('ordenacion','id_funcionario');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objFunc=$this->create('MODBitacorasProcesos');
        $this->res=$this->objFunc->listaGetDatos($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }


}

?>