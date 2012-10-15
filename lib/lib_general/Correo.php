<?php
class Correo
{
	
/*
**********************************************************
Nombre de la función:	EnviarCorreoAdjunto($origen,$destino,$nom_archivo,$dir_archivo,$asunto,$mensaje)
Propósito:				Se utiliza para crear enviar un mail con un archivo adjunto
						
						
Parámetros:				$origen	--> quien es envia el mensaje
						$destino  --> para quien es el mensage
						$nom_archivo  --> nombre del archivo adjunto
						$dir_archivo  --> dir donde se encuentra el archivo 
						$asunto  --> asunto del mensaje
						$mensaje  --> el mensaje pra enviar por mail
Valores de Retorno:		1 	-->	exito en el envio
						0	--> error
Autor					Rensi Arteaga Copari rensi@pi.umsa.bo
**********************************************************
*/


function EnviarCorreoAdjunto($origen,$destino,$nom_archivo,$dir_archivo,$asunto,$mensaje)
{

		$file = fopen($dir_archivo+"/"+nom_archivo, "r");
		$contenido = fread($file, filesize($dir_archivo+"/"+nom_archivo));
		$encoded_attach = chunk_split(base64_encode($contenido));
		fclose($file);
		
		$nombref=$nom_archivo;
		if($asuton=="")
		{
			$asunto="Archivo adjunto";
		}
		$email=$destino;
	
		//$mensaje="Email enviado por cortesia de Diseño y Programación";
	
		$cabeceras = "From: lotito <$origen>\n";
		$cabeceras .= "Reply-To: $email\n";
		$cabeceras .= "Return-path: $email\r\n";
		$cabeceras .= "MIME-version: 1.0\n";
		$cabeceras .= "Content-type: multipart/mixed; ";
		$cabeceras .= "boundary=\"Message-Boundary\"\n";
		$cabeceras .= "Content-transfer-encoding: 7BIT\n";
		$cabeceras .= "X-attachments: $nombref";
		
		$body_top = "--Message-Boundary\n";
		$body_top .= "Content-type: text/plain; charset=US-ASCII\n";
		$body_top .= "Content-transfer-encoding: 7BIT\n";
		$body_top .= "Content-description: Mail message body\n\n";
	
		$cuerpo = $body_top.$mensaje;
	
		//$nombref="fichero.bin";
		$cuerpo .= "\n\n--Message-Boundary\n";
		$cuerpo .= "Content-type: Binary; name=\"$nombref\"\n";
		$cuerpo .= "Content-Transfer-Encoding: BASE64\n";
		$cuerpo .= "Content-disposition: attachment; filename=\"$nombref\"\n\n";
		$cuerpo .= "$encoded_attach\n";
		$cuerpo .= "--Message-Boundary--\n";

		$exito=mail($email,$asunto,$cuerpo,$cabeceras);
		return $exito;
	
	}
	
