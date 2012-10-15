<?php
/***
 Nombre: 	MODRegional.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tregional del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODRegional extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
	
	function listarRegional(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_regional_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_REGION_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
	
		//Definicion de la lista del resultado del query
	
		$this->captura('id_regional','integer');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','pxp.estado_reg');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','varchar');
		
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;
	}
	
	function insertarRegional(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_regional_ime';
		$this->transaccion='SEG_REGION_INS';
		$this->tipo_procedimiento='IME';
		
		//Define los parametros para la funcion	
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	function modificarRegional(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_regional_ime';
		$this->transaccion='SEG_REGION_MOD';
		$this->tipo_procedimiento='IME';
		
		//Define los parametros para la funcion	
		$this->setParametro('id_regional','id_regional','integer');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	function eliminarRegional(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_regional_ime';
		$this->transaccion='SEG_REGION_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_regional','id_regional','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;
	}
	
}
?>