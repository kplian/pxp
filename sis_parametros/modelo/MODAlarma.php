<?php
/**
*@package pXP
*@file gen-MODAlarma.php
*@author  (fprudencio)
*@date 18-11-2011 11:59:10
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/
class MODAlarma extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
	
	
	function GeneraAlarma(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_dispara_alarma_ime';
		$this->transaccion='PM_GENALA_INS';
		//definicion de variables
		$this->tipo_conexion='seguridad';
		$this->tipo_procedimiento='IME';
		$this->count=false;
				
		//$this->count=false;	
		$this->arreglo=array("id_usuario" =>1,
							 "tipo"=>'TODOS');
		
		//Define los parametros para ejecucion de la funcion
		$this->setParametro('id_usuario','id_usuario','integer');
		$this->setParametro('tipo','tipo','varchar');
		
		
		//Se definen los datos para las variables de sesion
		
				
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		
		 
		return $this->respuesta;
	}
	
	function modificarEnvioCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_alarma_ime';
		$this->transaccion='PM_DESCCOR_MOD';
		$this->tipo_procedimiento='IME';
		
		//definicion de variables
		$this->tipo_conexion='seguridad';
		
		
		$this->count=false;
				
		//$this->count=false;	
		
		
		$this->setParametro('id_usuario','id_usuario','integer');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('errores_id','errores_id','varchar');
		$this->setParametro('errores_msg','errores_msg','codigo_html');
		$this->setParametro('pendiente','pendiente','varchar');
				
		//Define los parametros para la funcion
		//$this->setParametro('id_alarma','id_alarma','int4');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function listarAlarmaCorrespondeciaPendiente(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_alarma_sel';
		$this->transaccion='PM_ALARMCOR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
		
		
		//definicion de variables
		$this->tipo_conexion='seguridad';
		
		//$this->count=false;	
		$this->arreglo=array("id_usuario" =>1,
							 "tipo"=>'TODOS');
							 
		$this->setParametro('id_usuario','id_usuario','integer');				 
		//Definicion de la lista del resultado del query
		$this->captura('id_alarma','int4');
		$this->captura('email_empresa','varchar');
		$this->captura('fecha','date');
		$this->captura('descripcion','varchar');
		$this->captura('clase','varchar');
		$this->captura('titulo','varchar');
		$this->captura('obs','varchar');
		$this->captura('tipo','varchar');
		$this->captura('dias','integer');
		$this->captura('titulo_correo','varchar');
		$this->captura('acceso_directo','varchar');
		$this->captura('correos','text');
		$this->captura('documentos','text');
		
		$this->captura('id_plantilla_correo','integer');
		$this->captura('url_acuse','varchar');
		$this->captura('requiere_acuse','varchar');
		$this->captura('mensaje_link_acuse','varchar');
		$this->captura('pendiente','varchar');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->getConsulta();exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	

			
	function listarAlarma(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_alarma_sel';
		$this->transaccion='PM_ALARM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
				
		//Definicion de la lista del resultado del query
		$this->setParametro('id_usuario','id_usuario','integer');
		$this->setParametro('id_funcionario','id_funcionario','integer');
		$this->captura('id_alarma','int4');
		$this->captura('acceso_directo','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('fecha','date');
		$this->captura('estado_reg','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('clase','varchar');
		$this->captura('titulo','varchar');
		$this->captura('parametros','varchar');
		$this->captura('obs','varchar');
		$this->captura('tipo','varchar');
		$this->captura('dias','integer');
		$this->captura('titulo_correo','varchar');
		$this->captura('id_usuario','int4');

		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

	



	function alarmaPendiente(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_alarma_sel';
		$this->transaccion='PM_ALARM_PEND';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(FALSE);
				
		//Definicion de la lista del resultado del query
		$this->captura('total','bigint');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}		
	function insertarAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_alarma_ime';
		$this->transaccion='PM_ALARM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('titulo','titulo','varchar');
		$this->setParametro('titulo_correo','titulo_correo','varchar');
		
		$this->setParametro('descripcion','descripcion','codigo_html');
		$this->setParametro('id_uos','id_uos','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_alarma_ime';
		$this->transaccion='PM_ALARM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_alarma','id_alarma','integer');
		$this->setParametro('titulo','titulo','varchar');
		$this->setParametro('titulo_correo','titulo_correo','varchar');
		$this->setParametro('descripcion','descripcion','codigo_html');
		$this->setParametro('id_uos','id_uos','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	

			
	function getAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_alarma_sel';
		$this->transaccion='PM_GETALA_SEL';
		$this->tipo_procedimiento='SEL';
		$this->setCount(false);
				
		//Define los parametros para la funcion
		$this->setParametro('id_alarma','alarma','int4');
		
		$this->captura('id_alarma','int4');
        $this->captura('acceso_directo','varchar');
        $this->captura('id_funcionario','int4');
        $this->captura('fecha','date');
        $this->captura('estado_reg','varchar');
        $this->captura('descripcion','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('clase','varchar');
        $this->captura('titulo','varchar');
        $this->captura('parametros','varchar');
        $this->captura('obs','varchar');
        $this->captura('tipo','varchar');
        $this->captura('dias','integer');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function eliminarAlarma(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_alarma_ime';
        $this->transaccion='PM_ALARM_ELI';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_alarma','id_alarma','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
	
	function listarAlarmaWF(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_alarma_sel';
		$this->transaccion='PM_ALARMWF_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
				
		//Definicion de la lista del resultado del query
		$this->captura('id_alarma','int4');
		$this->captura('sw_correo','integer');
		$this->captura('correos','text');
		$this->captura('descripcion','varchar');
		$this->captura('recibido','varchar');
		$this->captura('fecha_recibido','timestamp');
		$this->captura('estado_envio','varchar');
		$this->captura('desc_falla','text');
		$this->captura('titulo_correo','varchar');		
		$this->captura('dias','integer');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function reenviarCorreo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'param.ft_alarma_ime';
        $this->transaccion = 'PM_RECVORR_MOD';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id_alarma','id_alarma','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function alterarDestino(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'param.ft_alarma_ime';
        $this->transaccion = 'PM_CAMDESTINO_MOD';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id_alarma','id_alarma','int4');
		$this->setParametro('correos','correos','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
	
	function confirmarAcuseRecibo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento = 'param.ft_alarma_ime';
        $this->transaccion = 'PM_CONACUSE_MOD';
        $this->tipo_procedimiento = 'IME';		
		//definicion de variables
		$this->tipo_conexion='seguridad';
		$this->setParametro('alarma','alarma','varchar'); 
		
					
		$this->armarConsulta();		
		$this->ejecutarConsulta();		
		 
		return $this->respuesta;
	}
	
	function listarComunicado(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_alarma_sel';
		$this->transaccion='PM_COMUN_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
				
		//Definicion de la lista del resultado del query
		$this->captura('id_alarma','int4');
		$this->captura('acceso_directo','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('fecha','date');
		$this->captura('estado_reg','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('clase','varchar');
		$this->captura('titulo','varchar');
		$this->captura('parametros','varchar');
		$this->captura('obs','varchar');
		$this->captura('tipo','varchar');
		$this->captura('dias','integer');
		$this->captura('id_alarma_fk','integer');
		$this->captura('estado_comunicado','varchar');
		$this->captura('id_uos','varchar');
		$this->captura('titulo_correo','varchar');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

    function finalizarComunicado(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_alarma_ime';
        $this->transaccion='PM_GENDETCOM_MOD';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_alarma','id_alarma','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }


    function alarmaWebSocket(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_alarma_sel';
        $this->transaccion='PM_NOTISOCKET_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setCount(FALSE);

        //Definicion de la lista del resultado del query
        $this->captura('id_usuario','int4');
        $this->captura('titulo','text');
        $this->captura('titulo_correo','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }


}
?>