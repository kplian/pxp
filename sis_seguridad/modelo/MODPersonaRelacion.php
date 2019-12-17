<?php
/***
 Nombre: 	MODPersonaRelacion.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tpersona del esquema SEGU


 * ISSUE	FECHA		EMPRESA		AUTOR	DETALLE
 #41	31.07.2019	etr			mzm		adicion de relacion persona_dependiente
 #91	05.12.2019	ETR			MZM		cambio de consulta para evitar relacion con tpersona
 */ 
class MODPersonaRelacion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	} 
	
	function listarPersonaRelacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_persona_relacion_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_PERREL_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
	
		//defino varialbes que se captran como retornod e la funcion //#91
		$this->captura('id_persona_relacion','integer');
		$this->captura('nombre','varchar');
		$this->captura('fecha_nacimiento','date');
		$this->captura('genero','varchar');
		$this->captura('historia_clinica','varchar');
		$this->captura('matricula','varchar');
		$this->captura('relacion','varchar');
		$this->captura('id_persona','integer');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','integer');
		 
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;

	}
	
	
	
	
	function insertarPersonaRelacion(){//#91
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_persona_relacion_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PERREL_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		$this->setParametro('id_persona','id_persona','integer');
		$this->setParametro('relacion','relacion','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('fecha_nacimiento','fecha_nacimiento','date');
		$this->setParametro('genero','genero','varchar');
		$this->setParametro('historia_clinica','historia_clinica','varchar');
		$this->setParametro('matricula','matricula','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta(); //echo $this->getConsulta(); exit;
		
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarPersonaRelacion(){//#91
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_persona_relacion_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PERREL_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_persona_relacion','id_persona_relacion','integer');	
		$this->setParametro('id_persona','id_persona','integer');
		$this->setParametro('relacion','relacion','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('fecha_nacimiento','fecha_nacimiento','date');
		$this->setParametro('genero','genero','varchar');
		$this->setParametro('historia_clinica','historia_clinica','varchar');
		$this->setParametro('matricula','matricula','varchar');

		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarPersonaRelacion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_persona_relacion_ime';
		$this->transaccion='SEG_PERREL_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_persona_relacion','id_persona_relacion','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	
	
}
?>
