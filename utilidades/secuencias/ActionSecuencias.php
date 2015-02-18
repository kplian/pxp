<?php


echo "ACTUALIZANDO SECUENCIAS <br>";

if(!$base = pg_connect('host='.$_POST['host'].' dbname='.$_POST['bdDestino']." user=".$_POST['usuario']." password='".$_POST['contrasena']."' port=5432"))
{
	echo "NO TIENES PERMISOS PARA HACER ESTO";
	EXIT();
}
$consulta="SELECT relname
			FROM pg_class as c join pg_namespace n on(n.oid = c.relnamespace) 
			WHERE n.nspname like '".$_POST['id_subsistema']."' and c.relkind='r';";


$tablas= ejecutarConsulta($consulta,$base);

foreach($tablas as $data){
	
	$relacion=$data['relname'];
	
	$consulta="SELECT column_name, column_default FROM information_schema.columns WHERE table_name = '$relacion';";
	
	$campos=ejecutarConsulta($consulta,$base);
	
	foreach ($campos as $data1){
		
		$secuencia=obtener_secuencia($data1['column_default']);
		if($secuencia!=""){
			
			$maximo=obtenerMaximo($_POST['id_subsistema'].".$relacion",$data1['column_name'],$base)+1;
			
			$insercion="alter SEQUENCE $secuencia restart with $maximo;";
			
			
			if(pg_query($base,$insercion)){
				echo "SECUENCIA ACTUALIZADA ";
				echo "$relacion,   ,$secuencia,  $maximo ";
				echo "<BR>";
				
			}
			else{
				echo "ERROR SECUENCIA";
				echo "$relacion,   ,$secuencia,  $maximo ";
				echo "<BR>";
			}
			
			
		}
	}
	
}

function obtener_secuencia($cadena){
	
	$res="";
	$ini=0;
	$fin=0;
	
	if(strpos($cadena,'nextval')>-1){
		
		$ini=strpos($cadena,"'");
		$fin=strpos($cadena,"'",$ini+1);
		$res=substr($cadena,$ini+1,$fin-$ini-1);
		
	}
	return $res;
	
}

function obtenerMaximo($tabla,$campo,$b){
		$query = "SELECT max($campo) as maximo
	              FROM $tabla";
		
		if($result = pg_query ($b,$query))
		{
			while ($row = pg_fetch_array ($result))
			{
				$maximo = $row["maximo"];
			}
		}
		else
		{
			$maximo = pg_errormessage($this->dbOrigen); 
		}
		pg_free_result($result);
		
		return $maximo;
	}
function ejecutarConsulta($query,$b){
		$salida_temp = array();
		if($result = pg_query($b,$query))
		{
			
			while ($row = pg_fetch_array($result))
			{
				array_push ($salida_temp, $row);
			}

			
			pg_free_result($result);

			return $salida_temp;
			
		}
		else{
			echo "Error en la consulta";
			return false;
		}
		
	}

?>