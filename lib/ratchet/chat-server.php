<?php
$_SERVER['REMOTE_ADDR'] = '192.168.12.22';


use Ratchet\Server\IoServer;
use Ratchet\Http\HttpServer;
use Ratchet\WebSocket\WsServer;

require '../act.php';

    require 'vendor/autoload.php';

require 'Chat.php';

$act = new act();
$se = $act->iniciarSession();


$server = IoServer::factory(
    new HttpServer(
        new WsServer(
            new Chat()
        )
    ),
    8080
);

$server->run();
