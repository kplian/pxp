<?php
/**
*@package pXP
*@file gen-MODConceptoIngas.php
*@author  (admin)
*@date 25-02-2013 19:49:23
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODConceptoIngas extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarConceptoIngas(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_concepto_ingas_sel';
		$this->transaccion='PM_CONIG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_concepto_ingas','int4');
		$this->captura('desc_ingas','varchar');
		$this->captura('tipo','varchar');
		$this->captura('movimiento','varchar');
		$this->captura('sw_tes','varchar');
		$this->captura('id_oec','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('activo_fijo','varchar');
		$this->captura('almacenable','varchar');
		$this->captura('id_grupo_ots','varchar');
		$this->captura('filtro_ot','varchar');
		$this->captura('requiere_ot','varchar');
		$this->captura('sw_autorizacion','varchar');
		$this->captura('id_entidad','integer');
		$this->captura('descripcion_larga','text');
		$this->captura('id_unidad_medida','int4');
		$this->captura('desc_unidad_medida','varchar');
		$this->captura('nandina','varchar');
		
		
		
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	/*
	Author RAC
	Date 20 Junio 2014
	Lista conceptos de gastos y los nobmre de las partidas
	es necesario filtrar ppor gestion 
	
	*/
	function listarConceptoIngasMasPartida(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.f_concepto_ingas_sel';
        $this->transaccion='PM_CONIGPAR_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $this->setParametro('autorizacion','autorizacion','varchar');
		$this->setParametro('autorizacion_nulos','autorizacion_nulos','varchar');
		
		        
        //Definicion de la lista del resultado del query
        $this->captura('id_concepto_ingas','int4');
        $this->captura('desc_ingas','varchar');
        $this->captura('tipo','varchar');
        $this->captura('movimiento','varchar');
        $this->captura('sw_tes','varchar');
        $this->captura('id_oec','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('activo_fijo','varchar');
        $this->captura('almacenable','varchar');
        $this->captura('desc_partida','text');
		$this->captura('id_grupo_ots','varchar');
		$this->captura('filtro_ot','varchar');
		$this->captura('requiere_ot','varchar');
		$this->captura('sw_autorizacion','varchar');
		
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
	
	function listarConceptoIngasPorPartidas(){
        //Definicion de variables para ejecucion del procedimientp
        //necesita sistema de presupuestos
        $this->procedimiento='param.f_concepto_ingas_sel';
        $this->transaccion='PM_CONIGPP_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->setParametro('id_partidas','id_partidas','varchar');
        $this->captura('id_concepto_ingas','int4');
        $this->captura('desc_ingas','varchar');
        $this->captura('tipo','varchar');
        $this->captura('movimiento','varchar');
        $this->captura('sw_tes','varchar');
        $this->captura('id_oec','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
		$this->captura('activo_fijo','varchar');
		$this->captura('almacenable','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
    /*
	 * Autor RAC
	 * DESC  lista concepto de gasto permitidos dentro de un presupeusto es necesario enviar el id presupuesto
	 * */

    function listarConceptoIngasPresupuesto(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.f_concepto_ingas_sel';
        $this->transaccion='PM_CONIGPRE_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $this->setParametro('autorizacion','autorizacion','varchar');
		$this->setParametro('autorizacion_nulos','autorizacion_nulos','varchar');
		$this->setParametro('id_presupuesto','id_presupuesto','integer');
		
		        
        //Definicion de la lista del resultado del query
        $this->captura('id_concepto_ingas','int4');
        $this->captura('desc_ingas','varchar');
        $this->captura('tipo','varchar');
        $this->captura('movimiento','varchar');
        $this->captura('sw_tes','varchar');
        $this->captura('id_oec','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('activo_fijo','varchar');
        $this->captura('almacenable','varchar');
        $this->captura('desc_partida','text');
		$this->captura('id_grupo_ots','varchar');
		$this->captura('filtro_ot','varchar');
		$this->captura('requiere_ot','varchar');
		$this->captura('sw_autorizacion','varchar');
		$this->captura('desc_gestion','varchar');
		
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
			
	function insertarConceptoIngas(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_concepto_ingas_ime';
		$this->transaccion='PM_CONIG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('desc_ingas','desc_ingas','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('movimiento','movimiento','varchar');
		$this->setParametro('sw_tes','sw_tes','varchar');
		$this->setParametro('id_oec','id_oec','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('activo_fijo','activo_fijo','varchar');
		$this->setParametro('almacenable','almacenable','varchar');
		
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('nandina','nandina','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarConceptoIngas(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_concepto_ingas_ime';
		$this->transaccion='PM_CONIG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
		$this->setParametro('desc_ingas','desc_ingas','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('movimiento','movimiento','varchar');
		$this->setParametro('sw_tes','sw_tes','varchar');
		$this->setParametro('id_oec','id_oec','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('activo_fijo','activo_fijo','varchar');
		$this->setParametro('almacenable','almacenable','varchar');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('nandina','nandina','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarConceptoIngas(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_concepto_ingas_ime';
		$this->transaccion='PM_CONIG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function editOt(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_concepto_ingas_ime';
		$this->transaccion='PM_CONEDOT_IME';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
		$this->setParametro('id_grupo_ots','id_grupo_ots','varchar');
		$this->setParametro('requiere_ot','requiere_ot','varchar');
		$this->setParametro('filtro_ot','filtro_ot','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

    function editAuto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_concepto_ingas_ime';
		$this->transaccion='PM_COAUTO_IME';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
		$this->setParametro('sw_autorizacion','sw_autorizacion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	
			
}
?>