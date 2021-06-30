<?php
/****************************************************************************************
 * @package pXP
 * @file MODNotificaciones.php
 * @author  (valvarado)
 * @date 30-03-2021 15:12:35
 * @description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 *
 * HISTORIAL DE MODIFICACIONES:
 * #ISSUE                FECHA                AUTOR                DESCRIPCION
 * #0                30-03-2021 15:12:35    valvarado             Creacion
 * #
 *****************************************************************************************/

class MODNotificaciones extends MODbase
{

    function __construct(CTParametro $pParam)
    {
        parent::__construct($pParam);
    }

    function listarNotificaciones()
    {
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento = 'param.ft_notificaciones_sel';
        $this->transaccion = 'PARAM_NOTI_SEL';
        $this->tipo_procedimiento = 'SEL';//tipo de transaccion

        //Definicion de la lista del resultado del query
        $this->captura('id', 'int4');
        $this->captura('estado_reg', 'varchar');
        $this->captura('id_funcionario_emisor', 'int4');
        $this->captura('id_funcionario_receptor', 'int4');
        $this->captura('id_proceso_wf', 'int4');
        $this->captura('id_estado_wf', 'int4');
        $this->captura('modulo', 'varchar');
        $this->captura('esquema', 'varchar');
        $this->captura('id_usuario_reg', 'int4');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('id_usuario_ai', 'int4');
        $this->captura('usuario_ai', 'varchar');
        $this->captura('id_usuario_mod', 'int4');
        $this->captura('fecha_mod', 'timestamp');
        $this->captura('usr_reg', 'varchar');
        $this->captura('usr_mod', 'varchar');
        $this->captura('enviado', 'varchar');
        $this->captura('title', 'varchar');
        $this->captura('body', 'varchar');
        $this->captura('id_registro', 'int4');
        $this->captura('desc_fun_emisor', 'text');
        $this->captura('desc_fun_receptor', 'text');
        $this->captura('nombre_vista', 'varchar');
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function insertarNotificaciones()
    {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'param.ft_notificaciones_ime';
        $this->transaccion = 'PARAM_NOTI_INS';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('estado_reg', 'estado_reg', 'varchar');
        $this->setParametro('id_funcionario_emisor', 'id_funcionario_emisor', 'int4');
        $this->setParametro('id_funcionario_receptor', 'id_funcionario_receptor', 'int4');
        $this->setParametro('id_proceso_wf', 'id_proceso_wf', 'int4');
        $this->setParametro('id_estado_wf', 'id_estado_wf', 'int4');
        $this->setParametro('modulo', 'modulo', 'varchar');
        $this->setParametro('esquema', 'esquema', 'varchar');
        $this->setParametro('title', 'title', 'varchar');
        $this->setParametro('body', 'body', 'varchar');
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function modificarNotificaciones()
    {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'param.ft_notificaciones_ime';
        $this->transaccion = 'PARAM_NOTI_MOD';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id', 'id', 'int4');
        $this->setParametro('estado_reg', 'estado_reg', 'varchar');
        $this->setParametro('id_funcionario_emisor', 'id_funcionario_emisor', 'int4');
        $this->setParametro('id_funcionario_receptor', 'id_funcionario_receptor', 'int4');
        $this->setParametro('id_proceso_wf', 'id_proceso_wf', 'int4');
        $this->setParametro('id_estado_wf', 'id_estado_wf', 'int4');
        $this->setParametro('modulo', 'modulo', 'varchar');
        $this->setParametro('esquema', 'esquema', 'varchar');
        $this->setParametro('title', 'title', 'varchar');
        $this->setParametro('body', 'body', 'varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function eliminarNotificaciones()
    {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'param.ft_notificaciones_ime';
        $this->transaccion = 'PARAM_NOTI_ELI';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id', 'id', 'int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function modificar()
    {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'param.ft_notificaciones_ime';
        $this->transaccion = 'PARAM_MOD_ENV';
        $this->tipo_procedimiento = 'IME';
        $this->tipo_conexion = 'seguridad';
        //Define los parametros para la funcion
        $this->setParametro('notificaciones', 'notificaciones', 'text');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function listar()
    {
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento = 'param.ft_notificaciones_sel';
        $this->transaccion = 'PARAM_NOTILISTAR_SEL';
        $this->tipo_procedimiento = 'SEL';//tipo de transaccion
        $this->setCount(false);
        $this->tipo_conexion = 'seguridad';
        //Definicion de la lista del resultado del query
        $this->captura('id', 'int4');
        $this->captura('estado_reg', 'varchar');
        $this->captura('id_funcionario_emisor', 'int4');
        $this->captura('id_funcionario_receptor', 'int4');
        $this->captura('id_proceso_wf', 'int4');
        $this->captura('id_estado_wf', 'int4');
        $this->captura('modulo', 'varchar');
        $this->captura('esquema', 'varchar');
        $this->captura('id_usuario_reg', 'int4');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('id_usuario_ai', 'int4');
        $this->captura('usuario_ai', 'varchar');
        $this->captura('id_usuario_mod', 'int4');
        $this->captura('fecha_mod', 'timestamp');
        $this->captura('usr_reg', 'varchar');
        $this->captura('usr_mod', 'varchar');
        $this->captura('enviado', 'varchar');
        $this->captura('token', 'varchar');
        $this->captura('title', 'varchar');
        $this->captura('body', 'varchar');
        $this->captura('id_registro', 'int4');
        $this->captura('desc_fun_emisor', 'text');
        $this->captura('desc_fun_receptor', 'text');
        $this->captura('nombre_vista', 'varchar');
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

}

?>