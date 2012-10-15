<?php
class funciones
{
	
/*
**********************************************************
Nombre de la funci�n:	copiar_archivo_servidor($archivo_temporal,$carpeta_destino)
Prop�sito:				Se utiliza esta funci�n para copiar 
						srchivos al servidor
Par�metros:				$archivo_temporal	-->	Aqu� se almacena el nombre del archivo temporal
						$carpeta_destino  --> Aqu� se guarda el nombre de la carpeta destino
Valores de Retorno:		$nombre_archivo 	-->	Retorna el nombre del archivo	
						-1	--> Indica que se produjo un error y no se pudo subir el archivo al servidor 
**********************************************************
*/

function carga_archivo ( $archivo, $directorio_destino )
{
	// Revisa si el archivo es de mas de 5 megabytes.
	if ( $archivo['size'] < 5512000 )
	{
		$nombre_archivo = basename ( $archivo['name'] ) ;
	    $nombre_archivo = $this -> limpiar($nombre_archivo);
		
		$archivo_destino = $directorio_destino . $nombre_archivo;

		if ( move_uploaded_file ($archivo['tmp_name'], $archivo_destino) )
		{
		    //""move_uploaded_file"" funcion que no funciona en este servidor
		    rename($archivo_destino,$directorio_destino."fv_lec_proce.txt" );
			return $nombre_archivo;
			chmod($directorio_destino."fv_lec_proce.txt",0777);
		}
		else
		{
			return -1 ;
		}
	}
	else
	{
		return -2 ;
	}
}

function limpiar ($archivo)
{
	$ruta = pathinfo($archivo);
	$nombre_completo = $ruta["basename"];
	$extension = $ruta["extension"];

	if ( isset($extension) && !empty($extension)) 
	{
		$extension = "." . $extension;

		// obtener la posicion de la extension
		$position = strpos($nombre_completo, $extension);

		// sacar el nombre del archivo sin extension
		$nombre_sin_extension = substr($archivo, 0, $position);
	}
	else
	{
		$nombre_sin_extension = $nombre_completo;
	}
   $len = strlen($nombre_sin_extension);
   $cadena = '';
   
   for($i = 0; $i < $len; $i++)
   {    $str = substr($nombre_sin_extension,$i,1);
   		if($str!=' ' && $str!='�' && $str!='�' && $str!='�' && $str!='�' && $str!='�' && $str!='�'&& $str!='�' && $str!='�' && $str!='�' && $str!='�' && $str!='�')
   		{
   			$cadena = $cadena.$str;
   		}
   		
   }
   

	return $cadena.$extension;
}


///////////////////////////////////////////////////////////////////////////////////////////
//	Funciones Veimar (Fin)
///////////////////////////////////////////////////////////////////////////////////////////


/*
**********************************************************
Nombre de la funci�n:	renombrar ( $archivo,$carpeta_archivo )
Prop�sito:				Se utiliza esta funci�n para copiar 
						srchivos al servidor
Par�metros:				$archivo	-->	Aqu� se almacena el nombre del archivo ha ser cambiado
						$carpeta_archivo  --> Aqu� se guarda el nombre de la carpeta destino
Valores de Retorno:		$nuevo_nombre	-->	El nuevo nombre del archivo	 
Observaci�n:			-----
Fecha de Creaci�n:		16 - 05 - 05
Versi�n:				1.0.0
**********************************************************
*/
function renombra_archivo ( $archivo, $carpeta_archivo )
{
	$ruta = pathinfo($archivo);
	$nombre_completo = $ruta["basename"];
	$extension = $ruta["extension"];

	if ( isset($extension) && !empty($extension)) 
	{
		$extension = "." . $extension;

		// obtener la posicion de la extension
		$position = strpos($nombre_completo, $extension);

		// sacar el nombre del archivo sin extension
		$nombre_sin_extension = substr($archivo, 0, $position);
	}
	else
	{
		$nombre_sin_extension = $nombre_completo;
	}

	$n = 0;
	$copia = "";

	while ( file_exists ( $carpeta_archivo . $nombre_sin_extension . $copia . $extension) )
	{
		if ($n<=9)
			$n = "00" . $n;
			
		if ($n<=99 && $n>=10)
			$n = "0" . $n;

		if ($n<=999 && $n>=100)
			$n = "" . $n;

		$copia = "_" . $n;
		$n++;
	}

	return $nombre_sin_extension . $copia . $extension;
}
   function PreguntaExtencion($archivo)
   {
   	$ext = '';
   	
   	$vari= explode(".",$archivo) ;
    $ext = $vari[1]; 
   	return $ext;
   }
   
   function eliminarespeciales($variable)
	{
		$res=str_replace("\'","'",$variable);
		return $res;
		
	}
	
