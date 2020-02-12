<?php
/**
*@package pXP
*@file gen-MODProgramador.php
*@author  (rarteaga)
*@date 08-01-2020 19:46:59
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #102		08-01-2020 19:46:59			RAC KPLIAN		CREACION

*/

class MODProgramador extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProgramador(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_programador_sel';
		$this->transaccion='SG_PRG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_programador','int4');
		$this->captura('usuario_ldap','varchar');
		$this->captura('alias_git','varchar');
		$this->captura('alias_codigo_1','varchar');
		$this->captura('nombre_completo','varchar');
		$this->captura('organizacion','varchar');
		$this->captura('correo_personal','varchar');
		$this->captura('fecha_inicio','date');
		$this->captura('estado_reg','varchar');
		$this->captura('alias_codigo_2','varchar');
		$this->captura('obs_dba','varchar');
		$this->captura('correo','varchar');
		$this->captura('fecha_fin','date');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarProgramador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_programador_ime';
		$this->transaccion='SG_PRG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('usuario_ldap','usuario_ldap','varchar');
		$this->setParametro('alias_git','alias_git','varchar');
		$this->setParametro('alias_codigo_1','alias_codigo_1','varchar');
		$this->setParametro('nombre_completo','nombre_completo','varchar');
		$this->setParametro('organizacion','organizacion','varchar');
		$this->setParametro('correo_personal','correo_personal','varchar');
		$this->setParametro('fecha_inicio','fecha_inicio','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('alias_codigo_2','alias_codigo_2','varchar');
		$this->setParametro('obs_dba','obs_dba','varchar');
		$this->setParametro('correo','correo','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProgramador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_programador_ime';
		$this->transaccion='SG_PRG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_programador','id_programador','int4');
		$this->setParametro('usuario_ldap','usuario_ldap','varchar');
		$this->setParametro('alias_git','alias_git','varchar');
		$this->setParametro('alias_codigo_1','alias_codigo_1','varchar');
		$this->setParametro('nombre_completo','nombre_completo','varchar');
		$this->setParametro('organizacion','organizacion','varchar');
		$this->setParametro('correo_personal','correo_personal','varchar');
		$this->setParametro('fecha_inicio','fecha_inicio','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('alias_codigo_2','alias_codigo_2','varchar');
		$this->setParametro('obs_dba','obs_dba','varchar');
		$this->setParametro('correo','correo','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProgramador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_programador_ime';
		$this->transaccion='SG_PRG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_programador','id_programador','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>