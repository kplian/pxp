<?php 
/*** 
 Nombre: Intermediario.php
 Proposito: Invocar al disparador de alarmas saltandose los pasos de 
 *          autentificacion
 * 		    este archivo se  invoca desde un cron tab en servidor linux
 *          solo deberia llamarce desde hay otras llamadas no seran autorizadas 
 Autor:	Kplian (RAC)
 Fecha:	19/07/2010
 */
include_once(dirname(__FILE__)."/../../lib/lib_control/CTSesion.php");
session_start();
$_SESSION["_SESION"]= new CTSesion(); 
include(dirname(__FILE__).'/../../lib/DatosGenerales.php');
include_once(dirname(__FILE__).'/../../lib/lib_general/Errores.php');

include_once(dirname(__FILE__).'/../../lib/lib_general/Correo.php');


include_once(dirname(__FILE__).'/../../lib/FirePHPCore-0.3.2/lib/FirePHPCore/FirePHP.class.php');

ob_start();
$fb=FirePHP::getInstance(true);

//estable aprametros ce la cookie de sesion
$_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control cantidad de error anidados
if($_SESSION["_FORSSL"]=='SI'){
	session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,true ,false);
}
else{
	session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,false ,false);
}

//echo dirname(__FILE__).'LLEGA';
register_shutdown_function('fatalErrorShutdownHandler');
set_exception_handler('exception_handler');
set_error_handler('error_handler');
include_once(dirname(__FILE__).'/../../lib/DatosGenerales.php');
include_once(dirname(__FILE__).'/../../lib/lib_control/CTincludes.php');

/////////////////////////////////////////
        $objPostData=new CTPostData();
        
        $correo=new Correo();
        
	    $aPostData=$objPostData->getData();
		//rac 22/09/2011 
		$aPostFiles=$objPostData->getFiles();
		//var_dump($this->aPostFiles);
		//exit;
		$_SESSION["_PETICION"]=serialize($aPostData);
		$objParam = new CTParametro($aPostData['p'],null,$aPostFiles);
		////////////////
        $objParam->defecto('ordenacion','id_lugar');
        $objParam->defecto('dir_ordenacion','asc');
		$objFunc=new FuncionesParametros();	
		$res=$objFunc->GeneraAlarma($objParam);
		
		$res2=$objFunc->listarAlarmaCorrespondeciaPendiente($objParam);
		
		
		foreach ($res2->datos as $d){
			if(isset($d['email_empresa'])){
		     $correo->EnviarCorreo('endesis@ende.bo',
			                      $d['email_empresa'],
			                      $d['tipo'].' '.$d['obs'],
			                      $d['descripcion'],
			                      $d['tipo'].' '.$d['obs'],
			                      $d['tipo'].' '.$d['obs']);
			}
		}
		
		$res2=$objFunc->modificarEnvioCorreo($objParam);
		
		
		$res->imprimirRespuesta($res->generarJson());
?>