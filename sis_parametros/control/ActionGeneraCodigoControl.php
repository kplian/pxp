<?php 
/*** 
 Nombre: Intermediario.php
 Proposito: Invocar al generador de codigo de control 
 *          autentificacion
 * 		    este archivo se  invoca desde un un servidor informix
 *          solo deberia llamarse desde ahí, otras llamadas no seran autorizadas 
 Autor:	Kplian (JRR)
 Fecha:	05/11/2014
 */

include_once(dirname(__FILE__)."/../../lib/lib_control/CTSesion.php");
session_start();
$_SESSION["_SESION"]= new CTSesion(); 
include(dirname(__FILE__).'/../../lib/DatosGenerales.php');
include_once(dirname(__FILE__).'/../../lib/lib_general/Errores.php');

//estable aprametros ce la cookie de sesion
$_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control 

//echo dirname(__FILE__).'LLEGA';
register_shutdown_function('fatalErrorShutdownHandler');
set_exception_handler('exception_handler');
set_error_handler('error_handler');;
include_once(dirname(__FILE__).'/../../lib/lib_control/CTincludes.php');

include_once(dirname(__FILE__).'/../../sis_parametros/modelo/MODUtilidades.php');


         $objPostData=new CTPostData();
        
        $arr_unlink=array();
        
        $aPostData=$objPostData->getData();
        //rac 22/09/2011 
        //$aPostFiles=$objPostData->getFiles();
        
        $_SESSION["_PETICION"]=serialize($aPostData);
        $objParam = new CTParametro($aPostData['p'],null,$aPostFiles);
        ////////////////
        $objParam->addParametro('llave',$_POST['llave']);
        $objParam->addParametro('nro_autorizacion',$_POST['nro_autorizacion']);
		$objParam->addParametro('nro_factura',$_POST['nro_factura']);
		$objParam->addParametro('nit',$_POST['nit']);
		$objParam->addParametro('fecha',$_POST['fecha']);
		$objParam->addParametro('monto',$_POST['monto']);
		
        
        $objFunc=new MODUtilidades($objParam);    
        $res = $objFunc->generarCodigoControl();
		if($res->getTipo()=='ERROR'){
			echo 'Se ha producido un error-> Mensaje Técnico:'.$res->getMensajeTec();
			exit;        
		}
		
        var_dump($res);
 
?>