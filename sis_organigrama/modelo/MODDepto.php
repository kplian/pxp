<?php
/***
 Nombre: 	MODDepto.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tdepto del esquema ORGA
 Autor:		Kplian
 Fecha:		06/06/2011
 */
class MODDepto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarDepto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_depto_sel';// nombre procedimiento almacenado
		$this->transaccion='OR_DEPPTO_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
	
		//Definicion de la lista del resultado del query
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('codigo_subsistema','codigo_subsistema','varchar');
	
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_depto','integer');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('nombre_corto','varchar');
		$this->captura('id_subsistema','integer');
		
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','integer');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','integer');
		$this->captura('usureg','text');
		$this->captura('usumod','text');
		$this->captura('desc_subsistema','text');
		
		
		//Ejecuta la funcion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->respuesta;

	}
	
	function insertarDepto(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_depto_ime';// nombre procedimiento almacenado
		$this->transaccion='OR_DEPPTO_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
			
		$this->setParametro('id_depto','id_depto','integer');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('nombre_corto','nombre_corto','varchar');
		
		$this->setParametro('id_subsistema','id_subsistema','integer');
	
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		//echo $this->getConsulta();
		return $this->respuesta;
	}
	
	function modificarDepto(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_depto_ime';// nombre procedimiento almacenado
		$this->transaccion='OR_DEPPTO_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_depto','id_depto','integer');	
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('nombre_corto','nombre_corto','varchar');
	
		$this->setParametro('id_subsistema','id_subsistema','integer');
	
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarDepto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_depto_ime';
		$this->transaccion='OR_DEPPTO_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_depto','id_depto','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
}
?>