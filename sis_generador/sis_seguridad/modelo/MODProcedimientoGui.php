<?php
/***
 Nombre: 	MODProcedimientoGui.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tprocedimiento_gui del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODProcedimientoGui extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarProcedimientoGui(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_procedimiento_gui_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_PROGUI_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		//parametro para filtrado
		$this->setParametro('id_gui','id_gui','integer');
		
		//Definicion de la lista del resultado del query
		//defino varialbes que se captran como retornod e la funcion
    	$this->captura('id_procedimiento_gui','integer');
        $this->captura('id_procedimiento','integer');
        $this->captura('id_gui','integer');
        $this->captura('codigo_sub','varchar');
        $this->captura('nombre_fun','varchar');
        $this->captura('codigo','varchar');
        $this->captura('desc_procedimiento','text');                           
        $this->captura('boton','segu.si_no');
        $this->captura('fecha_reg','date');
        $this->captura('estado_reg','pxp.estado_reg');
        
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
    	return $this->respuesta;

	}
	
	function insertarProcedimientoGui(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_procedimiento_gui_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PROGUI_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		//Define los parametros para la funcion	
		
		$this->setParametro('id_procedimiento','id_procedimiento','integer');
		$this->setParametro('id_gui','id_gui','integer');
		$this->setParametro('boton','boton','varchar');
    	//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarProcedimientoGui(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_procedimiento_gui_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PROGUI_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_procedimiento_gui','id_procedimiento_gui','integer');
		$this->setParametro('id_procedimiento','id_procedimiento','integer');
		$this->setParametro('id_gui','id_gui','integer');
		$this->setParametro('boton','boton','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();	
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarProcedimientoGui(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_procedimiento_gui_ime';
		$this->transaccion='SEG_PROGUI_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_procedimiento_gui','id_procedimiento_gui','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();	
		$this->ejecutarConsulta();
		return $this->respuesta;
	}

	function guardarProcedimientoGuiSincronizacion(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_procedimiento_gui_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_PROGUISINC_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('transaccion','transaccion','varchar');
		$this->setParametro('procedimiento','procedimiento','varchar');
		$this->setParametro('id_gui','id_gui','integer');
				
		//Ejecuta la instruccion
		$this->armarConsulta();	
		
		$this->ejecutarConsulta();
		return $this->respuesta;
	}

	
}
?>