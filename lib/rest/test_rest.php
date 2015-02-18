<?php
	
	include 'PxpRestClient.php';	
	
	$pxpRestClient = PxpRestClient::connect('127.0.0.1','kerp/pxp/lib/rest/')->setCredentialsPxp('jrivera','jrivera');
	
	    		
	echo $pxpRestClient->doPost('adquisiciones/Solicitud/reporteSolicitud',
	    array("id_proceso_wf"=>'4032'));

	


