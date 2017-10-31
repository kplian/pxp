<?php
include_once(dirname(__FILE__)."/../lib/lib_control/CTSesion.php");

include_once(dirname(__FILE__).'/../lib/DatosGenerales.php');
include_once(dirname(__FILE__).'/../lib/lib_general/Errores.php');
include_once(dirname(__FILE__).'/../lib/lib_control/CTincludes.php');



class act {

    function iniciarSession(){

        $_SESSION["_SESION"]= new CTSesion();
        $_SESSION["_tipo_aute"] = 'REST';
        
        //creamos array de request
        $reqArray = array();

        $reqArray['usuario'] ='admin';
        $reqArray['contrasena'] ='202cb962ac59075b964b07152d234b70';
        $reqArray['_tipo'] ='restAuten';


        //autentificar usuario en sistema
        //arma $JSON
        $JSON = json_encode($reqArray);
        echo $JSON;
        $objParam = new CTParametro($JSON,null,null,'../../sis_seguridad/control/Auten/verificarCredenciales');
        include_once dirname(__FILE__).'/../../sis_seguridad/control/ACTAuten.php';
        //Instancia la clase dinamica para ejecutar la accion requerida

        $cad = new ACTAuten($objParam);
        $res = $cad->verificarCredenciales();
        return $res;
    }
    function persona(){


        $_SESSION["_OFUSCAR_ID"]='no';
//estable aprametros ce la cookie de sesion
        $_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control cantidad de error anidados
        if($_SESSION["_FORSSL"]=='SI'){
            session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,true ,false);
        }
        else{
            session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,false ,false);
        }

        //session_start();
        $objParam = new CTParametro('{"start":"0","limit":"100","sort":"id_persona","dir":"ASC"}',null,null,'../../sis_seguridad/control/Persona/listarPersonaFoto');
        include_once dirname(__FILE__).'/../../sis_seguridad/modelo/MODPersona.php';
        $objFunSeguridad = new MODPersona($objParam);
        $res = $objFunSeguridad->listarPersonaFoto($objParam);
        return $res;

    }

    function accion($parametros,$sistema,$control,$metodo){
        //session_start();
        $_SESSION["_OFUSCAR_ID"]='no';
//estable aprametros ce la cookie de sesion
        $_SESSION["_CANTIDAD_ERRORES"]=0;//inicia control cantidad de error anidados
        if($_SESSION["_FORSSL"]=='SI'){
            session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,true ,false);
        }
        else{
            session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,false ,false);
        }


        $modelo = 'MOD'.$control.'.php';
        $objParam = new CTParametro($parametros,null,null,'../../sis_'.$sistema.'/control/'.$control.'/'.$metodo.'');
        include_once dirname(__FILE__).'/../../sis_'.$sistema.'/modelo/'.$modelo.'';

        //Instancia la clase dinamica para ejecutar la accion requerida
        eval('$objFunSeguridad = new MOD'.$control.'($objParam);');

        eval('$res = $objFunSeguridad->'.$metodo.'();');

        return $res;


    }
}

/*$act = new act();
$persona = $act->accion('{"start":"0","limit":"2","sort":"id_usuario","dir":"ASC"}','seguridad','Usuario','listarUsuario');
var_dump($persona->getDatos());*/



/*$act = new act();
$se = $act->iniciarSession();
var_dump($act);
var_dump($_SESSION);*/
//var_dump($se);