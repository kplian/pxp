<?php
/**
*@package pXP
*@file gen-MODEntidad.php
*@author  (admin)
*@date 20-09-2015 19:11:44
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEntidad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEntidad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_entidad_sel';
		$this->transaccion='PM_ENT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_entidad','int4');		
		$this->captura('nit','varchar');
        $this->captura('tipo_venta_producto','varchar');
        $this->captura('estados_comprobante_venta','varchar');
        $this->captura('estados_anulacion_venta','varchar');            
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('pagina_entidad','varchar');
		$this->captura('direccion_matriz','varchar');
		
		$this->captura('identificador_min_trabajo','varchar');
		$this->captura('identificador_caja_salud','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarEntidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_entidad_ime';
		$this->transaccion='PM_ENT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('tipo_venta_producto','tipo_venta_producto','varchar');
        $this->setParametro('estados_comprobante_venta','estados_comprobante_venta','varchar');
        $this->setParametro('estados_anulacion_venta','estados_anulacion_venta','varchar');
		$this->setParametro('nit','nit','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('pagina_entidad','pagina_entidad','varchar');
		$this->setParametro('direccion_matriz','direccion_matriz','varchar');
		
		$this->setParametro('identificador_min_trabajo','identificador_min_trabajo','varchar');
		$this->setParametro('identificador_caja_salud','identificador_caja_salud','varchar');		
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEntidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_entidad_ime';
		$this->transaccion='PM_ENT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_entidad','id_entidad','int4');
        $this->setParametro('tipo_venta_producto','tipo_venta_producto','varchar');
		$this->setParametro('estados_comprobante_venta','estados_comprobante_venta','varchar');
        $this->setParametro('estados_anulacion_venta','estados_anulacion_venta','varchar');
		$this->setParametro('nit','nit','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('pagina_entidad','pagina_entidad','varchar');
		$this->setParametro('direccion_matriz','direccion_matriz','varchar');
		
		$this->setParametro('identificador_min_trabajo','identificador_min_trabajo','varchar');
		$this->setParametro('identificador_caja_salud','identificador_caja_salud','varchar');	
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEntidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_entidad_ime';
		$this->transaccion='PM_ENT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_entidad','id_entidad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function getEntidadByDepto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_entidad_ime';
		$this->transaccion='PM_ENTGET_GET';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto','id_depto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function getEntidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_entidad_ime';
		$this->transaccion='PM_ENT_GET';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_entidad','id_entidad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>