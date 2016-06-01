<?php
/**
*@package pXP
*@file gen-MODCatalogoTipo.php
*@author  (admin)
*@date 27-11-2012 23:32:44
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCatalogoTipo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCatalogoTipo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_catalogo_tipo_sel';
		$this->transaccion='PM_PACATI_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_catalogo_tipo','int4');
		$this->captura('nombre','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('id_subsistema','int4');
		$this->captura('desc_subsistema','varchar');
		$this->captura('tabla','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarCatalogoTipo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_catalogo_tipo_ime';
		$this->transaccion='PM_PACATI_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('tabla','tabla','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCatalogoTipo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_catalogo_tipo_ime';
		$this->transaccion='PM_PACATI_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_catalogo_tipo','id_catalogo_tipo','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('tabla','tabla','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCatalogoTipo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_catalogo_tipo_ime';
		$this->transaccion='PM_PACATI_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_catalogo_tipo','id_catalogo_tipo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function exportarDatos() {
		
		$this->procedimiento='param.ft_catalogo_tipo_sel';
			$this->transaccion='PM_EXCATPO_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			
			$this->setParametro('id_catalogo_tipo','id_catalogo_tipo','integer');
			
			//Definicion de la lista del resultado del query
			$this->captura('tipo_reg','varchar');
			$this->captura('id_catalogo_tipo','int4');
			$this->captura('nombre','varchar');
			$this->captura('id_subsistema','int4');
			$this->captura('codigo_subsistema','varchar');
			$this->captura('tabla','varchar');
		
		$this->armarConsulta();	
		
        $this->ejecutarConsulta(); 
		 		
		////////////////////////////
		
		
		if($this->respuesta->getTipo() == 'ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento = 'param.ft_catalogo_tipo_sel';
			$this->transaccion = 'PM_EXCATA_SEL';
			$this->tipo_procedimiento = 'SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();		
			
			$this->captura('tipo_reg','varchar');
			$this->captura('id_catalogo','int4');
			$this->captura('id_catalogo_tipo','integer');
			$this->captura('id_subsistema','integer');
	        $this->captura('codigo_subsistema','varchar');
			$this->captura('descripcion','varchar');
			$this->captura('codigo','varchar');
			$this->captura('desc_catalogo_tipo','varchar');
		
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}

		
       return $this->respuesta;		
	
	}	
	
	
			
}
?>