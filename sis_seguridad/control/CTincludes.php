<?php
/***
 Nombre: CTincludes.php
 Proposito: archivos que incluye clases y archivos basicos para el funcionamiento
 del sistema 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
include_once(dirname(__FILE__)."../../../lib_control/CTEncriptacion.php");
include_once(dirname(__FILE__)."../../../lib_control/CTIntermediario.php");
include_once(dirname(__FILE__)."../../../lib_control/CTParametro.php");
include_once(dirname(__FILE__)."../../../lib_control/CTPostData.php");
include_once(dirname(__FILE__)."../../../lib_control/CTSesion.php");

include_once(dirname(__FILE__)."../../../lib_modelo/conexion.php");
include_once(dirname(__FILE__)."../../../lib_modelo/driver.php");
include_once(dirname(__FILE__)."../../../lib_modelo/validacion.php");

include_once(dirname(__FILE__)."../../../lib_general/Mensaje.php");

include_once(dirname(__FILE__)."../../../cifrado/rsa.class.php");
include_once(dirname(__FILE__)."../../../cifrado/feistel.php");


?>