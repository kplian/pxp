<?php
/****************************************************************************************
*@package pXP
*@file gen-MODChat.php
*@author  (admin)
*@date 05-06-2020 16:50:02
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                05-06-2020 16:50:02    admin             Creacion    
  #
*****************************************************************************************/

class MODChat extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarChat(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_chat_sel';
        $this->transaccion='PM_CHAT_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
		$this->captura('id_chat','int4');
		$this->captura('descripcion','varchar');
		$this->captura('id_tipo_chat','int4');
		$this->captura('id_tabla','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
            
    function insertarChat(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_chat_ime';
        $this->transaccion='PM_CHAT_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_tipo_chat','id_tipo_chat','int4');
		$this->setParametro('id_tabla','id_tabla','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarChat(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_chat_ime';
        $this->transaccion='PM_CHAT_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_chat','id_chat','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_tipo_chat','id_tipo_chat','int4');
		$this->setParametro('id_tabla','id_tabla','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarChat(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_chat_ime';
        $this->transaccion='PM_CHAT_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_chat','id_chat','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>