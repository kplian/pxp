<?php
class MODMoneda extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarMoneda(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_moneda_sel';// nombre procedimiento almacenado
		$this->transaccion='PM_MONEDA_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
	
		//Definicion de la lista del resultado del query
	
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_moneda','integer');
		$this->captura('codigo','varchar');
		$this->captura('moneda','varchar');
        $this->captura('estado_reg','varchar');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_reg','integer');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','integer');
        $this->captura('desc_usuario_reg','text'); 
        $this->captura('desc_usuario_mod','text'); 
        $this->captura('tipo_moneda','varchar'); 
		
		//Ejecuta la funcion
		$this->armarConsulta();
		//echo $this->getConsulta(); exit;
		$this->ejecutarConsulta();
		return $this->respuesta;

	}
	
	function insertarMoneda(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_moneda_ime';// nombre procedimiento almacenado
		$this->transaccion='PM_MONEDA_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('moneda','moneda','varchar');
		$this->setParametro('tipo_moneda','tipo_moneda','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		//echo $this->getConsulta();
		return $this->respuesta;
	}
	
	function modificarMoneda(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_moneda_ime';// nombre procedimiento almacenado
		$this->transaccion='PM_MONEDA_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_moneda','id_moneda','integer');	
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('moneda','moneda','varchar');
		//$this->setParametro('estado_reg','estado_reg','varchar');
		//$this->setParametro('fecha_reg','fecha_reg','date');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarMoneda(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_moneda_ime';
		$this->transaccion='PM_MONEDA_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_moneda','id_moneda','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
}
?>