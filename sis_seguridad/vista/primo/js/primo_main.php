<?php session_start();?>
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

	
	_CP.setPagina(new _primo({idContenedor:idContenedor}))
	
	
	
	
});