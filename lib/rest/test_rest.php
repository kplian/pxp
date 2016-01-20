<?php
	
	include 'PxpRestClient.php';	

	$pxpRestClient = PxpRestClient::connect('172.17.45.229','kerp_capacitacion/pxp/lib/rest/')->setCredentialsPxp('jrivera','123');
	
			
	echo $pxpRestClient->doGet('organigrama/Funcionario/getDatosFuncionario', array("nombre_empleado"=>'priscil'));


exit; 


