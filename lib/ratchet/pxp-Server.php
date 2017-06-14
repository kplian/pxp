<?php

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
    8080
);

$server->run();
