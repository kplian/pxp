<?php
/***
 Nombre: 	MODBloqueoNotificacion.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tbloqueo_notificacion del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */
class MODBloqueoNotificacion extends MODbase{
	
	function __construct(CTParametro $pParam){
		
		parent::__construct($pParam);
		
	}
	
	function listarNotificacion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_bloqueo_notificacion_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_NOTI_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->captura('id_bloqueo_notificacion','integer');
		$this->captura('nombre_patron','varchar');
		$this->captura('aplicacion','varchar');
		$this->captura('tipo_evento','varchar');
		$this->captura('usuario','varchar');
		$this->captura('ip','varchar');
		$this->captura('fecha_hora_ini','text');
		$this->captura('fecha_hora_fin','text');
		
				
		//Ejecuta la funcion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->respuesta;

	}
	
	function listarBloqueo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_bloqueo_notificacion_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_BLOQUE_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->captura('id_bloqueo_notificacion','integer');
		$this->captura('nombre_patron','varchar');
		$this->captura('aplicacion','varchar');
		$this->captura('tipo_evento','varchar');
		$this->captura('usuario','varchar');
		$this->captura('ip','varchar');
		$this->captura('fecha_hora_ini','text');
		$this->captura('fecha_hora_fin','text');
		
				
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;

	}
	function cambiarEstadoBloqueoNotificacion(){
	
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_bloqueo_notificacion_ime';
		$this->transaccion='SEG_ESBLONO_MOD';
		$this->tipo_procedimiento='IME';
			
		//Define los setParametros para la funcion
		$this->setParametro('id_bloqueo_notificacion','id_bloqueo_notificacion','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
}
?>