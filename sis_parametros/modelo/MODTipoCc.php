<?php
/**
*@package pXP
*@file gen-MODTipoCc.php
*@author  (admin)
*@date 26-05-2017 10:10:19
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoCc extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoCc(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_tipo_cc_sel';
		$this->transaccion='PM_TCC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_cc','int4');
		$this->captura('codigo','varchar');
		$this->captura('control_techo','varchar');
		$this->captura('mov_pres','_varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('movimiento','varchar');
		$this->captura('id_ep','int4');
		$this->captura('id_tipo_cc_fk','int4');
		$this->captura('descripcion','varchar');
		$this->captura('tipo','varchar');
		$this->captura('control_partida','varchar');
		$this->captura('momento_pres','_varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_ep','varchar');
		$this->captura('fecha_inicio','date');
		$this->captura('fecha_final','date');
		$this->captura('codigo_tccp','varchar');
		$this->captura('descripcion_tccp','varchar');
		$this->captura('mov_pres_str','varchar');
		$this->captura('momento_pres_str','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

   function listarTipoCcAll(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_tipo_cc_sel';
		$this->transaccion='PM_TCCALL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_cc','int4');
		$this->captura('codigo','varchar');
		$this->captura('control_techo','varchar');
		$this->captura('mov_pres','_varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('movimiento','varchar');
		$this->captura('id_ep','int4');
		$this->captura('id_tipo_cc_fk','int4');
		$this->captura('descripcion','varchar');
		$this->captura('tipo','varchar');
		$this->captura('control_partida','varchar');
		$this->captura('momento_pres','_varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_ep','varchar');
		$this->captura('fecha_inicio','date');
		$this->captura('fecha_final','date');
		$this->captura('codigo_tccp','varchar');
		$this->captura('descripcion_tccp','varchar');
		
	
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

   function listarTipoCcArb(){
		    //Definicion de variables para ejecucion del procedimientp
		   $this->procedimiento='param.ft_tipo_cc_sel';
		    $this-> setCount(false);
		    $this->transaccion='PM_TCCARB_SEL';
		    $this->tipo_procedimiento='SEL';//tipo de transaccion
		    
		    $id_padre = $this->objParam->getParametro('id_padre');
		    
		    $this->setParametro('node','node','varchar'); 
			  
		            
		    //Definicion de la lista del resultado del query
		    $this->captura('id_tipo_cc','int4');
			$this->captura('codigo','varchar');
			$this->captura('control_techo','varchar');
			$this->captura('mov_pres','varchar');
			$this->captura('estado_reg','varchar');
			$this->captura('movimiento','varchar');
			$this->captura('id_ep','int4');
			$this->captura('id_tipo_cc_fk','int4');
			$this->captura('descripcion','varchar');
			$this->captura('tipo','varchar');
			$this->captura('control_partida','varchar');
			$this->captura('momento_pres','varchar');
			$this->captura('fecha_reg','timestamp');
			$this->captura('usuario_ai','varchar');
			$this->captura('id_usuario_reg','int4');
			$this->captura('id_usuario_ai','int4');
			$this->captura('id_usuario_mod','int4');
			$this->captura('fecha_mod','timestamp');
			$this->captura('usr_reg','varchar');
			$this->captura('usr_mod','varchar');
			$this->captura('fecha_inicio','date');
			$this->captura('fecha_final','date');
			$this->captura('tipo_nodo','varchar');
			$this->captura('desc_ep','varchar');
			
			
			 
		     //Ejecuta la instruccion
		     $this->armarConsulta();
			 $this->ejecutarConsulta();
		    
		    return $this->respuesta;       
    }
			
			
	function insertarTipoCcArb(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_cc_ime';
		$this->transaccion='PM_TCC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('control_techo','control_techo','varchar');
		$this->setParametro('mov_pres','mov_pres','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('movimiento','movimiento','varchar');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_tipo_cc_fk','id_tipo_cc_fk','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('control_partida','control_partida','varchar');
		$this->setParametro('momento_pres','momento_pres','varchar');
		$this->setParametro('fecha_inicio','fecha_inicio','date');		
		$this->setParametro('fecha_final','fecha_final','date');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->getConsulta();
		//exit;
	   
		
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoCcArb(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_cc_ime';
		$this->transaccion='PM_TCC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_cc','id_tipo_cc','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('control_techo','control_techo','varchar');
		$this->setParametro('mov_pres','mov_pres','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('movimiento','movimiento','varchar');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_tipo_cc_fk','id_tipo_cc_fk','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('control_partida','control_partida','varchar');
		$this->setParametro('momento_pres','momento_pres','varchar');
		$this->setParametro('fecha_inicio','fecha_inicio','date');		
		$this->setParametro('fecha_final','fecha_final','date');
		$this->setParametro('mov_pres_str','mov_pres_str','varchar');
		$this->setParametro('momento_pres_str','momento_pres_str','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoCcArb(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_cc_ime';
		$this->transaccion='PM_TCC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_cc','id_tipo_cc','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>