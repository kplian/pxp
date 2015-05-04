<?php
	
	include 'PxpRestClient.php';	
	
	$pxpRestClient = PxpRestClient::connect('127.0.0.1','kerp_capacitacion/pxp/lib/rest/')->setCredentialsPxp('admin','123');
	
	  		
	echo $pxpRestClient->doPost('adquisiciones/Solicitud/reporteSolicitud',
	    array("id_proceso_wf"=>'12311'));


echo "llega";
exit;  