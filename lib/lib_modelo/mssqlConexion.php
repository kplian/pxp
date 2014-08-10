<?php
/**
 * *********************************
 * Autor: RCM
 * Clase:  mssqlConexion
 * Descripcion: Conexion y desconexion de bases de datos Microsotf Sql Server
 */
class mssqlConexion implements iConexion {
	
	protected $conexionBD;
	protected $cadena;

	function conectarnp(){
		try {       
    		 $_host='';
    		 $_port='';
    		 $_dbname='';
    		 $_user='';
    		 $_password='';
    		     
    		 if(isset($_SESSION['_HOST_MSSQL'])){
    		      $_host   = $_SESSION['_HOST_MSSQL'];
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
    		    
    		//Definición de cadena de conexión
    					
    		//if($this->conexionBD = pg_connect($this->cadena)){
    		if($this->conexionBD = mssql_connect($_host, 'edson.machicado', 'MicoChusko1')){
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

	}
	
	function desconectarnp(){
		$respuesta=mssql_close($this->conexionBD);
		return $respuesta;
	}
	
	function conectarp(){

	}
	

	function conectarSegu(){

	}
	
	public function getConexion(){
		return $this->conexionBD;
	}

}

?>
