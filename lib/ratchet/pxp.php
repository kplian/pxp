<?php
require 'vendor/autoload.php';

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

//$this->usuariosPXPSocket = array();

class Pxp implements MessageComponentInterface {
    protected $clients;
    protected $usuariosPXPSocket;

    protected $eventos = array();
   // protected $usuarioPXP = array();

    protected $cone;
    protected $link;



    public function __construct() {
        $this->clients = new \SplObjectStorage;

        $this->users = [];

        $this->usuariosPXPSocket = [];

        $this->cone = new conexion();
        $this->link = $this->cone->conectarpdo();

    }

    public function onOpen(ConnectionInterface $conn) {
        // Store the new connection to send messages to later


        //obtenemos la session del pxp
        $sessionIDPXP = $conn->WebSocket->request->getQuery()->toArray()['sessionIDPXP'];
        var_dump($sessionIDPXP);

        //verificaremos si la session enviada esta registrada en nuestra bd

        $seguSessionPXP = $this->link->prepare("select * from segu.tsesion where variable = '$sessionIDPXP' and fecha_reg = now()::DATE ");
        $seguSessionPXP->execute();
        $seguSessionPXP_RES = $seguSessionPXP->fetchAll(PDO::FETCH_ASSOC);


        $this->clients->attach($conn);
        //anadimos a una id_conexion la conexion entera para poder acceder luego a send
        $this->users[$conn->resourceId] = $conn;

        //si existe esa session registrada
        if (count($seguSessionPXP_RES) > 0){



            echo "New connection! ({$conn->resourceId})\n";

            //esta es una session de conexion al socket
            $idSession = $conn->WebSocket->request->getCookie("PHPSESSID");

            echo "New session! ({$idSession})\n";

        }else{
            echo "no tiene permiso para conectarse! \n";

            $send = array(
                "mensaje" => array(
                    "mensaje" => "se cerro el socket porque no tienes permiso no seas pendejo!!!",
                ),
                "data"=> array(
                    "metodo" => "cierreSocket"
                    //si no le envias id_contenedor entonces este metodo debe estar en el contenedor principal
                )
            );
            $id_conexion = $conn->resourceId;
            $send = json_encode($send, true);
            $this->users[$id_conexion]->send($send);

            $conn->close();

        }






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
                        "id_contenedor"=>$data["data"]["id_contenedor"],
                        "metodo"=>$data["data"]["metodo"]
                    ));

                }else{
                    //no existe el evento registrado y se crea uno con el key con el nombre del evento

                    $this->eventos[$data["data"]["evento"]][0] = array("id_conexion"=> $id_conexion,
                        "id_session"=>$idSession,
                        "id_usuario"=>$data["data"]["id_usuario"],
                        "nombre_usuario"=>$data["data"]["nombre_usuario"],
                        "evento"=>$data["data"]["evento"],
                        "id_contenedor"=>$data["data"]["id_contenedor"],
                        "metodo"=>$data["data"]["metodo"]
                    );

                }


                //var_dump($this->eventos);
                echo "tipo ! ({$tipo})\n";

            }elseif($tipo == "enviarMensaje"){

                $evento = $data["data"]["evento"];

                foreach ($this->eventos[$evento] as $even){
                    if ($evento["id_conexion"] != $id_conexion){

                        $send = array(
                            "mensaje" => $data["data"]["mensaje"],
                            "data" => $even
                        );
                        $send = json_encode($send, true);

                        $this->users[$even["id_conexion"]]->send($send);
                    }
                }
            }elseif($tipo == "eleminarEvento"){

                $id_contenedor = $data["data"]["id_contenedor"];

                foreach ($this->eventos as $key1 =>$eventos){

                    foreach ($eventos as $key => $e) {


                        //eleminamos si encuentra
                        if($e['id_contenedor'] == $id_contenedor && $e['id_conexion'] == $id_conexion && $e['id_session'] == $idSession){

                            unset($this->eventos[$key1][$key]);

                        }

                    }
                }



            }elseif($tipo == "registrarUsuarioSocket"){ //registramos al usuario con su socket para saber que usuarios estan conectados

                $id_usuario = $data["data"]["id_usuario"];

                if (array_key_exists($id_usuario, $this->usuariosPXPSocket)) {

                    //existe ya registrado el USUARIO

                    array_push($this->usuariosPXPSocket[$id_usuario],array(
                        "id_conexion"=> $id_conexion,
                        "id_session"=>$idSession,
                        "id_usuario"=>$id_usuario
                    ));

                }else{
                    //no existe

                    $this->usuariosPXPSocket[$id_usuario][0] = array(
                        "id_conexion"=> $id_conexion,
                        "id_session"=>$idSession,
                        "id_usuario"=>$id_usuario
                    );

                }

                var_dump($this->usuariosPXPSocket);




            }elseif($tipo == "obtenerUsuariosConectados"){ //obtenemos usuario conectados



                $send = json_encode($this->usuariosPXPSocket, true);

                $this->users[$id_conexion]->send($send);


                //var_dump($this->usuariosPXPSocket);




            }elseif($tipo == "enviarMensajeUsuario"){ //enviamos mensaje a un usuario en especifico o a varios


                $id_usuario = $data["data"]["id_usuario"];
                $id_usuario = (int)$id_usuario;

                if($data["data"]["destino"] == "Unico"){

                    foreach ($this->usuariosPXPSocket[$id_usuario] as $conexiones_habilitadas){
                        $id_conexion_para_enviar = $conexiones_habilitadas['id_conexion'];

                        $send = array(
                            "mensaje" => array(
                                "tipo_mensaje" => $data["data"]["tipo_mensaje"],
                                "titulo" => $data["data"]["titulo"],
                                "mensaje" => $data["data"]["mensaje"]
                            ),
                            "data"=> array(
                                "metodo" => $data["data"]["evento"]
                                //si no le envias id_contenedor entonces este metodo debe estar en el contenedor principal
                            )
                        );
                        $send = json_encode($send, true);

                        $this->users[$id_conexion_para_enviar]->send($send);
                    }

                }else{ //mandamos a todos los conectados

                    foreach ($this->usuariosPXPSocket as $usuarios_conectados){
                        foreach ($usuarios_conectados as $conexiones_habilitadas){

                            $id_conexion_para_enviar = $conexiones_habilitadas['id_conexion'];


                            $send = array(
                                "mensaje" => array(
                                    "tipo_mensaje" => $data["data"]["tipo_mensaje"],
                                    "titulo" => $data["data"]["titulo"],
                                    "mensaje" => $data["data"]["mensaje"]
                                ),
                                "data"=> array(
                                    "metodo" => $data["data"]["evento"]
                                    //si no le envias id_contenedor entonces este metodo debe estar en el contenedor principal
                                )
                            );
                            $send = json_encode($send, true);

                            $this->users[$id_conexion_para_enviar]->send($send);
                        }
                    }

                }


                //enviamos un retorno al que envio
                $this->users[$id_conexion]->send('envio correcto');





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




        //eliminamos todas los eventos que esta escuchando la conexion
        foreach ($this->eventos as $key1 =>$eventos){

            foreach ($eventos as $key => $e) {

                //var_dump($e);


                //eleminamos si encuentra
                if($e['id_conexion'] == $conn->resourceId){

                    unset($this->eventos[$key1][$key]);

                }

            }
        }

        //eliminamos los usuario con dicha conexion cerrada
        foreach ($this->usuariosPXPSocket as $key1 =>$usuarios){

            foreach ($usuarios as $key => $u) {


                //eleminamos si encuentra
                if($u['id_conexion'] == $conn->resourceId){

                    unset($this->usuariosPXPSocket[$key1][$key]);

                    //verificamos si ya no existe ninguna conexion para un usuario especifico y eliminamos su arreglo principal
                    if(count($this->usuariosPXPSocket[$key1]) == 0){
                        unset($this->usuariosPXPSocket[$key1]);
                    }

                }

            }
        }

        var_dump($this->usuariosPXPSocket);


        // The connection is closed, remove it, as we can no longer send it messages
        $this->clients->detach($conn);

        echo "Connection {$conn->resourceId} has disconnected\n";
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        echo "An error has occurred: {$e->getMessage()}\n";

        $conn->close();
    }


    public function send(ConnectionInterface $client, $type, $data){
        $send = array(
            "type" => $type,
            "data" => $data
        );
        $send = json_encode($send, true);
        $client->send($send);
    }



}