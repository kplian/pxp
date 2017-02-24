<?php
	
	include 'PxpRestClient.php';

//Generamos el documento con REST
$pxpRestClient = PxpRestClient::connect('127.0.0.1', 'kerp/pxp/lib/rest/')
    ->setCredentialsPxp('jrivera','Mund0libre.2');

$url_final = str_replace('sis_', '', $d['action']);

$url_final = str_replace('/control', '', $url_final);
/*
$res = $pxpRestClient->doPost('tesoreria/PlanPago/reporteActaConformidad',
    array(	"id_proceso_wf"=>68528,
        "firmar"=>'si',
        "fecha_firma"=>'01/01/2016',
        "usuario_firma"=>'jmp',
        "nombre_usuario_firma"=>'jmp'));
echo $res;*/
	/*	
	$variable = $pxpRestClient->doPost('almacenes/Movimiento/insertarMovimientoREST', 
		array(	"id_movimiento_tipo"=>11,
				"id_almacen"=>1,
				"id_funcionario"=>1347,
				"fecha_mov"=>'24/06/2016',
				"descripcion"=>'prueba registro rest',				
				"detalle"=>'[{"codigo_item":"3.4.1.1.1.1","cantidad":1},{"codigo_item":"3.4.1.1.1.1","cantidad":"2"}]'
				));
	echo $variable;
	*/
	/*	
	echo $pxpRestClient->doPost('sqlserver/CabeceraViatico/validarViatico', 
		array(	"id_funcionario"=>39,
				"id_int_comprobante"=>23659
				));*/
		/*	
		echo $pxpRestClient->doPost('almacenes/Item/listarSaldoXItem', 
		array(					
				"codigo"=>"3.2.1.1",
				"id_almacen"=>1
				));
	
	echo $variable;


	echo $pxpRestClient->doPost('almacenes/Item/listarSaldosXItems', 
		array(					
				"codigos"=>"3.4.1.54.1,3.4.1.54.2,3.4.1.54.3,3.4.1.54.4,3.4.1.54.5,3.4.1.60,3.4.2.1.3,3.4.2.1.4,3.4.2.1.5,3.4.2.1.6,3.4.2.1.7,3.4.2.1.8,3.4.2.1.9,34,35,3.4.2.2.3,3.4.2.2.4,3.4.2.2.5,3.4.2.2.6,3.4.2.2.7,3.4.2.2.8,3.4.2.2.9,15,3.4.1.27.3,3.4.1.27.4,3.4.1.27.5,3.4.1.27.6,3.4.1.27.7,16,17,3.4.1.12.1.2,3.4.1.12.1.3,3.4.1.12.1.4,3.4.1.12.1.5,F,14,14.5,3.4.1.3.1.1,3.4.1.3.1.2,3.4.1.3.1.3,3.4.1.3.1.4,3.4.1.3.1.5,3.4.1.3.1.6,3.4.1.3.1.7,3.4.1.3.1.7.5,3.4.1.50.1,3.4.1.4.1.1,3.4.1.4.1.2,3.4.1.4.1.3,3.4.1.4.1.4,3.4.1.4.1.5,3.4.1.4.1.6,3.4.1.4.1.7,3.4.1.4.1.7.5,3.4.1.26.3,3.4.1.26.4,3.4.1.26.5,3.4.1.26.6,3.4.1.26.7,3.4.1.25.3,3.4.1.25.4,3.4.1.25.5,3.4.1.25.6,3.4.1.7.1,3.4.1.7.2,3.4.1.7.3,3.4.1.7.4,3.4.1.7.5,3.4.1.15.2,3.4.1.15.3,3.4.1.15.4,3.4.1.15.5,3.4.1.15.6,3.4.1.5.1.2,3.4.1.5.1.3,3.4.1.5.1.4,3.4.1.5.1.5,3.4.1.5.1.6,3.4.1.5.2.1,3.4.1.5.2.2,3.4.1.5.2.3,3.4.1.5.2.4,3.4.1.5.2.5,3.4.1.5.2.6,3.4.1.5.2.7,XXXL,3.4.1.51,3.4.1.18.2,3.4.1.18.3,3.4.1.18.4,3.4.1.18.5,3.4.1.18.6,3.4.1.64,3.4.1.48,3.4.1.29,3.4.1.33,3.4.1.19,3.4.1.31,3.4.1.30,3.4.1.12.1.6,3.4.1.11.4,3.4.1.11.5,3.4.1.1.1.3,3.4.1.1.1.4,3.4.1.1.1.5,3.4.1.1.1.6,3.4.1.1.2.1,3.4.1.1.2.2,3.4.1.1.2.3,3.4.1.14.6,3.4.1.14.7,3.4.1.50.2,3.4.1.1.1.2,3.4.1.21,3.4.1.53,3.4.1.63,3.4.1.20,3.4.1.7.6,3.4.1.11.3",
				"id_almacen"=>1
				));
	
	echo $variable;*/

/*echo $pxpRestClient->doPost('organigrama/Cargo/listarCargoAcefalo',
    array(
        "tipo_contrato"=>"planta",
        "fecha"=>"26/01/2017",
        //"id_gerencia"=>"",
        "cargo"=>"trafi"
    ));

echo $variable;
*/

$res = $pxpRestClient->doPost('reclamo/Respuesta/reporteRespuestaPDF',
    array("id_proceso_wf"=>'141236'));

echo $res;


	
	/*echo $pxpRestClient->doPost('almacenes/Clasificacion/listarClasificacionArb',
		array(					
				"node"=>"219",
				"id_clasificacion"=>"219"
				));
	
	echo $variable;
*/
/*
$res = $pxpRestClient->doPost('tesoreria/Clasificacion/listarClasificacionRopaTrabajoTalla',
		array(	"id_proceso_wf"=>68528,
				"firmar"=>'si',
				"fecha_firma"=>'01/01/2016',
				"usuario_firma"=>'jmp',
				"nombre_usuario_firma"=>'jmp'));
echo $res;*/
exit; 
 

