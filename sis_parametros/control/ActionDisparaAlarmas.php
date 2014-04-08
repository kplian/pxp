<?php 
/*** 
 Nombre: Intermediario.php
 Proposito: Invocar al disparador de alarmas saltandose los pasos de 
 *          autentificacion
 * 		    este archivo se  invoca desde un cron tab en servidor linux
 *          solo deberia llamarse desde ahí, otras llamadas no seran autorizadas 
 Autor:	Kplian (RAC)
 Fecha:	19/07/2010
 */
include_once(dirname(__FILE__)."/../../lib/lib_control/CTSesion.php");
session_start();
$_SESSION["_SESION"]= new CTSesion(); 
include(dirname(__FILE__).'/../../lib/DatosGenerales.php');
include_once(dirname(__FILE__).'/../../lib/lib_general/Errores.php');

include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.phpmailer.php');
include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.smtp.php');
include_once(dirname(__FILE__).'/../../lib/lib_general/cls_correo_externo.php');


include_once(dirname(__FILE__).'/../../lib/FirePHPCore-0.3.2/lib/FirePHPCore/FirePHP.class.php');


ob_start();
$fb=FirePHP::getInstance(true);

//estable aprametros ce la cookie de sesion
$_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control 

/*
cantidad de error anidados
if($_SESSION["_FORSSL"]=='SI'){
    session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,true ,false);
}
else{
    session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,false ,false);
}
*/


//echo dirname(__FILE__).'LLEGA';
register_shutdown_function('fatalErrorShutdownHandler');
set_exception_handler('exception_handler');
set_error_handler('error_handler');;
include_once(dirname(__FILE__).'/../../lib/lib_control/CTincludes.php');

include_once(dirname(__FILE__).'/../../sis_parametros/modelo/MODAlarma.php');


         $objPostData=new CTPostData();
        
       
        
        $aPostData=$objPostData->getData();
        //rac 22/09/2011 
        //$aPostFiles=$objPostData->getFiles();
        
        $_SESSION["_PETICION"]=serialize($aPostData);
        $objParam = new CTParametro($aPostData['p'],null,$aPostFiles);
        ////////////////
        $objParam->defecto('ordenacion','id_lugar');
        $objParam->defecto('dir_ordenacion','asc');
        
        $objFunc=new MODAlarma($objParam);    
        $res=$objFunc->GeneraAlarma();
		if($res->getTipo()=='ERROR'){
			echo 'Se ha producido un error-> Mensaje Técnico:'.$res->getMensajeTec();
			exit;        
		}
		
        $objFunc=new MODAlarma($objParam);  
        $res2=$objFunc->listarAlarmaCorrespondeciaPendiente();
		if($res2->getTipo()=='ERROR'){
			echo 'Se ha producido un error-> Mensaje Técnico:'.$res2->getMensajeTec();
			exit;        
		}
        
        $correo=new CorreoExterno();

		foreach ($res2->datos as $d){
       		echo   'correo -> '.$d['email_empresa'].'</BR>' ;
			if(isset($d['email_empresa'])){
				$correo->addDestinatario($d['email_empresa'],$d['email_empresa']);
                $correo->setAsunto($d['tipo'].' '.$d['titulo_correo'].' '.$d['obs']);
                $correo->setMensaje($d['descripcion']);
                $correo->setTitulo($d['titulo_correo']);
                $correo->setDefaultPlantilla();
                $correo->enviarCorreo();
            }
        }
		
        $objFunc=new MODAlarma($objParam);
        $res2=$objFunc->modificarEnvioCorreo();
		if($res2->getTipo()=='ERROR'){
			echo 'Se ha producido un error-> Mensaje Técnico:'.$res2->getMensajeTec();
			exit;        
		}
        $res2->imprimirRespuesta($res2->generarJson());
 
?>