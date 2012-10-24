<?php
/***
 Nombre: 	MODUoFuncionario.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas a la tabla tuo_funcionario del esquema RHUM
 Autor:		Kplian
 Fecha:		04/06/2011
 */
class MODUoFuncionario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarUoFuncionario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='rhum.ft_uo_funcionario_sel';// nombre procedimiento almacenado
		$this->transaccion='RH_UOFUNC_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setParametro('id_uo','id_uo','integer');
		//Definicion de la lista del resultado del query
		$this->captura('id_uo_funcionario','integer');
		$this->captura('id_uo','integer');
		$this->captura('id_funcionario','integer');
		$this->captura('ci','varchar');
		$this->captura('codigo','varchar');
        $this->captura('desc_funcionario1','text');
        $this->captura('desc_funcionario2','text');
        $this->captura('num_doc','integer');
        $this->captura('fecha_asignacion','date');
        $this->captura('fecha_finalizacion','date');
        $this->captura('estado_reg','varchar');
        $this->captura('fecha_mod','timestamp');
        $this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','integer');
        $this->captura('id_usuario_reg','integer');
        $this->captura('USUREG','text');
		$this->captura('USUMOD','text');
		
		
    	
		//Ejecuta la funcion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();

		return $this->respuesta;

	}
	
	function insertarUoFuncionario(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='rhum.ft_uo_funcionario_ime';// nombre procedimiento almacenado
		$this->transaccion='RH_UOFUNC_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('id_funcionario','id_funcionario','integer');
		$this->setParametro('fecha_asignacion','fecha_asignacion','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarUoFuncionario(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='rhum.ft_uo_funcionario_ime';// nombre procedimiento almacenado
		$this->transaccion='RH_UOFUNC_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_uo_funcionario','id_uo_funcionario','integer');	
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('id_funcionario','id_funcionario','integer');
		$this->setParametro('fecha_asignacion','fecha_asignacion','date');
		$this->setParametro('fecha_finalizacion','fecha_finalizacion','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		
	
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	function eliminarUoFuncionario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='rhum.ft_uo_funcionario_ime';
		$this->transaccion='RH_UOFUNC_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_uo_funcionario','id_uo_funcionario','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
}
?>