<?php
/****************************************************************************************
*@package pXP
*@file gen-MODLenguaje.php
*@author  (admin)
*@date 21-04-2020 01:50:14
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                21-04-2020 01:50:14    admin             Creacion    
  #
*****************************************************************************************/

class MODLenguaje extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarLenguaje(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_lenguaje_sel';
        $this->transaccion='PM_LEN_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->captura('id_lenguaje','int4');
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('defecto','varchar');
        $this->captura('estado_reg','varchar');
        $this->captura('id_usuario_ai','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('usuario_ai','varchar');
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
            
    function insertarLenguaje(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_lenguaje_ime';
        $this->transaccion='PM_LEN_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('defecto','defecto','varchar');
        $this->setParametro('estado_reg','estado_reg','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarLenguaje(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_lenguaje_ime';
        $this->transaccion='PM_LEN_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_lenguaje','id_lenguaje','int4');
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('defecto','defecto','varchar');
        $this->setParametro('estado_reg','estado_reg','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarLenguaje(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_lenguaje_ime';
        $this->transaccion='PM_LEN_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_lenguaje','id_lenguaje','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

        
    function obtenerTraducciones(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_lenguaje_ime';
        $this->transaccion='PM_GETLEN_JSON';
        $this->tipo_procedimiento='IME';
            
        //Define los parametros para la funcion
        $this->setParametro('id_lenguaje','id_lenguaje','int4');
        $this->setParametro('codigo_lenguaje','codigo_lenguaje','varchar');        
        
        //Ejecuta la instruccion
        $this->armarConsulta();                
        $this->ejecutarConsulta();
        return $this->respuesta;
    }
    
    function obtenerTraduccionesGrupo(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_lenguaje_ime';
        $this->transaccion='PM_GETLENGRP_JSON';
        $this->tipo_procedimiento='IME';
            
        //Define los parametros para la funcion
        $this->setParametro('codigo_lenguaje','codigo_lenguaje','varchar'); 
        $this->setParametro('codigo_grupo','codigo_grupo','varchar');        
        
        //Ejecuta la instruccion
        $this->armarConsulta();                
        $this->ejecutarConsulta();
        return $this->respuesta;
    }



    
            
}
?>