<?php
/**
 * *********************************
 * Autor:JRR
 * Clase:conexion
 * Descripcion: Conexion y desconexion de bases de datos postgersql(conexiones persistenes)
 */
class pgConexion implements iConexion {
	
	protected $conexionBD;
	protected $cadena;

	function conectarnp(){
		try {       
    		 $_host='';
    		 $_port='';
    		 $_dbname='';
    		 $_user='';
    		 $_password='';
    		     
    		 if(isset($_SESSION['_HOST'])){
    		      $_host   = $_SESSION['_HOST'];
    		 }
    		 
    		 if(isset($_SESSION['_PUERTO'])){
                  $_port   = $_SESSION['_PUERTO'];
             } 
             
             if(isset($_SESSION['_BASE_DATOS'])){
                   $_dbname= $_SESSION['_BASE_DATOS'];
             } 
             
             if(isset($_SESSION['_BASE_DATOS']) && isset($_SESSION['_LOGIN'])){
                   $_user= $_SESSION['_BASE_DATOS']."_". $_SESSION['_LOGIN'];
             } 
             
             if(isset($_SESSION['_CONTRASENA'])){
                   $_password= $_SESSION['_CONTRASENA'];
             }  
    		    
    		    
    		$this->cadena="host=". $_host." port=".$_port." dbname=".$_dbname." user=".$_user." password=".$_password;
    		//echo 'cadenaQQ:'.$this->cadena;exit;
			
    		if($this->conexionBD = pg_connect($this->cadena)){
    			//echo 'Cnx->';var_dump($this->conexionBD);
				return $this->conexionBD;
			} else {
				$this->conexionBD=0;
				return 0;
			}
	  } 
	  catch (Exception $e){
            //TODO manejo de errores
            //echo 'Error capturado -> '.$e->getMessage();
      }

	}

	function conectarpdo($externo=''){

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
    		
    		$this->cadena="pgsql:host=". $_host.";port=".$_port.";dbname=".$_dbname.";user=".$_user.";password=".$_password;
    		
    		if($this->conexionBD = new PDO($this->cadena))
    		{
    			return $this->conexionBD;
    		}
    		else{
    			$this->conexionBD = 0;
    			return 0;
    		}
		
	  } 
	  catch (Exception $e){
            //TODO manejo de errores
            throw new Exception('Error al conectar a la base de datos los datos por PDO'.$this->cadena);
      }

	}
	
	function desconectarnp(){
		//var_dump(debug_backtrace());
		//jrr
		//var_dump($link);
		$respuesta=pg_close($this->conexionBD);
		return $respuesta;
	}
	
	function conectarp(){
		//pregunta si tenemos una conexion valida
		//$_SESSION["_SESION"]->getConexion();
		$this->cadena="host=".$_SESSION['_HOST']." port=".$_SESSION["_PUERTO"]." dbname=".$_SESSION['_BASE_DATOS']." user=".$_SESSION['_BASE_DATOS']."_". $_SESSION['_LOGIN']." password=".$_SESSION['_CONTRASENA'];
		
		//var_dump(pg_connection_status());
		//exit;
		
		if(pg_connection_status()){
			
		   return	$_SESSION["_SESION"]->getConexion();
			
			
		}
		else
		{
					//si no creamos una nueva
					//echo $this->cadena;
					//exit();
					if($this->conexionBD = pg_pconnect($this->cadena))
					{  $_SESSION["_SESION"]->setConexion($this->conexionBD);
						return $this->conexionBD;
					}
					else{
						$_SESSION["_SESION"]->setConexion(null);
						$this->conexionBD = 0;
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
		$this->cadena="host=".$_SESSION['_HOST']." port=".$_SESSION["_PUERTO"]." dbname=".$_SESSION['_BASE_DATOS']." user=".$_SESSION['_BASE_DATOS']."_".$_SESSION['_USUARIO_CONEXION']." password=".$_SESSION['_CONTRASENA_CONEXION'];
		if($this->conexionBD = pg_connect($this->cadena)){
			return $this->conexionBD;
		} else {
			$this->conexionBD=0;
			return 0;
		}

	}
	
	public function getConexion(){
		return $this->conexionBD;
	}

}

?>
