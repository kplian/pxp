<?php
/**
*@package pXP
*@file gen-MODAntiguedad.php
*@author  (szambrana)
*@date 17-10-2019 14:41:21
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				17-10-2019 14:41:21								CREACION

*/

class MODAntiguedad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAntiguedad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_antiguedad_sel';
		$this->transaccion='PM_ANTIG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_antiguedad','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('categoria_antiguedad','int4');
		$this->captura('dias_asignados','int4');
		$this->captura('desde_anhos','int4');
		$this->captura('hasta_anhos','int4');
		$this->captura('obs_antiguedad','varchar');
		$this->captura('id_gestion','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('gestion','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarAntiguedad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_antiguedad_ime';
		$this->transaccion='PM_ANTIG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('categoria_antiguedad','categoria_antiguedad','int4');
		$this->setParametro('dias_asignados','dias_asignados','int4');
		$this->setParametro('desde_anhos','desde_anhos','int4');
		$this->setParametro('hasta_anhos','hasta_anhos','int4');
		$this->setParametro('obs_antiguedad','obs_antiguedad','varchar');
		$this->setParametro('id_gestion','id_gestion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAntiguedad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_antiguedad_ime';
		$this->transaccion='PM_ANTIG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_antiguedad','id_antiguedad','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('categoria_antiguedad','categoria_antiguedad','int4');
		$this->setParametro('dias_asignados','dias_asignados','int4');
		$this->setParametro('desde_anhos','desde_anhos','int4');
		$this->setParametro('hasta_anhos','hasta_anhos','int4');
		$this->setParametro('obs_antiguedad','obs_antiguedad','varchar');
		$this->setParametro('id_gestion','id_gestion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAntiguedad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_antiguedad_ime';
		$this->transaccion='PM_ANTIG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_antiguedad','id_antiguedad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>