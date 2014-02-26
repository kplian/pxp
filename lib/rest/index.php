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
    'log.level' => \Slim\Log::EMERGENCY,
    'debug' => true
));

$app->log->setEnabled(false);

$app->response->headers->set('Content-Type', 'application/json');
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
        
        include_once dirname(__FILE__).'/../sis_seguridad/control/ACTPersona.php';
        
       
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
        
        // $objParam = new CTParametro('{}');
        $objParam = new CTParametro('{"start":"'.$start.'","limit":"'.$limit.'","sort":"id_persona","dir":"ASC"}',null,null,'../../sis_seguridad/control/Persona/listarPersonaFoto');
        
        include_once dirname(__FILE__).'/../sis_seguridad/control/ACTPersona.php';
        
       
        $cad = new ACTPersona($objParam);
        $cad->listarPersona();
        
        
        
            
    }
); 



$app->get(
	 
    '/api/:sistema/:clase_control/:metodo(/:start(/:limit))',
    function ($sistema,$clase_control,$metodo,$start=0,$limit=10000)  {
    	        
        //TODO validar cadenas vaias y retorna error en forma JSON
        $ruta_include = 'sis_'.$sistema.'/control/ACT'.$clase_control.'.php';
        $ruta_url = 'sis_'+$sistema.'/control/'.$clase_control.'/'.$metodo;
        
        //TODO verificar sesion
        //throw new Exception('La sesion ha sido duplicada',2);
        
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
        
        //arma $JSON
        $JSON = json_encode($aPostData);
        
        $objParam = new CTParametro($JSON,null,null,'../../'.$ruta_url);
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

/**
 * Step 4: Run the Slim application
 *
 * This method should be called last. This executes the Slim application
 * and returns the HTTP response to the HTTP client.
 */
$app->run();
