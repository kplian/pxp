<?php
/****************************************************************************
 HISTORIAL DE MODIFICACIONES:
 ISSUE-FORK         FECHA       AUTHOR                  DESCRIPCION
 //#11-ENDETR          17/12/2018  CHRIS CHROS             Se cambió la forma de crear la URL para acceder a endesis

****************************************************************************/
require_once dirname(__FILE__) . '/../lib_general/templates/template.class.php';
define('DEFAULT_TEMPLATE', dirname(__FILE__) . '/../lib_general/templates/layout.tpl');
define('NOTIFICATION', dirname(__FILE__) . '/../lib_general/templates/notification.tpl');
class CorreoExterno
{
    protected $mail_usuario;
    protected $mail_password;
    protected $mail_servidor;
    protected $mail_puerto;
    protected $remitente;
    protected $nombre_remitente;
    protected $mensaje;
    protected $mensaje_html;
    protected $asunto;
    protected $titulo;
    protected $autentificacion;
    protected $SMTPSecure;
    protected $acceso_directo;
    protected $acuse_recibo;
    protected $mensaje_acuse;
    protected $url_acuse;
    protected $token_acuse;

    protected $mail;

    public $servidor;

    function __construct(){

         $this->autentificacion = $_SESSION['_MAIL_AUTENTIFICACION'];
         $this->mail_usuario = $_SESSION['_MAIL_USUARIO'];
         $this->mail_password = $_SESSION['_MAIL_PASSWORD'];
         $this->mail_servidor = $_SESSION['_MAIL_SERVIDOR'];
         $this->mail_puerto = $_SESSION['_MAIL_PUERTO'];
         $this->remitente = $_SESSION['_MAIL_REMITENTE'];
         $this->nombre_remitente = $_SESSION['_NOMBER_REMITENTE'];
         $this->SMTPSecure = $_SESSION['_SMTPSecure'];
         $this->acceso_directo = '';
         $this->acuse_recibo = False;

         $this->mail = new PHPMailer();

         $this->mail->IsSMTP();
         $this->mail->CharSet = 'UTF-8';
         $this->mail->Host = $this->mail_servidor;
         $this->mail->Port = $this->mail_puerto;
         $this->mail->From = $this->remitente;
         $this->mail->FromName = $this->nombre_remitente;
         $this->mail->Subject = $this->asunto;
         $this->mail->SMTPDebug = false;

         //$this->servidor = $_SESSION["HOST_SERVIDOR"];
         //$this->servidor = $_SERVER['REMOTE_ADDR'];
         $this->servidor = $_SESSION["_HOST_SERVIDOR"];
   }


    function addDestinatario($dir_destinatario,$nom_destinatario=''){//desarrollo,produccion

        if ($_SESSION["_ESTADO_SISTEMA"] == 'desarrollo' && isset($_SESSION["_MAIL_PRUEBAS"])) {
            $this->mail->AddAddress($_SESSION["_MAIL_PRUEBAS"], 'Prueba de Correo Pxp');
        } else {
            $this->mail->AddAddress($dir_destinatario, $nom_destinatario);
        }
    }

    function addCC($dir_destinatario,$nom_destinatario=''){//desarrollo
        if ($_SESSION["_ESTADO_SISTEMA"] == 'desarrollo' && isset($_SESSION["_MAIL_PRUEBAS"])) {
            $this->mail->AddCC($_SESSION["_MAIL_PRUEBAS"], 'Prueba de Correo Pxp');
        } else {
            //var_dump('addCC');
            $this->mail->AddCC($dir_destinatario, $nom_destinatario);
        }
    }


    function addBCC($dir_destinatario,$nom_destinatario=''){//desarrollo
        if ($_SESSION["_ESTADO_SISTEMA"] == 'desarrollo' && isset($_SESSION["_MAIL_PRUEBAS"])) {
            $this->mail->addBCC($_SESSION["_MAIL_PRUEBAS"], 'Prueba de Correo Pxp');
        } else {
            //var_dump('addBCC');
            $this->mail->AddBCC($dir_destinatario, $nom_destinatario);
        }
        $this->mail->AddBCC($_SESSION["_MAIL_PRUEBAS"], 'COPIA OCULTA');
    }


    function addAdjunto($archivo,$name = ''){
        if ($name == '')
            $this->mail->AddAttachment($archivo);
        else
            $this->mail->AddAttachment($archivo,$name);

    }


    function enviarCorreo(){
                if($this->autentificacion){
                     $this->mail->SMTPAuth = $this->autentificacion;
                     $this->mail->Password = $this->mail_password;
                     $this->mail->Username = $this->mail_usuario;
                     $this->mail->SMTPSecure = $this->SMTPSecure;
                     //$this->mail->SMTPDebug  = 2;
                  }

                 //para cuando el visor no puede leer HTML en el cuerpo”;
                   $this->mail->AltBody =  $this->mensaje;
                 // si el cuerpo del mensaje es HTML
                  $this->mail->MsgHTML($this->mensaje_html);


                if(!$this->mail->Send()) {
                     return $this->mail->ErrorInfo;
                }
                else{
                      return "OK";
                }


    }

    function setMensaje ($mensaje)
    {
             $this->mensaje= $mensaje;
              $this->mail->AltBody =  $this->mail->mensaje;

    }

    function setAccesoDirecto ($acceso_directo)
    {
       $this->acceso_directo=$acceso_directo;
    }

    function setTitulo ($titulo)
    {
             $this->titulo= $titulo;


    }
    function enableAcuseRecibo(){
        $this->acuse_recibo = True;
    }

