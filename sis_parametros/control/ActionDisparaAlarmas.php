<?php 
/*** 
 Nombre: Intermediario.php
 Proposito: Invocar al disparador de alarmas saltandose los pasos de 
 *          autentificacion
 * 		    este archivo se  invoca desde un cron tab en servidor linux
 *          solo deberia llamarse desde ahí, otras llamadas no seran autorizadas 
 Autor:	Kplian (RAC)
 Fecha:	19/07/2010
 */
include_once(dirname(__FILE__)."/../../lib/lib_control/CTSesion.php");
session_start();
$_SESSION["_SESION"]= new CTSesion(); 

include(dirname(__FILE__).'/../../lib/DatosGenerales.php');
include_once(dirname(__FILE__).'/../../lib/lib_general/Errores.php');
//include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.phpmailer.php');
//include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.smtp.php');
//include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.pop3.php');
require dirname(__FILE__).'/../../lib/PHPMailer/PHPMailerAutoload.php';
include_once(dirname(__FILE__).'/../../lib/lib_general/cls_correo_externo.php');
include_once(dirname(__FILE__).'/../../lib/rest/PxpRestClient.php');



include_once(dirname(__FILE__).'/../../lib/FirePHPCore-0.3.2/lib/FirePHPCore/FirePHP.class.php');


ob_start();
$fb=FirePHP::getInstance(true);

//estable aprametros ce la cookie de sesion
$_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control 

/*
cantidad de error anidados
if($_SESSION["_FORSSL"]=='SI'){
    session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,true ,false);
}
else{
    session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,false ,false);
}
*/


//echo dirname(__FILE__).'LLEGA';
//register_shutdown_function('fatalErrorShutdownHandler');
//set_exception_handler('exception_handler');
//set_error_handler('error_handler');;
include_once(dirname(__FILE__).'/../../lib/lib_control/CTincludes.php');

