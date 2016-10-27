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
include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.phpmailer.php');
include_once(dirname(__FILE__).'/../../lib/PHPMailer/class.smtp.php');
include_once(dirname(__FILE__).'/../../lib/lib_general/cls_correo_externo.php');
include_once(dirname(__FILE__).'/../../lib/rest/PxpRestClient.php');


ob_start();


//estable aprametros ce la cookie de sesion
$_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control 


//echo dirname(__FILE__).'LLEGA';
register_shutdown_function('fatalErrorShutdownHandler');
set_exception_handler('exception_handler');
set_error_handler('error_handler');;
include_once(dirname(__FILE__).'/../../lib/lib_control/CTincludes.php');

include_once(dirname(__FILE__).'/../../sis_workflow/modelo/MODDocumentoWf.php');


       $objPostData=new CTPostData();
       $arr_unlink=array();
        $aPostData=$objPostData->getData();
        
        
        $_SESSION["_PETICION"]=serialize($aPostData);
        $objParam = new CTParametro($aPostData['p'],null,$aPostFiles);
        ////////////////
        $objParam->defecto('ordenacion','id_documento_wf');
        $objParam->defecto('dir_ordenacion','asc');
        
        $objFunc=new MODDocumentoWf($objParam);    
        $res=$objFunc->listaDocumentosFirma();

		if($res->getTipo()=='ERROR'){
			echo 'Se ha producido un error-> Mensaje Técnico:'.$res->getMensajeTec();
			exit;        
		}
		
		foreach ($res->datos as $d){
			
       		if ($d['accion_pendiente'] == 'firmar') {
       			
       			//Generamos el documento con REST
				$pxpRestClient = PxpRestClient::connect('127.0.0.1',substr($_SESSION["_FOLDER"], 1) .'pxp/lib/rest/')
                                                                                                        ->setCredentialsPxp($_GET['user'],$_GET['pw']);
					
				$url_final = str_replace('sis_', '', $d['action']);
				
				$url_final = str_replace('/control', '', $url_final);
				
				$res = $pxpRestClient->doPost($url_final,
				    array(	"id_proceso_wf"=>$d['id_proceso_wf'],
				    		"firmar"=>'si',
							"fecha_firma"=>$d["fecha_firma"],
							"usuario_firma"=>$d["usuario_firma"],
							"nombre_usuario_firma"=>$d["nombre_usuario_firma"]));
                $res = str_replace('\\', '\\\\', $res);
                $res = str_replace('\\\\', '\\', $res);

				$res_json = json_decode($res);
                
				//var_dump($res_json);
                //exit;
				$objParam->addParametro('archivo_generado',$res_json->ROOT->detalle->archivo_generado);
				$objParam->addParametro('hash_firma',$res_json->ROOT->datos->hash);
				$objParam->addParametro('datos_firma',json_encode($res_json->ROOT->datos->datos_documento));
				$objParam->addParametro('id_documento_wf',$d['id_documento_wf']);
				//Si la generacion del documento fue exitosa, movemos el documento para que sea guardado
				//y actualizamos los datos del documento firmado dentro de un pdo
				$objFunc=new MODDocumentoWf($objParam);
        		$res=$objFunc->firmarDocumento();
				
								
				
       		} else if ($d['accion_pendiente'] == 'eliminar_firma') {
       			$objParam->addParametro('url',$d['url']);
				$objParam->addParametro('id_documento_wf',$d['id_documento_wf']);
       			$objFunc=new MODDocumentoWf($objParam);    
        		$res=$objFunc->eliminarArchivo();
        		
       		}		
			
        }		
        var_dump($res);
		exit;
 
?>