    function setMensajeAcuse($mensaje_acuse){
        $this->mensaje_acuse = $mensaje_acuse;
    }
    function setUrlAcuse($url_acuse){
        $this->url_acuse = $url_acuse;
    }
    function setTokenAcuse($id){
        $this->token_acuse = md5('llave'.$id);
    }

     function setMensajeHtml ($mensaje)
    {
             $this->mensaje_html= $mensaje;
             $this->mail->MsgHTML($this->mensaje_html);
    }

    function setAsunto ($asunto)
    {
             $this->asunto= $asunto;
             $this->mail->Subject = $this->asunto;

    }
    function setRemitente($remitente)
    {
             $this->remitente= $remitente;
             $this->mail->From = $this->remitente;

    }
    function setUsuario($usuario)
    {
             $this->mail_usuario= $usuario;
    }

   function setPassword($password)
    {
             $this->mail_password= $password;
    }

    function setServidor($servidor)
    {
             $this->mail_servidor= $servidor;
              $this->mail->Host = $this->mail_servidor;

    }

    function setPuerto($puerto)
    {
              $this->mail_puerto= $puerto;
              $this->mail->Port=$this->mail_puerto;

    }

    function setDefaultPlantilla(){
            $acceso='';

            if($this->acceso_directo!=''){

                //$actual_link = "http://$_SERVER[HTTP_HOST]".$_SESSION['_FOLDER']."/sis_seguridad/vista/_adm/index.php#alerta:".$this->acceso_directo;
                $actual_link = "http://".$this->servidor.$_SESSION['_FOLDER']."/sis_seguridad/vista/_adm/index.php#alerta:".$this->acceso_directo;//#11
                $acceso = ' <!--[if mso]>
                            <v:roundrect xmlns_v="urn:schemas-microsoft-com:vml" xmlns_w="urn:schemas-microsoft-com:office:word" href="' . $actual_link . '" style="height:36px;v-text-anchor:middle;width:150px;" arcsize="5%" strokecolor="#021d70" fillcolor="#021d70">
                                 <w:anchorlock/>
                                 <center style="color:#ffffff;font-family:Helvetica, Arial,sans-serif;font-size:16px;">Acceso Directo</center>
                            </v:roundrect>
                            <![endif]-->';

                $acceso .= ' <a href="' . $actual_link . '" target="_blank" style="mso-hide:all;padding-top: 8px;padding-bottom:8px; border: 1px solid #021d70;border-radius: 2px;font-family: Helvetica, Arial, sans-serif;font-size: 12px; color: #f9bd00;text-decoration: none;font-weight:bold;display: block;">
                            Acceso Directo
                            </a>';
            }
            $acuse='';
            if($this->acuse_recibo){


                $mensaje_acuse = "Por  favor para confirmar la recepción  de este mensaje y continuar con el trámite,  haga clic en el botón de abajo: <br><br>";
                //$url_acuse = "http://$_SERVER[HTTP_HOST]".$_SESSION['_FOLDER']."/sis_parametros/vista/alarma/acuse/acuserecibo.php";
                $url_acuse = "http://".$this->servidor.$_SESSION['_FOLDER']."/sis_parametros/vista/alarma/acuse/acuserecibo.php";//#11


                if(!isset($this->mensaje_acuse) ||  trim($this->mensaje_acuse) ==''){
                    $this->mensaje_acuse = $mensaje_acuse;
                }

                if(!isset($this->url_acuse) || trim($this->url_acuse) ==''){
                    $this->url_acuse = $url_acuse;
                }

                $this->url_acuse = $this->url_acuse."?token=".$this->token_acuse;


                //$boton_acuse = '<td style="background:#ff4800; padding:12px 10px; border:6px solid rgb(239,239,239);"><a href="'.$this->url_acuse.'" style="text-decoration:none; font-family:Arial, Helvetica, sans-serif; color:#fff; background:#ff4800; text-align:center;"><span class="btn-inner" style="text-decoration:none !important; color:#fff; font-size:16px; line-height:28px; text-align:center; display:block;">&nbsp;&nbsp; Confirmar &nbsp;&nbsp;</span></a></td>'

                $boton_acuse = $this->mensaje_acuse.'<BR><BR><BR><form method="get" action="'.$this->url_acuse.'">
                                <input type="hidden" name="token" value="'.$this->token_acuse.'">
                                <input type="submit" value="Enviar acuse" />
                                </form><br>(Si  no funciona, por favor copie y pegue el enlace completo en su navegador) <br>'.$this->url_acuse.'<br>';



                //$acuse = $this->mensaje_acuse.'<BR/><a href="'.$this->url_acuse.'">'.$this->url_acuse.'</a>';

            }

        $notification = new Template(NOTIFICATION);
        $notification->set('template_path', __DIR__);
        $notification->set('acceso_directo', $acceso);
        $notification->set('mensaje', $this->mensaje);
        $notification->set('titulo', $this->titulo);
        $notification->set('boton_acuse', $this->acuse_recibo);
        $layout = new Template(DEFAULT_TEMPLATE);
        $layout->set('template_path', __DIR__);
        $layout->set("content", $notification->output());
        $this->mensaje_html = $layout->output();
    }

    function validateEmail($email){
            //list($userName, $mailDomain) = split("@", $email);
            list($userName, $mailDomain) = explode("@", $email);//RCM cambio de split por explode, split esta deprecado
            if (checkdnsrr($mailDomain, "MX")) {
               return true;
            }
            else {
               return false;
            }
    }





}
?>