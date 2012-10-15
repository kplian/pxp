<?php
/***
 Nombre: 	MODFuncion.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tfuncion del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */
class MODFuncion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
	
	function listarFuncion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_funcion_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_FUNCIO_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
	
		//Definicion de la lista del resultado del query
	    $this->setParametro('id_subsistema','id_subsistema','integer');
	    
	    
		$this->captura('id_funcion','integer');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','text');
		$this->captura('fecha_reg','date');
		//$this->captura('estado_reg','segu.activo_inactivo');
		$this->captura('id_subsistema','integer');		
		$this->captura('estado_reg','segu.activo_inactivo');		
		
		//Ejecuta la funcion
		$this->armarConsulta();
		
		$consulta=$this->getConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function insertarFuncion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_funcion_ime';
		$this->transaccion='SEG_FUNCIO_INS';
		$this->tipo_procedimiento='IME';
		
		//Define los parametros para la funcion	
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	function modificarFuncion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_funcion_ime';
		$this->transaccion='SEG_FUNCIO_MOD';
		$this->tipo_procedimiento='IME';
		
		//Define los parametros para la funcion	
		$this->setParametro('id_actividad','id_actividad','integer');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	function eliminarFuncion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_funcion_ime';
		$this->transaccion='SEG_FUNCIO_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_funcion','id_funcion','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;
	}
	
	
	function sincFunciones(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_funcion_ime';
		$this->transaccion='SEG_SINCFUN_MOD';
		$this->tipo_procedimiento='IME';
		
		
		
		$this->setParametro('id_funcion','id_funcion','integer');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		
		$this->armarConsulta();
		$consulta=$this->getConsulta();
		
		$this->ejecutarConsulta();
		return $this->respuesta;	
	}
}
?>