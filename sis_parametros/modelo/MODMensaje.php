<?php
/****************************************************************************************
*@package pXP
*@file gen-MODMensaje.php
*@author  (favio)
*@date 15-06-2020 21:17:46
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                15-06-2020 21:17:46    favio             Creacion    
  #
*****************************************************************************************/

class MODMensaje extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarMensaje(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_mensaje_sel';
        $this->transaccion='PM_MEN_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
		$this->captura('id_mensaje','int4');
		$this->captura('id_usuario_from','int4');
		$this->captura('id_usuario_to','_int4');
		$this->captura('id_chat','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('mensaje','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarMensaje(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_mensaje_ime';
        $this->transaccion='PM_MEN_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_usuario_from','id_usuario_from','int4');
		$this->setParametro('id_usuario_to','id_usuario_to','_int4');
		$this->setParametro('id_chat','id_chat','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('mensaje','mensaje','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarMensaje(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_mensaje_ime';
        $this->transaccion='PM_MEN_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_mensaje','id_mensaje','int4');
		$this->setParametro('id_usuario_from','id_usuario_from','int4');
		$this->setParametro('id_usuario_to','id_usuario_to','_int4');
		$this->setParametro('id_chat','id_chat','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('mensaje','mensaje','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarMensaje(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_mensaje_ime';
        $this->transaccion='PM_MEN_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_mensaje','id_mensaje','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>