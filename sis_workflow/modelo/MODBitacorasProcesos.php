<?php
/**
*@package pXP
*@file gen-MODBitacotasProcesos.php
*@author  (admin)
*@date 21-03-2017 16:31:09
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODBitacorasProcesos extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarBitacotasProcesos(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_bitacoras_procesos_sel';
		$this->transaccion='WF_BTS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
        $this->captura('id_tipo_proceso','int4');
		$this->captura('tipo_proceso','varchar');
        $this->captura('nro_tramite','varchar');
        $this->captura('nombre_estado','varchar');
		$this->captura('date_part','float8');
        $this->captura('fecha_ini','timestamp');
        $this->captura('fecha_fin','timestamp');
        $this->captura('estado_sig','varchar');
        $this->captura('proveido','text');
		$this->captura('proceso_wf','varchar');
        $this->captura('id_proceso_wf','int4');
		$this->captura('id_estado_wf','int4');
        $this->captura('id_funcionario','int4');
		//$this->captura('desc_funcionario1','text');
		$this->captura('nombre_completo1','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarBitacotasProcesos(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_bitacoras_procesos_sel';
		$this->transaccion='WF_BTS_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('tipo_proceso','tipo_proceso','varchar');
		$this->setParametro('date_part','date_part','float8');
		$this->setParametro('nombre_estado','nombre_estado','varchar');
		$this->setParametro('proceso_wf','proceso_wf','varchar');
		$this->setParametro('nom_estado','nom_estado','varchar');
		$this->setParametro('proveido','proveido','text');
		$this->setParametro('fecha_fin','fecha_fin','timestamp');
		$this->setParametro('fecha_inicio','fecha_inicio','timestamp');
		$this->setParametro('nro_tramite','nro_tramite','varchar');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		$this->setParametro('id_estado_wf','id_estado_wf','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarBitacotasProcesos(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_bitacoras_procesos_sel';
		$this->transaccion='WF_BTS_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion

		$this->setParametro('tipo_proceso','tipo_proceso','varchar');
		$this->setParametro('date_part','date_part','float8');
		$this->setParametro('nombre_estado','nombre_estado','varchar');
		$this->setParametro('proceso_wf','proceso_wf','varchar');
		$this->setParametro('nom_estado','nom_estado','varchar');
		$this->setParametro('proveido','proveido','text');
		$this->setParametro('fecha_fin','fecha_fin','timestamp');
		$this->setParametro('fecha_inicio','fecha_inicio','timestamp');
		$this->setParametro('nro_tramite','nro_tramite','varchar');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		$this->setParametro('id_estado_wf','id_estado_wf','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}


    function listarBitacorasProceso(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.ft_bitacoras_procesos_sel';
        $this->transaccion='WF_PRO_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion


        //Definicion de la lista del resultado del query
        $this->captura('id_tipo_proceso','int4');
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('id_proceso_macro','int4');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        //var_dump($this->respuesta); exit;
        //Devuelve la respuesta
        return $this->respuesta;
    }
    function listaGetDatos(){

        $this->procedimiento ='wf.ft_bitacoras_procesos_sel';
        $this->transaccion='MAT_FUN_GET';
        $this->tipo_procedimiento='SEL';
        $this->setParametro('p_id_usuario','p_id_usuario','int4');
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        //var_dump($this->respuesta); exit;
        //Devuelve la respuesta
        return $this->respuesta;
    }

}
?>