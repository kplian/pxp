<?php
/***
 Nombre: 	MODHorarioTrabajo.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla thorario_trabajo del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODHorarioTrabajo extends MODbase {
	
	function __construct(CTParametro $pParam=null){
		parent::__construct($pParam);
	}
	
	
	
	function listarHorarioTrabajo(){
		
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_horario_trabajo_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_HORTRA_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		
		
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_horario_trabajo','integer');
		$this->captura('dia_semana','integer');
		$this->captura('hora_ini','time');
		$this->captura('hora_fin','time');
		$this->captura('dia_literal','varchar');
		
		
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;

	}
	
	function insertarHorarioTrabajo(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_horario_trabajo_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_HORTRA_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		$this->setParametro('dia_semana','num_dia','integer');
		$this->setParametro('hora_ini','hora_ini','time');
		$this->setParametro('hora_fin','hora_fin','time');
			
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		//echo $this->getConsulta(); exit;
		return $this->respuesta;
	}
	
	function modificarHorarioTrabajo(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_horario_trabajo_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_HORTRA_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		
		
		//Define los setParametros para la funcion	
		$this->setParametro('id_horario_trabajo','id_horario_trabajo','integer');	
		$this->setParametro('dia_semana','num_dia','integer');
		$this->setParametro('hora_ini','hora_ini','time');
		$this->setParametro('hora_fin','hora_fin','time');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	function eliminarHorarioTrabajo(){
	
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_horario_trabajo_ime';
		$this->transaccion='SEG_HORTRA_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los setParametros para la funcion
		$this->setParametro('id_horario_trabajo','id_horario_trabajo','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
}
?>
