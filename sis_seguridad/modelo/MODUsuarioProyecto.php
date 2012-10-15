<?php
/***
 Nombre: 	MODUsuarioProyecto.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tusuario_proyecto del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODUsuarioProyecto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	

	function listarUsuarioProyecto(){
		
		$this->procedimiento='segu.ft_usuario_proyecto_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUPRO_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		$this->captura('id_usuario_proyecto','integer');
		$this->captura('id_proyecto','integer');
		$this->captura('id_usuario','integer');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','segu.activo_inactivo');
		$this->captura('desc_proyecto','varchar');
		$this->captura('desc_person','text');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function insertarUsuarioProyecto(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_usuario_proyecto_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUPRO_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		
		$this->setparametro('id_proyecto','id_proyecto','integer');
		$this->setparametro('id_usuario','id_usuario','integer');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarUsuarioProyecto(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_usuario_proyecto_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUPRO_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		$this->setparametro('id_usuario_proyecto','id_usuario_proyecto','integer');
		$this->setparametro('id_proyecto','id_proyecto','integer');
		$this->setparametro('id_usuario','id_usuario','integer');
						
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;	
	}
	
	function eliminarUsuarioProyecto(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_usuario_proyecto_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_USUPRO_ELI';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		$this->setparametro('id_usuario_proyecto','id_usuario_proyecto','integer');
		
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
}
?>