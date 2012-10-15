<?php
class MODGestion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarGestion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_gestion_sel';// nombre procedimiento almacenado
		$this->transaccion='PM_GESTIO_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
	
		//Definicion de la lista del resultado del query
		$this->setParametro('estado','estado','varchar');	
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_gestion','integer');
		$this->captura('gestion','integer');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_reg','integer');
        $this->captura('id_usuario_mod','integer');
        $this->captura('desc_usureg','text');
        $this->captura('desc_usumod','text');	
		
		//Ejecuta la funcion
		$this->armarConsulta();
		
		
		$this->ejecutarConsulta();
//echo '---'.$this->getConsulta();
		return $this->respuesta;

	}
	
	function insertarGestion(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_gestion_ime';// nombre procedimiento almacenado
		$this->transaccion='PM_GESTIO_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
			
		$this->setParametro('gestion','gestion','integer');
	//	$this->setParametro('estado_reg','estado_reg','varchar');
		//$this->setParametro('fecha_reg','fecha_reg','date');
	
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		echo $this->getConsulta();
		return $this->respuesta;
	}
	
	function modificarGestion(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_gestion_ime';// nombre procedimiento almacenado
		$this->transaccion='PM_GESTIO_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_gestion','id_gestion','integer');	
		$this->setParametro('gestion','gestion','integer');
		//$this->setParametro('estado_reg','estado_reg','varchar');
		//$this->setParametro('fecha_reg','fecha_reg','date');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarGestion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_gestion_ime';
		$this->transaccion='PM_GESTIO_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_gestion','id_gestion','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
}
?>