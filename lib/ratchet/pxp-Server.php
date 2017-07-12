<?php
require '../DatosGenerales.php';
require '../lib_control/CTincludes.php';

use Ratchet\Server\IoServer;
use Ratchet\Http\HttpServer;
use Ratchet\WebSocket\WsServer;


require 'vendor/autoload.php';

require 'pxp.php';



$server = IoServer::factory(
    new HttpServer(
        new WsServer(
            new Pxp()
        )
    ),
    $_SESSION['_PUERTO_WEBSOCKET']
);

$server->run();
