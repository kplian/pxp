<?php
	
	include 'PxpRestClient.php';

//Generamos el documento con REST

$pxpRestClient = PxpRestClient::connect('192.168.11.82', 'kerp_capacitacion/pxp/lib/rest/')
    ->setCredentialsPxp('jrivera','123');

/*
$res = $pxpRestClient->doPost('tesoreria/PlanPago/reporteActaConformidad',
    array(	"id_proceso_wf"=>68528,
        "firmar"=>'si',
        "fecha_firma"=>'01/01/2016',
        "usuario_firma"=>'jmp',
        "nombre_usuario_firma"=>'jmp'));
echo $res;
*/
/*
	$variable = $pxpRestClient->doPost('almacenes/Movimiento/insertarMovimientoREST', 
		array(	"id_movimiento_tipo"=>11,
				"id_almacen"=>1,
				"id_funcionario"=>2048,
				"fecha_mov"=>'29/03/2017',
				"descripcion"=>'Movimiento generado desde el sistema de dotacion',
                "id_funcionario_aprobador"=>56,
				"detalle"=>'[{"codigo_item":"3.4.1.1.1.1","cantidad":1},{"codigo_item":"3.4.1.1.1.1","cantidad":"2"}]',
                "codigo_tran"=>'MOV.SAL.20170502160449'
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
*/
/*
	echo $pxpRestClient->doPost('almacenes/Item/listarSaldosXItems', 
		array(					
				"codigos"=>"3.4.1.54.1,3.4.1.54.2,3.4.1.54.3,3.4.1.54.4,3.4.1.54.5,3.4.1.60,3.4.2.1.3,3.4.2.1.4,3.4.2.1.5,3.4.2.1.6,3.4.2.1.7,3.4.2.1.8,3.4.2.1.9,34,35,3.4.2.2.3,3.4.2.2.4,3.4.2.2.5,3.4.2.2.6,3.4.2.2.7,3.4.2.2.8,3.4.2.2.9,15,3.4.1.27.3,3.4.1.27.4,3.4.1.27.5,3.4.1.27.6,3.4.1.27.7,16,17,3.4.1.12.1.2,3.4.1.12.1.3,3.4.1.12.1.4,3.4.1.12.1.5,F,14,14.5,3.4.1.3.1.1,3.4.1.3.1.2,3.4.1.3.1.3,3.4.1.3.1.4,3.4.1.3.1.5,3.4.1.3.1.6,3.4.1.3.1.7,3.4.1.3.1.7.5,3.4.1.50.1,3.4.1.4.1.1,3.4.1.4.1.2,3.4.1.4.1.3,3.4.1.4.1.4,3.4.1.4.1.5,3.4.1.4.1.6,3.4.1.4.1.7,3.4.1.4.1.7.5,3.4.1.26.3,3.4.1.26.4,3.4.1.26.5,3.4.1.26.6,3.4.1.26.7,3.4.1.25.3,3.4.1.25.4,3.4.1.25.5,3.4.1.25.6,3.4.1.7.1,3.4.1.7.2,3.4.1.7.3,3.4.1.7.4,3.4.1.7.5,3.4.1.15.2,3.4.1.15.3,3.4.1.15.4,3.4.1.15.5,3.4.1.15.6,3.4.1.5.1.2,3.4.1.5.1.3,3.4.1.5.1.4,3.4.1.5.1.5,3.4.1.5.1.6,3.4.1.5.2.1,3.4.1.5.2.2,3.4.1.5.2.3,3.4.1.5.2.4,3.4.1.5.2.5,3.4.1.5.2.6,3.4.1.5.2.7,XXXL,3.4.1.51,3.4.1.18.2,3.4.1.18.3,3.4.1.18.4,3.4.1.18.5,3.4.1.18.6,3.4.1.64,3.4.1.48,3.4.1.29,3.4.1.33,3.4.1.19,3.4.1.31,3.4.1.30,3.4.1.12.1.6,3.4.1.11.4,3.4.1.11.5,3.4.1.1.1.3,3.4.1.1.1.4,3.4.1.1.1.5,3.4.1.1.1.6,3.4.1.1.2.1,3.4.1.1.2.2,3.4.1.1.2.3,3.4.1.14.6,3.4.1.14.7,3.4.1.50.2,3.4.1.1.1.2,3.4.1.21,3.4.1.53,3.4.1.63,3.4.1.20,3.4.1.7.6,3.4.1.11.3",
            //"codigos"=>"3.4.1.5.1.3",
            "id_almacen"=>1
				));
	
	echo $variable;
*/
/*echo $pxpRestClient->doPost('organigrama/Cargo/listarCargoAcefalo',
    array(
        "tipo_contrato"=>"planta",
        "fecha"=>"26/01/2017",
        //"id_gerencia"=>"",
        "cargo"=>"trafi"
    ));*/

/*echo $pxpRestClient->doPost('organigrama/Funcionario/getDatosFuncionario',
    array(
        "nombre_empleado"=>"rivera",
        "start"=>0,
        "limit"=>50

    ));
*/

