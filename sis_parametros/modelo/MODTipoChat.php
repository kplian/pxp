<?php
/****************************************************************************************
*@package pXP
*@file gen-MODTipoChat.php
*@author  (admin)
*@date 05-06-2020 16:49:24
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                05-06-2020 16:49:24    admin             Creacion    
  #
*****************************************************************************************/

class MODTipoChat extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarTipoChat(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_tipo_chat_sel';
        $this->transaccion='PM_TTC_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
		$this->captura('id_tipo_chat','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('grupo','varchar');
		$this->captura('tabla','varchar');
		$this->captura('nombre_id','varchar');
		$this->captura('tipo_chat','varchar');
		$this->captura('nombre','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarTipoChat(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_tipo_chat_ime';
        $this->transaccion='PM_TTC_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('grupo','grupo','varchar');
		$this->setParametro('tabla','tabla','varchar');
		$this->setParametro('nombre_id','nombre_id','varchar');
		$this->setParametro('tipo_chat','tipo_chat','varchar');
		$this->setParametro('nombre','nombre','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarTipoChat(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_tipo_chat_ime';
        $this->transaccion='PM_TTC_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_tipo_chat','id_tipo_chat','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('grupo','grupo','varchar');
		$this->setParametro('tabla','tabla','varchar');
		$this->setParametro('nombre_id','nombre_id','varchar');
		$this->setParametro('tipo_chat','tipo_chat','varchar');
		$this->setParametro('nombre','nombre','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarTipoChat(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_tipo_chat_ime';
        $this->transaccion='PM_TTC_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_tipo_chat','id_tipo_chat','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>