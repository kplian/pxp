<?php
/***
 Nombre: 	MODRolProcedimiento.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tprocedimiento del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODRolProcedimiento extends MODbase
{
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}

	
	function listarRolProcedimiento(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_rol_procedimiento_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_ROLPRO_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_rol_procedimiento','integer');
		$this->captura('id_procedimiento','integer');
		$this->captura('id_rol','integer');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','segu.activo_inactivo');
								
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function insertarRolProcedimiento(){
				
		$this->procedimiento='segu.ft_rol_procedimiento_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_ROLPRO_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		$this->setparametro('id_procedimiento','id_procedimiento','integer');
		$this->setparametro('id_rol','id_rol','integer');
				
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarRolProcedimiento(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_rol_procedimiento_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_ROLPRO_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		$this->setparametro('id_rol_procedimiento','id_rol_procedimiento','integer');
		$this->setparametro('id_procedimiento','id_procedimiento','integer');
		$this->setparametro('id_rol','id_rol','integer');
						
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarRolProcedimiento(){
		//echo $parametro->getOrdenacion;
		$this->procedimiento='segu.ft_rol_procedimiento_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_ROLPRO_ELI';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
				
		$this->setparametro('id_rol_procedimiento','id_rol_procedimiento','integer');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
}
?>