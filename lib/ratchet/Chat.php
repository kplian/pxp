<?php
 require 'vendor/autoload.php';

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;



class Chat implements MessageComponentInterface {
    protected $clients;
    protected $act;

    public function __construct() {
        $this->clients = new \SplObjectStorage;


        


    }

    public function onOpen(ConnectionInterface $conn) {

        //$cookies = (string) $conn->WebSocket->request->getHeader('Cookie');
        //echo "New $cookies! ({$cookies})\n";
        // Store the new connection to send messages to later
        //$conn->Session->get("192.168.12.61/kerp/");

        //$conn->Session->get("/kerp");

        $isSession = $conn->WebSocket->request->getCookie("PHPSESSID");

        echo "New session! ({$isSession})\n";


        $this->clients->attach($conn);

//        $conn->session = new session($conn->WebSocket->request->getCookie("PHPSESSID"));
//        echo "The session id passed in was : ".$conn->WebSocket->request->getCookie("PHPSESSID")."\n";


        echo "New connection! ({$conn->resourceId})\n";
    }

    public function onMessage(ConnectionInterface $from, $msg) {
        /*session_set_cookie_params (0,'/kerp/', '' ,true ,false);
        $sessionId = $from->WebSocket->request->getCookies()['PHPSESSID'];

        $se = session_id();
        echo "session del navegador ! ({$sessionId})\n";
        echo "session del session_id() ! ({$se})\n";


        session_id($sessionId);
        @session_start();
        session_write_close();


        $se2 = session_id();
        $pass = $_SESSION['_CONTRASENA'];
        echo "cambiado del session_id() ! ({$pass})\n";

        echo "New ! ({$_SESSION["_TIPO_CONEXION"]})\n";*/
        //$persona = $this->act->accion('{"start":"0","limit":"2","sort":"id_usuario","dir":"ASC"}','seguridad','Usuario','listarUsuario');

        //session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,true ,false);
        //session_start();
        //$sessionId = $from->WebSocket->request->getCookies()['PHPSESSID'];


        // echo $sessionId;

        /* echo $sessionId;
         echo '  |||'.session_id();
         echo $_SESSION['_CONTRASENA'];*/
       /*
        $persona = $act->accion('{"start":"0","limit":"2","sort":"id_usuario","dir":"ASC"}','seguridad','Usuario','listarUsuario');
        $res_datos =  $persona->getDatos();
        echo $res_datos[0]['id_persona'];*/

        $act = new act();
        $persona = $act->accion('{"start":"0","limit":"50","sort":"id_usuario","dir":"ASC"}','seguridad','Usuario','listarUsuario');
        $res_per = $persona->getDatos();
        $per = $res_per[0]['cuenta'];
        $JSON = json_encode($res_per);
        echo "persona ! ({$JSON})\n";


        $numRecv = count($this->clients) - 1;
        echo sprintf('Connection %d sending message "%s" to %d other connection%s' . "\n"
            , $from->resourceId, $msg, $numRecv, $numRecv == 1 ? '' : 's');

        foreach ($this->clients as $client) {



            if ($from !== $client) {
                // The sender is not the receiver, send to each client connected
                $client->send($msg);
            }
        }
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



/*
class session {

    // the id of the client session;
    private $id;

    // take a session Id and continue a session if empty create a new session
    public function __construct($PHPSESSID = ''){

        // if we have a valid session id containing letters and numbers then use it
        // @note add check for weird characters later
        if (strlen($PHPSESSID) > 5 && preg_match('/[A-Za-z]/', $PHPSESSID) && preg_match('/[0-9]/', $PHPSESSID)){
            session_id($PHPSESSID);
        } else{
            session_regenerate_id(); // so we get a new session id for the new user
        }

        @session_start();
        $this->id = session_id();
        unset($_SESSION); // so we cant attempt to use this directly
        session_write_close();
    }

    // return the value of a session variable or null
    public function get($var_name){
        session_id($this->id);
        @session_start();

        if(isset($_SESSION[$var_name])){
            $var =  $_SESSION[$var_name];
        } else{
            $var = NULL;
        }

        unset($_SESSION);
        session_write_close();

        return $var;
    }

    // set the value of a session variable
    public function set($var_name, $var_value){
        session_id($this->id);
        @session_start();

        $_SESSION[$var_name] = $var_value;

        unset($_SESSION);
        session_write_close();
    }

}*/

