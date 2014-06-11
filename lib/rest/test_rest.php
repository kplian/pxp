<?php
	//$srt= mb_convert_encoding('!"·$%&/()=1234567890','UTF-8');
	
	include 'PxpRestClient.php';	
	//phpinfo();
	$pxpRestClient = PxpRestClient::connect('192.168.225.72','kerp/pxp/lib/rest/')
					->setCredentialsPxp('admin','admin');
	//echo $pxpRestClient->doGet('libre/tesoreria/CuentaDocumentadaEndesis/listarFondoAvance2',array("limit"=>'10'));
	//echo $pxpRestClient->doGet('tesoreria/CuentaDocumentadaEndesis/listarFondoAvance',array("limit"=>'10'));
	//echo $pxpRestClient->doGet('seguridad/Usuario/listarUsuario',array());
	echo $pxpRestClient->doGet('seguridad/Gui/listarMenuMobile',array("tipo_proceso"=>'SOLCO'));
	


