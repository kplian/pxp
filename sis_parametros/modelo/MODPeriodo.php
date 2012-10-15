<?php
class MODPeriodo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarPeriodo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_periodo_sel';// nombre procedimiento almacenado
		$this->transaccion='PM_PERIOD_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
	
		//Definicion de la lista del resultado del query
	
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_periodo','integer');
		$this->captura('periodo','integer');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','date');
		$this->captura('id_gestion','integer');
		$this->captura('gestion','integer');
							
		//Ejecuta la funcion
		$this->armarConsulta();
		
		
		$this->ejecutarConsulta();
//echo '---'.$this->getConsulta();
		return $this->respuesta;

	}
	
	function insertarPeriodo(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_periodo_ime';// nombre procedimiento almacenado
		$this->transaccion='PM_PERIOD_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
			
		$this->setParametro('periodo','periodo','integer');
		$this->setParametro('id_gestion','id_gestion','integer');
	//	$this->setParametro('estado_reg','estado_reg','varchar');
		//$this->setParametro('fecha_reg','fecha_reg','date');
	
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		//echo $this->getConsulta();
		return $this->respuesta;
	}
	
	function modificarPeriodo(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_periodo_ime';// nombre procedimiento almacenado
		$this->transaccion='PM_PERIOD_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_periodo','id_periodo','integer');	
		$this->setParametro('periodo','periodo','integer');
		$this->setParametro('id_gestion','id_gestion','integer');
		//$this->setParametro('estado_reg','estado_reg','varchar');
		//$this->setParametro('fecha_reg','fecha_reg','date');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarPeriodo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_periodo_ime';
		$this->transaccion='PM_PERIOD_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_periodo','id_periodo','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
}
?>