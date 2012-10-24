<?php
/***
 Nombre: 	MODEstructuraUO.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla testructura_uo del esquema RHUM
 Autor:		Kplian
 Fecha:		04/06/2011
 */
class MODEstructuraUo extends MODbase {
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
	
	

	function listarEstructuraUo(){
		$this->procedimiento='rhum.ft_estructura_uo_sel';
		$this->transaccion='RH_ESTRUO_SEL';
		$this->tipo_procedimiento='SEL';
		
		$this->setCount(false);
		
			$this->setParametro('id_padre','id_padre','varchar');
					
			//defino varialbes que se captran como retornod e la funcion
			$this->captura('id_uo','integer');
			$this->captura('codigo','varchar');
			$this->captura('descripcion','varchar');
			$this->captura('cargo_individual','varchar');
			$this->captura('nombre_unidad','varchar');
			$this->captura('nombre_cargo','varchar');
			$this->captura('presupuesta','varchar');
			$this->captura('nodo_base','varchar');
			$this->captura('estado_reg','varchar');
			$this->captura('fecha_reg','timestamp');
			$this->captura('id_usuario_reg','integer');
			$this->captura('fecha_mod','timestamp'); 
			$this->captura('id_usuario_mod','integer');
			$this->captura('usureg','text');
			$this->captura('usumod','text');
			$this->captura('id_uo_padre','integer');
			$this->captura('id_estructura_uo','integer');
			$this->captura('correspondencia','varchar');
			$this->captura('gerencia','varchar');
			$this->armarConsulta();
			$this->ejecutarConsulta();
			return $this->respuesta;	
		
						
		
	}
	
	
	
     function insertarEstructuraUo(){
         	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='rhum.ft_estructura_uo_ime';// nombre procedimiento almacenado
		$this->transaccion='RH_ESTRUO_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		//Define los parametros para la funcion	
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('id_uo_padre','id_uo_padre','integer');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre_unidad','nombre_unidad','varchar');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('nombre_cargo','nombre_cargo','varchar');
		$this->setParametro('cargo_individual','cargo_individual','varchar');
		$this->setParametro('presupuesta','presupuesta','varchar');
		$this->setParametro('nodo_base','nodo_base','varchar');
		$this->setParametro('correspondencia','correspondencia','varchar');
		$this->setParametro('gerencia','gerencia','varchar');
		
	    	//Ejecuta la instruccion
	  //  echo '....'.$this->getConsulta(); exit;
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	function modificarEstructuraUo(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='rhum.ft_estructura_uo_ime';// nombre procedimiento almacenado
		$this->transaccion='RH_ESTRUO_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_estructura_uo','id_estructura_uo','integer');
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('id_uo_padre','id_uo_padre','integer');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre_unidad','nombre_unidad','varchar');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('nombre_cargo','nombre_cargo','varchar');
		$this->setParametro('cargo_individual','cargo_individual','varchar');
		$this->setParametro('presupuesta','presupuesta','varchar');
		$this->setParametro('nodo_base','nodo_base','varchar');
		$this->setParametro('correspondencia','correspondencia','varchar');
		$this->setParametro('gerencia','gerencia','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	function eliminarEstructuraUo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='rhum.ft_estructura_uo_ime';
		$this->transaccion='RH_ESTRUO_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('id_uo_padre','id_uo_padre','integer');
	//	$this->setParametro('id_estructura_uo_padre','id_estructura_uo_padre','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	

}
?>