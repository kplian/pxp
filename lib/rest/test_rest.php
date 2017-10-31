<?php
	
	
	include 'PxpRestClient.php';

//Generamos el documento con REST

$pxpRestClient = PxpRestClient::connect('erpmobile.obairlines.bo', 'rest/',443,'https')->setCredentialsPxp('notificaciones','Mund0libre');
//$pxpRestClient = PxpRestClient::connect('192.168.11.82', 'kerp_capacitacion/pxp/lib/rest/')->setCredentialsPxp('admin','123');

/*$res = $pxpRestClient->doPost('seguridad/aesEncryption',
    array(	"value"=>"jrivera",
        "key"=>'123'));
		
echo $res;
*/
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
				"id_int_comprobante"=>37473
				));
*/
/*
echo $pxpRestClient->doPost('sqlserver/CabeceraViatico/insertarViatico',
		array(	"id_funcionario" => 39,
				"tipo_viatico" => "administrativo",
				"descripcion" => "Por concepto de Rendicion de Viaje OB.AI.OV.31.2017",
				"acreedor" => "Funcionarios BoA",
				"fecha" => "14/06/2017",
				"nro_sigma" => "c-3658",
				"id_int_comprobante_ajusvar_dump($res->errorInfo());
		exit;te" => 37380,
				"tipo_ajuste" => "disminucion",
				//"json_detalle"=>'[{"tipo_viaje":"nacional","tipo_transaccion":"credito","tipo_credito":"banco","monto":450,"id_centro_costo":844,"forma_pago":"transferencia","acreedor":"BOA","glosa":"Devolucion de Viaticos del Funcionario JHONN EDWARD CLAROS ROJAS por Viaje a CBB-VVI-MIA-VVI-CBB"},{"tipo_viaje":"internacional","tipo_transaccion":"credito","tipo_credito":"banco","monto":2083.52,"id_centro_costo":844,"forma_pago":"transferencia","acreedor":"BOA","glosa":"Devolucion de Viaticos del Funcionario: JHONN EDWARD CLAROS ROJAS por Viaje a: CBB-VVI-MIA-VVI-CBB"},{"tipo_viaje":"","tipo_transaccion":"debito","tipo_credito":"banco","monto":2533.52,"id_centro_costo":844,"forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Creditos para el Viatico Administrativo"}]',
				  "json_detalle"=>'[{"tipo_viaje":"nacional","tipo_transaccion":"credito","monto":450,"id_centro_costo":844,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"BOA","glosa":"Devolucion de Viaticos del Funcionario: JHONN EDWARD CLAROS ROJAS por Viaje a: CBB-VVI-MIA-VVI-CBB"},{"tipo_viaje":"internacional","tipo_transaccion":"credito","monto":2083.52,"id_centro_costo":844,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"BOA","glosa":"Devolucion de Viaticos del Funcionario: JHONN EDWARD CLAROS ROJAS por Viaje a: CBB-VVI-MIA-VVI-CBB"},{"tipo_viaje":"","tipo_transaccion":"debito","monto":2533.52,"id_centro_costo":844,"tipo_credito":"banco","forma_pago":"transferencia","acreedor":"Funcionarios de BOA","glosa":"Creditos para el Viatico Administrativo"}]'
		));
*/
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
		array(					197588
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

/*
echo $pxpRestClient->doPost('obingresos/Deposito/subirArchivoDeposito',
    array(
        "id_deposito"=>"49929",
        "nombre_archivo"=> "Archivo-20170920_034547.docx"

    ));
*/
/*echo $pxpRestClient->doPost('obingresos/DetalleBoletosWeb/insertarBilletePortal',
    array(
        "billete"=>"9304017399622",
        "medio_pago"=>"CUENTA-CORRI",//CUENTA-CORRI,PBANCA-ELECTRONI
        "entidad"=>"NINGUNA",//NINGUNA,BUN
        "moneda"=>"BOB",
        "importe"=>279,
        "fecha_emision"=>"06/08/2017",//DD/MM/YYYY
        "nit"=>"1234",
        "razon_social"=>"jrivera",
        "fecha_pago"=>"06/08/2017",//DD/MM/YYYY
        "id_entidad"=>1906,
        "comision"=>23.3,
        "neto"=>233,
        "numero_autorizacion"=>"c2e56673-03cf-4690-9286-1b3bedac3c9c"

    ));

*/

/*echo $pxpRestClient->doPost('obingresos/PeriodoVenta/listarTotalesPeriodoAgencia',
    array(
        "id_periodo_venta"=>"5",
        "start"=>0,
        "limit"=>1000

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
/*
echo $pxpRestClient->doPost('almacenes/Item/nombreClasificacionItems',
    array(
        "codigos"=>"3.4.1.55.2,3.4.1.52,3.4.1.52,3.4.1.1.2.2"
    ));
*/

/*echo $pxpRestClient->doPost('obingresos/Deposito/listarDeposito',
    array(
        "id_deposito"=>"33645",
        "start"=>0,
        "limit"=>50

    ));base64_encode(
	            mcrypt_encrypt(
	                MCRYPT_RIJNDAEL_256,
	                $sSecretKey, $sValue, 
	                MCRYPT_MODE_ECB, 
	                mcrypt_create_iv(
	                    mcrypt_get_iv_size(
	                        MCRYPT_RIJNDAEL_256, 
	                        MCRYPT_MODE_ECB
	                    ), 
	                    MCRYPT_RAND)
	                )
	            )
	*/
/*
echo $pxpRestClient->doPost('obingresos/PeriodoVenta/listarDetallePeriodoAgencia',
    array(
        "id_agencia"=>"228",
        "id_periodo_venta"=>"",
        "tipo"=>'cuenta_corriente'

    ));
*/

echo $pxpRestClient->doPost('obingresos/PeriodoVenta/ResumenEstadoCC',
    array(
        "id_agencia"=>"4618"

    ));

/*echo $pxpRestClient->doPost('obingresos/MovimientoEntidad/anularAutorizacion',
    array(
        "autorizacion"=>"b2cc105a-00ce-4956-a104-43f7fbbda7b5",
        "billete"=>"9302400005121"

    ));
*/
/*
$res = $pxpRestClient->doPost('legal/ContratoComercial/ReporteContratoComercial',
    array(
    	"id_documento_wf"=>'199874',	
    	"tipo"=>"1",//1 banca,2 poliza ,3 prepago
        "codigo_documento"=>'CC1',
        "nombre_agencia"=>'aries',
        "direccion"=>'direccion agencia',
        "esquina"=>'',
		"zona"=>'gdfsg',
		"correo"=>'aaa@bbb.ccc',
		"telefono"=>'456456',
		"celular"=>'6456456',
		"nit"=>'123456',
		"representante_legal"=>'jmp',
		"cedula_identidad"=>'1234',
		"expedido"=>'CB',
		"fecha_inicio"=>'25/02/2018',
		"fecha_fin"=>'25/02/2019',
		"numero"=>'CC1',
		"aseguradora"=>'xxxx',
		"monto"=>'580',
		"hrs_ini"=>'11:15 PM',
		"fecha_vigente_inicio"=>'25/02/2018',
		"hrs_fin"=>'11:15 PM',
		"fecha_vigente_fin"=>'25/02/2019'));
		
	//el reporte esta en: direccion_erp/lib/lib_control/Intermediario.php?r='+archivo_generado(del json)
echo $res;
*/

/*echo $pxpRestClient->doPost('obingresos/Deposito/insertarDeposito',
    array(

        "tipo"=>"agencia",
        "saldo"=>"",
        "id_agencia"=>"110",
        "nro_deposito"=>"yyyy",
        "fecha"=>"31/01/2017",
        "moneda"=>"BOB",
        "monto_deposito"=>"100",
        "id_periodo_venta" =>""

    ));
*/

/*echo $pxpRestClient->doPost('parametros/Archivo/subirArchivo',
    array(
        "id_tabla"=>"33705",
        "tabla"=>"obingresos.tdeposito",
        "codigo_tipo_archivo"=>"ESCANDEP",
        "nombre_descriptivo"=>"",
        "archivo" => '@/tmp/Archivo-20170829_183321.pdf;filename=Archivo-20170829_183321.pdf'

    ));
*/
/*echo $pxpRestClient->doPost('parametros/Archivo/getRutaArchivo',
    array(
        "id_archivo"=>"17"

    ));
*/
/*

$this->setParametro('id_contrato','id_contrato','integer');
        $this->setParametro('banco','banco','varchar');
        $this->setParametro('tipo_boletvar_dump($res->errorInfo());
		exit;a','tipo_boleta','varchar');
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
/*
echo $pxpRestClient->doPost('obingresos/Agencia/verificarSaldo',
    array(
        "pnr"=>"TREY1B",
        "apellido"=>"prueba",
        "id_agencia"=>"149",
        "forma_pago"=>"postpago",
        "monto"=>"307",
        "monto_total"=>"350",
        "moneda"=>"BOB",
        "usuario"=>"xxx",
        "tipo_usuario"=>"",
        "fecha"=>"22/09/2017"

    ));

*/
/*
echo $pxpRestClient->doPost('obingresos/Agencia/getSaldoAgencia',
    array(
        "id_agencia"=>"4144",
        "moneda"=>"BOB"
    ));
*/

/*echo $pxpRestClient->doPost('workflow/DocumentoWf/subirArchivoWf',
    array(
        "id_documento_wf"=>"197624",
        "num_tramite"=>"",
        "archivo" => '@' . realpath('mozilla.pdf') . ';filename=mozilla.pdf'

    ));
*/

/*
echo $pxpRestClient->doPost('obingresos/Agencia/getDocumentosContrato',
    array(
        "id_contrato"=>"1007"

    ));
*/
/*
echo $pxpRestClient->doPost('presupuestos/Presupuesto/listarPresupuestoRest',
    array(
        "gestion"=>"2017"
    ));
*/
/*
echo $pxpRestClient->do2Post('presupuestos/PresupuestoFuncionario/listarCentroCostoFuncionarios',
    array(
        "id_cc"=>885,
        "gestion"=>"2017"
    ));

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

/*$res = $pxpRestClient->doPost('organigrama/CertificadoPlanilla/insertarCertificadoPlanilla',
    array(	"tipo_certificado"=>"General",
        "fecha_solicitud"=>'04/08/2017',
        "id_funcionario"=>1670,
        "importe_viatico"=>""));
echo $res;

*/
/*
$res = $pxpRestClient->doPost('obingresos/PeriodoVenta/validarBoletosPortal',
    array(	"fecha_emision"=>"14/08/2017"));
echo $res;*/

/*$variable = $pxpRestClient->doPost('ventas_facturacion/Venta/insertarVentaCompleta',
    array(	"id_cliente"=>1,
        "nit"=>4394,
        "id_sucursal"=>13,
        "nro_tramite"=>'',
        "a_cuenta"=>0,
        "total_venta"=>56,
        "fecha_estimada_entrega"=>"",
        "id_punto_venta"=>5,
        "id_forma_pago"=>890,
        "monto_forma_pago"=>56,
        "numero_tarjeta"=>"",
        "codigo_tarjeta"=>"",
        "tipo_tarjeta"=>"",
        "porcentaje_descuento"=>"",
        "id_vendedor_medico"=>"",
        "comision"=>"",
        "observaciones"=>"venta prueba servicio",
        "tipo_factura"=>"computarizada",
        "fecha"=>"18-09-2017",
        "nro_factura"=>"50",
        "id_dosificacion"=>"1",
        "excento"=>0,
        "id_moneda"=>1,
        "tipo_cambio_venta"=>"",
        "total_venta_msuc"=>56,
        "transporte_fob"=>56,
        "seguros_fob"=>"",
        "otros_fob"=>"",
        "transporte_cif"=>"",
        "seguros_cif"=>"",
        "otros_cif"=>"",
        "valor_bruto"=>"",
        "descripcion_bulto"=>"",
        "id_cliente_destino"=>"",
        "hora_estimada_entrega"=>"",
        "forma_pedido"=>"",
        "json_new_records"=>'[{"id_item":"8","id_producto":1,"id_formula":"","tipo":"servicio","estado_reg":"activo","cantidad":3,"precio":3,"sw_porcentaje_formula":"","porcentaje_descuento":"","id_vendedor_medico":"","descripcion":"","id_venta":"","bruto":"","ley":"","kg_fino","","id_unidad_medida":2}]',
        "id_forma_pago"=>0,
        "formas_pago"=>'[{"id_forma_pago":"980","valor":1,"numero_tarjeta":"","codigo_tarjeta":"","tipo_tarjeta":"","id_venta":""}]',
    ));
echo $variable;*/


/*$res = $pxpRestClient->doPost('ventas_facturacion/Dosificacion/alertarDosificacion',
    array());
echo $res;*/
/*
$res = $pxpRestClient->doPost('organigrama/CertificadoPlanilla/consultaDatosFuncionario',
        array( "id_funcionario"=>424));
echo $res;
*/
exit;
	