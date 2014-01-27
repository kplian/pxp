<?php
/***
 Nombre: 	MODSubsistema.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tsubsistema del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODSubsistema extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarSubsistema(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_subsistema_sel';// nombre procedimiento almacenado
		$this->transaccion='SEG_SUBSIS_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		//Definicion de la lista del resultado del query
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_subsistema','integer');
		$this->captura('codigo','varchar');
		$this->captura('prefijo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','pxp.estado_reg');
		$this->captura('nombre_carpeta','varchar');
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
    	return $this->respuesta;

	}
	
	function insertarSubsistema(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_subsistema_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_SUBSIS_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		//Define los parametros para la funcion	
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('prefijo','prefijo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('nombre_carpeta','nombre_carpeta','varchar');
	
    	//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarSubsistema(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_subsistema_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_SUBSIS_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('prefijo','prefijo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('nombre_carpeta','nombre_carpeta','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarSubsistema(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_subsistema_ime';
		$this->transaccion='SEG_SUBSIS_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_subsistema','id_subsistema','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function exportarDatosSeguridad() {
		
		$this->procedimiento='segu.ft_gui_sel';
			$this->transaccion='SEG_EXPGUI_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			
			$this->setParametro('id_subsistema','id_subsistema','integer');
			$this->setParametro('todo','todo','varchar');	
			$this->captura('tipo','varchar');
			$this->captura('nombre','varchar');
			$this->captura('descripcion','text');
			$this->captura('codigo_gui','varchar');
			$this->captura('visible','segu.si_no');
			$this->captura('orden_logico','integer');
			$this->captura('ruta_archivo','text');
			$this->captura('nivel','integer');
			$this->captura('icono','varchar');
			$this->captura('clase_vista','varchar');
			$this->captura('subsistema','varchar');
			$this->captura('estado_reg','pxp.estado_reg');
			
		
		
		
		
		
		$this->armarConsulta();	
		
        $this->ejecutarConsulta();  
		
		////////////////////////////
		
		
		

		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='segu.ft_estructura_gui_sel';
			$this->transaccion='SEG_EXPESTGUI_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			$this->captura('tipo','varchar');
			$this->captura('codigo_gui','varchar');
			$this->captura('fk_codigo_gui','varchar');
			$this->captura('estado_reg','segu.activo_inactivo');
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		////////////////////////
		
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
			$this->procedimiento='segu.ft_funcion_sel';
			$this->transaccion='SEG_EXPFUN_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);	
			$this->resetCaptura();
			$this->addConsulta();	
				    
			
			//defino varialbes que se captran como retornod e la funcion
			$this->captura('tipo','varchar');
			$this->captura('nombre','varchar');
			$this->captura('descripcion','text');
			$this->captura('subsistema','varchar');
			$this->captura('estado_reg','segu.activo_inactivo');
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();
			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		
		////////////////////////////
		
		
		

		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='segu.ft_procedimiento_sel';
			$this->transaccion='SEG_EXPPROC_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			$this->captura('tipo','varchar');
			$this->captura('codigo','varchar');
			$this->captura('descripcion','text');
			$this->captura('habilita_log','segu.si_no');
			$this->captura('autor','varchar');
			$this->captura('fecha_creacion','varchar');
			$this->captura('funcion','varchar');
			$this->captura('estado_reg','pxp.estado_reg');
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='segu.ft_procedimiento_gui_sel';
			$this->transaccion='SEG_EXPPROCGUI_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			$this->captura('tipo','varchar');
			$this->captura('codigo','varchar');
			$this->captura('codigo_gui','varchar');
			$this->captura('boton','segu.si_no');
			$this->captura('estado_reg','pxp.estado_reg');	
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='segu.ft_rol_sel';
			$this->transaccion='SEG_EXPROL_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			
			$this->captura('tipo','varchar');		
			$this->captura('descripcion','text');
			$this->captura('rol','varchar');
			$this->captura('desc_codigo','varchar');
			$this->captura('estado_reg','segu.activo_inactivo');
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();
			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='segu.ft_gui_rol_sel';
			$this->transaccion='SEG_EXPGUIROL_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			$this->captura('tipo','varchar');
			$this->captura('codigo_gui','varchar');
			$this->captura('rol','varchar');
			$this->captura('estado_reg','segu.activo_inactivo');
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();
			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		

		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='segu.ft_rol_procedimiento_gui_sel';
			$this->transaccion='SEG_EXPROLPROGUI_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			$this->captura('tipo','varchar');	
			$this->captura('rol','varchar');
			$this->captura('codigo','varchar');
			$this->captura('codigo_gui','varchar');
			$this->captura('estado_reg','segu.activo_inactivo');
						
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
        
       return $this->respuesta;		
	
	}
	
}
?>