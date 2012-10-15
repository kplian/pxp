<?php 
/***
 Nombre: Intermediario.php
 Proposito: Invocar a la clase Intermediaria para ejecutar las acciones
 a peticion del usuario
 Autor:	Kplian (RCM)
 Fecha:	19/07/2010
 */
include_once(dirname(__FILE__)."/CTSesion.php");
session_start();
include(dirname(__FILE__).'/../../lib/DatosGenerales.php');
include_once('../lib_general/Errores.php');
//estable aprametros ce la cookie de sesion
$_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control cantidad de error anidados
if($_SESSION["_FORSSL"]=='SI'){
	session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,true ,false);
}
else{
	session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,false ,false);
}
register_shutdown_function('fatalErrorShutdownHandler');
set_exception_handler('exception_handler');
set_error_handler('error_handler');
include_once('../DatosGenerales.php');
include_once('CTincludes.php');
//Instancia la Clase Intermediario y se direcciona la solicitud realizada
$a=new CTIntermediario();
$a->direccionarAccion();
?>