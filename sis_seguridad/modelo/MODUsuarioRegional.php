<?php
/***
 Nombre: 	MODUsuarioRegional.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tusuario_regional del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODUsuarioRegional extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	function listarUsuarioRegional(){
		
		$this->procedimiento='segu.ft_usuario_regional_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUREG_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		
		//defino varialbes que se captran como retornod e la funcion
		
		$this->captura('id_usuario_regional','integer');
		$this->captura('id_regional','integer');
		$this->captura('id_usuario','integer');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','segu.activo_inactivo');
		$this->captura('desc_regional','varchar');
		$this->captura('desc_person','text');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function insertarUsuarioRegional(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_usuario_regional_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUREG_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		
		$this->setparametro('id_regional','id_regional','integer');
		$this->setparametro('id_usuario','id_usuario','integer');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;	
	}
	
	function modificarUsuarioRegional(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_usuario_regional_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUREG_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		$this->setparametro('id_usuario_regional','id_usuario_regional','integer');
		$this->setparametro('id_regional','id_regional','integer');
		$this->setparametro('id_usuario','id_usuario','integer');
						
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarUsuarioRegional(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_usuario_regional_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUREG_ELI';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		$this->setparametro('id_usuario_regional','id_usuario_regional','integer');
		
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;	
	}
	
	
}
?>