<?php
	
	include 'PxpRestClient.php';	

	$pxpRestClient = PxpRestClient::connect('172.17.45.229','kerp_capacitacion/pxp/lib/rest/')->setCredentialsPxp('jrivera','123');
	
		
	/*$variable = $pxpRestClient->doPost('sqlserver/CabeceraViatico/insertarViatico', 
		array(	"id_funcionario"=>1347,
				"tipo_viatico"=>'administrativo',
				"descripcion"=>'viatico de prueba',
				"acreedor"=>'funcionario xxxxx',
				"fecha"=>'24/05/2016',
				"nro_sigma"=>'C-765767',
				"json_detalle"=>'[{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":215,"id_centro_costo":801,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: IVAN GABRIEL SEJAS ORTEGA por Viaje a: CBB-VVI-CBB- No se Esta Tomando en cuenta el monto de sus Tasas: Bs. 30"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":215,"id_centro_costo":804,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: EDGAR WALTER GUTIERREZ AGUILAR por Viaje a: CBB-VVI-CBB- No se Esta Tomando en cuenta el monto de sus Tasas: Bs. 30"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":215,"id_centro_costo":804,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: WILLIAM JALDIN CORRALES por Viaje a: CBB-VVI-CBB- No se Esta Tomando en cuenta el monto de sus Tasas: Bs. 30"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":215,"id_centro_costo":804,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: JUAN FABIO CAHUASA QUISPE por Viaje a: CBB-VVI-CBB- No se Esta Tomando en cuenta el monto de sus Tasas: Bs. 30"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":215,"id_centro_costo":801,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: JULIO BERNARDO ANDRADE REQUENA por Viaje a: CBB-LPB-CBB- No se Esta Tomando en cuenta el monto de sus Tasas: Bs. 30"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":215,"id_centro_costo":801,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: ANDRES SIDNEY RODRIGUEZ GUTIERREZ por Viaje a: CBB-LPB-CBB- No se Esta Tomando en cuenta el monto de sus Tasas: Bs. 30"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":215,"id_centro_costo":802,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: KARINA BARRANCOS RIOS por Viaje a: CBB-LPB-CBB- No se Esta Tomando en cuenta el monto de sus Tasas: Bs. 30"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":245,"id_centro_costo":812,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: MARIA JOSE DE LA FUENTE JUSTINIANO por Viaje a: SRE-POI-SRE"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":245,"id_centro_costo":806,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: EDLY KARINA MORALES OLIVA por Viaje a: SRE-POI-SRE"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":245,"id_centro_costo":806,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: EFRAIN MENACHO TOLA por Viaje a: SRE-POI-SRE"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":245,"id_centro_costo":806,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: NICOLAS PAINO COLQUE por Viaje a: SRE-POI-SRE"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":245,"id_centro_costo":804,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: PEDRO LUIS VARGAS BUSTILLO por Viaje a: SRE-POI-SRE"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":860,"id_centro_costo":804,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: RONNIE MARIO BAZUALDO TAPIA por Viaje a: CBB-SRE-POI-SRE-CBB- No se Esta Tomando en cuenta el monto de sus Tasas: Bs. 15"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":245,"id_centro_costo":812,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: HUGO RAFAEL SANCHEZ BORJA por Viaje a: SRE-POI-SRE"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":355,"id_centro_costo":804,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: ROLY ADOLFO ARIAS AMURRIO por Viaje a: CBB-VVI-CBB- No se Esta Tomando en cuenta el monto de sus Tasas: Bs. 30"},{"tipo_viaje":"nacional","tipo_transaccion":"debito","monto":355,"id_centro_costo":804,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Viaticos del Funcionario: JHONY ROJAS HUANCA por Viaje a: CBB-VVI-CBB- No se Esta Tomando en cuenta el monto de sus Tasas: Bs. 30"},{"tipo_viaje":"","tipo_transaccion":"credito","monto":4448.54,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Creditos para el Viatico Administrativo"},{"tipo_viaje":"","tipo_transaccion":"credito","monto":96.46,"tipo_credito":"retencion_transitoria","forma_pago":"","acreedor":"Impuestos","glosa":"Creditos para las Retenciones IVA Transitorias"}]'
				));
	$obj = json_decode($variable);
	
		
	echo $pxpRestClient->doPost('sqlserver/CabeceraViatico/validarViatico', 
		array(	"id_funcionario"=>39,
				"id_int_comprobante"=>23659
				));*/
			
		echo $pxpRestClient->doPost('almacenes/Item/listarSaldoXItem', 
		array(					
				"codigo"=>"3.2.1.1",
				"id_almacen"=>1
				));	
				

exit; 
 

