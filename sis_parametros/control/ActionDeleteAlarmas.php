<?php 
/*** 
 	ISSUE			FECHA			AUTHOR 					DESCRIPCION
	#17	EndeEtr		22/05/2019		EGS						inactivacion de alertas deacuerdo a dias asignados
 Nombre: Intermediario.php
 Proposito: Invocar al disparador de alarmas saltandose los pasos de 
 *          autentificacion este archivo se  invoca desde un cron tab en servidor linux
 *          solo deberia llamarse desde ahí, otras llamadas no seran autorizadas 

 */
include_once(dirname(__FILE__)."/../../lib/lib_control/CTSesion.php");
session_start();
$_SESSION["_SESION"]= new CTSesion(); 

include(dirname(__FILE__).'/../../lib/DatosGenerales.php');
include_once(dirname(__FILE__).'/../../lib/lib_general/Errores.php');

require dirname(__FILE__).'/../../lib/PHPMailer/PHPMailerAutoload.php';
include_once(dirname(__FILE__).'/../../lib/lib_general/cls_correo_externo.php');
include_once(dirname(__FILE__).'/../../lib/rest/PxpRestClient.php');



include_once(dirname(__FILE__).'/../../lib/FirePHPCore-0.3.2/lib/FirePHPCore/FirePHP.class.php');


ob_start();
$fb=FirePHP::getInstance(true);

//estable aprametros ce la cookie de sesion
$_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control 

include_once(dirname(__FILE__).'/../../lib/lib_control/CTincludes.php');
include_once(dirname(__FILE__).'/../../sis_parametros/modelo/MODAlarma.php');


        $objPostData = new CTPostData();
        $arr_unlink = array();
        $aPostData = $objPostData->getData();


        
        $_SESSION["_PETICION"]=serialize($aPostData);
        $objParam = new CTParametro($aPostData['p'],null,$aPostFiles);
		
		$objParam->addParametro('id_usuario', 1);
		
		$objParam->addParametro('habilitado', 'si');
		
        ////////////////
         
        //var_dump($objParam); 
        $objFunc =new MODAlarma($objParam);    
        $res=$objFunc->deleteAlarmaCron();
		if($res->getTipo()=='ERROR'){
			echo 'Se ha producido un error-> Mensaje Técnico:'.$res->getMensajeTec();
			exit;        
		}


        $errores_id = '';
		$errores_msg = '';
		$pendiente = '0';
        error_reporting(-1);//captura todos los tipos de errores ...
		

		$objParam->addParametro('errores_id', $errores_id);
		$objParam->addParametro('errores_msg', $errores_msg);
		$objParam->addParametro('id_usuario', 1);
		$objParam->addParametro('tipo', 'TODOS');
	
        $res->imprimirRespuesta($res->generarJson());
		
		foreach ($arr_unlink as $value) {
			unlink($value);
		
		}
 
?>