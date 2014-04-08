<?php 
/*** 
 Nombre: Intermediario.php
 Proposito: Invocar al disparador de alarmas saltandose los pasos de 
 *          autentificacion
 *          este archivo se  invoca desde un cron tab en servidor linux
 *          solo deberia llamarce desde hay otras llamadas no seran autorizadas 
 Autor: Kplian (RAC)
 Fecha: 19/07/2010
 */
session_start();
include_once(dirname(__FILE__).'/../DatosGenerales.php');
include_once(dirname(__FILE__).'/../PHPMailer/class.phpmailer.php');
include_once(dirname(__FILE__).'/../PHPMailer/class.smtp.php');


include_once(dirname(__FILE__).'/../lib_general/cls_correo_externo.php');


        $correo=new CorreoExterno();
        

        $correo->addDestinatario('jaime@kplian.com','rensi arteaga');
        $correo->setAsunto('prueba de correo externo');
        $correo->setMensaje('este es el cuerpo del mensaje');
        $correo->setTitulo('Correo de prueba');
        $correo->setDefaultPlantilla();
        $mensaje = $correo->enviarCorreo();
		echo $mensaje;
         
      
?>