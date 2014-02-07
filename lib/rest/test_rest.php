<?php

	include 'PxpRestClient.php';
	
	//phpinfo();
	$pxpRestClient = PxpRestClient::connect('192.168.56.101','kerp-boa/pxp/lib/rest/')
					->setCredentialsPxp('admin','admin');
	
	echo $pxpRestClient->doGet('seguridad/Usuario/listarUsuario/1/2');
	echo '................';
	echo $pxpRestClient->doGet('seguridad/Usuario/listarUsuario/1/2');