	/*///////////////////////////////////////////////////
//Convierte fecha de mysql a normal
////////////////////////////////////////////////////*/
/*///////////////////////////////////////////////////
//Convierte fecha de postgre a normal
////////////////////////////////////////////////////*/
function fecha_normal($fecha){
    ereg( "([0-9]{1,2})-([0-9]{1,2})-([0-9]{2,4})", $fecha, $mifecha);
    $lafecha=$mifecha[2]."/".$mifecha[1]."/".$mifecha[3];
    if ($lafecha=="//" || $lafecha=="00/00/0000")
    {
    	$lafecha="";
    }    
    return $lafecha;    
}

function fecha_normal2($fecha){
    
	echo $fecha;
    /*
    
    //ereg( "([0-9]{2,4})-([0-9]{1,2})-([0-9]{1,2})", $fecha, $mifecha);
        
    preg_match("/([0-9]{2,4})-([0-9]{1,2})-([0-9]{1,2})/", $fecha, $mifecha);
    		
    $lafecha=$mifecha[3]."/".$mifecha[2]."/".$mifecha[1];
    if ($lafecha=="//" || $lafecha=="00/00/0000")
    {
    	$lafecha="";
    }    
	*/
    //return $fecha;		    
}


////////////////////////////////////////////////////
//Convierte fecha de normal a mysql
////////////////////////////////////////////////////

function fecha_mysql($fecha){
    ereg( "([0-9]{1,2})/([0-9]{1,2})/([0-9]{2,4})", $fecha, $mifecha);
    $lafecha=$mifecha[3]."-".$mifecha[2]."-".$mifecha[1];
    return $lafecha;
} 
function fecha_pgsql($fecha){
    ereg( "([0-9]{1,2})/([0-9]{1,2})/([0-9]{2,4})", $fecha, $mifecha);
    $lafecha=$mifecha[3]."-".$mifecha[2]."-".$mifecha[1];
    return $lafecha;
}
function fecha_jpgraph($fecha){
	
	setlocale(LC_TIME, 'es_ES');
	//setlocale(LC_TIME, 'es_MX');
	
	return strftime('%d de %B del %Y',strtotime($fecha));
}

/*
 * MFLORES: Funciones que suman y restan fechas actualizadas 08-02-2012
 */

/**Suma la cantidad e dias a una fecha
 * *******************************************
 *
 * @param fecha $fecha
 * @param entero $ndias
 * @return fecha sumada
 */

function suma_fechas($fecha,$ndias)	
{
	$fecha1 = explode('-',$dFecIni);
	$fecha2 = explode('-',$dFecFin);
	
	//defino fecha 1 
	$ano1 = $fecha1[0]; 
	$mes1 = $fecha1[1]; 
	$dia1 = $fecha1[2]; 
		
	//defino fecha 2 
	$ano2 = $fecha2[0]; 
	$mes2 = $fecha2[1]; 
	$dia2 = $fecha2[2]; 
		
	//calculo timestam de las dos fechas 
	$timestamp1 = mktime(0,0,0,$mes1,$dia1,$ano1); 
	$timestamp2 = mktime(4,12,0,$mes2,$dia2,$ano2); 
	
	//resto a una fecha la otra 
	$segundos_diferencia = $timestamp1 + $timestamp2; 
	//echo $segundos_diferencia; 
	
	//convierto segundos en d�as 
	$dias_diferencia = $segundos_diferencia / (60 * 60 * 24); 
	
	//obtengo el valor absoulto de los d�as (quito el posible signo negativo) 
	$dias_diferencia = abs($dias_diferencia); 
	
	//quito los decimales a los d�as de diferencia 
	$dias_diferencia = floor($dias_diferencia); 
	
	return (string)$dias_diferencia;	      
}

/**Resta dos fechas
 * **********************************************
 *
 * @param fecha inicio $dFecIni
 * @param fecha fin $dFecFin
 * @return nro de dias
 */

function restaFechas($dFecIni, $dFecFin)
{	
	$fecha1 = explode('-',$dFecIni);
	$fecha2 = explode('-',$dFecFin);
	
	//defino fecha 1 
	$ano1 = $fecha1[0]; 
	$mes1 = $fecha1[1]; 
	$dia1 = $fecha1[2]; 
		
	//defino fecha 2 
	$ano2 = $fecha2[0]; 
	$mes2 = $fecha2[1]; 
	$dia2 = $fecha2[2]; 
		
	//calculo timestam de las dos fechas 
	$timestamp1 = mktime(0,0,0,$mes1,$dia1,$ano1); 
	$timestamp2 = mktime(4,12,0,$mes2,$dia2,$ano2); 
	
	//resto a una fecha la otra 
	$segundos_diferencia = $timestamp1 - $timestamp2; 
	//echo $segundos_diferencia; 
	
	//convierto segundos en d�as 
	$dias_diferencia = $segundos_diferencia / (60 * 60 * 24); 
	
	//obtengo el valor absoulto de los d�as (quito el posible signo negativo) 
	$dias_diferencia = abs($dias_diferencia); 
	
	//quito los decimales a los d�as de diferencia 
	$dias_diferencia = floor($dias_diferencia); 
	//$dias_diferencia = $dias_diferencia + 1;
	return (string)$dias_diferencia;		
}


// obtiene porcentajes
function porcentaje($total, $parte, $redondear = 1) 
{
    return round($parte / $total * 100, $redondear);
}

}?>