<?php
/****************************************************************************************
*@package pXP
*@file gen-MODDataExample.php
*@author  (admin)
*@date 12-06-2020 16:37:18
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                12-06-2020 16:37:18    admin             Creacion    
  #
*****************************************************************************************/

class MODDataExample extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarDataExample(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='exa.ft_data_example_sel';
        $this->transaccion='EXA_TDE_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
		$this->captura('id_data_example','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('desc_example','varchar');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
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
            
    function insertarDataExample(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='exa.ft_data_example_ime';
        $this->transaccion='EXA_TDE_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('desc_example','desc_example','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarDataExample(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='exa.ft_data_example_ime';
        $this->transaccion='EXA_TDE_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_data_example','id_data_example','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('desc_example','desc_example','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarDataExample(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='exa.ft_data_example_ime';
        $this->transaccion='EXA_TDE_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_data_example','id_data_example','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }


    function listarDataExampleChat(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='exa.ft_data_example_sel';
        $this->transaccion='EXA_TDECHAT_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        $this->captura('id_data_example','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('desc_example','varchar');
        $this->captura('usuario_ai','varchar');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_reg','int4');
        $this->captura('id_usuario_ai','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('id_chat','int4');
        $this->captura('id_tipo_chat','int4');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

            
}
?>