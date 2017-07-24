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
		if($this->objParam->getParametro('minutos')!='')
		{
			if(array_key_exists('_ULTIMA_ALARMA',$_SESSION)) {
				if (count($_SESSION['_ULTIMA_ALARMA']) > 0) {
			    	$this->objParam->addFiltro("alarm.id_alarma not in(" . implode (',',$_SESSION['_ULTIMA_ALARMA']) ." )");
				}
			}			
			$this->objParam->addFiltro("alarm.fecha_reg > (now() - interval ''" . ($this->objParam->getParametro('minutos') + 1 ). " minute'')");	
		}

		//ffp
		if($this->objParam->getParametro('estado_notificacion')!='') {

			$this->objParam->addFiltro("alarm.estado_notificacion = ''".$this->objParam->getParametro('estado_notificacion')."'' ");
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAlarma','listarAlarma');
		} else{
			$this->objFunc=$this->create('MODAlarma');	
			$this->res=$this->objFunc->listarAlarma();
			if($this->objParam->getParametro('minutos')!='')
			{
				$this->llenarUltimasAlarmas();
			}
		}	
		$this->res->imprimirRespuesta($this->res->generarJson());
		
	}

	function llenarUltimasAlarmas() {
		
		if(!array_key_exists('_ULTIMA_ALARMA',$_SESSION)) {
			$_SESSION['_ULTIMA_ALARMA'] = array();
		}
		
		foreach ($this->res->getDatos() as  $value) {
			array_push($_SESSION['_ULTIMA_ALARMA'],$value['id_alarma']);
		}
	}
	
	function listarAlarmaWF(){
		//$this->objParam->defecto('ordenacion','id_alarma');

		$this->objParam->defecto('alarm.fecha','desc');		
		if($this->objParam->getParametro('id_proceso_wf')!='')
		{
			$this->objParam->addFiltro("alarm.id_proceso_wf=".$this->objParam->getParametro('id_proceso_wf'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAlarma','listarAlarmaWF');
		} else{
			$this->objFunc=$this->create('MODAlarma');	
			$this->res=$this->objFunc->listarAlarmaWF();
		}	
		$this->res->imprimirRespuesta($this->res->generarJson());
		
	}
	
	function listarComunicado(){
		//$this->objParam->defecto('ordenacion','id_alarma');

		$this->objParam->defecto('alarm.fecha','desc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAlarma','listarComunicado');
		} else{
			$this->objFunc=$this->create('MODAlarma');	
			$this->res=$this->objFunc->listarComunicado();
		}	
		$this->res->imprimirRespuesta($this->res->generarJson());
		
	}
	
	
	function alarmaPendiente(){
		$this->objParam->defecto('ordenacion','id_alarma');

		$this->objParam->defecto('dir_ordenacion','asc');
		
			$this->objFunc=$this->create('MODAlarma');		
			$this->res=$this->objFunc->alarmaPendiente();
			$this->res->imprimirRespuesta($this->res->generarJson());
		
	}			
	function insertarAlarma(){
		$this->objFunc=$this->create('MODAlarma');		
		if($this->objParam->insertar('id_alarma')){
			$this->res=$this->objFunc->insertarAlarma();			
		} else{			
			$this->res=$this->objFunc->modificarAlarma();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAlarma(){
		$this->objFunc=$this->create('MODAlarma');		
		$this->res=$this->objFunc->eliminarAlarma();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function getAlarma(){
        $this->objFunc=$this->create('MODAlarma');      
        $this->res=$this->objFunc->getAlarma();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	
	function reenviarCorreo(){
		$this->objFunc=$this->create('MODAlarma');		
		$this->res=$this->objFunc->reenviarCorreo();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function alterarDestino(){
		$this->objFunc=$this->create('MODAlarma');		
		$this->res=$this->objFunc->alterarDestino();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

   function confirmarAcuseRecibo(){
		$this->objFunc=$this->create('MODAlarma');		
		$this->res=$this->objFunc->confirmarAcuseRecibo();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
   
   function finalizarComunicado(){
		$this->objFunc=$this->create('MODAlarma');		
		$this->res=$this->objFunc->finalizarComunicado();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
   function alarmaWebSocket(){
		$this->objFunc=$this->create('MODAlarma');
		$this->res=$this->objFunc->alarmaWebSocket();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
   function obtenerSessionId(){
		echo session_id();
	}



			
}

?>