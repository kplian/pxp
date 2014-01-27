<?php
/***
 Nombre: ACTBloqueoNotificacion.php
 Proposito: Clase que realiza la gestion de los bloques al sistema 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTBloqueoNotificacion extends ACTbase{    

	function listarNotificacion(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','id_bloqueo_notificacion');
		$this->objParam->defecto('dir_ordenacion','desc');
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODBloqueoNotificacion','listarNotificacion');
		}
		else {
			$this->objFunSeguridad=$this->create('MODBloqueoNotificacion');
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarNotificacion($this->objParam);
			
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function listarBloqueo(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','id_bloqueo_notificacion');
		$this->objParam->defecto('dir_ordenacion','desc');
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODBloqueoNotificacion','listarBloqueo');
		}
		else {
			$this->objFunSeguridad=$this->create('MODBloqueoNotificacion');
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarBloqueo($this->objParam);
			
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	function CambiarEstadoBloqueoNotificacion(){
		
        //crea un objeto del tipo seguridad
		$this->objFunSeguridad=$this->create('MODBloqueoNotificacion');
		$this->res=$this->objFunSeguridad->cambiarEstadoBloqueoNotificacion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
			

	}
	
	

}

?>