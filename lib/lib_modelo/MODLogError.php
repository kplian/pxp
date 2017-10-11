<?php
class MODLogError{
	var $categoria;
	var $descripcion;
	var $procedimientos;
	var $ip;
	var $id_usuario;
	var $cone;
	var $peticion;
	
	function __construct($categoria,$descripcion,$procedimientos){
		$this->cone=new conexion();
		$this->ip=getenv("REMOTE_ADDR");
		if(isset($_SESSION["ss_id_usuario"]))
			$this->id_usuario=$_SESSION["ss_id_usuario"];
		else 
			$this->id_usuario='NULL';
		$this->categoria=$categoria;
		$this->descripcion=str_replace("'",'',$descripcion);
		$this->procedimientos=str_replace("'","",$procedimientos);
		
		if($_SESSION["_PETICION"]!=''){
			$_SESSION["_PETICION"]=str_replace("'","",$_SESSION["_PETICION"]);
			$this->peticion="'".$_SESSION["_PETICION"]."'";
		}
		else{
			$this->peticion='NULL';
		}
		
	}
	function guardarLogError(){
		$array=Array();
		$consulta='select * from pxp.f_registrar_log ('.	$this->id_usuario.",'".
												$this->ip."',
												'99:99:99:99:99:99','".
												$this->categoria."','".
												$this->descripcion."','".
												$this->procedimientos."',NULL,".
												$this->peticion.",
												NULL,NULL,NULL,NULL,
												'".session_id()."',".getmypid().",NULL,1)";
		
		
		$link=$this->cone->conectarSegu();
		if($res = pg_query($link,$consulta)){
		 	while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC))
			{
				array_push ($array, $row);
			}
				
			//Libera la memoria
			pg_free_result($res);
		}
		/*echo "prueba".pg_last_error($link);
				exit;*/
	}
}
?>