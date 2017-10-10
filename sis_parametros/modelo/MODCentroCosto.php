<?php
/**
*@package pXP
*@file gen-MODCentroCosto.php
*@author  (admin)
*@date 19-02-2013 22:53:59
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCentroCosto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
	 
	function listarCentroCostoGrid(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_centro_costo_sel';
		$this->transaccion='PM_CENCOS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_centro_costo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_ep','int4');
		$this->captura('id_gestion','int4');
		$this->captura('id_uo','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('codigo_uo','varchar');
		$this->captura('nombre_uo','varchar');
		$this->captura('ep','text');
		$this->captura('gestion','integer');
		$this->captura('codigo_cc','text');
		
		$this->captura('nombre_programa','varchar');
		$this->captura('nombre_proyecto','varchar');
		$this->captura('nombre_actividad','varchar');
		$this->captura('nombre_financiador','varchar');
		$this->captura('nombre_regional','varchar');
		//$this->captura('movimiento_tipo_pres','varchar');	
		
		$this->captura('id_tipo_cc','int4');
		$this->captura('codigo_tcc','varchar');
		$this->captura('descripcion_tcc','varchar');	
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function listarCentroCosto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_centro_costo_sel';
		$this->transaccion='PM_CEC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_centro_costo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_ep','int4');
		$this->captura('id_gestion','int4');
		$this->captura('id_uo','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('codigo_uo','varchar');
		$this->captura('nombre_uo','varchar');
		$this->captura('ep','text');
		$this->captura('gestion','integer');
		$this->captura('codigo_cc','text');
		
		$this->captura('nombre_programa','varchar');
		$this->captura('nombre_proyecto','varchar');
		$this->captura('nombre_actividad','varchar');
		$this->captura('nombre_financiador','varchar');
		$this->captura('nombre_regional','varchar');
		$this->captura('movimiento_tipo_pres','varchar');
				
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	/*
    Autor: Jaime
    Fecha:  31-05-2013
    Listado de centrode costo filtrado por ep configuradas al depto de 
    o a un grupo (Tomar en cuenta que solo filtra por EP)
    
    */

	function listarCentroCostoCombo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_centro_costo_sel';
		$this->transaccion='PM_CECCOM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setParametro('codigo_subsistema','codigo_subsistema','varchar');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_centro_costo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_ep','int4');
		$this->captura('id_gestion','int4');
		$this->captura('id_uo','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('codigo_uo','varchar');
		$this->captura('nombre_uo','varchar');
		$this->captura('ep','text');
		$this->captura('gestion','integer');
		$this->captura('codigo_cc','text');
		
		$this->captura('nombre_programa','varchar');
        $this->captura('nombre_proyecto','varchar');
        $this->captura('nombre_actividad','varchar');
        $this->captura('nombre_financiador','varchar');
        $this->captura('nombre_regional','varchar'); 
		$this->captura('movimiento_tipo_pres','varchar');   
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	/*
	Autor: Rac
	Fecha:  31-05-2013
	Desc permite listar centro de costos filtrando por la configuracion
	de ep y uo configuradas en los grupo de usuario
	
	*/
	function listarCentroCostoFiltradoXUsuaio(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.f_centro_costo_sel';
        $this->transaccion='PM_CECCOMFU_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->captura('id_centro_costo','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_ep','int4');
        $this->captura('id_gestion','int4');
        $this->captura('id_uo','int4');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        
        $this->captura('codigo_uo','varchar');
        $this->captura('nombre_uo','varchar');
        $this->captura('ep','text');
        $this->captura('gestion','integer');
        $this->captura('codigo_cc','text');
        
        $this->captura('nombre_programa','varchar');
        $this->captura('nombre_proyecto','varchar');
        $this->captura('nombre_actividad','varchar');
        $this->captura('nombre_financiador','varchar');
        $this->captura('nombre_regional','varchar'); 
		$this->captura('movimiento_tipo_pres','varchar');   
        
        
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
    
    /*
    Autor: Rac
    Fecha:  31-05-2013
    Desc permite listar centro de costos filtrando por la configuracion
    de ep y uo configuradas en los grupo de usuario
    
    */
    function listarCentroCostoFiltradoXDepto(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.f_centro_costo_sel';
        $this->transaccion='PM_CCFILDEP_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setParametro('id_depto','id_depto','integer'); 
        $this->setParametro('filtrar','filtrar','varchar');               
        //Definicion de la lista del resultado del query
        $this->captura('id_centro_costo','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_ep','int4');
        $this->captura('id_gestion','int4');
        $this->captura('id_uo','int4');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        
        $this->captura('codigo_uo','varchar');
        $this->captura('nombre_uo','varchar');
        $this->captura('ep','text');
        $this->captura('gestion','integer');
        $this->captura('codigo_cc','text');
        
        $this->captura('nombre_programa','varchar');
        $this->captura('nombre_proyecto','varchar');
        $this->captura('nombre_actividad','varchar');
        $this->captura('nombre_financiador','varchar');
        $this->captura('nombre_regional','varchar'); 
		$this->captura('movimiento_tipo_pres','varchar');   
        
        
        
        //Ejecuta la instruccion
        $this->armarConsulta();
		//echo $this->consulta;exit;
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
			
	function insertarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_centro_costo_ime';
		$this->transaccion='PM_CEC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_tipo_cc','id_tipo_cc','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_centro_costo_ime';
		$this->transaccion='PM_CEC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_centro_costo','id_centro_costo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_tipo_cc','id_tipo_cc','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_centro_costo_ime';
		$this->transaccion='PM_CEC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_centro_costo','id_centro_costo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function listarCentroCostoProyecto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_centro_costo_sel';
		$this->transaccion='PM_CCPRO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

		//Define los parametros para la funcion
		$this->setParametro('id_proyecto_ep','id_proyecto_ep','int4');

		//Definicion de la lista del resultado del query
		$this->captura('id_centro_costo','int4');
		$this->captura('id_gestion','int4');
		$this->captura('codigo_uo','varchar');
		$this->captura('nombre_uo','varchar');
		$this->captura('gestion','int4');
		$this->captura('codigo_cc','text');
		$this->captura('nombre_proyecto','varchar');
		$this->captura('codigo_tcc','varchar');
		$this->captura('descripcion_tcc','varchar');
		$this->captura('fecha_inicio','date');
		$this->captura('fecha_final','date');
		$this->captura('id_proyecto','int4');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>