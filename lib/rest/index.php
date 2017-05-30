<?php
/**
 * Step 1: Require the Slim Framework
 *
 * If you are not using Composer, you need to require the
 * Slim Framework and register its PSR-0 autoloader.
 *
 * If you are using Composer, you can skip this step.
 */

include_once(dirname(__FILE__)."/../../../lib/lib_control/CTSesion.php");
session_start();
include_once(dirname(__FILE__).'/../../../lib/DatosGenerales.php');
include_once(dirname(__FILE__).'/../../../lib/lib_general/Errores.php');
include_once(dirname(__FILE__).'/../../../lib/lib_control/CTincludes.php');


$_SESSION["_OFUSCAR_ID"]='no'; 
//estable aprametros ce la cookie de sesion
$_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control cantidad de error anidados
if($_SESSION["_FORSSL"]=='SI'){
    session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,true ,false);
}
else{
    session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,false ,false);
}


require 'Slim/Slim.php';


\Slim\Slim::registerAutoloader();

/**
 * Step 2: Instantiate a Slim application
 *
 * This example instantiates a Slim application using
 * its default settings. However, you will usually configure
 * your Slim application now by passing an associative array
 * of setting names and values into the application constructor.
 */
$app = new \Slim\Slim(array(

    'log.enabled' => false,
    'debug' => false
));
register_shutdown_function('fatalErrorShutdownHandler');
set_exception_handler('exception_handler');
set_error_handler('error_handler');

//$app->error('exception_handler');
$app->log->setEnabled(false);
//error_reporting(~E_NOTICE);
$app->response->headers->set('Content-Type', 'application/json');
$headers = $app->request->headers;

header('Access-Control-Allow-Origin: ' . $headers['Origin']);
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: pxp-user, content-type, Php-Auth-User, Php-Auth-Pw');
header('Access-Control-Allow-Credentials: true');	
header('Access-Control-Max-Age: 1728000');

 // get route

/**
 * Step 3: Define the Slim application routes
 *
 * Here we define several Slim application routes that respond
 * to appropriate HTTP request methods. In this example, the second
 * argument for `Slim::get`, `Slim::post`, `Slim::put`, `Slim::patch`, and `Slim::delete`
 * is an anonymous function.
 */

// GET route
$app->get(
    '/',
    function () {
         echo 'Hola';
       }
);


function get_func_argNames($funcName) {
    $f = new ReflectionFunction($funcName);
    $result = array();
    foreach ($f->getParameters() as $param) {
        $result[] = $param->name;   
    }
    return $result;
}

function authPxp($headersArray) {
	
	$_SESSION["_SESION"]= new CTSesion();
	$_SESSION["_tipo_aute"] = 'REST';   

	$mensaje = '';  
    //listar usuario con Pxp-User del header
    $objParam = new CTParametro('',null,null,'../../sis_seguridad/control/Usuario/listarUsuario');
	$objParam->addParametro('usuario', $headersArray['Pxp-User']);    
    include_once dirname(__FILE__).'/../../../sis_seguridad/modelo/MODUsuario.php';
	$objFunSeguridad = new MODUsuario($objParam);
	
    $res = $objFunSeguridad->listarUsuarioSeguridad($objParam);
	
	if ($res->datos['contrasena'] == '') {
		$mensaje = "El Usuario no esta registrado en el sistema";
	}
	
    //obtener la contrasena del usuario en md5
    $md5Pass = $res->datos['contrasena'];
	
    
	//creamos array de request
	$reqArray = array();
	
	if (!extension_loaded('mcrypt')) {
		if ($mensaje == '')
	    $mensaje = 'El modulo mcrypt no esta instalado en el servidor. No es posible utilizar REST en este momento';
	}
	if ($headersArray['Pxp-User'] == $headersArray['Php-Auth-User']) {
		
		$auxArray = explode('$$', fnDecrypt($headersArray['Php-Auth-Pw'], $md5Pass));
		$headers = false;
	} else {
	//desencriptar usuario y contrasena
		$auxArray = explode('$$', fnDecrypt($headersArray['Php-Auth-User'], $md5Pass));
		$headers = true;
	}
	
	if (count($auxArray) == 2 && ($auxArray[1] == $headersArray['Pxp-User'] || $auxArray[1] == $md5Pass)) {
			
		$reqArray['usuario'] = $headersArray['Pxp-User'];		
		$reqArray['contrasena'] =  $md5Pass;	
		$reqArray['_tipo'] = 'restAuten';
	
    
	    //autentificar usuario en sistema
	    //arma $JSON
	    $JSON = json_encode($reqArray);    
	    $objParam = new CTParametro($JSON,null,null,'../../sis_seguridad/control/Auten/verificarCredenciales');
	    include_once dirname(__FILE__).'/../../../sis_seguridad/control/ACTAuten.php';    
	    //Instancia la clase dinamica para ejecutar la accion requerida
	    
	    eval('$cad = new ACTAuten($objParam);');
	    eval('$cad->verificarCredenciales();');
	} else {
		if ($mensaje == '')
			$mensaje = "Contrasena invalida para el usuario : " . $headersArray['Pxp-User'];
	} 
	
	if ($mensaje != '') {
		$men=new Mensaje();
		$men->setMensaje('ERROR','pxp/lib/rest/index.php Linea: 131',$mensaje,
		'Codigo de error: AUTEN',
		'control','','','OTRO','');
		
		//rac 21092011 					
		$men->imprimirRespuesta($men->generarJson(),'200');
		exit;
	}
	
} 

