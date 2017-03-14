<?php
/**
*@package pXP
*@file gen-MODColumnasArchivoExcel.php
*@author  (gsarmiento)
*@date 15-12-2016 20:46:43
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODColumnasArchivoExcel extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarColumnasArchivoExcel(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_columnas_archivo_excel_sel';
		$this->transaccion='PM_COLXLS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

		$this->setParametro('id_plantilla_archivo_excel', 'id_plantilla_archivo_excel', 'int4');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_columna_archivo_excel','int4');
		$this->captura('id_plantilla_archivo_excel','int4');
		$this->captura('sw_legible','varchar');
		$this->captura('formato_fecha','varchar');
		$this->captura('anio_fecha','int4');
		$this->captura('numero_columna','int4');
		$this->captura('nombre_columna','varchar');
		$this->captura('nombre_columna_tabla','varchar');
		$this->captura('tipo_valor','varchar');
		$this->captura('punto_decimal','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

	function listarColumnasArchivoExcelporCodigoArchivo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_columnas_archivo_excel_sel';
		$this->transaccion='PM_COLXLSCOD_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

		$this->setParametro('codigo', 'codigo', 'varchar');

		//Definicion de la lista del resultado del query
		$this->captura('id_columna_archivo_excel','int4');
		$this->captura('id_plantilla_archivo_excel','int4');
		$this->captura('sw_legible','varchar');
		$this->captura('formato_fecha','varchar');
		$this->captura('anio_fecha','int4');
		$this->captura('numero_columna','int4');
		$this->captura('nombre_columna','varchar');
		$this->captura('nombre_columna_tabla','varchar');
		$this->captura('tipo_valor','varchar');
		$this->captura('punto_decimal','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function insertarColumnasArchivoExcel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_columnas_archivo_excel_ime';
		$this->transaccion='PM_COLXLS_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla_archivo_excel','id_plantilla_archivo_excel','int4');
		$this->setParametro('sw_legible','sw_legible','varchar');
		$this->setParametro('formato_fecha','formato_fecha','varchar');
		$this->setParametro('anio_fecha','anio_fecha','int4');
		$this->setParametro('numero_columna','numero_columna','int4');
		$this->setParametro('nombre_columna','nombre_columna','varchar');
		$this->setParametro('nombre_columna_tabla','nombre_columna_tabla','varchar');
		$this->setParametro('tipo_valor','tipo_valor','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('punto_decimal','punto_decimal','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarColumnasArchivoExcel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_columnas_archivo_excel_ime';
		$this->transaccion='PM_COLXLS_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_columna_archivo_excel','id_columna_archivo_excel','int4');
		$this->setParametro('id_plantilla_archivo_excel','id_plantilla_archivo_excel','int4');
		$this->setParametro('sw_legible','sw_legible','varchar');
		$this->setParametro('formato_fecha','formato_fecha','varchar');
		$this->setParametro('anio_fecha','anio_fecha','int4');
		$this->setParametro('numero_columna','numero_columna','int4');
		$this->setParametro('nombre_columna','nombre_columna','varchar');
		$this->setParametro('nombre_columna_tabla','nombre_columna_tabla','varchar');
		$this->setParametro('tipo_valor','tipo_valor','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('punto_decimal','punto_decimal','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarColumnasArchivoExcel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_columnas_archivo_excel_ime';
		$this->transaccion='PM_COLXLS_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_columna_archivo_excel','id_columna_archivo_excel','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>