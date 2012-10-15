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
	var maestro={id_usuario:<?php echo $id_usuario;?>};
	_CP.setPagina(new Phx.vista.usuario_actividad({idContenedor:idContenedor,idContenedorPadre:idContenedorPadre,maestro:maestro}))
	
	
	
	
});