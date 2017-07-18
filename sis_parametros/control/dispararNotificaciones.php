<?php
include_once(dirname(__FILE__).'/../../lib/rest/PxpRestClient.php');
include(dirname(__FILE__).'/../../lib/DatosGenerales.php');

include_once(dirname(__FILE__).'/../../lib/textalk/vendor/autoload.php');

use WebSocket\Client;

//Generamos el documento con REST
$pxpRestClient = PxpRestClient::connect('127.0.0.1',substr($_SESSION["_FOLDER"], 1) .'pxp/lib/rest/')
    ->setCredentialsPxp($_GET['user'],$_GET['pw']);

$sessionId = $pxpRestClient->doPost('parametros/Alarma/obtenerSessionId',
    array(	));



$datos_alarma_bd = $pxpRestClient->doPost('parametros/Alarma/alarmaWebSocket',
    array(	"start"=>0,"limit"=>2,"sort"=>"id_alarma","dir"=>"ASC","estado_notificacion"=>"pendiente"));

$resp_datos = json_decode($datos_alarma_bd);




//si existe error al traer los archivos existentes que ya se registaron entonces exit
if($resp_datos->ROOT->error == true){
    echo "error al traer datos del erp";
    exit;
}

$evento = "enviarMensajeUsuario";
$tipo = "notificacion";



//obtenemos en un array los archivos que estan registrados concatenando la ruta de archivo para poder comparar con la lista del ftp
foreach ($resp_datos->datos as $datos){




    //mandamos datos al websocket
    $data = array(
        "mensaje" => $datos->titulo_correo,
        "tipo_mensaje" => $tipo,
        "titulo" => $datos->titulo,
        "id_usuario" => $datos->id_usuario,
        "destino" => "Unico",
        "evento" => $evento
    );
    $send = array(
        "tipo" => "enviarMensajeUsuario",
        "data" => $data
    );




    $client = new Client("ws://localhost:".$_SESSION['_PUERTO_WEBSOCKET']."?sessionIDPXP=".$sessionId);

    $client->send(json_encode($send));

}




?>