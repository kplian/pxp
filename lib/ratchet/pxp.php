<?php
require 'vendor/autoload.php';

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

class Pxp implements MessageComponentInterface {
    protected $clients;

    protected $eventos = array();


    public function __construct() {
        $this->clients = new \SplObjectStorage;

        $this->users = [];
    }

    public function onOpen(ConnectionInterface $conn) {
        // Store the new connection to send messages to later
        $this->clients->attach($conn);


        //anadimos a una id_conexion la conexion entera para poder acceder luego a send
        $this->users[$conn->resourceId] = $conn;

        echo "New connection! ({$conn->resourceId})\n";

        $idSession = $conn->WebSocket->request->getCookie("PHPSESSID");

        echo "New session! ({$idSession})\n";


    }

    public function onMessage(ConnectionInterface $from, $msg) {

        //obtenemos la id_conexion
        $id_conexion = $from->resourceId;
        //obtenemos la idSession
        $idSession = $from->WebSocket->request->getCookie("PHPSESSID");

        //decodificamos el mensaje json
        $data = json_decode($msg, true);



        if(isset($data['data']) && count($data['data']) != 0){

            //obtenemos el tipo del mensaje
            $tipo = $data['tipo'];

            //registramos el evento al usuario para que escuche todo relacionado con el evento
            if($tipo == "escucharEvento"){
                // formato del json que tiene que recibir: data: {"id_usuario": Phx.CP.config_ini.id_usuario,"nombre_usuario":Phx.CP.config_ini.nombre_usuario ,"evento": 'sis_colas/ticket',"id_contenedor":15},


                if (array_key_exists($data["data"]["evento"], $this->eventos)) {

                    //existe ya registrado el evento

                    array_push($this->eventos[$data["data"]["evento"]],array("id_conexion"=> $id_conexion,
                        "id_session"=>$idSession,
                        "id_usuario"=>$data["data"]["id_usuario"],
                        "nombre_usuario"=>$data["data"]["nombre_usuario"],
                        "evento"=>$data["data"]["evento"],
                        "id_contenedor"=>$data["data"]["id_contenedor"]
                    ));

                }else{
                    //no existe el evento registrado y se crea uno con el key con el nombre del evento

                    $this->eventos[$data["data"]["evento"]][0] = array("id_conexion"=> $id_conexion,
                        "id_session"=>$idSession,
                        "id_usuario"=>$data["data"]["id_usuario"],
                        "nombre_usuario"=>$data["data"]["nombre_usuario"],
                        "evento"=>$data["data"]["evento"],
                        "id_contenedor"=>$data["data"]["id_contenedor"]);

                }


                //var_dump($this->eventos);
                echo "tipo ! ({$tipo})\n";

            }elseif($tipo == "enviarMensaje"){

                $evento = $data["data"]["evento"];

                foreach ($this->eventos[$evento] as $evento){
                    if ($evento["id_conexion"] != $id_conexion){

                        $this->users[$evento["id_conexion"]]->send($data["data"]["mensaje"]);
                    }
                }
            }

        }


        /*$numRecv = count($this->clients) - 1;
        echo sprintf('Connection %d sending message "%s" to %d other connection%s' . "\n"
            , $from->resourceId, $msg, $numRecv, $numRecv == 1 ? '' : 's');

        foreach ($this->clients as $client) {
            if ($from !== $client) {
                // The sender is not the receiver, send to each client connected
                $client->send($msg);
            }
        }*/
    }

    public function onClose(ConnectionInterface $conn) {
        // The connection is closed, remove it, as we can no longer send it messages
        $this->clients->detach($conn);

        echo "Connection {$conn->resourceId} has disconnected\n";
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        echo "An error has occurred: {$e->getMessage()}\n";

        $conn->close();
    }


}