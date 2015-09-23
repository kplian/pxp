<?php
/**
*@package pXP
*@file gen-MODProcesoMacro.php
*@author  (admin)
*@date 19-02-2013 13:51:29
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProcesoMacro extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProcesoMacro(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_proceso_macro_sel';
		$this->transaccion='WF_PROMAC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proceso_macro','int4');
		$this->captura('id_subsistema','int4');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('inicio','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_subsistema','varchar');
		$this->captura('grupo_doc','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarProcesoMacro(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_proceso_macro_ime';
		$this->transaccion='WF_PROMAC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_subsistema','id_subsistema','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('inicio','inicio','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('grupo_doc','grupo_doc','codigo_html');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProcesoMacro(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_proceso_macro_ime';
		$this->transaccion='WF_PROMAC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('id_subsistema','id_subsistema','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('inicio','inicio','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('grupo_doc','grupo_doc','codigo_html');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProcesoMacro(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_proceso_macro_ime';
		$this->transaccion='WF_PROMAC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function exportarDatosWf() {
		
		$this->procedimiento='wf.ft_proceso_macro_sel';
			$this->transaccion='WF_EXPPROMAC_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			
			$this->setParametro('id_proceso_macro','id_proceso_macro','integer');
			$this->setParametro('todo','todo','varchar');	
			
			$this->captura('tipo','varchar');
			$this->captura('codigo','varchar');
			$this->captura('codigo_subsistema','varchar');
			$this->captura('nombre','varchar');
			$this->captura('inicio','varchar');
			$this->captura('estado_reg','varchar');
		
		$this->armarConsulta();	
		
        $this->ejecutarConsulta();  		
		////////////////////////////
		
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_categoria_documento_sel';
			$this->transaccion='WF_EXPCATDOC_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();		
			
			$this->captura('tipo','varchar');
			$this->captura('codigo','varchar');
			$this->captura('nombre','varchar');			
			$this->captura('estado_reg','varchar');			
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}

		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_tipo_proceso_sel';
			$this->transaccion='WF_EXPTIPPROC_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();		
			
			$this->captura('tipo','varchar');
			$this->captura('codigo','varchar');
			$this->captura('codigo_tipo_estado','varchar');
			$this->captura('codigo_tipo_proceso_estado','varchar');
			$this->captura('codigo_pm','varchar');
			$this->captura('nombre','varchar');
			$this->captura('tabla','varchar');
			$this->captura('columna_llave','varchar');
			$this->captura('inicio','varchar');
			$this->captura('funcion_validacion','varchar');
			$this->captura('tipo_disparo','varchar');
			$this->captura('descripcion','varchar');
			$this->captura('codigo_llave','varchar');
			$this->captura('estado_reg','varchar');
			$this->captura('funcion_disparo_wf','varchar');
			
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  		
			$this->ejecutarConsulta($this->respuesta);
		}
		
		////////////////////////
		
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
			$this->procedimiento='wf.ft_tabla_sel';
			$this->transaccion='WF_EXPTABLA_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);	
			$this->resetCaptura();
			$this->addConsulta();				
			
			//defino varialbes que se captran como retornod e la funcion
			$this->captura('tipo','varchar');
			$this->captura('codigo_tabla','varchar');
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('nombre_tabla','varchar');
			$this->captura('descripcion','text');
			$this->captura('scripts_extras','text');
			$this->captura('vista_tipo','varchar');
			$this->captura('vista_posicion','varchar');
			$this->captura('vista_codigo_tabla_maestro','varchar');
			$this->captura('vista_campo_ordenacion','varchar');
			$this->captura('vista_dir_ordenacion','varchar');
			$this->captura('vista_campo_maestro','varchar');
			$this->captura('vista_scripts_extras','text');
			$this->captura('menu_nombre','varchar');
			$this->captura('menu_icono','varchar');
			$this->captura('menu_codigo','varchar');
			$this->captura('vista_estados_new','text');
			$this->captura('vista_estados_delete','text');
			$this->captura('estado_reg','varchar');
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();
			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		
		////////////////////////////
		
		
		

		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_tipo_estado_sel';
			$this->transaccion='WF_EXPTIPES_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			
			$this->captura('tipo','varchar');
			$this->captura('codigo','varchar');
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('nombre_estado','varchar');
			$this->captura('inicio','varchar');
			$this->captura('disparador','varchar');
			$this->captura('fin','varchar');
			$this->captura('tipo_asignacion','varchar');
			$this->captura('nombre_func_list','varchar');
			$this->captura('depto_asignacion','varchar');
			$this->captura('nombre_depto_func_list','varchar');
			$this->captura('obs','text');
			$this->captura('alerta','varchar');
			$this->captura('pedir_obs','varchar');
			$this->captura('descripcion','varchar');
			$this->captura('plantilla_mensaje','varchar');
			$this->captura('plantilla_mensaje_asunto','varchar');
			$this->captura('cargo_depto','text');
			$this->captura('mobile','varchar');
			$this->captura('funcion_inicial','varchar');
			$this->captura('funcion_regreso','varchar');
			$this->captura('acceso_directo_alerta','varchar');
			$this->captura('nombre_clase_alerta','varchar');
			$this->captura('tipo_noti','varchar');
			$this->captura('titulo_alerta','varchar');
			$this->captura('parametros_ad','varchar');
			$this->captura('estado_reg','varchar');	
			$this->captura('codigo_estado_anterior','varchar');		
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_tipo_columna_sel';
			$this->transaccion='WF_EXPTIPCOL_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			
			$this->captura('tipo','varchar');
			$this->captura('nombre_columna','varchar');
			$this->captura('codigo_tabla','varchar');
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('tipo_columna','varchar');
			$this->captura('descripcion','text');	
			$this->captura('tamano','varchar');
			$this->captura('campos_adicionales','text');
			$this->captura('joins_adicionales','text');
			$this->captura('formula_calculo','text');
			$this->captura('grid_sobreescribe_filtro','text');	
			$this->captura('grid_campos_adicionales','text');
			$this->captura('form_tipo_columna','varchar');
			$this->captura('form_label','varchar');
			$this->captura('form_es_combo','varchar');
			$this->captura('form_combo_rec','varchar');	
			$this->captura('form_sobreescribe_config','text');
			$this->captura('estado_reg','varchar');
			$this->captura('bd_prioridad','integer');
			$this->captura('form_grupo','integer');
            $this->captura('bd_campos_subconsulta','text');
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_tipo_documento_sel';
			$this->transaccion='WF_EXPTIPDW_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			
			$this->captura('tipo','varchar');
			$this->captura('codigo','varchar');		
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('nombre','varchar');
			$this->captura('descripcion','text');
			$this->captura('action','varchar');
			$this->captura('tipo_documento','varchar');
			$this->captura('estado_reg','varchar');
			$this->captura('orden','numeric');
			$this->captura('categoria_documento','varchar[]');
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();
			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_labores_tipo_proceso_sel';
			$this->transaccion='WF_EXPLABTPROC_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			
			$this->captura('tipo','varchar');
			$this->captura('codigo','varchar');
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('nombre','varchar');
			$this->captura('descripcion','varchar');
			$this->captura('estado_reg','varchar');
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();
			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		

		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_tipo_documento_estado_sel';
			$this->transaccion='WF_EXPDES_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			
			$this->captura('tipo','varchar');
			$this->captura('codigo_tipo_documento','varchar');	
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('codigo_tipo_estado','varchar');
			$this->captura('codigo_tipo_proceso_externo','varchar');
			$this->captura('momento','varchar');
			$this->captura('tipo_busqueda','varchar');
			$this->captura('regla','varchar');
			$this->captura('estado_reg','varchar');
						
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_columna_estado_sel';
			$this->transaccion='WF_EXPCOLEST_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			
			$this->captura('tipo','varchar');			
			$this->captura('nombre_tipo_columna','varchar');
			$this->captura('codigo_tabla','varchar');	
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('codigo_tipo_estado','varchar');
			$this->captura('momento','varchar');
			$this->captura('regla','varchar');
			$this->captura('estado_reg','varchar');						
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}

		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_estructura_estado_sel';
			$this->transaccion='WF_EXPESTES_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			
			$this->captura('tipo','varchar');			
			$this->captura('codigo_estado_padre','varchar');	
			$this->captura('codigo_estado_hijo','varchar');
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('prioridad','integer');
			$this->captura('regla','varchar');
			$this->captura('estado_reg','varchar');
						
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}

		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_tipo_proceso_origen_sel';
			$this->transaccion='WF_EXPTPO_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();			
			
			$this->captura('tipo','varchar');
			$this->captura('codigo_tipo_proceso','varchar');	
			$this->captura('codigo_pm','varchar');
			$this->captura('codigo_tipo_proceso_origen','varchar');
			$this->captura('codigo_tipo_estado','varchar');
			$this->captura('tipo_disparo','varchar');
			$this->captura('funcion_validacion_wf','text');
			$this->captura('estado_reg','varchar');
						
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}

		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_funcionario_tipo_estado_sel';
			$this->transaccion='WF_EXPFUNTES_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();			
			
			$this->captura('tipo','varchar');
			$this->captura('codigo_tipo_estado','varchar');	
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('ci','varchar');
			$this->captura('codigo_depto','varchar');
			$this->captura('regla','varchar');			
			$this->captura('estado_reg','varchar');
						
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_plantilla_correo_sel';
			$this->transaccion='WF_EXPCORREO_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();			
			
			$this->captura('tipo','varchar');
			$this->captura('codigo','varchar');
			$this->captura('codigo_tipo_estado','varchar');	
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('regla','text');
			$this->captura('plantilla','text');
			$this->captura('correos','text');			
			$this->captura('estado_reg','varchar');
			$this->captura('asunto','varchar');
						
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}

		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento='wf.ft_tipo_estado_rol_sel';
			$this->transaccion='WF_EXPTESROL_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();			
			
			$this->captura('tipo','varchar');
			$this->captura('codigo_tipo_proceso','varchar');
			$this->captura('codigo_tipo_estado','varchar');	
			$this->captura('codigo_rol','varchar');					
			$this->captura('estado_reg','varchar');
						
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
        
       return $this->respuesta;		
	
	}			
}
?>