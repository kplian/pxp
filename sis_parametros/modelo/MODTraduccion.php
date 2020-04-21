<?php
/****************************************************************************************
*@package pXP
*@file gen-MODTraduccion.php
*@author  (admin)
*@date 21-04-2020 03:41:52
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                21-04-2020 03:41:52    admin             Creacion    
  #
*****************************************************************************************/

class MODTraduccion extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarTraduccion(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_traduccion_sel';
        $this->transaccion='PM_TRA_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
		$this->captura('id_traduccion','bigint');
		$this->captura('id_lenguaje','int4');
		$this->captura('id_palabra_clave','int4');
		$this->captura('texto','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('desc_lenguaje','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarTraduccion(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_traduccion_ime';
        $this->transaccion='PM_TRA_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_lenguaje','id_lenguaje','int4');
		$this->setParametro('id_palabra_clave','id_palabra_clave','int4');
		$this->setParametro('texto','texto','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarTraduccion(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_traduccion_ime';
        $this->transaccion='PM_TRA_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_traduccion','id_traduccion','int4');
		$this->setParametro('id_lenguaje','id_lenguaje','int4');
		$this->setParametro('id_palabra_clave','id_palabra_clave','int4');
		$this->setParametro('texto','texto','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarTraduccion(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_traduccion_ime';
        $this->transaccion='PM_TRA_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_traduccion','id_traduccion','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>