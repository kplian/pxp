<?php
	
	include 'PxpRestClient.php';	

	$pxpRestClient = PxpRestClient::connect('172.17.45.229','kerp_capacitacion/pxp/lib/rest/')->setCredentialsPxp('jrivera','123');
	
		
	$variable = $pxpRestClient->doPost('almacenes/Movimiento/insertarMovimientoREST', 
		array(	"id_movimiento_tipo"=>11,
				"id_almacen"=>1,
				"id_funcionario"=>1347,
				"fecha_mov"=>'24/06/2016',
				"descripcion"=>'prueba registro rest',				
				"detalle"=>'[{"codigo_item":"3.4.1.1.1.1","cantidad":1},{"codigo_item":"3.4.1.1.1.1","cantidad":"2"}]'
				));
	echo $variable;
	
	/*	
	echo $pxpRestClient->doPost('sqlserver/CabeceraViatico/validarViatico', 
		array(	"id_funcionario"=>39,
				"id_int_comprobante"=>23659
				));*/
			
		/*echo $pxpRestClient->doPost('almacenes/Item/listarSaldoXItem', 
		array(					
				"codigo"=>"3.2.1.1",
				"id_almacen"=>1
				));*/	
				

exit; 
 

