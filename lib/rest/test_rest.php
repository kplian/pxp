<?php
	
	include 'PxpRestClient.php';	

	$pxpRestClient = PxpRestClient::connect('127.0.0.1','kerp/pxp/lib/rest/')->setCredentialsPxp('jrivera','Mund0libre.');
	
	    		
	echo $pxpRestClient->doPost('tesoreria/CuentaDocumentadaEndesis/enviarfondoAvanceCorreo', array("id_cuenta_documentada"=>'1711'));

echo "llega";
exit;  
