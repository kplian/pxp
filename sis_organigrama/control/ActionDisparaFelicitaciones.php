<?php 
/*** 
 Nombre: Intermediario.php
 Proposito: revisa los pagos penxdientes al dia e insertar las alamras correspondientes
 Autor:	Kplian (RAC)
 Fecha:	14/10/2014 */
include_once(dirname(__FILE__)."/../../lib/lib_control/CTSesion.php");
session_start();
$_SESSION["_SESION"]= new CTSesion(); 
include(dirname(__FILE__).'/../../lib/DatosGenerales.php');
include_once(dirname(__FILE__).'/../../lib/lib_general/Errores.php');
include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.phpmailer.php');
include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.smtp.php');
include_once(dirname(__FILE__).'/../../lib/lib_general/cls_correo_externo.php');
include_once(dirname(__FILE__).'/../../lib/rest/PxpRestClient.php');



include_once(dirname(__FILE__).'/../../lib/FirePHPCore-0.3.2/lib/FirePHPCore/FirePHP.class.php');


ob_start();
$fb=FirePHP::getInstance(true);

//estable aprametros ce la cookie de sesion
$_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control 


register_shutdown_function('fatalErrorShutdownHandler');
set_exception_handler('exception_handler');
set_error_handler('error_handler');;
include_once(dirname(__FILE__).'/../../lib/lib_control/CTincludes.php');
include_once(dirname(__FILE__).'/../../sis_organigrama/modelo/MODFuncionario.php');


        $objPostData=new CTPostData();
        $arr_unlink=array();
        $aPostData=$objPostData->getData();
        $_SESSION["_PETICION"]=serialize($aPostData);
        $objParam = new CTParametro($aPostData['p'],null,$aPostFiles);
        ////////////////
        $objParam->defecto('ordenacion','id_plan_pago');
        $objParam->defecto('dir_ordenacion','asc');
        $objFunc=new MODFuncionario($objParam);    
        
		//listas plan es de pago pendientes
		$res=$objFunc->alertarCumpleaneroDia();
		if($res->getTipo()=='ERROR'){
			echo 'Se ha producido un error-> Mensaje Técnico:'.$res->getMensajeTec();
			exit;        
		} 
       else{
       	   echo 'Procesado con exito';
       }
	      
 
?>