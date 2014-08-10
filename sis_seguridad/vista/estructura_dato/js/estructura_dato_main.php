<?php 
session_start();
/***
 * Nombre:		estructura_dato_main.php
 * Proposito:	Vista para mostrar formulario de creación de Estrutura
 * Autor:		Kplian
 * Fecha:		03/01/2011
 */
?>
//<script>
Ext.onReady(function(){

	
<?php
	//obtenemos la ruta absoluta
	$host  = $_SERVER['HTTP_HOST'];
	$uri  = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
	$dir = "http://$host$uri/";
	echo "\n var direccion='$dir';";
	echo "\n var idContenedor='".$_GET["idContenedor"]."';";
	?>
	_CP.setPagina(new Phx.vista.estructura_dato({idContenedor:idContenedor}))
	
	
	
	
});