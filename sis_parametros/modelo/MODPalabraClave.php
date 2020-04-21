<?php
/****************************************************************************************
*@package pXP
*@file gen-MODPalabraClave.php
*@author  (RAC)
*@date 21-04-2020 02:54:58
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #133               21-04-2020 02:54:58    RAC             Creacion    
  #
*****************************************************************************************/

class MODPalabraClave extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarPalabraClave(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_palabra_clave_sel';
        $this->transaccion='PM_PLC_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
		$this->captura('id_palabra_clave','int4');
		$this->captura('id_tabla','int8');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('default_text','varchar');
		$this->captura('id_grupo_idioma','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('desc_grupo_idioma','text');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarPalabraClave(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_palabra_clave_ime';
        $this->transaccion='PM_PLC_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_tabla','id_tabla','int8');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('default_text','default_text','varchar');
		$this->setParametro('id_grupo_idioma','id_grupo_idioma','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarPalabraClave(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_palabra_clave_ime';
        $this->transaccion='PM_PLC_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_palabra_clave','id_palabra_clave','int4');
		$this->setParametro('id_tabla','id_tabla','int8');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('default_text','default_text','varchar');
		$this->setParametro('id_grupo_idioma','id_grupo_idioma','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarPalabraClave(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_palabra_clave_ime';
        $this->transaccion='PM_PLC_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_palabra_clave','id_palabra_clave','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>