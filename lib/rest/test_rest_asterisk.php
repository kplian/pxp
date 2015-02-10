#!/usr/bin/php -q
<?php
set_time_limit(30);
require_once "phpagi.php";
require_once "PxpRestClient.php";
include_once('/var/www/html/libs/JSON.php');
error_reporting(E_ALL);


$agi = new AGI();
$agi->answer();


//agi(googletts.agi,"Esta es una simple prueba de google",es)
$agi->exec("AGI","googletts.agi,\"Bienvenido a la aplicación para inactivar roles en el servidor vps de estados unidos .\",es,#,1.28");
$pxpRestClient = PxpRestClient::connect('gema.kplian.com','pxp/lib/rest/')
					->setCredentialsPxp('admin','admin');
	
$jsonString =  $pxpRestClient->doGet('seguridad/Rol/listarRol',array('start'=>'0','limit'=>'10'));
$jsonString = str_replace ('(','',$jsonString);
$jsonString = str_replace (')','',$jsonString);

$json = new Services_JSON(); 
$array = $json->decode($jsonString);
$id = 1;
foreach ($array->datos as $value) {
	$valor = $value->rol;
	$agi->exec("AGI","googletts.agi,\" $id  Rol  $valor.\",es,#,1.28");
	$id++;
}

$agi->exec("AGI","googletts.agi,\" Ingrese el número de rol a eliminar despues del tono \",es,#,1.28");

$resultado = $agi->get_data('beep', 3000, 20); 

$numero = $resultado['result'];

$id_rol = $array->datos[$numero-1]->id_rol;
$agi->exec("AGI","googletts.agi,\" El id del rol seleccionado es  $id_rol\",es,#,1.28");
$jsonString =  $pxpRestClient->doPost('seguridad/Rol/eliminarRol',array('_tipo'=>'matriz','row'=>"{\"0\":{\"id_rol\":\"$id_rol\",\"_fila\":$numero}}"));
$agi->exec("AGI","googletts.agi,\" El rol ha sido inactivado exitosamente \",es,#,1.28");


$agi->hangup();


?>
