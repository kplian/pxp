<?php
	//$srt= mb_convert_encoding('!"·$%&/()=1234567890','UTF-8');
	
	include 'PxpRestClient.php';	
	//phpinfo();
	$pxpRestClient = PxpRestClient::connect('172.17.45.229','kerp_capacitacion/pxp/lib/rest/')
					->setCredentialsPxp('jrivera','jrivera');
	//echo $pxpRestClient->doGet('libre/tesoreria/CuentaDocumentadaEndesis/listarFondoAvance2',array("limit"=>'10'));
	echo $pxpRestClient->doGet('tesoreria/CuentaDocumentadaEndesis/listarFondoAvance',array("limit"=>'10'));
	//echo $pxpRestClient->doGet('seguridad/Usuario/listarUsuario',array());
	echo $pxpRestClient->doPost('tesoreria/CuentaDocumentadaEndesis/aprobarFondoAvance',array("id_cuenta_documentada"=>'358',"accion"=>"cancelar"));
	
