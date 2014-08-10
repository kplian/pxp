<?php
	
	$archivo = '../../../sis_seguridad/modelo/MODFuncion.php';
	$archivoN = '../../../sis_seguridad/modelo/MODFuncionN.php';
	$arrProcedimiento = array();
	$arrTransaccion = array();
	$arrTipoProcedimiento = array();
	$arrTipoConexion = array();
	$arrCount = array();
	$arrRespuesta = array();

	$arrProcedimiento[0]="this->procedimiento=";
	$arrProcedimiento[1]="this->procedimiento =";
	$arrProcedimiento[2]="this->procedimiento  =";
	$arrProcedimiento[3]="this->procedimiento   =";
	
	$arrTransaccion[0]="this->transaccion=";
	$arrTransaccion[1]="this->transaccion =";
	$arrTransaccion[2]="this->transaccion  =";
	$arrTransaccion[3]="this->transaccion   =";
	
	$arrTipoProcedimiento[0]="this->tipo_procedimiento=";
	$arrTipoProcedimiento[1]="this->tipo_procedimiento =";
	$arrTipoProcedimiento[2]="this->tipo_procedimiento  =";
	$arrTipoProcedimiento[3]="this->tipo_procedimiento   =";
	
	$arrTipoConexion[0]="this->tipo_conexion=";
	$arrTipoConexion[1]="this->tipo_conexion =";
	$arrTipoConexion[2]="this->tipo_conexion  =";
	$arrTipoConexion[3]="this->tipo_conexion   =";
	
	$arrCount[0]="this->count=";
	$arrCount[1]="this->count =";
	$arrCount[2]="this->count  =";
	$arrCount[3]="this->count   =";
	
	$arrRespuesta[0]="this->respuesta;";
	$arrRespuesta[1]="this->respuesta ;";
	$arrRespuesta[2]="this->respuesta  ;";
	$arrRespuesta[3]="this->respuesta   ;";

	$file = fopen($archivo,'r') or die ('Error al abrir archivo');
	$fileN = fopen($archivoN,'w') or die ('Error al abrir archivo nuevo');
	echo 'Archivo abierto<br>';
	
	while(!feof($file)) {
		$linea = fgets($file);
		//1 Procedimiento
		$i=0;
		while($i<=count($arrProcedimiento)){
			$find=strpos($linea,$arrProcedimiento[$i]);
			if($find===false){
			} else{
				//echo strripos($linea,"'").'<br>';
				$linea = str_replace($arrProcedimiento[$i],'this->setProcedimiento(',$linea);
				$linea = str_replace(';',');',$linea);
			}
			$i++;
		}
		//2 Transacci�n
		$i=0;
		while($i<=count($arrTransaccion)){
			$find=strpos($linea,$arrTransaccion[$i]);
			if($find===false){
			} else{
				//echo strripos($linea,"'").'<br>';
				$linea = str_replace($arrTransaccion[$i],'this->setTransaccion(',$linea);
				$linea = str_replace(';',');',$linea);
			}
			$i++;
		}
		//3 Tipo procedimiento
		$i=0;
		while($i<=count($arrTipoProcedimiento)){
			$find=strpos($linea,$arrTipoProcedimiento[$i]);
			if($find===false){
			} else{
				//echo strripos($linea,"'").'<br>';
				$linea = str_replace($arrTipoProcedimiento[$i],'this->setTipoProcedimiento(',$linea);
				$linea = str_replace(';',');',$linea);
			}
			$i++;
		}
		//4 Tipo conexi�n
		$i=0;
		while($i<=count($arrTipoConexion)){
			$find=strpos($linea,$arrTipoConexion[$i]);
			if($find===false){
			} else{
				//echo strripos($linea,"'").'<br>';
				$linea = str_replace($arrTipoConexion[$i],'this->setTipoConexion(',$linea);
				$linea = str_replace(';',');',$linea);
			}
			$i++;
		}
		//5 Count
		$i=0;
		while($i<=count($arrCount)){
			$find=strpos($linea,$arrCount[$i]);
			if($find===false){
			} else{
				//echo strripos($linea,"'").'<br>';
				$linea = str_replace($arrCount[$i],'this->setCount(',$linea);
				$linea = str_replace(';',');',$linea);
			} 
			$i++;
		}
		//6 Respuesta
		$i=0;
		while($i<=count($arrRespuesta)){
			$find=strpos($linea,$arrRespuesta[$i]);
			if($find===false){
			} else{
				//echo strripos($linea,"'").'<br>';
				$linea = str_replace($arrRespuesta[$i],'this->getRespuesta();',$linea);
			}
			$i++;
		}
		echo $linea.'<br>';
		//Escribe la l�nea en el nuevo archivo
		fwrite($fileN,$linea);
	}
	
	fclose($file);
	fclose($fileN);
	echo ' + Archivo creado!'.'<br />';

?>