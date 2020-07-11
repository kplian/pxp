<?php
/*************************************************************************************
 Nombre: ACTAuten.php
 Proposito: Verificar las credenciales de usario y validar la sesion si son correctas
 Autor:    Kplian (RAC)
 Fecha:    14/7/2010


HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA       AUTOR           DESCRIPCION
#133 ETR           22-04-2020     RAC            recibe variable de lenguaje
#179 KPLIAN        13.06.2020     RAC            autentificacion con google o facebook
#179 KPLIAN        10.07.2020     RAC            si queire loguearce con google o facebook y el usuario no existe lo crea
*****************************************************************************************/
use Pkly\I18Next\I18n;
/*ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
error_reporting(E_ALL);*/
class ACTAuten extends ACTbase {

    //Variables
    private $datos=array();
    private $primo1;
    private $primo2;
    private $clase;
    private $fei;
    private $llaves;
    private $cls_primo1;
    private $cls_primo2;


    /////////////
    //Constructor
    ////////////
    function __construct(CTParametro &$pParam){
        parent::__construct($pParam);
    }

    ////////////////
    //   Metodos
    ////////////////

    function prepararLlavesSession(){
        //Se obtiene el primer primo
        $this->funciones= $this->create('MODSesion');
        $this->res=$this->funciones->prepararLlavesSession();

        //echo 'resp:'.$this->res;exit;
        if($this->res->getTipo()=='ERROR'){
            $this->res->imprimirRespuesta($this->res->generarJson());
            exit;
        }

        $this->datos=array();
        $this->datos=$this->res->getDatos();
        $this->primo1=$this->datos[0]['primo'];
        //setea las llaves en variables de session ....
        $_SESSION['key_k']=$this->datos[0]['m'];
        $_SESSION['key_p']=$this->datos[0]['e'];
        $_SESSION['key_p_inv']=$this->datos[0]['k'];
        $_SESSION['key_m']=$this->datos[0]['p'];
        $_SESSION['key_d']=$this->datos[0]['x'];
        $_SESSION['key_e']=$this->datos[0]['z'];

        $_SESSION["_SESION"]= new CTSesion();
        //Se obtiene los feistel
        $this->fei=new feistel();
        $_SESSION["_SESION"]->setEstado("preparada");
        $_SESSION['_p']=$this->fei->aumenta1($_SESSION['key_p']);



        //Devuelve la respuesta
        echo "{success:true}";
        exit;

    }
    //Genera las llaves publicas
    function getPublicKey(){
        //Se obtiene el primer primo
        $this->funciones= $this->create('MODPrimo');
        $this->res=$this->funciones->ObtenerPrimo();


        //echo 'resp:'.$this->res;exit;
        if($this->res->getTipo()=='ERROR'){

            $this->res->imprimirRespuesta($this->res->generarJson());
            exit;
        }

        $this->datos=array();
        $this->datos=$this->res->getDatos();
        $this->primo1=$this->datos[0]['primo'];

        //Se obtiene el segundo primo
        $this->res=$this->funciones->ObtenerPrimo();

        if($this->res->getTipo()=='ERROR'){
            $this->res->imprimirRespuesta($this->res->generarJson());
            exit;
        }

        $this->datos=$this->res->getDatos();
        $this->primo2=$this->datos[0]['primo'];

        //Se genero las llaves a partir de los primos
        $this->clase=new RSA();
        $this->llaves=$this->clase->generate_keys($this->primo1,$this->primo2);

        //Se obtiene los feistel
        $this->fei=new feistel();
        $_SESSION['key_k']=$this->fei->generarK();
        $_SESSION['key_p']=$this->fei->generarPi();
        $_SESSION['key_p_inv']=$this->fei->inversaPi($_SESSION['key_p']);

        //Se guarda las llaves asincronas
        $_SESSION['key_m']=$this->llaves[0];
        $_SESSION['key_d']=$this->llaves[2];
        $_SESSION['key_e']=$this->llaves[1];

        $_SESSION["_SESION"]->setEstado("preparada");


        $x=0;
        if($_SESSION["encriptar_data"]=='si'){
            $x=1;
        }
        $_SESSION['_p']=$this->fei->aumenta1($_SESSION['key_p']);



        //Devuelve la respuesta
        echo "{success:true,
            m:'".$this->llaves[0]."',
            e:'".$this->llaves[1]."',
            k:'".$_SESSION['key_k']."',
            p:'".$_SESSION['_p']."',
            x:".$x."}";
        exit;

    }

    //Verifica las credenciales de usuario
    function verificarCredenciales() {
        $this->funciones= $this->create('MODUsuario');
        $this->res=$this->funciones->ValidaUsuario();
        $this->datos=$this->res->getDatos();
        $this->oEncryp=new CTEncriptacionPrivada($this->objParam->getParametro('contrasena'),$_SESSION['key_p'],$_SESSION['key_k'],$_SESSION['key_d'],$_SESSION['key_m']);
        //#133
        if( $this->objParam->getParametro('language') != '') {
            $_SESSION["ss_lenguaje_usu"] = strtoupper($this->objParam->getParametro('language'));
        } else {
            $_SESSION["ss_lenguaje_usu"] = 'EN';
        }

        I18n::get()->changeLanguage(strtolower($_SESSION["ss_lenguaje_usu"]));

        if($this->res->getTipo()=='Error' || $this->datos['cuenta']==''){
            //si no existe le mando otra vez a la portada
            $_SESSION["autentificado"] = "NO";
            $_SESSION["ss_id_usuario"] = "";
            $_SESSION["ss_id_lugar"] = "";
            $_SESSION["ss_nombre_lugar"] = "";
            $_SESSION["ss_nombre_empleado"] = "";
            $_SESSION["ss_paterno_empleado"] = "";
            $_SESSION["ss_materno_empleado"] = "";
            $_SESSION["ss_nombre_usuario"] = "";
            $_SESSION["ss_id_funcionario"] = "";
            $_SESSION["ss_id_cargo"] = "";
            $_SESSION["ss_nombre_basedatos"] = "";
            $_SESSION["ss_id_persona"] = "";
            $_SESSION["ss_ip"] = "";
            $_SESSION["ss_mac"] = "";

           echo "{success:false,mensaje:'".I18n::get()->t('invalid_usu')."'}";
           exit;
        }
        else {
            $LDAP=TRUE;

            //preguntamos el tipo de autentificacion
            if($this->datos['autentificacion']=='ldap'){

                $_SESSION["_CONTRASENA"]=md5($_SESSION["_SEMILLA"].$this->datos['contrasena']);
                $conex = ldap_connect($_SESSION["_SERVER_LDAP"],$_SESSION["_PORT_LDAP"]) or die ("No ha sido posible conectarse al servidor");
                ldap_set_option($conex, LDAP_OPT_PROTOCOL_VERSION, 3);

                if ($conex) {
                           // bind with appropriate dn to give update access
                    $r=ldap_bind($conex,trim($this->objParam->getParametro('usuario')).'@'.$_SESSION["_DOMINIO"],$this->oEncryp->getDecodificado());

                   if ($r && trim($this->objParam->getParametro('contrasena'))!= '')
                    {
                       $LDAP=TRUE;
                    }
                    else{
                       $LDAP=FALSE;
                    }

                    ldap_close($conex);

                }
                else{
                    $LDAP=FALSE;
                }

            }


         //si falla la autentificacion LDAP cerramos sesion
         if(!$LDAP){
             $_SESSION["autentificado"] = "NO";
                $_SESSION["ss_id_usuario"] = "";
                $_SESSION["ss_id_lugar"] = "";
                $_SESSION["ss_nombre_lugar"] = "";
                $_SESSION["ss_nombre_empleado"] = "";
                $_SESSION["ss_paterno_empleado"] = "";
                $_SESSION["ss_materno_empleado"] = "";
                $_SESSION["ss_nombre_usuario"] = "";
                $_SESSION["ss_id_funcionario"] = "";
                $_SESSION["ss_id_cargo"] = "";
                $_SESSION["ss_nombre_basedatos"] = "";
                $_SESSION["ss_id_persona"] = "";
                $_SESSION["ss_ip"] = "";
                $_SESSION["ss_mac"] = "";

         }  else {
                $_SESSION["autentificado"] = "SI";
                $_SESSION["ss_id_usuario"] = $this->datos['id_usuario'];

                $_SESSION["ss_id_funcionario"] = $this->datos['id_funcionario'];
                $_SESSION["ss_id_cargo"] = $this->datos['id_cargo'];
                $_SESSION["ss_id_persona"] = $this->datos['id_persona'];
                $_SESSION["_SESION"]->setIdUsuario($this->datos['id_usuario']);
                //cambia el estado del Objeto de sesion activa
                $_SESSION["_SESION"]->setEstado("activa");



                if($_SESSION["_ESTADO_SISTEMA"]=='desarrollo'){
                $_SESSION["mensaje_tec"]=true;
                }
                else{
                $_SESSION["mensaje_tec"]=false;
                }
                $mres = new Mensaje();
                if($_SESSION["_OFUSCAR_ID"]=='si'){
                    $id_usuario_ofus = $mres->ofuscar(($this->datos['id_usuario']));
                    $id_funcionario_ofus = $mres->ofuscar(($this->datos['id_funcionario']));
                }
                else{
                    $id_usuario_ofus = $this->datos['id_usuario'];
                    $id_funcionario_ofus = $this->datos['id_funcionario'];
                }


                ////

                $_SESSION["_CONT_ALERTAS"] = $this->datos['cont_alertas'];
                $_SESSION["_CONT_INTERINO"] = $this->datos['cont_interino'];
                $_SESSION["_NOM_USUARIO"] = $this->datos['nombre']." ".$this->datos['apellido_paterno']." ".$this->datos['apellido_materno'];
                $_SESSION["_ID_USUARIO_OFUS"] = $id_usuario_ofus;
                $_SESSION["_ID_FUNCIOANRIO_OFUS"] = $id_funcionario_ofus;
                $_SESSION["_AUTENTIFICACION"] = $this->datos['autentificacion'];
                $_SESSION["_ESTILO_VISTA"] = $this->datos['estilo'];


                if(!isset($_SESSION["_SIS_INTEGRACION"])) {
                    $sis_integracion = 'NO';
                }
                else {
                    $sis_integracion = $_SESSION["_SIS_INTEGRACION"];
                }


                if(isset($_SESSION["ss_id_cargo"]) && $_SESSION["ss_id_cargo"] !=''){

                    $id_cargo = $_SESSION["ss_id_cargo"];
                }
                else {
                    $id_cargo = 0;
                }


                if($_SESSION["_tipo_aute"] != 'REST'){
                    //almacena llave ....
                    $_SESSION["_SESION"]->actualizarLlaves($_SESSION['key_k'], $_SESSION['key_p'], $_SESSION['key_p_inv'], $_SESSION['key_m'], $_SESSION['key_d'], $_SESSION['key_e']);
                }
                $logo = str_replace('../../../', '', $_SESSION['_MINI_LOGO']);
                $logo = ($_SESSION["_FORSSL"]=="SI") ? 'https://' : 'http://' . $_SERVER['HTTP_HOST'] . $_SESSION["_FOLDER"] . $logo;
                //cualquier variable que se agregue aqui tb debe ir en sis_seguridad/vista/_adm/resources/Phx.CP.mmain.php
                if ($this->objParam->getParametro('_tipo') != 'restAuten') {
                    echo "{success:true,
                    id_cargo:".$id_cargo.",
                    cont_alertas:".$_SESSION["_CONT_ALERTAS"].",
                    cont_interino:".$_SESSION["_CONT_INTERINO"].",
                    nombre_usuario:'".$_SESSION["_NOM_USUARIO"]."',
                    nombre_basedatos:'".$_SESSION["_BASE_DATOS"]."',
                    mini_logo:'".$_SESSION["_MINI_LOGO"]."',
                    icono_notificaciones:'" . $logo . "',
                    id_usuario:'".$_SESSION["_ID_USUARIO_OFUS"]."',
                    id_funcionario:'".$_SESSION["_ID_FUNCIOANRIO_OFUS"]."',
                    autentificacion:'".$_SESSION["_AUTENTIFICACION"]."',
                    estilo_vista:'".$_SESSION["_ESTILO_VISTA"]."',
                    mensaje_tec:'".$_SESSION["mensaje_tec"]."',
                    sis_integracion:'".$sis_integracion."',
                    puerto_websocket:'".$_SESSION["_PUERTO_WEBSOCKET"]."',
                    timeout:".$_SESSION["_TIMEOUT"]."}";

                    exit;
                }
            }
        }
    }

    function cerrarSesion(){
        session_unset();
        session_destroy(); // destruyo la sesion
        header("Location: /");
        echo '{"success":true}';
    }

    //#179
	function createTokenUser(){
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODUsuario');
		$this->res=$this->objFunSeguridad->createTokenUser($this->objParam);
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

    function resetPassword(){
        //g-recaptcha-response
        $url = "https://www.google.com/recaptcha/api/siteverify";
        if (!isset($_SESSION['_RECAPTCHA_PRIVATEKEY'])) {
            throw new Exception('Captch private key not configured');
        }

        $res_captcha = $this->objParam->getParametro('captcha');
        $response = file_get_contents($url . "?secret=" . $_SESSION['_RECAPTCHA_PRIVATEKEY'] . "&response=" . $res_captcha);
        $data = json_decode($response);
        if (isset($data->success) && $data->success == true) {
            $this->objFunc=$this->create('MODUsuario');
            $this->res=$this->objFunc->resetPassword($this->objParam);
            $datos = $this->res->getDatos();

            /*send reset mail*/
            if (isset($datos['mail_template'])) {
                include_once(dirname(__FILE__).'/../../../' . $datos['mail_template']);
                $template = resetPasswordTemplate($datos['name'], $this->objParam->getParametro('url') . 'forgot/update/' . $datos['token']);

                $email = new \SendGrid\Mail\Mail();
                $email->setFrom($_SESSION['_MAIL_REMITENTE'], $_SESSION['_NOMBER_REMITENTE']);
                $email->setSubject("Hemos recibido una solicitud para cambiar tu password");
                $email->addTo($datos['email'], $datos['name']);

                $email->addContent(
                    "text/html", $template);
                $sendgrid = new \SendGrid($_SESSION['_SENDGRID_API_KEY']);
                try {
                    $response = $sendgrid->send($email);

                } catch (Exception $e) {
                    $this->res=new Mensaje();
                    $this->res->setMensaje('ERROR','ACTAuten','An error happened while sending the email','An error happened while sending the email','control','','','','');
                    $this->res->imprimirRespuesta($this->res->generarJson());
                    exit;
                }
            }
            /*end send reset mail*/
            $this->res->imprimirRespuesta($this->res->generarJson());
        } else {
            $this->res=new Mensaje();
            $this->res->setMensaje('ERROR','ACTAuten','You are a robot','You are a robot','control','','','','');
            $this->res->imprimirRespuesta($this->res->generarJson());
        }
    }

    function signUp(){
        //g-recaptcha-response
        $url = "https://www.google.com/recaptcha/api/siteverify";
        if (!isset($_SESSION['_RECAPTCHA_PRIVATEKEY'])) {
            throw new Exception('Captch private key not configured');
        }

        $res_captcha = $this->objParam->getParametro('captcha');
        $response = file_get_contents($url . "?secret=" . $_SESSION['_RECAPTCHA_PRIVATEKEY'] . "&response=" . $res_captcha);
        $data = json_decode($response);
        if (isset($data->success) && $data->success == true) {
            $this->objFunc=$this->create('MODUsuario');
            $this->res=$this->objFunc->signUp($this->objParam);
            $datos = $this->res->getDatos();

            /*send signup mail*/
            if (isset($datos['mail_template'])) {
                include_once(dirname(__FILE__).'/../../../' . $datos['mail_template']);
                $template = signupTemplate($this->objParam->getParametro('name'), $this->objParam->getParametro('url') . 'signup/confirm/' . $datos['token']);

                $email = new \SendGrid\Mail\Mail();
                $email->setFrom($_SESSION['_MAIL_REMITENTE'], $_SESSION['_NOMBER_REMITENTE']);
                $email->setSubject("Has creado un usuario en Vouz");
                $email->addTo($this->objParam->getParametro('email'), $this->objParam->getParametro('name'));

                $email->addContent(
                    "text/html", $template);
                $sendgrid = new \SendGrid($_SESSION['_SENDGRID_API_KEY']);
                try {
                    $response = $sendgrid->send($email);

                } catch (Exception $e) {
                    $this->res=new Mensaje();
                    $this->res->setMensaje('ERROR','ACTAuten','An error happened while sending the email','An error happened while sending the email','control','','','','');
                    $this->res->imprimirRespuesta($this->res->generarJson());
                    exit;
                }
            }
            /*end send signup mail*/

            $this->res->imprimirRespuesta($this->res->generarJson());
        } else {
            $this->res=new Mensaje();
            $this->res->setMensaje('ERROR','ACTAuten','You are a robot','You are a robot','control','','','','');
            $this->res->imprimirRespuesta($this->res->generarJson());
        }
    }

    function signupConfirm() {
        $this->objFunc=$this->create('MODUsuario');
        $this->res=$this->objFunc->signupConfirm($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function updatePassword() {
        $this->objFunc=$this->create('MODUsuario');
        $this->res=$this->objFunc->updatePassword($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function oauthLogin() {

        /*
        inputs vars
         -- for autentificate
                - language
                - type
                - token
                - device
        --for create user
                - name
                - surname
                - email
                - type
                - user_id
                - url_photo
                - device
        
        */

        //Recupera datos de usuario
        
        $this->funciones= $this->create('MODUsuario');
        $this->res=$this->funciones->ValidaUsuario();
        $this->datos=$this->res->getDatos();
        $_SESSION["_LOGIN"]=$this->objParam->getParametro('email'); //recueprando cuenta de usuario

        //#133
        if( $this->objParam->getParametro('language') != '') {
            $_SESSION["ss_lenguaje_usu"] = strtoupper($this->objParam->getParametro('language'));
        } else {
            $_SESSION["ss_lenguaje_usu"] = 'EN';
        }

        I18n::get()->changeLanguage(strtolower($_SESSION["ss_lenguaje_usu"]));

        header('Content-type: application/json; charset=utf-8');
        if($this->res->getTipo()=='Error' || $this->datos['cuenta']=='') {
            //si no existe le mando otra vez a la portada
            $_SESSION["autentificado"] = "NO";
            $_SESSION["ss_id_usuario"] = "";
            $_SESSION["ss_id_lugar"] = "";
            $_SESSION["ss_nombre_lugar"] = "";
            $_SESSION["ss_nombre_empleado"] = "";
            $_SESSION["ss_paterno_empleado"] = "";
            $_SESSION["ss_materno_empleado"] = "";
            $_SESSION["ss_nombre_usuario"] = "";
            $_SESSION["ss_id_funcionario"] = "";
            $_SESSION["ss_id_cargo"] = "";
            $_SESSION["ss_nombre_basedatos"] = "";
            $_SESSION["ss_id_persona"] = "";
            $_SESSION["ss_ip"] = "";
            $_SESSION["ss_mac"] = "";

           echo "{success:false, mensaje:'".I18n::get()->t('invalid_usu')."'}";
           exit;
        }
        else {
            $PASS = 0;
            switch ($this->objParam->getParametro('type')) {
                case 'google':
                    $_SESSION["_CONTRASENA"]=md5($_SESSION["_SEMILLA"].$this->datos['contrasena']);
                    $token_google = filter_var($this->objParam->getParametro('token'), FILTER_SANITIZE_STRING);
                    //$token_google = $this->objParam->getParametro('token');

                    switch ($this->objParam->getParametro('device')) {
                        case 'web':
                            $client = new Google_Client();
                            $client->setClientId($_SESSION['_GOOGLE_CLIENT_ID']);
                            $client->setClientSecret($_SESSION['_GOOGLE_CLIENT_SECRET']);
                            $client->setRedirectUri('postmessage');
                        break;
                        default:
                            $client = new Google_Client();
                            $client->setClientId($_SESSION['_GOOGLE_CLIENT_ID']);
                            //$client->setClientId($_SESSION['_GOOGLE_ADROID_ID']);
                            //$payload = $client->verifyIdToken($token_google);
                        break;
                    }
                    $payload = $client->verifyIdToken($token_google);
                    if($payload) {
                        //token en realide tiene el user_id almacenado en base de datos al momento de crear el usuario
                        if( $this->datos['token'] == $payload["sub"]  &&  $_SESSION['_GOOGLE_CLIENT_ID'] == $payload["aud"]) {
                            $PASS = 1;
                        }
                    }


                break;
                case 'facebook':
                    $_SESSION["_CONTRASENA"]=md5($_SESSION["_SEMILLA"].$this->datos['contrasena']);
                    $face_user_token = filter_var($this->objParam->getParametro('token'), FILTER_SANITIZE_STRING);
                    $facebook_user_access_token = $face_user_token;
                    $my_facebook_app_id = $_SESSION['_FACE_CLIENT_ID'];//  as set up in Facebook
                    $my_facebook_app_secret = $_SESSION['_FACE_CLIENT_SECRET'];//  as set up in Facebook
                    $facebook_application = $_SESSION['_FACE_APP_NAME']; //  as set up in Facebook
                    ///////////////////////////////////////
                    // get facebook access token
                    ///////////////////////////////////////
                    $curl_facebook1 = curl_init(); // start curl
                    $url = "https://graph.facebook.com/oauth/access_token?client_id=".$my_facebook_app_id."&client_secret=".$my_facebook_app_secret."&grant_type=client_credentials"; // set url and parameters
                    curl_setopt($curl_facebook1, CURLOPT_URL, $url); // set the url variable to curl
                    curl_setopt($curl_facebook1, CURLOPT_RETURNTRANSFER, true); // return output as string
                    $output = curl_exec($curl_facebook1); // execute curl call
                    curl_close($curl_facebook1); // close curl
                    $decode_output = json_decode($output, true); // decode the response (without true this will crash)

                    // store access_token
                    $facebook_access_token = $decode_output['access_token'];
                    /////////////////////////////////////
                    // verify my access was legitimate
                    /////////////////////////////////////
                    $curl_facebook2 = curl_init(); // start curl
                    $url = "https://graph.facebook.com/debug_token?input_token=".$facebook_user_access_token."&access_token=".$facebook_access_token; // set url and parameters
                    curl_setopt($curl_facebook2, CURLOPT_URL, $url); // set the url variable to curl
                    curl_setopt($curl_facebook2, CURLOPT_RETURNTRANSFER, true); // return output as string
                    $output2 = curl_exec($curl_facebook2); // execute curl call
                    curl_close($curl_facebook2); // close curl
                    $decode_output2 = json_decode($output2, true); // decode the response (without true this will crash)
                    // test browser and Facebook variables match for security
                    if ($my_facebook_app_id == $decode_output2['data']['app_id'] && $decode_output2['data']['application'] == $facebook_application && $decode_output2['data']['is_valid'] == true) {
                       $PASS = 1;
                    }
                break;
                default:
                    $PASS = 0;
                break;
            }


            //si falla la autentificacion LDAP cerramos sesion
            if($PASS == 0) {
                    $success = "false";
                    $_SESSION["autentificado"] = "NO";
                    $_SESSION["ss_id_usuario"] = "";
                    $_SESSION["ss_id_lugar"] = "";
                    $_SESSION["ss_nombre_lugar"] = "";
                    $_SESSION["ss_nombre_empleado"] = "";
                    $_SESSION["ss_paterno_empleado"] = "";
                    $_SESSION["ss_materno_empleado"] = "";
                    $_SESSION["ss_nombre_usuario"] = "";
                    $_SESSION["ss_id_funcionario"] = "";
                    $_SESSION["ss_id_cargo"] = "";
                    $_SESSION["ss_nombre_basedatos"] = "";
                    $_SESSION["ss_id_persona"] = "";
                    $_SESSION["ss_ip"] = "";
                    $_SESSION["ss_mac"] = "";

                    echo '{"success":'.$success.'}';
                    exit;
            }
            else {
                $success = "true";
                $_SESSION["autentificado"] = "SI";
                $_SESSION["ss_id_usuario"] = $this->datos['id_usuario'];
                $_SESSION["ss_id_funcionario"] = $this->datos['id_funcionario'];
                $_SESSION["ss_id_cargo"] = $this->datos['id_cargo'];
                $_SESSION["ss_id_persona"] = $this->datos['id_persona'];
                //cambia el estado del Objeto de sesion activa
                $_SESSION["_SESION"] = new CTSesion();
                $_SESSION["_SESION"]->setIdUsuario($this->datos['id_usuario']);
                $_SESSION["_SESION"]->setEstado("activa");


                if($_SESSION["_ESTADO_SISTEMA"]=='desarrollo'){
                    $_SESSION["mensaje_tec"]=true;
                }
                else{
                    $_SESSION["mensaje_tec"]=false;
                }
                $mres = new Mensaje();
                if($_SESSION["_OFUSCAR_ID"]=='si'){
                    $id_usuario_ofus = $mres->ofuscar(($this->datos['id_usuario']));
                    $id_funcionario_ofus = $mres->ofuscar(($this->datos['id_funcionario']));
                }
                else{
                    $id_usuario_ofus = $this->datos['id_usuario'];
                    $id_funcionario_ofus = $this->datos['id_funcionario'];
                }


                $_SESSION["_CONT_ALERTAS"] = $this->datos['cont_alertas'];
                $_SESSION["_CONT_INTERINO"] = $this->datos['cont_interino'];
                $_SESSION["_NOM_USUARIO"] = $this->datos['nombre']." ".$this->datos['apellido_paterno']." ".$this->datos['apellido_materno'];
                $_SESSION["_ID_USUARIO_OFUS"] = $id_usuario_ofus;
                $_SESSION["_ID_FUNCIOANRIO_OFUS"] = $id_funcionario_ofus;
                $_SESSION["_AUTENTIFICACION"] = $this->datos['autentificacion'];
                $_SESSION["_ESTILO_VISTA"] = $this->datos['estilo'];


                if(!isset($_SESSION["_SIS_INTEGRACION"])){
                    $sis_integracion = 'NO';
                }
                else{
                    $sis_integracion = $_SESSION["_SIS_INTEGRACION"];
                }

                if(isset($_SESSION["ss_id_cargo"]) && $_SESSION["ss_id_cargo"] !=''){
                    $id_cargo = $_SESSION["ss_id_cargo"];
                }
                else {
                    $id_cargo = 0;
                }

                echo '{"success":true,
                    "cont_alertas":'.$_SESSION["_CONT_ALERTAS"].',
                    "nombre_usuario":"'.$_SESSION["_NOM_USUARIO"].'",
                    "nombre_basedatos":"'.$_SESSION["_BASE_DATOS"].'",
                    "id_usuario":"'.$_SESSION["_ID_USUARIO_OFUS"].'",
                    "id_funcionario":"'.$_SESSION["_ID_FUNCIOANRIO_OFUS"].'",
                    "autentificacion":"'.$_SESSION["_AUTENTIFICACION"].'",
                    "estilo_vista":"'.$_SESSION["_ESTILO_VISTA"].'",
                    "mensaje_tec":"'.$_SESSION["mensaje_tec"].'",
                    "phpsession":"'.session_id().'",
                    "timeout":'.$_SESSION["_TIMEOUT"].'}';
                
                exit;

            }
        }
    }
}
?>