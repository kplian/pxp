<?php
/****************************************************************************************
*@package pXP
*@file gen-MODTipoEnvioCorreo.php
*@author  (egutierrez)
*@date 26-11-2020 15:26:10
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                26-11-2020 15:26:10    egutierrez             Creacion    
  #
*****************************************************************************************/

class MODTipoEnvioCorreo extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarTipoEnvioCorreo(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_tipo_envio_correo_sel';
        $this->transaccion='PM_GRC_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
		$this->captura('id_tipo_envio_correo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('dias_envio','varchar');
		$this->captura('dias_consecutivo','varchar');
		$this->captura('habilitado','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('dias_vencimiento','integer');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarTipoEnvioCorreo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_tipo_envio_correo_ime';
        $this->transaccion='PM_GRC_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('dias_envio','dias_envio','varchar');
		$this->setParametro('dias_consecutivo','dias_consecutivo','varchar');
		$this->setParametro('habilitado','habilitado','varchar');
        $this->setParametro('dias_vencimiento','dias_vencimiento','integer');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarTipoEnvioCorreo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_tipo_envio_correo_ime';
        $this->transaccion='PM_GRC_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_tipo_envio_correo','id_tipo_envio_correo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('dias_envio','dias_envio','varchar');
		$this->setParametro('dias_consecutivo','dias_consecutivo','varchar');
		$this->setParametro('habilitado','habilitado','varchar');
        $this->setParametro('dias_vencimiento','dias_vencimiento','integer');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarTipoEnvioCorreo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_tipo_envio_correo_ime';
        $this->transaccion='PM_GRC_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_tipo_envio_correo','id_tipo_envio_correo','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>