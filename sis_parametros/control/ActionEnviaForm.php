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



        $correo=new CorreoExterno();
		$correo->addDestinatario('jaime@kplian.com','Jaime Rivera');
        $correo->setAsunto('Formulario');
        $correo->setMensaje('<form method="post" action="contact.php">
							    <textarea name="message"></textarea>
							    <input type="submit">
							</form>');
        $correo->setTitulo('Formulario');
        $correo->setDefaultPlantilla();
        $correo->enviarCorreo();
		     
 
?>