function fnDecrypt($sValue, $sSecretKey)
{
    return rtrim(
        mcrypt_decrypt(
            MCRYPT_RIJNDAEL_256, 
            $sSecretKey, 
            base64_decode($sValue), 
            MCRYPT_MODE_ECB,
            mcrypt_create_iv(
                mcrypt_get_iv_size(
                    MCRYPT_RIJNDAEL_256,
                    MCRYPT_MODE_ECB
                ), 
                MCRYPT_RAND
            )
        ), "\0"
    );
}








$app->get('/seguridad/Persona2/:start/:limit','persona2');

function persona2($r,$t){
          $ref = new ReflectionFunction('persona2');
         //print_r($ref->getParameters());
         
         // $data = json_decode($request->getBody()) ?: $request->params();
           
           
           //print_r($data);
           
          $objPostData=new CTPostData();
      
       
       // $_SESSION["_PETICION"]=serialize($aPostData);
        
        
        $aPostData = $objPostData->getData();
        
        
       // $objParam = new CTParametro('{}');
        $objParam = new CTParametro('{"start":"'.$start.'","limit":"'.$limit.'","sort":"id_persona","dir":"ASC"}',null,null,'../../sis_seguridad/control/Persona/listarPersonaFoto');
        
        include_once dirname(__FILE__).'/../../sis_seguridad/control/ACTPersona.php';
        
       
        $cad = new ACTPersona($objParam);
        $cad->listarPersona();
    
       
    
}



$app->get(
    '/seguridad/Persona/:start/:limit',
    function () use ($app) {
           //$start = $app->request->get('start');
           // $limit = $app->request->get('limit');
           
            $par = list($start, $limit) = func_get_args();
           
          // $ref = new ReflectionFunction();
           
           //print_r($ref->getParameters());
           
           //get_func_argNames('test')
           
           
   //          foreach(func_get_args() as $k => $v){
  //                echo $k . " => " . $v . "<BR/>";
  //           }
                
           
             //print_r($f);
           
  //         $paramValue = $app->request->params('paramName');
   //        print_r($paramValue);
           
           //$req = $app->request();
           //print_r($req);
            
            $request= $app->request();
            
            $s1 = $app->request()->params('start');
            //list($start, $limit) = func_get_args();
            
            $data = json_decode($request->getBody()) ?: $request->params();
           
           
          // print_r($data);
           //$req = $app->request();
           //print_r($req->params());       
            
        
        //Instancia la clase dinamica para ejecutar la accion requerida
        //Se obtiene las claves (nombres de las columnas) del array
        $tmpKeys=array_keys($_REQUEST);
        $aVariablesEncryp=array();
        $i=0;
        
        //Se obtiene lo enviado en estado nativo que puede estar encriptado o no
        
        foreach($_REQUEST as $row){
            $aVariablesEncryp[$tmpKeys[$i]]=$row;//$this->tmpValues[$i];
            $i++;
        }
        
        $objPostData=new CTPostData();
      
        // $_SESSION["_PETICION"]=serialize($aPostData);
        $aPostData = $objPostData->getData();
        $_SESSION["_PETICION"]=serialize($aPostData);
        // $objParam = new CTParametro('{}');
        $objParam = new CTParametro('{"start":"'.$start.'","limit":"'.$limit.'","sort":"id_persona","dir":"ASC"}',null,null,'../../sis_seguridad/control/Persona/listarPersonaFoto');
        
        include_once dirname(__FILE__).'/../sis_seguridad/control/ACTPersona.php';
        
       
        $cad = new ACTPersona($objParam);
        $cad->listarPersona();
        
        
        
            
    }
); 

