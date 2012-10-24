<?php
/***
 Nombre: 	MODFuncionario.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tfuncionario del esquema RHUM
 Autor:		Kplian
 Fecha:		04/06/2011
 */
class MODFuncionario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarFuncionario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='rhum.ft_funcionario_sel';// nombre procedimiento almacenado
		$this->transaccion='RH_FUNCIO_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		//Definicion de la lista del resultado del query
	
		//defino varialbes que se captran como retornod e la funcion
		
		$this->captura('id_funcionario','integer');
		$this->captura('codigo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','date');
		$this->captura('id_persona','integer');
		$this->captura('id_usuario_reg','integer');
		$this->captura('fecha_mod','date');
		$this->captura('id_usuario_mod','integer');
		$this->captura('email_empresa','varchar');
		$this->captura('interno','varchar');
		$this->captura('fecha_ingreso','date');
		$this->captura('desc_person','text');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('ci','varchar');
		$this->captura('num_documento','integer');
		$this->captura('telefono1','varchar');
		$this->captura('celular1','varchar');
		$this->captura('correo','varchar');
		
		
		//Ejecuta la funcion
		$this->armarConsulta();		
		//echo $this->getConsulta(); exit;
		$this->ejecutarConsulta();
		return $this->respuesta;

	}
	
	function listarFuncionarioCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='rhum.ft_funcionario_sel';// nombre procedimiento almacenado
		$this->transaccion='RH_FUNCIOCAR_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		//ENVIA ESTAS VARIALBES PARA EL FILTRO
		$this->setParametro('estado_reg_fun','estado_reg_fun','varchar');
		$this->setParametro('estado_reg_asi','estado_reg_asi','varchar');
	 
	
		$this->captura('id_uo_funcionario','integer');
		$this->captura('id_funcionario','integer');
		$this->captura('desc_funcionario1','text');
		$this->captura('desc_funcionario2','text');	
		$this->captura('id_uo','integer');
		$this->captura('nombre_cargo','varchar');
		$this->captura('fecha_asignacion','date');
		$this->captura('fecha_finalizacion','date');
		$this->captura('num_doc','integer');
		$this->captura('ci','varchar');
		$this->captura('codigo','varchar');
		$this->captura('email_empresa','varchar');
		$this->captura('estado_reg_fun','varchar');
		$this->captura('estado_reg_asi','varchar');
		//Ejecuta la funcion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->respuesta;

	}
	
	
	function insertarFuncionario(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='rhum.ft_funcionario_ime';// nombre procedimiento almacenado
		$this->transaccion='RH_FUNCIO_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		
		
		$this->setParametro('id_funcionario','id_funcionario','integer');	
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_persona','id_persona','integer');
		$this->setParametro('correo','correo','varchar');
		$this->setParametro('celular','celular','varchar');
		$this->setParametro('telefono','telefono','varchar');
		$this->setParametro('documento','documento','integer');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_ingreso','fecha_ingreso','date');
		$this->setParametro('email_empresa','email_empresa','varchar');
		$this->setParametro('interno','interno','varchar');
		
		
		
		
	
		
	
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	function modificarFuncionario(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='rhum.ft_funcionario_ime';// nombre procedimiento almacenado
		$this->transaccion='RH_FUNCIO_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_funcionario','id_funcionario','integer');	
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_persona','id_persona','integer');
		$this->setParametro('correo','correo','varchar');
		$this->setParametro('celular','celular','varchar');
		$this->setParametro('telefono','telefono','varchar');
		$this->setParametro('documento','documento','integer');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_ingreso','fecha_ingreso','date');
		$this->setParametro('email_empresa','email_empresa','varchar');
		$this->setParametro('interno','interno','varchar');
	
	
	
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	function eliminarFuncionario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='rhum.ft_funcionario_ime';
		$this->transaccion='RH_FUNCIO_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario','id_funcionario','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
}
?>