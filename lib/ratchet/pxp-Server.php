<?php
require '../DatosGenerales.php';
require '../lib_control/CTincludes.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);



use Ratchet\Server\IoServer;
use Ratchet\Http\HttpServer;
use Ratchet\WebSocket\WsServer;
echo "inicia ....";

require 'vendor/autoload.php';

require 'pxp.php';

ini_set("error_log", "/tmp/php-error.log");
error_log( "Hello, errors!" );

ignore_user_abort(true);

ini_set('max_execution_time', 0);

set_time_limit(0);

$server = IoServer::factory(
    new HttpServer(
        new WsServer(
            new Pxp()
        )
    ),
    $_SESSION['_PUERTO_WEBSOCKET']
);

echo "atesn de abrir ...";
$server->run();
echo "despues de abrir ...";