<?php
/****************************************************************************************
*@package pXP
*@file gen-MODAgrupacionCorreo.php
*@author  (egutierrez)
*@date 26-11-2020 15:27:53
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                26-11-2020 15:27:53    egutierrez             Creacion    
  #
*****************************************************************************************/

class MODAgrupacionCorreo extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarAgrupacionCorreo(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_agrupacion_correo_sel';
        $this->transaccion='PM_COR_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
		$this->captura('id_agrupacion_correo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('correo','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('id_tipo_envio_correo','int4');
        $this->captura('desc_funcionario1','varchar');
        $this->captura('email_empresa','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarAgrupacionCorreo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_agrupacion_correo_ime';
        $this->transaccion='PM_COR_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('correo','correo','varchar');
        $this->setParametro('id_tipo_envio_correo','id_tipo_envio_correo','int4');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarAgrupacionCorreo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_agrupacion_correo_ime';
        $this->transaccion='PM_COR_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_agrupacion_correo','id_agrupacion_correo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('correo','correo','varchar');
        $this->setParametro('id_tipo_envio_correo','id_tipo_envio_correo','int4');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarAgrupacionCorreo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_agrupacion_correo_ime';
        $this->transaccion='PM_COR_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_agrupacion_correo','id_agrupacion_correo','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>