$app->get(
	 
    '/:sistema/:clase_control/:metodo',
    function ($sistema,$clase_control,$metodo) use ($app) {
    	$headers = $app->request->headers;	
		$cookies = $app->request->cookies;
		
		$psudourl = '/'.$sistema.'/'.$clase_control.'/'.$metodo;
		
		
		//var_dump($app->request->cookies);
    	if ( isset($cookies['PHPSESSID']) && isset($_SESSION['_SESION']) && $_SESSION["_SESION"]->getEstado()=='activa') {
			
		} else if (isset($headers['Php-Auth-User'])) {
    		authPxp($headers);
		}else if (in_array($psudourl, $_SESSION['_REST_NO_CHECK'])) {
    		
		} else {
			$men=new Mensaje();
			$men->setMensaje('ERROR','pxp/lib/rest/index.php Linea: 304','No hay una sesion activa para realizar esta peticion',
			'Codigo de error: SESION',
			'control','','','OTRO','');
			
			//rac 21092011 					
			$men->imprimirRespuesta($men->generarJson(),'401');
			exit;
		}
    	
		//var_dump($app->request->headers);
		
    	     
        //TODO validar cadenas vaias y retorna error en forma JSON
        $ruta_include = 'sis_'.$sistema.'/control/ACT'.$clase_control.'.php';
        $ruta_url = 'sis_'+$sistema.'/control/'.$clase_control.'/'.$metodo;
         
        //TODO verificar sesion
        //throw new Exception('La sesion ha sido duplicada',2);
        $start = $app->request->params('start');
		$limit = $app->request->params('limit');
		$sort = $app->request->params('sort');
		$dir = $app->request->params('dir');
		$filter = $app->request->params('filter');
		
         //TODO desencriptar variables ...
        $objPostData=new CTPostData();
		
        $aPostData = $objPostData->getData();
        
        //add elements to array 
        if(isset($start)){
             $aPostData['start'] = $start;
        }
        else{
             $aPostData['start'] = 0;
        }
        if(isset($limit)){
             $aPostData['limit'] = $limit;
        }
        else{
             $aPostData['limit'] = 10000;
        }
		if(isset($sort)){
             $aPostData['sort'] = $sort;
        }       
		if(isset($dir)){
             $aPostData['dir'] = $dir;
        } 
		if(isset($filter)){
             $aPostData['filter'] = $filter;
        }        
        $_SESSION["_PETICION"]=serialize($aPostData);
        //arma $JSON
        $JSON = json_encode($aPostData);
        

        $objParam = new CTParametro($JSON,null,null,'../../'.$ruta_url);
        include_once dirname(__FILE__).'/../../../'.$ruta_include;

        
        //Instancia la clase dinamica para ejecutar la accion requerida
        eval('$cad = new ACT'.$clase_control.'($objParam);');
		
        eval('$cad->'.$metodo.'();');
        
    }
); 

$app->post(
	 
    '/seguridad/Auten/verificarCredenciales',
    function () use ($app) {
        register_shutdown_function('fatalErrorShutdownHandler');
        set_exception_handler('exception_handler');
        set_error_handler('error_handler');
    	$headers = $app->request->headers;
		if (isset($headers['Php-Auth-User'])) {
						
    		authPxp($headers);
			
		} else {	
	    	$mensaje = '';
	    	if ($app->request->post('usuario') == '') {
	    		$mensaje = "No se recibio el parametro usuario";
	    	}
			if ($app->request->post('contrasena') == '') {
				$mensaje = "No se recibio el parametro contrasena";
			}
			
			if ($mensaje != '') {
		    	$men=new Mensaje();
				$men->setMensaje('ERROR','pxp/lib/rest/index.php Linea: 377',$mensaje,
				'Codigo de error: AUTEN',
				'control','','','OTRO','');
								
				$men->imprimirRespuesta($men->generarJson(),'406');
				exit;
			}  	   	    	
	    	
	    	
	    	$auxHeaders = array('Pxp-User'=>$app->request->post('usuario'),'Php-Auth-User'=>$app->request->post('usuario'),'Php-Auth-Pw'=>$app->request->post('contrasena'));    	
	    	authPxp($auxHeaders); 
	    }		
		echo "{success:true,
				cont_alertas:".$_SESSION["_CONT_ALERTAS"].",
				nombre_usuario:'".$_SESSION["_NOM_USUARIO"]."',
				nombre_basedatos:'".$_SESSION["_BASE_DATOS"]."',
				id_usuario:'".$_SESSION["_ID_USUARIO_OFUS"]."',
				id_funcionario:'".$_SESSION["_ID_FUNCIOANRIO_OFUS"]."',
				autentificacion:'".$_SESSION["_AUTENTIFICACION"]."',
				estilo_vista:'".$_SESSION["_ESTILO_VISTA"]."',
				mensaje_tec:'".$_SESSION["mensaje_tec"]."',
				timeout:".$_SESSION["_TIMEOUT"]."}";	
				exit;		
    }
); 



