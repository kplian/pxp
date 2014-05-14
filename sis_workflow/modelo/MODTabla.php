<?php
/**
*@package pXP
*@file gen-MODTabla.php
*@author  (admin)
*@date 07-05-2014 21:39:40
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTabla extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTabla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tabla_sel';
		$this->transaccion='WF_tabla_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tabla','int4');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('vista_id_tabla_maestro','int4');
		$this->captura('bd_scripts_extras','text');
		$this->captura('vista_campo_maestro','int4');
		$this->captura('vista_scripts_extras','text');
		$this->captura('bd_descripcion','text');
		$this->captura('vista_tipo','varchar');
		$this->captura('menu_icono','varchar');
		$this->captura('menu_nombre','varchar');
		$this->captura('vista_campo_ordenacion','varchar');
		$this->captura('vista_posicion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('menu_codigo','varchar');
		$this->captura('bd_nombre_tabla','varchar');
		$this->captura('bd_codigo_tabla','varchar');
		$this->captura('vista_dir_ordenacion','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_tabla_maestro','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTabla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tabla_ime';
		$this->transaccion='WF_tabla_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('vista_id_tabla_maestro','vista_id_tabla_maestro','int4');
		$this->setParametro('bd_scripts_extras','bd_scripts_extras','text');
		$this->setParametro('vista_campo_maestro','vista_campo_maestro','int4');
		$this->setParametro('vista_scripts_extras','vista_scripts_extras','text');
		$this->setParametro('bd_descripcion','bd_descripcion','text');
		$this->setParametro('vista_tipo','vista_tipo','varchar');
		$this->setParametro('menu_icono','menu_icono','varchar');
		$this->setParametro('menu_nombre','menu_nombre','varchar');
		$this->setParametro('vista_campo_ordenacion','vista_campo_ordenacion','varchar');
		$this->setParametro('vista_posicion','vista_posicion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('menu_codigo','menu_codigo','varchar');
		$this->setParametro('bd_nombre_tabla','bd_nombre_tabla','varchar');
		$this->setParametro('bd_codigo_tabla','bd_codigo_tabla','varchar');
		$this->setParametro('vista_dir_ordenacion','vista_dir_ordenacion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTabla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tabla_ime';
		$this->transaccion='WF_tabla_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tabla','id_tabla','int4');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('vista_id_tabla_maestro','vista_id_tabla_maestro','int4');
		$this->setParametro('bd_scripts_extras','bd_scripts_extras','text');
		$this->setParametro('vista_campo_maestro','vista_campo_maestro','int4');
		$this->setParametro('vista_scripts_extras','vista_scripts_extras','text');
		$this->setParametro('bd_descripcion','bd_descripcion','text');
		$this->setParametro('vista_tipo','vista_tipo','varchar');
		$this->setParametro('menu_icono','menu_icono','varchar');
		$this->setParametro('menu_nombre','menu_nombre','varchar');
		$this->setParametro('vista_campo_ordenacion','vista_campo_ordenacion','varchar');
		$this->setParametro('vista_posicion','vista_posicion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('menu_codigo','menu_codigo','varchar');
		$this->setParametro('bd_nombre_tabla','bd_nombre_tabla','varchar');
		$this->setParametro('bd_codigo_tabla','bd_codigo_tabla','varchar');
		$this->setParametro('vista_dir_ordenacion','vista_dir_ordenacion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTabla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tabla_ime';
		$this->transaccion='WF_tabla_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tabla','id_tabla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>