<?php
	
	include 'PxpRestClient.php';	

	$pxpRestClient = PxpRestClient::connect('172.17.45.229','kerp/pxp/lib/rest/')->setCredentialsPxp('notificaciones','Mund0libre');
	
			
	echo $pxpRestClient->doGet('organigrama/Funcionario/getDatosFuncionario', array("nombre_empleado"=>'priscil'));


exit; 


