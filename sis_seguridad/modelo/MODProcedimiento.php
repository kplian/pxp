<?php
/***
 Nombre: 	MODProcedimiento.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tprocedimiento del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODProcedimiento extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarProcedimientoCmb(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_procedimiento_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_PROCECMB_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		//parametro para filtrado
		
		$this->setParametro('id_funcion','id_funcion','integer');
		//Definicion de la lista del resultado del query
		//defino varialbes que se captran como retornod e la funcion
        $this->captura('id_procedimiento','integer');
        $this->captura('id_funcion','integer');
        $this->captura('id_subsistema','integer');
        $this->captura('codigo_sub','varchar');
        $this->captura('nombre_fun','varchar');
        $this->captura('codigo','varchar');
        $this->captura('descripcion','text');
        $this->captura('habilita_log','segu.si_no');	
      	//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
    	return $this->respuesta;

	}
	
	function insertarProcedimiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_procedimiento_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PROCED_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		//Define los parametros para la funcion	
		$this->setParametro('id_funcion','id_funcion','integer');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('habilita_log','habilita_log','varchar');
	
    	//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarProcedimiento(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_procedimiento_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PROCED_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_procedimiento','id_procedimiento','integer');
		$this->setParametro('id_funcion','id_funcion','integer');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('habilita_log','habilita_log','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();		
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarProcedimiento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_procedimiento_ime';
		$this->transaccion='SEG_PROCED_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_procedimiento','id_procedimiento','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
					
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
}
?>