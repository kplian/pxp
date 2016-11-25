<?php
/**
*@package pXP
*@file MODActividad.php
*@author  Gonzalo Sarmiento Sejas
*@date 06-02-2013 15:45:34
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUtilidades extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function generarCodigoControl(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_utilidades_ime';
		$this->transaccion='PM_GENCC_IME';
		$this->tipo_procedimiento='IME';//tipo de transaccion
		$this->tipo_conexion='seguridad';
		
		$this->arreglo['id_usuario'] = 1;
		
		$this->setParametro('id_usuario','id_usuario','integer');
						
		//Definicion de la lista del resultado del query
		$this->setParametro('llave','varchar','varchar');
		$this->setParametro('nro_autorizacion','varchar','varchar');
		$this->setParametro('nro_factura','varchar','varchar');
		$this->setParametro('nit','varchar','varchar');
		$this->setParametro('fecha','varchar','varchar'); // formato YYYYMMDD
		$this->setParametro('monto','numeric','numeric');//tiene q ser numerico redondeado a 0 decimales
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
}
?>