<?php
/***
 Nombre: 	MODUsuarioRol.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tusuario_rol del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODUsuarioRol extends MODbase{
	
	function __construct(CTParametro $pParam){
		
		parent::__construct($pParam);
		
	}
	
	function listarUsuarioRol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_usuario_rol_sel');
		$this->setTransaccion('SEG_USUROL_SEL');
		$this->setTipoProcedimiento('SEL');//tipo de transaccion
		
		//Definicion de la lista del resultado del query
	
		$this->setParametro('id_usuario','id_usuario','integer');
		//$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_rol','integer'); 
		$this->captura('id_rol','integer');
		$this->captura('id_usuario','integer');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','pxp.estado_reg');
		$this->captura('rol','varchar');
		$this->captura('usuario','text');
		$this->captura('nombre','varchar');//subsistema
		
		
		//Ejecuta la funcion
		$this->armarConsulta();
		
		
		$this->ejecutarConsulta();

		return $this->getRespuesta();

	} 
	
	function insertarUsuarioRol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_usuario_rol_ime');
		$this->setTransaccion('SEG_USUROL_INS');
		$this->setTipoProcedimiento('IME');
		
		//Define los Parametros para la funcion	
	    $this->setParametro('id_rol','id_rol','integer');
		$this->setParametro('id_usuario','id_usuario','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	function modificarUsuarioRol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_usuario_rol_ime');
		$this->setTransaccion('SEG_USUROL_MOD');
		$this->setTipoProcedimiento('IME');
		
		//Define los setParametros para la funcion	
		
	    $this->setParametro('id_usuario_rol','id_usuario_rol','integer');
		$this->setParametro('id_rol','id_rol','integer');
		$this->setParametro('id_usuario','id_usuario','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	function eliminarUsuarioRol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_usuario_rol_ime');
		$this->setTransaccion('SEG_USUROL_ELI');
		$this->setTipoProcedimiento('IME');
			
		//Define los setParametros para la funcion
		$this->setParametro('id_usuario_rol','id_usuario_rol','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
			
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
}
?>