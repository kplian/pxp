<?php
/***
 Nombre: 	MODTipoDocumento.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla ttipo_documento del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODTipoDocumento extends MODbase{

	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}

	function listarTipoDocumento(){
		
				
			
		//echo $parametro->getOrdenacion;
		$this->setProcedimiento('segu.ft_tipo_documento_sel');
		$this->setTransaccion('SEG_TIPDOC_SEL');
		$this->setTipoProcedimiento('SEL');//tipo de transaccion
		
		//Definicion de la lista del resultado del query
	
		//defino varialbes que se captran como retorno de la funcion
		$this->captura('id_tipo_documento','integer');
		$this->captura('nombre','varchar');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','pxp.estado_reg');
				
					
		$this->armarConsulta();

		$consulta=$this->getConsulta();	
		$this->ejecutarConsulta();
		return $this->getRespuesta();		
	
	}
	
	function insertarTipoDocumento(){
		//echo $parametro->getOrdenacion;
		$this->setProcedimiento('segu.ft_tipo_documento_ime');// nombre procedimiento almacenado
		$this->setTransaccion('SEG_TIPODOC_INS');//nombre de la transaccion
		$this->setTipoProcedimiento('IME');//tipo de transaccion
		
		$this->setParametro('id_tipo_documento','integer');
		$this->setParametro('nombre','varchar');
		$this->setParametro('fecha_reg','date');
		$this->setParametro('estado_reg','segu.activo_inactivo');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	function modificarTipoDocumento(){
		//echo $parametro->getOrdenacion;
		$this->setProcedimiento('segu.ft_tipo_documento_ime');// nombre procedimiento almacenado
		$this->setTransaccion('SEG_TIPODOC_MOD');//nombre de la transaccion
		$this->setTipoProcedimiento('IME');//tipo de transaccion
		
		$this->setParametro('id_tipo_documento','integer');
		$this->setParametro('nombre','varchar');
		$this->setParametro('fecha_reg','date');
		$this->setParametro('estado_reg','segu.activo_inactivo');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	function eliminarTipoDocumento(){
		//echo $parametro->getOrdenacion;
		$this->setProcedimiento('segu.ft_tipo_documento_ime');
		$this->setTransaccion('SEG_TIPODOC_ELI');
		$this->setTipoProcedimiento('IME');
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_documento','id_tipo_documento','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
}
?>