<?php
//session_start();
/**
 * *********************************
 * Autor:JRR
 * Clase:conexion
 * Descripcion: Conexion y desconexion de bases de datos postgersql(conexiones persistenes)
 */
class conexion
{


	
	function conectarnp($remote = ''){
		try {       
    		 $_host='';
    		 $_port='';
    		 $_dbname='';
    		 $_user='';
    		 $_password='';
			 
    		 if ($remote != '' && isset($_SESSION['_REMOTE_PXP'][$remote])) {
    		 	$_host   = $_SESSION['_REMOTE_PXP'][$remote]['host'];
    		 }  else {
	    		 if(isset($_SESSION['_HOST'])){
	    		 	$_host   = $_SESSION['_HOST'];
	    		 }
    		 }    		 
    		 
    		 if(isset($_SESSION['_PUERTO'])){
                  $_port   = $_SESSION['_PUERTO'];
             } 
			 
			 if ($remote != '' && isset($_SESSION['_REMOTE_PXP'][$remote])) {
    		 	$_dbname   = $_SESSION['_REMOTE_PXP'][$remote]['db'];
    		 }  else {
	    		 if(isset($_SESSION['_BASE_DATOS'])){
	    		 	$_dbname   = $_SESSION['_BASE_DATOS'];
	    		 }
    		 }             
                          
             if(isset($_SESSION['_BASE_DATOS']) && isset($_SESSION['_LOGIN'])){
                   $_user= $_dbname."_". $_SESSION['_LOGIN'];
             } 
             
             if(isset($_SESSION['_CONTRASENA'])){
                   $_password= $_SESSION['_CONTRASENA'];
             }  
    		    
    		    
    		$cadena="host=". $_host." port=".$_port." dbname=".$_dbname." user=".$_user." password=".$_password;
    
    		if($conexion = pg_connect($cadena))
    		{
    			return $conexion;
    		}
    		else{
    				
    			return 0;
    		}
		
	  } 
	  catch (Exception $e){
            //TODO manejo de errores
            //echo 'Error capturado -> '.$e->getMessage();
      }

	}


	function conectarPDOInformix(){
		
		
		
		#Only needed if INFORMIXDIR is not already set
		
			
		/*$hostname = '172.17.45.7';

		$database = 'ingresos';
		
		$login = 'conexinf';
		
		$password = 'conexinf123';
		
		$informixserver = 'sai1';
		*/
		#Only needed if INFORMIXDIR is not already set
		
		putenv("INFORMIXDIR=/opt/informix");
		$dbh = "informix:host=".$_SESSION['_HOST_INFORMIX'].";service=informixport;database=".$_SESSION['_DATABASE_INFORMIX'].";server=".$_SESSION['_SERVER_INFORMIX']."; protocol=onsoctcp;charset=utf8";
		
		
		
		$conexion = new PDO($dbh,$_SESSION['_USER_INFORMIX'],$_SESSION['_PASS_INFORMIX']);
		
		return $conexion;

		
	}
	//mandar valor "segu" en el segund parametro para que tome la conexion de seguridad con pdo
	function conectarpdo($externo='', $segu= ''){

		if ($externo != '') {
			$ext = "_" . $externo;
		}
		else {
			$ext = "";
		}
		
		try {       
    		 $_host='';
    		 $_port='';
    		 $_dbname='';
    		 $_user='';
    		 $_password='';
    		     
    		 if(isset($_SESSION['_HOST'.$ext])){
    		      $_host   = $_SESSION['_HOST'.$ext];
    		 }
    		 
    		 if(isset($_SESSION['_PUERTO'.$ext])){
                  $_port   = $_SESSION['_PUERTO'.$ext];
             } 
             
             if(isset($_SESSION['_BASE_DATOS'.$ext])){
                   $_dbname= $_SESSION['_BASE_DATOS'.$ext];
             } 
             
             if(isset($_SESSION['_BASE_DATOS'.$ext]) && isset($_SESSION['_LOGIN'])){
                   $_user= $_SESSION['_BASE_DATOS'.$ext]."_". $_SESSION['_LOGIN'];
             } 
             
             if(isset($_SESSION['_CONTRASENA_MD5']) && isset($_SESSION['_SEMILLA'.$ext])){
                   $_password= md5($_SESSION['_SEMILLA'.$ext] . $_SESSION['_CONTRASENA_MD5']);
             } else if(isset($_SESSION['_CONTRASENA'])){
             	$_password= $_SESSION['_CONTRASENA'];
             } 
			 
			 if ($segu = 'segu') {
			 	$_user = $_SESSION['_BASE_DATOS']."_".$_SESSION['_USUARIO_CONEXION'];
				$_password = $_SESSION['_CONTRASENA_CONEXION'];
			 }
    		
    		$cadena="pgsql:host=". $_host.";port=".$_port.";dbname=".$_dbname.";user=".$_user.";password=".$_password;
    		
    		if($conexion = new PDO($cadena))
    		{
    			return $conexion;
    		}
    		else{
    				
    			return 0;
    		}
		
	  } 
	  catch (Exception $e){
            //TODO manejo de errores
            throw new Exception('Error al conectar a la base de datos los datos por PDO'.$cadena);
      }

	}
	
	function desconectarnp($link){
		    
		$respuesta=pg_close($link);
		
		return $respuesta;
	}
	
	
	function conectarp(){
		//pregunta si tenemos una conexion valida
		//$_SESSION["_SESION"]->getConexion();
		$cadena="host=".$_SESSION['_HOST']." port=".$_SESSION["_PUERTO"]." dbname=".$_SESSION['_BASE_DATOS']." user=".$_SESSION['_BASE_DATOS']."_". $_SESSION['_LOGIN']." password=".$_SESSION['_CONTRASENA'];
		
		
		//var_dump(pg_connection_status());
		//exit;
		
		if(pg_connection_status()){
			
		   return	$_SESSION["_SESION"]->getConexion();
			
			
		}
		else
		{
					//si no creamos una nueva
					//echo $cadena;
					//exit();
					if($conexion = pg_pconnect($cadena))
					{  $_SESSION["_SESION"]->setConexion($conexion);
						return $conexion;
					}
					else{
						$_SESSION["_SESION"]->setConexion(null);
						return 0;
					}
		
		
	    }

	}
	
/**
 * *********************************
 * Autor: Rensi Arteaga Copari
 * Clase: conexion
 * Descripcion: Conexion exclusiva para atentificar usuarios y obtener llaves de encriptacion (no persistente)
 */
	
	
	function conectarSegu(){
		    
		$cadena="host=".$_SESSION['_HOST']." port=".$_SESSION["_PUERTO"]." dbname=".$_SESSION['_BASE_DATOS']." user=".$_SESSION['_BASE_DATOS']."_".$_SESSION['_USUARIO_CONEXION']." password=".$_SESSION['_CONTRASENA_CONEXION'];
		
		//echo $cadena;exit;
		if($conexion = pg_connect($cadena))
		{
			return $conexion;
		}
		else{
				
			return 0;
		}

	}



}




?>
