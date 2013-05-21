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
$param = new CTParametro();

//Se desofusca el identificador si fuera necesario
if($_SESSION["_OFUSCAR_ID"] == 'si') {
	
	$id_desofuscado = $param->desofuscar($_GET['id']);
	
} else {
	$id_desofuscado = $_GET['id'];
}

//Se arma la url del archivo
$ruta_archivo = dirname(__FILE__) . "/../../../uploaded_files/" . $_GET['sistema'] . "/" . $_GET['clase'] . "/";

if (isset($_GET['folder']) && $_GET['folder'] != "") {
	$ruta_archivo .= $_GET['folder'] . "/";
}
//abre el archivo si existe
if (file_exists( $ruta_archivo . md5($id_desofuscado . $_SESSION["_SEMILLA"]) . "." . $_GET['extension'])){
	if ($_GET['extension'] == 'pdf') {
		header('Content-type: application/pdf');
		readfile($ruta_archivo . md5($id_desofuscado . $_SESSION["_SEMILLA"]) . "." . $_GET['extension']);
	} else {
		header('Content-Disposition: attachment; filename="downloaded.' . $_GET['extension']);
		readfile($ruta_archivo . md5($id_desofuscado . $_SESSION["_SEMILLA"]) . "." . $_GET['extension']);
	}
	
} else {
	echo "No existe el fichero solicitado";
	exit;
}
?>