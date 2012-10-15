<?php
	//session_start();
	include_once("Mensaje.php");
	
	function exception_handler($exception){
		$_SESSION["_CANTIDAD_ERRORES"]++;
		$mensaje=$exception->getMessage();
		if($_SESSION['_CANTIDAD_ERRORES']<4){
			if(strpos($mensaje,'sesion'))
				$categoria='SESION';	
			else if(strpos($mensaje,'validacion de caracteres'))
				$categoria='INYECCION';
			else
				$categoria='ERROR_CONTROLADO_PHP';
				
			if(!isset($_SESSION['cantidad_errores'])){
				
			  $_SESSION['cantidad_errores']=0;
			}	
		    if($_SESSION['cantidad_errores']<3){
				$bdlog=new MODLogError($categoria,$exception->getMessage(),'Archivo: '.$exception->getFile().
										' Linea: '.$exception->getLine().'.  Traza de errores: '.$exception->getTraceAsString());
				$bdlog->guardarLogError();
			}
			
			
			$men=new Mensaje();
			
			
					
			$mensaje=htmlentities($mensaje);
			$men->setMensaje('ERROR',$exception->getFile().' Linea: '.$exception->getLine(),$mensaje,
			'Traza de errores: '.$exception->getTraceAsString().'<BR> Codigo de error:'.$exception->getCode(),
			'control','','','OTRO','');
						
			$men->imprimirRespuesta($men->generarJson());
			exit;
			
		}
		else{
			header("HTTP/1.1 406 Not Acceptable");
			echo '{"ROOT":{"error":true,"detalle":{
					"mensaje":"Error en el servidor Web probable falta de conexión al Servidor de Base de Datos (Comuniquese con el Administrador)",
					"mensaje_tec":"'.$mensaje.'",
					"origen":"Errores.php",
					"capa":"control",
					"consulta":""}}}';
			exit;
		}
		 
		
	}
	function error_handler($errno, $errstr,$errfile ,$errline){
			
		if(
		($errno=='8' || $errno=='2048' || strpos($errstr,'Query failed')>0) ||
		(($errno=='8' || $errno=='2048' )&& strpos($errstr,'Query failed')>0)
		
		
		){
		//if($errno=='8' || $errno=='2048' || strpos($errstr,'Query failed')>0){
		//RAC, JRR	 31102011 
		//if(($errno=='8' || $errno=='2048' )&& strpos($errstr,'Query failed')>0){
		
			return;
		}
		$_SESSION["_CANTIDAD_ERRORES"]++;
		if($_SESSION['_CANTIDAD_ERRORES']<4){
			if($_SESSION['_CANTIDAD_ERRORES']<3){
				$bdlog=new MODLogError('ERROR_WEB',$errstr,$errfile.' Linea: '.$errline);
				$bdlog->guardarLogError();
				
			}
			$men=new Mensaje();
			
			if($_SESSION["_ESTADO_SISTEMA"]=='desarrollo')
				$mensaje=$errstr;
						
			else 
				$mensaje='Ha ocurrido un error en el servidor Web, consulte con el administrador';
			$mensaje=htmlentities($mensaje);
			$men->setMensaje('ERROR',$errfile.' Linea: '.$errline,$mensaje,
			'Codigo de error:'.$errno,
			'control','','','OTRO','');
			//rac 21092011 					
			$men->imprimirRespuesta($men->generarJson());
			exit;
		}
		else{
			header("HTTP/1.1 406 Not Acceptable");
			echo '{"ROOT":{"error":true,"detalle":{
					"mensaje":"Error en el servidor Web probable falta de conexión al Servidor de Base de Datos (Comuniquese con el Administrador)",
					"mensaje_tec":"'.$mensaje.'",
					"origen":"Errores.php",
					"capa":"control",
					"consulta":""}}}';
			exit;
			
		}
		
	}
	
	function fatalErrorShutdownHandler()
	{
		$last_error = error_get_last();
		if ($last_error['type'] === E_ERROR || $last_error['type'] === E_PARSE) {
				
			error_handler(E_ERROR, $last_error['message'], $last_error['file'], $last_error['line']);
		}
	}

?>