<?php
include_once(dirname(__FILE__).'/../../lib/rest/PxpRestClient2.php');
include(dirname(__FILE__).'/../../lib/DatosGenerales.php');

//Generamos el documento con REST
$pxpRestClient = PxpRestClient2::connect('pxp.vouz.me','pxp/lib/rest/', 443, 'https' )
    ->setCredentialsPxp($_GET['user'],$_GET['pw']);


$datos_alarma_bd = $pxpRestClient->doPost('parametros/Alarma/dispararPushNotifications',
    array(	));

$resp_datos =  json_decode($datos_alarma_bd, true);

if($resp_datos->ROOT->error == true){
    echo "error al traer datos del erp";
    exit;
} else {
    echo $datos_alarma_bd;
    exit;
}

?>