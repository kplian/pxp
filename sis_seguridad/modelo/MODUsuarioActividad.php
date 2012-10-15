<?php
/***
 Nombre: 	MODUsuarioActividad.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tusuario_actividad del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODUsuarioActividad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	

	function listarUsuarioActividad(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_usuario_actividad_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUACT_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		//defino varialbes que se captran como retornod e la funcion
		
		$this->captura('id_usuario_actividad','integer');
		$this->captura('id_actividad','integer');
		$this->captura('id_usuario','integer');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','segu.activo_inactivo');
		$this->captura('desc_actividad','varchar');
		$this->captura('desc_person','text');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function insertarUsuarioActividad(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_usuario_actividad_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUACT_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		
		$this->setparametro('id_actividad','id_actividad','integer');
		$this->setparametro('id_usuario','id_usuario','integer');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;	
	}
	
	function modificarUsuarioActividad(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_usuario_actividad_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUACT_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		$this->setparametro('id_usuario_actividad','id_usuario_actividad','integer');
		$this->setparametro('id_actividad','id_actividad','integer');
		$this->setparametro('id_usuario','id_usuario','integer');
						
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarUsuarioActividad(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_usuario_actividad_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUACT_ELI';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		$this->setparametro('id_usuario_actividad','id_usuario_actividad','integer');
		
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
}
?>