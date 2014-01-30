<?php
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
  
    protected $mail;
    
    function __construct(){
            
        $this->autentificacion=true;        
        $this->mail_usuario=$_SESSION['_MAIL_USUARIO'];
        $this->mail_password=$_SESSION['_MAIL_PASSWORD'];
        $this->mail_servidor=$_SESSION['_MAIL_SERVIDOR'];
        $this->mail_puerto=$_SESSION['_MAIL_PUERTO'];
        
        $this->remitente=$_SESSION['_MAIL_REMITENTE'];
        $this->nombre_remitente=$_SESSION['_NOMBER_REMITENTE'];  
        $this->SMTPSecure=$_SESSION['_SMTPSecure'];
        
        
             
         $this->mail= new PHPMailer();
         $this->mail->IsSMTP();
         $this->mail->Host = $this->mail_servidor;
         $this->mail->Port = $this->mail_puerto;
         $this->mail->From = $this->remitente;
         $this->mail->FromName = $this->nombre_remitente;
         $this->mail->Subject = $this->asunto;
          
       
   }
    
    function addDestinatario($dir_destinatario,$nom_destinatario=''){
        $this->mail->AddAddress($dir_destinatario, $nom_destinatario);    
        
    }
    
    function addCC($dir_destinatario,$nom_destinatario=''){
        $this->mail->AddCC($dir_destinatario, $nom_destinatario);
    }
    
    
    
    function addAdjunto($archivo){
       
        $this->mail->AddAttachment($archivo);    
        
    }
   
   
    function enviarCorreo(){
                if($this->autentificacion){
                     $this->mail->SMTPAuth = true;               
                     $this->mail->Password = $this->mail_password;
                     $this->mail->Username = $this->mail_usuario; 
                     $this->mail->SMTPSecure = $this->SMTPSecure; 
                     //$this->mail->SMTPDebug  = 2;      
                  } 
                  
                 //para cuando el visor no puede leer HTML en el cuerpo”; 
                   $this->mail->AltBody =  $this->mail->mensaje;
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
    
    function setTitulo ($titulo)
    {
             $this->titulo= $titulo;
             
         
    }
    
    
     function setMensajeHtml ($mensaje)
    {
             $this->mensaje= $mensaje;
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
                          
            $this->mensaje_html=$cuerpo = "
                    <html>
                    <head>
                    <title>".$this->titulo."</title>
                    <style type=\"text/css\">
                        body{
                            font-family:Arial, Helvetica, sans-serif;
                        }
                        a:link{
                            font-weight: bold;
                            text-decoration: none;
                            font-style: italic;
                        }
                        a:hover{
                            text-decoration: underline;
                        }
                        a:visited{
                            font-weight: bold;
                            color: blue;
                            font-style: italic;
                        }
                        
                    </style>
                    </head>
                    <body>
                    <h1>".$this->titulo."</h1>".stripslashes($this->mensaje)."
                    <p>-------------------------------------------<br/>
                    <h6>Powered by KPLIAN<h6>
                    <p>
                    </body>
                    </html>";
        
    }
      
                                                               
          
}
?>