include_once(dirname(__FILE__).'/../../sis_parametros/modelo/MODAlarma.php');


        $objPostData = new CTPostData();
        $arr_unlink = array();
        $aPostData = $objPostData->getData();
        //rac 22/09/2011 
        //$aPostFiles=$objPostData->getFiles();
        
        $_SESSION["_PETICION"]=serialize($aPostData);
        $objParam = new CTParametro($aPostData['p'],null,$aPostFiles);
        ////////////////
        $objParam->defecto('ordenacion','id_lugar');
        $objParam->defecto('dir_ordenacion','asc');
        
        $objFunc=new MODAlarma($objParam);    
        $res=$objFunc->GeneraAlarma();
		if($res->getTipo()=='ERROR'){
			echo 'Se ha producido un error-> Mensaje Técnico:'.$res->getMensajeTec();
			exit;        
		}
		
        $objFunc=new MODAlarma($objParam);  
        $res2=$objFunc->listarAlarmaCorrespondeciaPendiente();
		if($res2->getTipo()=='ERROR'){
			echo 'Se ha producido un error-> Mensaje Técnico:'.$res2->getMensajeTec();
			exit;        
		}
        
        $errores_id = '';
		$errores_msg = '';
		$pendiente = '0';
		var_dump($res2->datos);
        error_reporting(-1);//captura todos los tipos de errores ...
		foreach ($res2->datos as $d){
			
				$pendiente = $d['pendiente'];
			    
	       		$correo = new CorreoExterno();
				try {	
			       		
						if(isset($d['email_empresa'])){
							$correo->addDestinatario($d['email_empresa'],$d['email_empresa']); 
							//$correo->addCC($_SESSION["_MAIL_PRUEBAS"],'Correo de Pruebas');  
			                
			                if ($d['acceso_directo'] !='' && $d['acceso_directo'] != NULL){
			                  $correo->setAccesoDirecto($d['id_alarma']);  
			                } 
							
							if (!PHPMailer::validateAddress($d['email_empresa'])) {
					            throw new phpmailerException("Email address " . $d['email_empresa'] . " is invalid -- aborting!");
					        }
							
							if (!$correo->validateEmail($d['email_empresa'])) {
					            throw new phpmailerException("Domain Email address " . $d['email_empresa'] . " is invalid -- aborting!");
					        }   
							
							            
			                
			            } else if (isset($d['correos'])) {
			            	$correos = explode(',', $d['correos']);
                            var_dump($correos);
							foreach($correos as $value) {

								$value = trim($value);
								echo 'sss <br>';
								echo $value;
                                if (preg_match('/\([A-Za-z0-9]+/', $value)){
                                    $procesar = explode(';',trim($value, '()'));
                                    foreach($procesar as $value) {
                                        $value = trim($value);
                                        $correo->addCC($value, $value);
                                    }

                                }else if (preg_match('/\[[A-Za-z0-9]+/', $value)){
                                    $procesar = explode(';',trim($value, '[]'));
                                    foreach($procesar as $value) {
                                        $value = trim($value);
                                        $correo->addBCC($value, $value);
                                    }
                                }
                                else {
                                    $correo->addDestinatario($value, $value);
                                }

								if (!PHPMailer::validateAddress($value)) {
						            throw new phpmailerException("Email address " . $value . " is invalid -- aborting!");
						        }
								if (!$correo->validateEmail($value)) {
						            throw new phpmailerException("Domain Email address " . $value . " is invalid -- aborting!");
						        }
							}
							
			            }
						
						
						
						if(isset($d['requiere_acuse'])){
							if($d['requiere_acuse'] == 'si'){
								
								 $correo->enableAcuseRecibo();
								 $correo->setMensajeAcuse($d['mensaje_link_acuse']);
								 $correo->setUrlAcuse($d['url_acuse']);
								 $correo->setTokenAcuse($d['id_alarma']);     
						    	 
						    }	
						}
						
						$correo->setAsunto($d['titulo_correo'].' '.$d['obs']);
			            $correo->setMensaje($d['descripcion']);
                        if ($d['tipo'] != 'felicitacion') {
                            $correo->setTitulo($d['titulo_correo']);
                        }
						
						//Anadir los adjuntos
						$adjuntos = explode(',', $d['documentos']);
						
						foreach($adjuntos as $value) {
							$url = explode('|', $value);
							
							if (count($url) > 2) {
								//es un reporte generado (llamar un metodo para generar el reporte)
								
								$pxpRestClient = PxpRestClient::connect('127.0.0.1',substr($_SESSION["_FOLDER"], 1) . 'pxp/lib/rest/')
																->setCredentialsPxp($_GET['user'],$_GET['pw']);
								
								$url_final = str_replace('../../sis_', '', $url[0]);
								$url_final = str_replace('sis_', '', $url_final);
								
								$url_final = str_replace('/control', '', $url_final);
								
								$res = $pxpRestClient->doPost($url_final,
								array("id_proceso_wf"=>$url[1]));
								$res_json = json_decode($res);
								$correo->addAdjunto(dirname(__FILE__) . '/../../../reportes_generados/' . $res_json->ROOT->detalle->archivo_generado,$url[2]);
								//poniendo la url para eliminar
								//array_push($arr_unlink,dirname(__FILE__) . '/../../../reportes_generados/' . $res_json->ROOT->detalle->archivo_generado);
								
								
							} else {
								//es un archivo
								$url_final = str_replace('./../../../', '/../../../', $url[0]);	
												
								$correo->addAdjunto(dirname(__FILE__) . $url_final, $url[1]);
							}
							
						}
						
						
						
			            $correo->setDefaultPlantilla();
			            
			            
						
						$respuesta_correo = $correo->enviarCorreo();	
						if($respuesta_correo != "OK"){
			            	if ($errores_id == ''){
			            		$errores_id = ''. $d['id_alarma'];
								$errores_msg = $d['id_alarma'].'<oo#oo>'.$respuesta_correo;
			            	}	
			            	$errores_id = $errores_id .','. $d['id_alarma'];
							$errores_msg = $errores_msg.'###+###'.$d['id_alarma'].'<oo#oo>'.$respuesta_correo;
					     };
			        
				} 
				catch (phpmailerException $e) {
					$respuesta_correo = $e->errorMessage();
				 	if ($errores_id == ''){
	            		$errores_id = ''. $d['id_alarma'];
						$errores_msg = $d['id_alarma'].'<oo#oo>Php mailer error:'.$respuesta_correo;
	            	}	
	            	$errores_id = $errores_id .','. $d['id_alarma'];
					$errores_msg = $errores_msg.'###+###'.$d['id_alarma'].'<oo#oo>'.$respuesta_correo;
				} catch (Exception $e) {
				     $respuesta_correo = $e->getMessage();
				 	if ($errores_id == ''){
	            		$errores_id = ''. $d['id_alarma'];
						$errores_msg = $d['id_alarma'].'<oo#oo>'.$respuesta_correo;
	            	}	
	            	$errores_id = $errores_id .','. $d['id_alarma'];
					$errores_msg = $errores_msg.'###+###'.$d['id_alarma'].'<oo#oo>'.$respuesta_correo;
				}
				
				
				
        }
		
		//echo '------>   ';
		//echo $errores_msg;
		$objParam->addParametro('errores_id', $errores_id);
		$objParam->addParametro('errores_msg', $errores_msg);
		$objParam->addParametro('id_usuario', 1);
		$objParam->addParametro('tipo', 'TODOS');
		$objParam->addParametro('pendiente', $pendiente);		
		
        $objFunc=new MODAlarma($objParam);        
        $res2=$objFunc->modificarEnvioCorreo();
		if($res2->getTipo()=='ERROR'){
			echo 'Se ha producido un error-> Mensaje Técnico:'.$res2->getMensajeTec();
			exit;        
		}
        $res2->imprimirRespuesta($res2->generarJson());
		
		foreach ($arr_unlink as $value) {
			unlink($value);
		
		}
 
?>