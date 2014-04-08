<?php
	//$srt= mb_convert_encoding('!"·$%&/()=1234567890','UTF-8');
	
	include 'PxpRestClient.php';
	
	//phpinfo();
	$pxpRestClient = PxpRestClient::connect('172.17.45.229','kerp_capacitacion/pxp/lib/rest/');
					//->setCredentialsPxp('jrivera','jrivera');
	
	//echo $pxpRestClient->doGet('seguridad/Usuario/listarUsuario',array());
	echo $pxpRestClient->doPost('seguridad/Auten/verificarCredenciales',array('usuario'=>'jrivera','contrasena'=>'jrivera'));
	
