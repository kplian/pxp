<?php
/***
 Nombre: 	MODDocumento.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tdocumento del esquema PARAM
 Autor:		Kplian
 Fecha:		06/06/2011
 */ 
class MODDocumento extends MODbase{ 
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarDocumento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_documento_sel';// nombre procedimiento almacenado
		$this->transaccion='PM_DOCUME_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
	 $this->setParametro('tipo','tipo','varchar');
		//Definicion de la lista del resultado del query
	
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_documento','integer');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_mod','timestamp');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_subsistema','integer');
		$this->captura('id_usuario_mod','integer');
		$this->captura('id_usuario_reg','integer');
		$this->captura('desc_subsis','text');
		$this->captura('nombre_subsis','varchar');
		$this->captura('usureg','text');
		$this->captura('usumod','text');
		/*$this->captura('id_depto','integer');
		$this->captura('id_depto_uo','integer');
		
		$this->captura('id_uo','integer');
		$this->captura('desc_depto','varchar');
		$this->captura('desc_depto_uo','text');
		$this->captura('desc_uo','varchar');
	*/	$this->captura('tipo_numeracion','varchar');
		$this->captura('periodo_gestion','varchar');
        $this->captura('tipo','varchar');
        $this->captura('formato','varchar');

		
		//Ejecuta la funcion
		$this->armarConsulta();
		//echo $this->getConsulta(); exit;
		$this->ejecutarConsulta();
		return $this->respuesta;

	}
	
	function insertarDocumento(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_documento_ime';// nombre procedimiento almacenado
		$this->transaccion='PM_DOCUME_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('id_depto','id_depto','integer');
		$this->setParametro('id_depto_uo','id_depto_uo','integer');
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('tipo_numeracion','tipo_numeracion','varchar');
		$this->setParametro('periodo_gestion','periodo_gestion','varchar');
        $this->setParametro('tipo','tipo','varchar');
 $this->setParametro('formato','formato','varchar');
	
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		//echo $this->getConsulta();
		return $this->respuesta;
	}
	
	function modificarDocumento(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_documento_ime';// nombre procedimiento almacenado
		$this->transaccion='PM_DOCUME_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_documento','id_documento','integer');	
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_depto','id_depto','integer');
		$this->setParametro('id_depto_uo','id_depto_uo','integer');
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('tipo_numeracion','tipo_numeracion','varchar');
		$this->setParametro('periodo_gestion','periodo_gestion','varchar');
        $this->setParametro('tipo','tipo','varchar');
        $this->setParametro('formato','formato','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		//		echo '---'.$this->getConsulta();exit;
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarDocumento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_documento_ime';
		$this->transaccion='PM_DOCUME_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_documento','id_documento','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
}
?>