	/*
**********************************************************
Nombre de la función:	ValidarDatos($campo)
Propósito:				Se utiliza para validar el contenido del 
						los parametros que entran a la funcion mail
						para evitar la inyeccion y el uso de malas palabras
						
						
Parámetros:				$campo	--> ???? palabra a vereficar
						
Valores de Retorno:		1 	-->	palabras prohibidas
						0	--> no tiene palabras prohibidas
Autor					Rensi Arteaga Copari rensi@pi.umsa.bo
**********************************************************
*/
	
	
	function ValidarDatos($campo){
    //Array con las posibles cabeceras a utilizar por un spammer
    $badHeads = array("Content-Type:",
                                 "MIME-Version:",
                                 "Content-Transfer-Encoding:",
                                 "Return-path:",
                                 "Subject:",
                                 "From:",
                                 "Envelope-to:",
                                 "To:",
                                 "bcc:",
                                 "cc:",
                                 "caraj",
                                 "puta",
                                 "puto",
                                 "huevon",
                                 "mierd",
                                 "coju",
                                 "bolud",
                                 "putit","cabron",
                                 "gay",
                                 "culo",
                                 "marac",
                                 "poto",
                                 "bolud",
                                 "culero",
                                 "coño",
                                 "estupid",
                                 "pene",
                                 "pichi",
                                 "meon",
                                 "perr",
                                 "vagin",
                                 "indio",
                                 "prosti",
                                 "cortesana",
                                 "meretri",
                                 "pelotud",
								 "p.u.t",
								 "p-u-t",
								 "p?u?t",
                                 "oroton");

    //Comprobamos que entre los datos no se encuentre alguna de
    //las cadenas del array. Si se encuentra alguna cadena se
    //dirige a una página de Forbidden
    $sw = 0;
    foreach($badHeads as $valor){ 
      if(strpos(strtolower($campo), strtolower($valor)) !== false){ 
        $sw = 1;
        return 1;
      }
    }
    if(sw==0) 
    {return 0; //no tiene palabras prohibidas
    	
    }
  
  }
  
  
  	/*
**********************************************************
Nombre de la función:	ValidarDatos($campo)
Propósito:				Se utiliza para validar el contenido del 
						los parametros que entran a la funcion mail
						para evitar la inyeccion y el uso de malas palabras
						
						
Parámetros:				$campo	--> ???? palabra a vereficar
						
Valores de Retorno:		1 	-->	parace ser un  correo
						0	--> no tiene @ en la cadena
Autor					Rensi Arteaga Copari rensi@pi.umsa.bo
**********************************************************
*/
	
	
	function ValidarCorreo($campo){
    //Array con las posibles cabeceras a utilizar por un spammer
    $badHeads = array("@");
    $sw = 0;
    //Comprobamos que entre los datos no se encuentre alguna de
    //las cadenas del array. Si se encuentra alguna cadena se
    //dirige a una página de Forbidden
    foreach($badHeads as $valor){ 
      if(strpos(strtolower($campo), strtolower($valor)) !== false){ 
        $sw = 1;
      	return 1;
        
      }
    } 
    if($sw == 0)
    {return 0;
    	
    }
  
  }
  
	
/*
**********************************************************
Nombre de la función:	function EnviarCorreodePrueba($origen,$destino,$tema,$mensaje)
Propósito:				Se utiliza para crear enviar un mail con un archivo adjunto
						
						
Parámetros:				$origen	--> quien es envia el mensaje
						$destino  --> para quien es el mensage
						$nombre  --> pra mostra en el mensaje
						$id  --> clave cliente
						
Valores de Retorno:		1 	-->	exito en el envio
						0	--> error
Autor					Rensi Arteaga Copari rensi@pi.umsa.bo
						23 octubre 2006
**********************************************************
*/
function EnviarCorreodePrueba($origen,$destino,$tema,$mensaje)
{
		$destinatario = $destino;
		$asunto = "$tema";
		$cuerpo = stripslashes($mensaje);	
		//stripslashes($cuerpo);
		//para el envío en formato HTML
		
		$headers  = "MIME-Version: 1.0\r\n";
		$headers .= "Content-type: text/html; charset=iso-8859-1\r\n";

		//dirección del remitente
		$headers .= "From: $origen\r\n";
		
		//dirección de respuesta, si queremos que sea distinta que la del remitente
		$headers .= "Reply-To: $email\r\n";

		//direcciones que recibián copia
		$headers .= "Cc: rensi4rn@gmail.com\r\n";

		//direcciones que recibirán copia oculta
		//$headers .= "Bcc: fsa@jtc.com.bo\r\n";
        
		
		$exito= mail($destinatario,$asunto,$cuerpo,$headers);

		echo $exito;
		exit;
		return $exito;
	
	}

  
function EnviarCorreo($origen,$destino,$tema,$mensaje,$titulo,$mensaje_cab)
{
		$destinatario = $destino;
		$asunto = "$tema";
		$cuerpo = stripslashes($mensaje);	
		//stripslashes($cuerpo);
		//para el envío en formato HTML
		$cuerpo = "
		<html>
		<head>
 		<title>'.$titulo.'</title>
 		<style type='text/css'>
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
		<h1>".$mensaje_cab."</h1>
		".stripslashes($mensaje)."
		
		
		
		<p>-------------------------------------------<br/>
  		Power by PXP
		<p>
		</body>
		</html>
		";
		
		$headers  = "MIME-Version: 1.1\r\n";
		$headers .= "Content-type: text/html; charset=iso-8859-1\r\n";

		//dirección del remitente
		$headers .= "From: $origen\r\n";
		
		//dirección de respuesta, si queremos que sea distinta que la del remitente
		$headers .= "Reply-To: $email\r\n";
		$headers .= "Return-path: $email\r\n";

		//direcciones que recibián copia
		//$headers .= "Cc: rensi4rn@gmail.com\r\n";

		//direcciones que recibirán copia oculta
		//$headers .= "Bcc: fsa@jtc.com.bo\r\n";
        
		
		$exito= mail($destinatario,$asunto,$cuerpo,$headers);

		
		return $exito;
	
	}	
}?>