$app->post(
	 
    '/:sistema/:clase_control/:metodo',
    function ($sistema,$clase_control,$metodo) use ($app) {
       
    	$headers = $app->request->headers;	
		$cookies = $app->request->cookies;
		$psudourl = '/'.$sistema.'/'.$clase_control.'/'.$metodo;

				
    	if ( isset($cookies['PHPSESSID']) && isset($_SESSION['_SESION']) && $_SESSION["_SESION"]->getEstado()=='activa') {
			
		} else if (isset($headers['Php-Auth-User'])) {
    		authPxp($headers);
		}else if (in_array($psudourl, $_SESSION['_REST_NO_CHECK'])) {
    		
		} else {
			$men=new Mensaje();
			$men->setMensaje('ERROR','pxp/lib/rest/index.php Linea: 432','No hay una sesion activa para realizar esta peticion',
			'Codigo de error: SESION',
			'control','','','OTRO','');
			
			//rac 21092011 					
			$men->imprimirRespuesta($men->generarJson(),'401');
			exit;
		}
    	
		//var_dump($app->request->headers);
		
    	     
        //TODO validar cadenas vaias y retorna error en forma JSON
        $ruta_include = 'sis_'.$sistema.'/control/ACT'.$clase_control.'.php';
        $ruta_url = 'sis_'+ $sistema.'/control/'.$clase_control.'/'.$metodo;

         
        //TODO verificar sesion
        //throw new Exception('La sesion ha sido duplicada',2);
        
         //TODO desencriptar variables ...
        $objPostData=new CTPostData();
		
        $aPostData = $objPostData->getData();
        $aPostFiles = $objPostData->getFiles();
        foreach($app->request->post() as $key => $val) {
        	$aPostData[$key] = $val;
		} 
		
		if ($app->request->post('_tipo') == 'matriz' ) {
			$m = 1;  
		} else {
			$m = null;
		}
		     
        $_SESSION["_PETICION"]=serialize($aPostData);
        //arma $JSON
        $JSON = json_encode($aPostData);
        

        $objParam = new CTParametro($JSON,$m,$aPostFiles,'../../'.$ruta_url);
        include_once dirname(__FILE__).'/../../../'.$ruta_include;


        //Instancia la clase dinamica para ejecutar la accion requerida
        eval('$cad = new ACT'.$clase_control.'($objParam);');
		
        eval('$cad->'.$metodo.'();');
        
    }
); 





$app->get('/books/:id/:op/', 

function ($op,$id) {
    //Show book identified by $id
       echo 'Hola '.$id .' , .. '.$op;
   }
);


// POST route
$app->post(
    '/post',
    function () {
        echo 'This is a POST route';
    }
);

// POST route
$app->get(
    '/get',
    function () {
        echo 'This is a GET route';
    }
);

// PUT route
$app->put(
    '/put',
    function () {
        echo 'This is a PUT route';
    }
);

// PATCH route
$app->patch('/patch', function () {
    echo 'This is a PATCH route';
});

// DELETE route
$app->delete(
    '/delete',
    function () {
        echo 'This is a DELETE route';
    }
);
  	
$app->options('/:sistema/:clase_control/:metodo', function ($sistema,$clase_control,$metodo) use ($app) {
	$headers = $app->request->headers;
	
    header('Access-Control-Allow-Origin: ' . $headers['Origin']);
	header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
	header('Access-Control-Allow-Headers: pxp-user, content-type, Php-Auth-User, Php-Auth-Pw');
	header('Access-Control-Allow-Credentials: true');	
	header('Access-Control-Max-Age: 1728000');
	
	
	
});

/**
 * Step 4: Run the Slim application
 *
 * This method should be called last. This executes the Slim application
 * and returns the HTTP response to the HTTP client.
 */
error_reporting(0);
$app->run();