/*echo $pxpRestClient->doPost('obingresos/Agencia/subirArchivoContrato',
    array(
        "id_documento_wf"=>"197624",
        "nombre_archivo"=>" Archivo-20170522_170031.pdf"

    ));

echo $pxpRestClient->doPost('obingresos/Agencia/insertarBoletaAgencia',
    array(
        "id_contrato"=>"197624",
        "banco"=>"BUN",
        "tipo_boleta"=>"poliza",
        "fecha_inicio"=>"01/01/2017",
        "fecha_fin"=>"31/01/2017",
        "moneda"=>"BOB",
        "monto"=>"100"

    ));

*/

echo $pxpRestClient->doPost('almacenes/Item/nombreClasificacionItems',
    array(
        "codigos"=>"3.4.1.70.7,3.4.1.69.6"
    ));

/*
echo $pxpRestClient->doPost('obingresos/Deposito/insertarDeposito',
    array(
        "tipo"=>"agencia",
        "saldo"=>"",
        "id_agencia"=>"2",
        "nro_deposito"=>"zzzzz",
        "fecha"=>"31/01/2017",
        "moneda"=>"BOB",
        "monto_deposito"=>"100",
        "id_periodo_venta" =>""

    ));
*/
/*

$this->setParametro('id_contrato','id_contrato','integer');
        $this->setParametro('banco','banco','varchar');
        $this->setParametro('tipo_boleta','tipo_boleta','varchar');
        $this->setParametro('fecha_inicio','fecha_inicio','date');
        $this->setParametro('fecha_fin','fecha_fin','date');
        $this->setParametro('moneda','moneda','varchar');
        $this->setParametro('monto','monto','numeric');
*/
    /*echo $pxpRestClient->doPost('obingresos/TipoPeriodo/obtenerTipoPeriodoXFP',
    array(
        "formas_pago"=>"banca_internet,postpago"

    ));*/
    
   /* echo $pxpRestClient->doPost('obingresos/Agencia/finalizarContratoPortal',
    array(
        "id_contrato"=>"1029"

    ));*/

/*echo $pxpRestClient->doPost('obingresos/Agencia/insertarContratoPortal',
    array(
        "id_agencia"=>"4148",
        "id_funcionario"=>"1347",
        "numero_contrato"=>"12345",
        "objeto"=>"pruebajrr",
        "fecha_firma"=>"01/01/2017",
        "fecha_inicio"=>"01/01/2017",
        "fecha_fin"=>"31/12/2017",
        "tipo_agencia"=>"noiata",
        "formas_pago"=>"postpago",
        "moneda_restrictiva"=>"si",
        "cuenta_bancaria1"=>"",
        "entidad_bancaria1"=>"",
        "cuenta_bancaria1"=>"",
        "nombre_cuenta_bancaria1"=>"",
        "cuenta_bancaria2"=>"",
        "entidad_bancaria2"=>"",
        "nombre_cuenta_bancaria2"=>"",

    ));
*/
/*
echo $pxpRestClient->doPost('workflow/DocumentoWf/getRutaDocumento',
    array(
        "id_documento_wf"=>"197588"

    ));
*/

/*echo $pxpRestClient->doPost('obingresos/Agencia/verificarSaldo',
    array(
        "pnr"=>"T5HJG",
        "apellido"=>"prueba",
        "id_agencia"=>"4144",
        "forma_pago"=>"postpago",
        "monto"=>"300",
        "moneda"=>"BOB"
    ));

/*

echo $pxpRestClient->doPost('workflow/DocumentoWf/subirArchivoWf',
    array(
        "id_documento_wf"=>"197624",
        "num_tramite"=>"",
        "archivo" => '@' . realpath('mozilla.pdf') . ';filename=mozilla.pdf'

    ));


/*

echo $pxpRestClient->doPost('obingresos/Agencia/getDocumentosContrato',
    array(
        "id_contrato"=>"1007"

    ));

/*
echo $pxpRestClient->doPost('presupuestos/Presupuesto/listarPresupuestoRest',
    array(
        "gestion"=>"2017"
    ));
*/
/*
echo $pxpRestClient->doPost('presupuestos/PresupuestoFuncionario/listarCentroCostoFuncionarios',
    array(
        "id_cc"=>844,
        "gestion"=>"2017"
    ));
*/
/*
$res = $pxpRestClient->doPost('reclamo/Respuesta/reporteRespuestaPDF',
    array("id_proceso_wf"=>'141236'));

echo $res;*/


	
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
/*
$res = $pxpRestClient->doPost('almacenes/Reportes/reporteExistencias',
		array(	"id_almacen"=>1,
				"fecha_hasta"=>'30/03/2017',
				"all_items"=>'Por Clasificacion',
				"all_items"=>'Por Clasificacion',
				"id_items"=>'',
				"clasificacion"=>'[3.4]-Ropa de Trabajo',
				"alertas"=>'no',
				"saldo_cero"=>'si',
				"id_clasificacion"=>30,
				"almacen"=>'ALMACEN CENTRAL CTO-CBB'));
echo $res;
*/
exit; 
 

