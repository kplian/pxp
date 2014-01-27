<?php
/***
 Nombre: 	MODEstructuraDato.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla testrutura_dato del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */
class MODEstructuraDato extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}

	
	
	function listarEstructuraDato(){
		//echo $parametro->getOrdenacion;
		
		$this->procedimiento='segu.ft_estructura_dato_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_ESTDAT_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
				
		
		$this->captura('id_estructura_dato','integer');
		$this->captura('id_subsistema','integer');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','text');
		$this->captura('encripta','segu.si_no');
		$this->captura('log','segu.si_no');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','segu.activo_inactivo');
		$this->captura('tipo','varchar');
		$this->captura('nombre_subsis','varchar');	
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function insertarEstructuraDato(){
		
		
		$this->procedimiento='segu.ft_estructura_dato_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_ESTDAT_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion		
		
		$this->setparametro('id_subsistema',$arreglo['id_subsistema'],'integer');
		
		$this->setparametro('nombre','nombre','varchar');
		$this->setparametro('descripcion','descripcion','text');
		$this->setparametro('encripta','encripta','varchar');
		$this->setparametro('log','log','varchar');
		$this->setparametro('tipo','tipo','varchar');
		
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
				
		return $this->respuesta;
	}
	
	function modificarEstructuraDato(){
		
		$this->procedimiento='segu.ft_estructura_dato_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_ESTDAT_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		$this->setparametro('id_estructura_dato','id_estructura_dato','integer');
		$this->setparametro('id_subsistema',$arreglo['id_subsistema'],'integer');
		
		$this->setparametro('nombre','nombre','varchar');
		$this->setparametro('descripcion','descripcion','text');
		$this->setparametro('encripta','encripta','varchar');
		$this->setparametro('log','log','varchar');
		$this->setparametro('tipo','tipo','varchar');
		
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
				
		return $this->respuesta;
	}
	
	function eliminarEstructuraDato(){
		
		$this->procedimiento='segu.ft_estructura_dato_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_ESTDAT_ELI';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		$this->setparametro('id_estructura_dato','id_estructura_dato','integer');
				
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
				
		return $this->respuesta;
	}
	
}
?>