<?php
/***
 Nombre: 	MODClasificador.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tclasificador del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */
class MODClasificador extends MODbase{
	
	function __construct(CTParametro $pParam){
		
		parent::__construct($pParam);
		
	}
	
	function listarClasificador(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_clasificador_sel');// nombre procedimiento almacenado
		$this->setTransaccion('SEG_CLASIF_SEL');//nombre de la transaccion
		$this->setTipoProcedimiento('SEL');//tipo de transaccion
		
	
		//Definicion de la lista del resultado del query
	
		
		$this->captura('id_clasificador','integer');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','text');
		$this->captura('prioridad','integer');
		$this->captura('fecha_reg','date');
		//$this->captura('estado_reg','varchar');
		
		//Ejecuta la funcion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();

		return $this->getRespuesta();

	}
	
	function insertarClasificador(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_clasificador_ime');
		$this->setTransaccion('SEG_CLASIF_INS');
		$this->setTipoProcedimiento('IME');
		
		//Define los Parametros para la funcion	
		$this->setParametro('id_clasificador','id_clasificador','integer');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('prioridad','prioridad','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	function modificarClasificador(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_clasificador_ime');
		$this->setTransaccion('SEG_CLASIF_MOD');
		$this->setTipoProcedimiento('IME');
		
		//Define los setParametros para la funcion			
		$this->setParametro('id_clasificador','id_clasificador','integer');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('prioridad','prioridad','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	function eliminarClasificador(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_clasificador_ime');
		$this->setTransaccion('SEG_CLASIF_ELI');
		$this->setTipoProcedimiento('IME');
			
		//Define los setParametros para la funcion
		$this->setParametro('id_clasificador','id_clasificador','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
			
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
}
?>