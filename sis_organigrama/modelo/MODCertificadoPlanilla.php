<?php
/**
*@package pXP
*@file gen-MODCertificadoPlanilla.php
*@author  (miguel.mamani)
*@date 24-07-2017 14:48:34
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCertificadoPlanilla extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCertificadoPlanilla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_certificado_planilla_sel';
		$this->transaccion='OR_PLANC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_certificado_planilla','int4');
		$this->captura('tipo_certificado','varchar');
		$this->captura('fecha_solicitud','date');
		$this->captura('beneficiario','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('importe_viatico','numeric');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_funcionario1','text');
        $this->captura('nro_tramite','varchar');
        $this->captura('estado','varchar');
        $this->captura('id_proceso_wf','int4');
        $this->captura('id_estado_wf','int4');
        $this->captura('nombre_cargo','varchar');
        $this->captura('ci','varchar');
        $this->captura('haber_basico','numeric');
        $this->captura('expedicion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		//var_dump($this->respuesta); exit;
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarCertificadoPlanilla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_certificado_planilla_ime';
		$this->transaccion='OR_PLANC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('tipo_certificado','tipo_certificado','varchar');
		$this->setParametro('fecha_solicitud','fecha_solicitud','date');
		//$this->setParametro('beneficiario','beneficiario','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('importe_viatico','importe_viatico','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCertificadoPlanilla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_certificado_planilla_ime';
		$this->transaccion='OR_PLANC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_certificado_planilla','id_certificado_planilla','int4');
		$this->setParametro('tipo_certificado','tipo_certificado','varchar');
		$this->setParametro('fecha_solicitud','fecha_solicitud','date');
		$this->setParametro('beneficiario','beneficiario','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('importe_viatico','importe_viatico','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCertificadoPlanilla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_certificado_planilla_ime';
		$this->transaccion='OR_PLANC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_certificado_planilla','id_certificado_planilla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    function siguienteEstado()
    {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'orga.ft_certificado_planilla_ime';
        $this->transaccion = 'OR_SIGUE_EMI';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id_proceso_wf_act', 'id_proceso_wf_act', 'int4');
        $this->setParametro('id_estado_wf_act', 'id_estado_wf_act', 'int4');
        $this->setParametro('id_tipo_estado', 'id_tipo_estado', 'int4');
        $this->setParametro('id_funcionario_wf', 'id_funcionario_wf', 'int4');
        $this->setParametro('id_depto_wf', 'id_depto_wf', 'int4');
        $this->setParametro('obs', 'obs', 'text');
        $this->setParametro('json_procesos', 'json_procesos', 'text');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    function anteriorEstado()
    {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'orga.ft_certificado_planilla_ime';
        $this->transaccion = 'OR_ANTE_IME';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id_proceso_wf', 'id_proceso_wf', 'int4');
        $this->setParametro('id_estado_wf', 'id_estado_wf', 'int4');
        $this->setParametro('obs', 'obs', 'text');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    function reporteCertificado()
    {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'orga.ft_certificado_planilla_sel';
        $this->transaccion = 'OR_CERT_REP';
        $this->tipo_procedimiento = 'SEL';

        //Define los parametros para la funcion
        $this->setCount(false);
        $this->setParametro('id_proceso_wf', 'id_proceso_wf', 'int4');
        $this->setParametro('id_usuario','id_usuario','int4');

        $this->captura('nombre_funcionario','text');
        $this->captura('nombre_cargo','varchar');
        $this->captura('fecha_contrato','date');
        $this->captura('haber_basico','numeric');
        $this->captura('ci','varchar');
        $this->captura('expedicion','varchar');
        $this->captura('genero','varchar');
        $this->captura('fecha_solicitud','date');
        $this->captura('nombre_unidad','varchar');
        $this->captura('haber_literal','varchar');
        $this->captura('jefa_recursos','text');
        $this->captura('tipo_certificado','varchar');
        $this->captura('importe_viatico','numeric');
        $this->captura('literal_importe_viatico','varchar');
        $this->captura('nro_tramite','varchar');
        $this->captura('iniciales','varchar');
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
      // var_dump($this->respuesta); exit;
        //Devuelve la respuesta
        return $this->respuesta;
    }



}
?>