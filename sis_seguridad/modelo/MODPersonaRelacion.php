<?php
/***
 Nombre: 	MODPersonaRelacion.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tpersona del esquema SEGU


 * ISSUE	FECHA		EMPRESA		AUTOR	DETALLE
 #41	31.07.2019	etr			mzm		adicion de relacion persona_dependiente
 * 
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
	
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_persona','integer');
		$this->captura('ap_materno','varchar');
		$this->captura('ap_paterno','varchar');
		$this->captura('nombre','varchar');
		$this->captura('nombre_completo1','text');
		$this->captura('desc_person','text');
		$this->captura('ci','varchar');
		$this->captura('correo','varchar');
		$this->captura('celular1','varchar');
		$this->captura('num_documento','integer');
		$this->captura('telefono1','varchar');
		$this->captura('telefono2','varchar');
		$this->captura('celular2','varchar');
		$this->captura('extension','varchar');
		$this->captura('tipo_documento','varchar');
		$this->captura('expedicion','varchar');
		//nombre varialbe de envio, tipo dato, columna que serra el nombre foto retorno, ruta para guardar archivo, crear miniatura, almacenar en sesion, nombre variale sesion			
		
		$this->captura('foto','bytea','id_persona','extension','sesion','foto');
		//$this->captura('foto','bytea','id_persona','extension','archivo','../../sis_seguridad/control/foto_persona/');
		//$this->captura('foto','bytea','id_persona','extension','archivo','./');
		
		 //30.07.2019
		$this->captura('matricula','varchar');
		$this->captura('historia_clinica','varchar');
		$this->captura('relacion','varchar');
		$this->captura('id_persona_fk','integer');
		$this->captura('id_persona_relacion','integer');                     
		

		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;

	}
	
	
	
	
	function insertarPersonaRelacion(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_persona_relacion_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PERREL_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		
		
		//Define los parametros para la funcion	
			
		$this->setParametro('id_persona_fk','id_persona_fk','integer');
		$this->setParametro('id_persona','id_persona','integer');
		$this->setParametro('relacion','relacion','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta(); //echo $this->getConsulta(); exit;
		
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarPersonaRelacion(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_persona_relacion_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PERREL_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		
		//apartir del tipo  del archivo obtiene la extencion
	

		
		//Define los parametros para la funcion	
		$this->setParametro('id_persona_relacion','id_persona_relacion','integer');	
		$this->setParametro('id_persona_fk','id_persona_fk','integer');
		$this->setParametro('id_persona','id_persona','integer');
		$this->setParametro('relacion','relacion','varchar');

		
		
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
