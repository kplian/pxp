<?php
/**
**********************************************************
Nombre de archivo:      CTOpenFile.php
Propósito:              Abre un archivo guardado 
Tabla:                  cualquier tabla
Parámetros:             $id
 						$sistema
						$clase
 						$folder
 						$extension
                        

Valores de Retorno:     Abre el archivo guardado
Fecha de Creación:      2013-05-08 17:32:13
Versión:                1.0.0
Autor:                  Jaime Rivera Rojas
**********************************************************
*/
//se incluye la clase de ofuscacion
include_once(dirname(__FILE__) . "/CTParametro.php");
include_once(dirname(__FILE__) . "/CTSesion.php");
include_once(dirname(__FILE__)."/../cifrado/feistel.php");
//se inicia sesion
session_start();

if(isset($_SESSION["_SESION"])){	
	if($_SESSION["_SESION"]->getEstado() == 'inactiva' || $_SESSION["_SESION"]->getEstado() == 'preparada'){
		echo "Debe iniciar sesión en el sistema";
		exit;
	}
} else {
	echo "Debe iniciar sesión en el sistema";
	exit;
}

//Se instancia la clase parametro
$param = new CTParametro(null, null, null, null);

//Se desofusca el identificador si fuera necesario
if($_SESSION["_OFUSCAR_ID"] == 'si') {
	
	$id_desofuscado = $param->desofuscar($_GET['id']);
	
} else {
	$id_desofuscado = $_GET['id'];
}


//Se arma la url del archivo

if(isset($_GET['url']) && $_GET['url']!=''){
        
    $ruta_archivo = dirname(__FILE__) . "/".$_GET['url'];

}
else{
    $ruta_archivo = dirname(__FILE__) . "/../../../uploaded_files/" . $_GET['sistema'] . "/" . $_GET['clase'] . "/";
    
    if (isset($_GET['folder']) && $_GET['folder'] != "") {
       $ruta_archivo .= $_GET['folder'] . "/";
    }
    
    $ruta_archivo=$ruta_archivo. md5($id_desofuscado . $_SESSION["_SEMILLA"]) . "." . $_GET['extension'];
}


//abre el archivo si existe
if (file_exists($ruta_archivo)){
	if (strtolower($_GET['extension']) == 'pdf') {
		header('Content-type: application/pdf');
		readfile($ruta_archivo);
	} 
	
    elseif (strtolower($_GET['extension']) == 'csv') {
    	
		header('Pragma: public');
		header('Expires: 0');
		header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
		header('Content-Description: File Transfer');
		header('Content-Type: text/csv');
		header('Content-Disposition: attachment; filename="downloaded.' . $_GET['extension']);
		header('Content-Transfer-Encoding: binary'); 
		readfile($ruta_archivo);
	
    }
	
	else {
		header('Content-Description: File Transfer');
		header('Content-Type: application/octet-stream');
		header('Content-Disposition: attachment; filename="downloaded.' . $_GET['extension']);
		header('Content-Transfer-Encoding: binary');
		header('Connection: Keep-Alive');
		header('Expires: 0');
		header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
		header('Pragma: public');
		readfile($ruta_archivo);
	}
	
} else {
	echo "No existe el fichero solicitado ".$ruta_archivo;
	exit;
}
?>
