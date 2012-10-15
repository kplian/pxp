<?php
/***
 Nombre: 	MODPersona.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tpersona del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODPersona extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarPersona(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_persona_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_PERSON_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
	
		//Definicion de la lista del resultado del query
		
	;
	
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_persona','integer');
		$this->captura('ap_materno','varchar');
		$this->captura('ap_paterno','varchar');
		$this->captura('nombre','varchar');
		$this->captura('nombre_completo1','text');
		$this->captura('nombre_completo2','text');
		$this->captura('ci','varchar');
		$this->captura('correo','varchar');
		$this->captura('celular1','varchar');
		$this->captura('num_documento','integer');
		$this->captura('telefono1','varchar');
		$this->captura('telefono2','varchar');
		$this->captura('celular2','varchar');

		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;

	}
	
	function listarPersonaFoto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_persona_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_PERSONMIN_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
	
		//Definicion de la lista del resultado del query
		
		//creamos variables de sesion para descargar la fotos
		$_SESSION["FOTO"]=array();
	
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_persona','integer');
		$this->captura('ap_materno','varchar');
		$this->captura('ap_paterno','varchar');
		$this->captura('nombre','varchar');
		$this->captura('nombre_completo1','text');
		$this->captura('nombre_completo2','text');
		$this->captura('ci','varchar');
		$this->captura('correo','varchar');
		$this->captura('celular1','varchar');
		$this->captura('num_documento','integer');
		$this->captura('telefono1','varchar');
		$this->captura('telefono2','varchar');
		$this->captura('celular2','varchar');
		$this->captura('extension','varchar');
		//nombre varialbe de envio, tipo dato, columna que serra el nombre foto retorno, ruta para guardar archivo, crear miniatura, almacenar en sesion, nombre variale sesion			
		$this->captura('foto','bytea','id_persona','extension','sesion','foto');
		//$this->captura('foto','bytea','id_persona','extension','archivo','../../sis_seguridad/control/foto_persona/');
		//$this->captura('foto','bytea','id_persona','extension','archivo','./');
		
		
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;

	}
	
	
	function insertarPersona(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_persona_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PERSON_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		
		
		//Define los parametros para la funcion	
			
		$this->setParametro('ap_materno','ap_materno','varchar');
		$this->setParametro('ap_paterno','ap_paterno','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('ci','ci','varchar');
		$this->setParametro('correo','correo','varchar');
		$this->setParametro('celular1','celular1','varchar');
		$this->setParametro('telefono1','telefono1','varchar');
		$this->setParametro('telefono2','telefono2','varchar');
		$this->setParametro('celular2','celular2','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarPersona(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_persona_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PERSON_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		
		//apartir del tipo  del archivo obtiene la extencion
	

		
		//Define los parametros para la funcion	
		$this->setParametro('id_persona','id_persona','integer');	
		$this->setParametro('ap_materno','ap_materno','varchar');
		$this->setParametro('ap_paterno','ap_paterno','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('ci','ci','varchar');
		$this->setParametro('correo','correo','varchar');
		$this->setParametro('celular1','celular1','varchar');
		$this->setParametro('telefono1','telefono1','varchar');
		$this->setParametro('telefono2','telefono2','varchar');
		$this->setParametro('celular2','celular2','varchar');

		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarPersona(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_persona_ime';
		$this->transaccion='SEG_PERSON_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_persona','id_persona','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function subirFotoPersona(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_persona_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_UPFOTOPER_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//apartir del tipo  del archivo obtiene la extencion
		$ext = pathinfo($this->arregloFiles['foto']['name']);
 		$this->arreglo['extension']= $ext['extension'];
		
		//Define los parametros para la funcion	
		$this->setParametro('id_persona','id_persona','integer');	
		$this->setParametro('extension','extension','varchar');
		$this->setParametro('foto','foto','bytea',false,1024,true);
		//$this->setParametro('foto','foto','bytea',false,1024,false,array("csv"));
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
}
?>