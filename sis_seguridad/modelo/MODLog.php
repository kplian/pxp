<?php
/***
 Nombre: 	MODLog.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tlog del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODLog extends MODbase{
	
	function __construct(CTParametro $pParam){
		
		parent::__construct($pParam);
		
	}
	
	function listarLog(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_log_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_LOG_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('gestion','gestion','varchar');
		$this->setParametro('periodo','periodo','varchar');
		//Definicion de la lista del resultado del query
	
		
		$this->captura('identificador','integer');
		$this->captura('id_usuario','integer');
		$this->captura('cuenta_usuario','varchar');
		$this->captura('mac_maquina','varchar');
		$this->captura('ip_maquina','varchar');
		$this->captura('tipo_log','varchar');
		$this->captura('descripcion','text');
		$this->captura('fecha_reg','TIMESTAMP');
		$this->captura('procedimientos','text');
		$this->captura('transaccion','varchar');
		$this->captura('consulta','varchar');
		$this->captura('usuario_base','varchar');
		$this->captura('tiempo_ejecucion','integer');
		$this->captura('pidweb','integer');
		$this->captura('piddb','integer');
		$this->captura('sidweb','varchar');
		$this->captura('codigo_error','varchar');
		$this->captura('descripcion_transaccion','text');
		$this->captura('codigo_subsistema','varchar');
				
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;

	}
	function listarLogHorario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_log_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_LOGHOR_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('gestion','gestion','varchar');
		$this->setParametro('periodo','periodo','varchar');
		//Definicion de la lista del resultado del query
	
		
		$this->captura('identificador','integer');
		$this->captura('id_usuario','integer');
		$this->captura('cuenta_usuario','varchar');
		$this->captura('mac_maquina','varchar');
		$this->captura('ip_maquina','varchar');
		$this->captura('tipo_log','varchar');
		$this->captura('descripcion','text');
		$this->captura('fecha_reg','TIMESTAMP');
		$this->captura('procedimientos','text');
		$this->captura('transaccion','varchar');
		$this->captura('consulta','varchar');
		$this->captura('usuario_base','varchar');
		$this->captura('tiempo_ejecucion','integer');
		$this->captura('pidweb','integer');
		$this->captura('piddb','integer');
		$this->captura('sidweb','varchar');
		$this->captura('codigo_error','varchar');
		$this->captura('descripcion_transaccion','text');
		$this->captura('codigo_subsistema','varchar');
		$this->captura('dia_semana','varchar');
				
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;

	}
	
	function listarLogMonitor(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_log_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_LOGMON_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->arreglo=array("archivo_log" =>$_SESSION['_FOLDER_LOGS_BD'].$_SESSION['_NOMBRE_LOG_BD']);
		$this->setParametro('archivo_log','archivo_log','varchar');
		//Definicion de la lista del resultado del query
	
		
		$this->captura('identificador','integer');
		$this->captura('id_usuario','integer');
		$this->captura('cuenta_usuario','varchar');
		$this->captura('mac_maquina','varchar');
		$this->captura('ip_maquina','varchar');
		$this->captura('tipo_log','varchar');
		$this->captura('descripcion','text');
		$this->captura('fecha_reg','TIMESTAMP');
		$this->captura('procedimientos','text');
		$this->captura('transaccion','varchar');
		$this->captura('consulta','varchar');
		$this->captura('usuario_base','varchar');
		$this->captura('tiempo_ejecucion','integer');
		$this->captura('pidweb','integer');
		$this->captura('piddb','integer');
		$this->captura('sidweb','varchar');
		$this->captura('codigo_error','varchar');
		$this->captura('descripcion_transaccion','text');
		$this->captura('codigo_subsistema','varchar');
		
				
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;

	}
	
	function listarMonitorEsquema(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_monitor_bd_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_MONESQ_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
				
		$this->captura('nspoid','integer');
		$this->captura('schemaname','varchar');
		$this->captura('usename','varchar');
		$this->captura('cantidad_tablas','bigint');
		$this->captura('cantidad_indices','bigint');
		$this->captura('scaneos_secuenciales','numeric');
		$this->captura('tuplas_seq_leidas','numeric');
		$this->captura('indices_scaneados','numeric');
		$this->captura('tuplas_idx_leidas','numeric');
		$this->captura('tuplas_insertadas','numeric');
		$this->captura('tuplas_actualizadas','numeric');
		$this->captura('tuplas_borradas','numeric');
		$this->captura('tuplas_actualizadas_hot','numeric');
		$this->captura('tuplas_vivas','numeric');
		$this->captura('tuplas_muertas','numeric');
		$this->captura('bloques_leidos_disco_tabla','numeric');
		$this->captura('bloques_leidos_buffer_tabla','numeric');
		$this->captura('bloques_leidos_disco_indice','numeric');
		$this->captura('bloques_leidos_buffer_indice','numeric');
		$this->captura('bloques_leidos_disco_toast','numeric');
		$this->captura('bloques_leidos_buffer_toast','numeric');
		$this->captura('bloques_leidos_disco_toast_indice','numeric');
		$this->captura('bloques_leidos_buffer_toast_indice','numeric');
		$this->captura('kb_tablas','bigint');
		$this->captura('kb_indices','bigint');
		
	  
				
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;

	}
	function listarMonitorTabla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_monitor_bd_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_MONTAB_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
				
		$this->captura('oid','integer');
		$this->captura('relnamespace','integer');
		$this->captura('tablename','varchar');
		$this->captura('usename','varchar');
		$this->captura('last_vacuum','text');
		$this->captura('last_autovacuum','text');
		$this->captura('last_analyze','text');
		$this->captura('last_autoanalyze','text');
		$this->captura('cantidad_indices','bigint');
		$this->captura('cantidad_triggers','bigint');
		$this->captura('scaneos_secuenciales','numeric');
		$this->captura('tuplas_seq_leidas','numeric');
		$this->captura('indices_scaneados','numeric');
		$this->captura('tuplas_idx_leidas','numeric');
		$this->captura('tuplas_insertadas','numeric');
		$this->captura('tuplas_actualizadas','numeric');
		$this->captura('tuplas_borradas','numeric');
		$this->captura('tuplas_actualizadas_hot','numeric');
		$this->captura('tuplas_vivas','numeric');
		$this->captura('tuplas_muertas','numeric');
		$this->captura('bloques_leidos_disco_tabla','numeric');
		$this->captura('bloques_leidos_buffer_tabla','numeric');
		$this->captura('bloques_leidos_disco_indice','numeric');
		$this->captura('bloques_leidos_buffer_indice','numeric');
		$this->captura('bloques_leidos_disco_toast','numeric');
		$this->captura('bloques_leidos_buffer_toast','numeric');
		$this->captura('bloques_leidos_disco_toast_indice','numeric');
		$this->captura('bloques_leidos_buffer_toast_indice','numeric');
		$this->captura('kb_tabla','numeric');
		$this->captura('kb_indices','numeric');
		
	  
				
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;

	}
	function listarMonitorFuncion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_monitor_bd_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_MONFUN_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
				
		$this->captura('oid','integer');
		$this->captura('pronamespace','integer');
		$this->captura('proname','varchar');
		$this->captura('setuid','varchar');
		$this->captura('usename','varchar');
		  
				
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;

	}
	function listarMonitorIndice(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_monitor_bd_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_MONIND_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->captura('relid','integer');		
		$this->captura('indexrelid','integer');
		$this->captura('indexrelname','varchar');
		$this->captura('numero_index_scan','bigint');
		$this->captura('numero_indices_devueltos','bigint');
		$this->captura('numero_tuplas_vivas','bigint');
		$this->captura('bloques_disco_leidos','bigint');
		$this->captura('bloques_buffer_leidos','bigint');
		
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;

	}
	function listarMonitorRecursos(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_monitor_bd_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_MONREC_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->count=false;
		
		$this->captura('usuario_bd','varchar');
		$this->captura('transaccion_actual','varchar');
		$this->captura('funcion_actual','varchar');
		$this->captura('consulta','text');
		$this->captura('hora_inicio_proceso','text');		
		$this->captura('hora_inicio_consulta','text');
		$this->captura('pid_bd','integer');
		$this->captura('comando_bd','varchar');
		$this->captura('usuario_pbd','varchar');
		$this->captura('pcpu_bd','numeric');
		$this->captura('pmem_bd','numeric');
		$this->captura('vmstat_bd','varchar');
		$this->captura('pid_web','integer');
		$this->captura('comando_web','varchar');
		$this->captura('usuario_web','varchar');
		$this->captura('pcpu_web','numeric');
		$this->captura('pmem_web','numeric');
		$this->captura('vmstat_web','varchar');
		$this->captura('sid_web','text');
			
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;

	}
	
	
}
?>