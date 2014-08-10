<?php 
/***
 Nombre: cerrar.php
 Proposito: Realizar un cierre seguro de la sesion abierta
 Autor:	Kplian (RAC)
 Fecha:	01/07/2010
 */
session_start() ;
session_unset();
session_destroy(); // destruyo la sesi�n 
header("Location: ../../../index.php"); 

/*
Para hacer una redirecci�n 301 (permanente), utilizaremos un c�digo PHP como este:

header("HTTP/1.1 301 Moved Permanently");
header("Location: nueva_pagina.html");

Para hacer una redirecci�n 302 con PHP (temporal) el c�digo ser�a as�:

header("HTTP/1.1 302 Moved Temporarily");
header("Location: nueva_pagina.html"); 
*/
//header("Location: http://192.168.0.8/endesis/index.php"); 
exit;
?>