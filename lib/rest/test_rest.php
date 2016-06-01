<?php
	
	include 'PxpRestClient.php';	

	$pxpRestClient = PxpRestClient::connect('172.17.45.229','kerp_capacitacion/pxp/lib/rest/')->setCredentialsPxp('jrivera','123');
	
			
	echo $pxpRestClient->doGet('sqlserver/CabeceraViatico/insertarViatico', 
		array(	"id_funcionario"=>1347,
				"tipo_viatico"=>'operativo',
				"descripcion"=>'viatico de prueba',
				"acreedor"=>'funcionario xxxxx',
				"fecha"=>'01/01/2016',
				"json_detalle"=>'[{"tipo_viaje":"nacional", "tipo_transaccion":"debito","monto":140048.00,"id_uo":10},
				{"tipo_viaje":"internacional", "tipo_transaccion":"debito","monto":122904.59,"id_uo":10},
				{"tipo_transaccion":"credito","monto":228768.75,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Viaticos Operativos"},
				{"tipo_transaccion":"credito","monto":34183.84,"tipo_credito":"retencion"}]',
				));


exit; 
 

