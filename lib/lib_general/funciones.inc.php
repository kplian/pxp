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

function num2letrasCheque($num, $fem = false, $dec = true) { 
//if (strlen($num) > 14) die("El n?mero introducido es demasiado grande"); 
   $matuni[2]  = "DOS"; 
   $matuni[3]  = "TRES"; 
   $matuni[4]  = "CUATRO"; 
   $matuni[5]  = "CINCO"; 
   $matuni[6]  = "SEIS"; 
   $matuni[7]  = "SIETE"; 
   $matuni[8]  = "OCHO"; 
   $matuni[9]  = "NUEVE"; 
   $matuni[10] = "DIEZ"; 
   $matuni[11] = "ONCE"; 
   $matuni[12] = "DOCE"; 
   $matuni[13] = "TRECE"; 
   $matuni[14] = "CATORCE"; 
   $matuni[15] = "QUINCE"; 
   $matuni[16] = "DIECISEIS"; 
   $matuni[17] = "DIECISIETE"; 
   $matuni[18] = "DIECIOCHO"; 
   $matuni[19] = "DIECINUEVE"; 
   $matuni[20] = "VEINTE"; 
   $matunisub[2] = "DOS"; 
   $matunisub[3] = "TRES"; 
   $matunisub[4] = "CUATRO"; 
   $matunisub[5] = "QUIN"; 
   $matunisub[6] = "SEIS"; 
   $matunisub[7] = "SETE"; 
   $matunisub[8] = "OCHO"; 
   $matunisub[9] = "NOVE"; 

   $matdec[2] = "VEINT"; 
   $matdec[3] = "TREINTA"; 
   $matdec[4] = "CUARENTA"; 
   $matdec[5] = "CINCUENTA"; 
   $matdec[6] = "SESENTA"; 
   $matdec[7] = "SETENTA"; 
   $matdec[8] = "OCHENTA"; 
   $matdec[9] = "NOVENTA"; 
   $matsub[3]  = 'MILL'; 
   $matsub[5]  = 'BILL'; 
   $matsub[7]  = 'MILL'; 
   $matsub[9]  = 'TRILL'; 
   $matsub[11] = 'MILL'; 
   $matsub[13] = 'BILL'; 
   $matsub[15] = 'MILL'; 
   $matmil[4]  = 'MILLONES'; 
   $matmil[6]  = 'BILLONES'; 
   $matmil[7]  = 'DE BILLONES'; 
   $matmil[8]  = 'MILLONES DE BILLONES'; 
   $matmil[10] = 'TRILLONES'; 
   $matmil[11] = 'DE TRILLONES'; 
   $matmil[12] = 'MILLONES DE TRILLONES'; 
   $matmil[13] = 'DE TRILLONES'; 
   $matmil[14] = 'BILLONES DE TRILLONES'; 
   $matmil[15] = 'DE BILLONES DE TRILLONES'; 
   $matmil[16] = 'MILLONES DE BILLONES DE TRILLONES'; 
   $num=number_format($num,2,'.', '');

   $num = trim((string)@$num); 
   
   if ($num[0] == '-') { 
      $neg = 'menos '; 
      $num = substr($num, 1); 
   }else 
      $neg = ''; 
   
   while ($num[0] == '0') $num = substr($num, 1); 
   if ($num[0] < '1' or $num[0] > 9) $num = '0' . $num; 
   $zeros = true; 
   $punt = false; 
   $ent = ''; 
   $fra = ''; 
     
  for ($c = 0; $c < strlen($num); $c++) { 
   	  
      $n = $num[$c]; 
      if (! (strpos(".,'''", $n) === false)) { 
         if ($punt) break; 
         else{ 
            $punt = true; 
            continue; 
         } 

      }elseif (! (strpos('0123456789', $n) === false)) { 
         if ($punt) { 
           if ($n != '0')$zeros = false; 
                  
            $fra =$fra.$n; 
         }else 

            $ent .= $n; 
      }else 

        break; 

   } 
    
   $ent = '     ' . $ent; 
   /// esto cambiare****************************************
   /** le quite para que muestre los ceros 
    * 
    * */
  
   if ($dec and $fra ) { 
      $fin = ' '.$fra;  //,
   }else 
      $fin = ''; 
  
   if ((int)$ent === 0) return 'CERO ' . $fin; 
   $tex = ''; 
   $sub = 0; 
   $mils = 0; 
   $neutro = false; 
   while ( ($num = substr($ent, -3)) != '   ') { 
      $ent = substr($ent, 0, -3); 
      if (++$sub < 3 and $fem) { 
         $matuni[1] = 'UNA'; //UNA
         $subcent = 'AS'; //AS
      }else{ 
         $matuni[1] = $neutro ? 'UN' : 'UNO'; 
         $subcent = 'OS'; 
      } 
      $t = ''; 
      $n2 = substr($num, 1); 
      if ($n2 == '00') { 
      }elseif ($n2 < 21) 
         $t = ' ' . $matuni[(int)$n2]; 
      elseif ($n2 < 30) { 
         $n3 = $num[2]; 
         if ($n3 != 0) $t = 'I' . $matuni[$n3]; 
         $n2 = $num[1]; 
         $t = ' ' . $matdec[$n2] . $t; 
      }else{ 
         $n3 = $num[2]; 
         if ($n3 != 0) $t = ' Y ' . $matuni[$n3]; 
         $n2 = $num[1]; 
         $t = ' ' . $matdec[$n2] . $t; 
      } 
      $n = $num[0]; 
      if ($n == 1) { 
	       if ($num[1]==0 && $num[2]==0){
		 
              $t = ' CIEN' . $t; 
      
		   }else{
	         $t = ' CIENTO' . $t; 
    	   }
	  
	  
	  
	  
	  }elseif ($n == 5){ 
         $t = ' ' . $matunisub[$n] . 'IENT' . $subcent . $t; 
      }elseif ($n != 0){ 
         $t = ' ' . $matunisub[$n] . 'CIENT' . $subcent . $t; 
      } 
      if ($sub == 1) { 
      }elseif (! isset($matsub[$sub])) { 
         if ($num == 1) { 
            $t = ' UN MIL';  //MIL
         }elseif ($num > 1){ 
            $t .= ' MIL'; 
         } 
      }elseif ($num == 1) { 
         $t .= ' ' . $matsub[$sub] . 'ÓN'; 
      }elseif ($num > 1){ 
         $t .= ' ' . $matsub[$sub] . 'ONES'; 
      }   
      if ($num == '000') $mils ++; 
      elseif ($mils != 0) { 
         if (isset($matmil[$sub])) $t .= ' ' . $matmil[$sub]; 
         $mils = 0; 
      } 
      $neutro = true; 
      $tex = $t . $tex; 
   } 
   $tex = $neg . substr($tex, 1) . $fin .'/100 '; 
   return ucfirst($tex); 
}

}?>