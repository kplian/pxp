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


	
	function conectarnp(){
		$cadena="host=".$_SESSION['_HOST']." port=".$_SESSION["_PUERTO"]." dbname=".$_SESSION['_BASE_DATOS']." user=".$_SESSION['_BASE_DATOS']."_". $_SESSION['_LOGIN']." password=".$_SESSION['_CONTRASENA'];

		if($conexion = pg_connect($cadena))
		{
			return $conexion;
		}
		else{
				
			return 0;
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
