<?php
/**
 *@package pXP
 *@file gen-MODFieldValorArchivo.php
 *@author  (admin)
 *@date 19-10-2017 15:00:59
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODFieldValorArchivo extends MODbase{

    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }

    function listarFieldValorArchivo(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_field_valor_archivo_sel';
        $this->transaccion='PM_FVALA_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        //Definicion de la lista del resultado del query
        $this->captura('id_field_valor_archivo','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('valor','varchar');
        $this->captura('id_archivo','int4');
        $this->captura('id_field_tipo_archivo','int4');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('usuario_ai','varchar');
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

    function insertarFieldValorArchivo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_field_valor_archivo_ime';
        $this->transaccion='PM_FVALA_INS';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('valor','valor','varchar');
        $this->setParametro('id_archivo','id_archivo','int4');
        $this->setParametro('id_field_tipo_archivo','id_field_tipo_archivo','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function modificarFieldValorArchivo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_field_valor_archivo_ime';
        $this->transaccion='PM_FVALA_MOD';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_field_valor_archivo','id_field_valor_archivo','int4');
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('valor','valor','varchar');
        $this->setParametro('id_archivo','id_archivo','int4');
        $this->setParametro('id_field_tipo_archivo','id_field_tipo_archivo','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function eliminarFieldValorArchivo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_field_valor_archivo_ime';
        $this->transaccion='PM_FVALA_ELI';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_field_valor_archivo','id_field_valor_archivo','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }


    function insertarFieldValorArchivoJson(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_field_valor_archivo_ime';
        $this->transaccion='PM_FVJSON_INS';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion

        $this->setParametro('id_archivo','id_archivo','int4');
        $this->setParametro('json','json','text');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }


}
?>