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
		
	idContenedorPadre='<?php echo $idContenedorPadre;?>';
	
	var maestro;
	_CP.setPagina(new Phx.vista.usuario_regional({idContenedor:idContenedor,idContenedorPadre:idContenedorPadre,maestro:maestro}))
	
	
	
});