<?php
/***
 Nombre: 	MODPatronEvento.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tpatron_evento del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODPatronEvento extends MODbase {
	
	function __construct(CTParametro $pParam=null){
		parent::__construct($pParam);
	}
	
	
	
	function listarPatronEvento(){
		
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_patron_evento_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_PATEVE_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		
		
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_patron_evento','integer');
		$this->captura('tipo_evento','varchar');
		$this->captura('operacion','varchar');
		$this->captura('aplicacion','varchar');
		$this->captura('cantidad_intentos','integer');
		$this->captura('periodo_intentos','numeric');
		$this->captura('tiempo_bloqueo','numeric');
		$this->captura('email','varchar');
		$this->captura('nombre_patron','varchar');
		
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;

	}
	
	function insertarPatronEvento(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_patron_evento_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PATEVE_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		
	
		$this->setParametro('tipo_evento','tipo_evento','varchar');
		$this->setParametro('operacion','operacion','varchar');
		$this->setParametro('aplicacion','aplicacion','varchar');
		$this->setParametro('cantidad_intentos','cantidad_intentos','integer');
		$this->setParametro('periodo_intentos','periodo_intentos','numeric');
		$this->setParametro('tiempo_bloqueo','tiempo_bloqueo','numeric');
		$this->setParametro('email','email','varchar');
		$this->setParametro('nombre_patron','nombre_patron','varchar');
			
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarPatronEvento(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_patron_evento_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PATEVE_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		
		
		//Define los setParametros para la funcion	
		$this->setParametro('id_patron_evento','id_patron_evento','integer');	
		$this->setParametro('tipo_evento','tipo_evento','varchar');
		$this->setParametro('operacion','operacion','varchar');
		$this->setParametro('aplicacion','aplicacion','varchar');
		$this->setParametro('cantidad_intentos','cantidad_intentos','integer');
		$this->setParametro('periodo_intentos','periodo_intentos','numeric');
		$this->setParametro('tiempo_bloqueo','tiempo_bloqueo','numeric');
		$this->setParametro('email','email','varchar');
		$this->setParametro('nombre_patron','nombre_patron','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarPatronEvento(){
	
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_patron_evento_ime';
		$this->transaccion='SEG_PATEVE_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los setParametros para la funcion
		$this->setParametro('id_patron_evento','id_patron_evento','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	
	
	
}
?>
