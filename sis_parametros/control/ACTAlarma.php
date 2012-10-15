<?php
/**
*@package pXP
*@file gen-ACTAlarma.php
*@author  (fprudencio)
*@date 18-11-2011 11:59:10
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAlarma extends ACTbase{    
			
	function listarAlarma(){
		//$this->objParam->defecto('ordenacion','id_alarma');

		$this->objParam->defecto('alarm.fecha','desc');
		if($this->objParam->getParametro('id_usuario')!='')
		{
			$this->objParam->addFiltro("alarm.id_funcionario in (Select fun.id_funcionario
            													 from rhum.tfuncionario fun
            													 inner join segu.tusuario usu on usu.id_persona=fun.id_persona
                                                                 where usu.id_usuario=".$this->objParam->getParametro('id_usuario').")");	
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarAlarma');
		} else{
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->listarAlarma($this->objParam);
		}	
		$this->res->imprimirRespuesta($this->res->generarJson());
		
	}
	function alarmaPendiente(){
		$this->objParam->defecto('ordenacion','id_alarma');

		$this->objParam->defecto('dir_ordenacion','asc');
		
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->alarmaPendiente($this->objParam);
			$this->res->imprimirRespuesta($this->res->generarJson());
		
	}			
	function insertarAlarma(){
		$this->objFunc=new FuncionesParametros();	
		if($this->objParam->insertar('id_alarma')){
			$this->res=$this->objFunc->insertarAlarma($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAlarma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAlarma(){
		$this->objFunc=new FuncionesParametros();	
		$this->res=$this->objFunc->eliminarAlarma($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>