<?php
/**
 *@package pXP
 *@file gen-MODFieldTipoArchivo.php
 *@author  (admin)
 *@date 18-10-2017 14:28:34
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODFieldTipoArchivo extends MODbase{

    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }

    function listarFieldTipoArchivo(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_field_tipo_archivo_sel';
        $this->transaccion='PM_FITIAR_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        //Definicion de la lista del resultado del query
        $this->captura('id_field_tipo_archivo','int4');
        $this->captura('id_tipo_archivo','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('nombre','varchar');
        $this->captura('descripcion','varchar');
        $this->captura('tipo','varchar');
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

    function insertarFieldTipoArchivo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_field_tipo_archivo_ime';
        $this->transaccion='PM_FITIAR_INS';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('descripcion','descripcion','varchar');
        $this->setParametro('tipo','tipo','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function modificarFieldTipoArchivo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_field_tipo_archivo_ime';
        $this->transaccion='PM_FITIAR_MOD';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_field_tipo_archivo','id_field_tipo_archivo','int4');
        $this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('descripcion','descripcion','varchar');
        $this->setParametro('tipo','tipo','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function eliminarFieldTipoArchivo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_field_tipo_archivo_ime';
        $this->transaccion='PM_FITIAR_ELI';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_field_tipo_archivo','id_field_tipo_archivo','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    function listarFieldTipoArchivoValor(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_field_tipo_archivo_sel';
        $this->transaccion='PM_FITIARVAL_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        $this->count= false;

        $this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');
        $this->setParametro('id_archivo','id_archivo','int4');


        //Definicion de la lista del resultado del query
        $this->captura('id_field_tipo_archivo','int4');
        $this->captura('id_field_valor_archivo','int4');
        $this->captura('nombre','varchar');
        $this->captura('tipo','varchar');
        $this->captura('valor','varchar');
        $this->captura('descripcion','varchar');






        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

}
?>