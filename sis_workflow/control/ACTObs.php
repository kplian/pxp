<?php
/**
*@package pXP
*@file gen-ACTObs.php
*@author  (admin)
*@date 20-11-2014 18:53:55
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
/*require_once(dirname(__FILE__).'/../../pxp/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/DiagramadorGantt.php');
require_once(dirname(__FILE__).'/../../pxp/pxpReport/DataSource.php');*/
include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.phpmailer.php');
include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.smtp.php');
include_once(dirname(__FILE__).'/../../lib/lib_general/cls_correo_externo.php');

class ACTObs extends ACTbase{    
			
	function listarObs(){
		$this->objParam->defecto('ordenacion','id_obs');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODObs','listarObs');
		} else{
			$this->objFunc=$this->create('MODObs');
			
			$this->res=$this->objFunc->listarObs($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarObsFuncionario(){
		$this->objParam->defecto('ordenacion','id_obs');
		$this->objParam->defecto('dir_ordenacion','asc');
		if ($this->objParam->getParametro('estado') != 'todos') {
			$this->objParam->addFiltro("obs.estado  = ''abierto''");
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODObs','listarObsFuncionario');
		} else{
			$this->objFunc=$this->create('MODObs');
			
			$this->res=$this->objFunc->listarObsFuncionario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarObs(){
		
		$this->objFunc=$this->create('MODObs');	
		if($this->objParam->insertar('id_obs')){
			$this->res=$this->objFunc->insertarObs($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarObs($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarObs(){
			$this->objFunc=$this->create('MODObs');	
		$this->res=$this->objFunc->eliminarObs($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function cerrarObs(){
		$this->objFunc=$this->create('MODObs');	
		$this->res=$this->objFunc->cerrarObs($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function SolicitarCierreObs(){

		$correo=new CorreoExterno();
		//destinatario
		$email = $this->objParam->getParametro('email');
		$correo->addDestinatario($email);
		$email_cc = $this->objParam->getParametro('email_cc');
		$correo->addCC($email_cc);

		$email_cc = $this->objParam->getParametro('email_cc');
		$correo->setMensaje($email_cc);

		$body = $this->objParam->getParametro('body');
		$correo->setMensaje($body);

		$asunto = $this->objParam->getParametro('asunto');
		$correo->setAsunto($asunto);


		$correo->setDefaultPlantilla();
		$resp=$correo->enviarCorreo();

		if($resp=='OK'){
			$mensajeExito = new Mensaje();
			$mensajeExito->setMensaje('EXITO','Solicitud.php','Correo enviado',
				'Se mando el correo con exito: OK','control' );
			$this->res = $mensajeExito;
			$this->res->imprimirRespuesta($this->res->generarJson());
		}
		else{
			echo "{\"ROOT\":{\"error\":true,\"detalle\":{\"mensaje\":\" Error al enviar correo\"}}}";
		}

		exit;
	}
	
			
}

?>