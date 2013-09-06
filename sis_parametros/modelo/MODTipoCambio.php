<?php
/**
*@package pXP
*@file MODTipoCambio.php
*@author  Gonzalo Sarmiento Sejas
*@date 08-03-2013 15:30:14
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoCambio extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoCambio(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_tipo_cambio_sel';
		$this->transaccion='PM_TCB_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_cambio','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha','date');
		$this->captura('observaciones','varchar');
		$this->captura('compra','numeric');
		$this->captura('venta','numeric');
		$this->captura('oficial','numeric');
		$this->captura('id_moneda','int4');
		$this->captura('moneda','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarTipoCambio(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_tipo_cambio_ime';
		$this->transaccion='PM_TCB_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('compra','compra','numeric');
		$this->setParametro('venta','venta','numeric');
		$this->setParametro('oficial','oficial','numeric');
		$this->setParametro('id_moneda','id_moneda','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoCambio(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_tipo_cambio_ime';
		$this->transaccion='PM_TCB_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_cambio','id_tipo_cambio','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('compra','compra','numeric');
		$this->setParametro('venta','venta','numeric');
		$this->setParametro('oficial','oficial','numeric');
		$this->setParametro('id_moneda','id_moneda','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoCambio(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_tipo_cambio_ime';
		$this->transaccion='PM_TCB_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_cambio','id_tipo_cambio','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function obtenerTipoCambio(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.f_tipo_cambio_ime';
        $this->transaccion='PM_OBTTCB_GET';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_moneda','id_moneda','int4');
        $this->setParametro('fecha','fecha','date');
		$this->setParametro('tipo','tipo','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
		//echo $this->consulta;exit;
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
	
			
}
?>