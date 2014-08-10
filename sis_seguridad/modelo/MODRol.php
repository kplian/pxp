<?php
/***
 Nombre: 	MODRol.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla trol del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODRol extends MODbase{
	
	function __construct(CTParametro $pParam){
		
		parent::__construct($pParam);
		
	}
	
	function listarRol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_rol_sel');
		$this->setTransaccion('SEG_ROL_SEL');
		$this->setTipoProcedimiento('SEL');//tipo de transaccion
		
	
		//Definicion de la lista del resultado del query
	
		$this->captura('id_rol','integer');
		$this->captura('descripcion','text');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','segu.activo_inactivo');
		$this->captura('rol','varchar');
		$this->captura('id_subsistema','integer');
		$this->captura('desc_subsis','varchar');
		//$this->captura('estado_reg','varchar');
		
		//Ejecuta la funcion
		$this->armarConsulta();
		
		
		$this->ejecutarConsulta();

		return $this->getRespuesta();

	} 
	
	function insertarRol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_rol_ime');
		$this->setTransaccion('SEG_ROL_INS');
		$this->setTipoProcedimiento('IME');
		
		//Define los Parametros para la funcion	
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('rol','rol','varchar');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	function modificarRol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_rol_ime');
		$this->setTransaccion('SEG_ROL_MOD');
		$this->setTipoProcedimiento('IME');
		
		//Define los setParametros para la funcion	
		$this->setParametro('id_rol','id_rol','integer');		
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('rol','rol','varchar');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	function eliminarRol(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_rol_ime');
		$this->setTransaccion('SEG_ROL_ELI');
		$this->setTipoProcedimiento('IME');
			
		//Define los setParametros para la funcion
		$this->setParametro('id_rol','id_rol','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
			
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
}
?>