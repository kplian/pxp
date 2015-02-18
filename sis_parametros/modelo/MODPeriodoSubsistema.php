<?php
/**
 *@package pXP
 *@file gen-MODPeriodoSubsistema.php
 *@author  Ariel Ayaviri Omonte
 *@date 19-03-2013 13:58:30
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODPeriodoSubsistema extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarPeriodoSubsistema() {
        $this->procedimiento = 'param.ft_periodo_subsistema_sel';
        $this->transaccion = 'PM_PESU_SEL';
        $this->tipo_procedimiento = 'SEL';
        
        $this->setParametro('codigo_subsistema', 'codigo_subsistema', 'varchar');

        $this->captura('id_periodo_subsistema', 'int4');
        $this->captura('estado_reg', 'varchar');
        $this->captura('id_subsistema', 'int4');
        $this->captura('id_periodo', 'int4');
        $this->captura('fecha_ini', 'date');
        $this->captura('fecha_fin', 'date');
        $this->captura('periodo', 'integer');
        $this->captura('id_gestion', 'int4');
        $this->captura('gestion', 'integer');
        $this->captura('estado', 'varchar');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('id_usuario_reg', 'int4');
        $this->captura('fecha_mod', 'timestamp');
        $this->captura('id_usuario_mod', 'int4');
        $this->captura('usr_reg', 'varchar');
        $this->captura('usr_mod', 'varchar');
		$this->captura('desc_subsistema', 'text');

        $this->armarConsulta();
		//echo $this->consulta;exit;
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function insertarPeriodoSubsistema() {
        $this->procedimiento = 'param.ft_periodo_subsistema_ime';
        $this->transaccion = 'PM_PESU_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('estado_reg', 'estado_reg', 'varchar');
        $this->setParametro('id_subsistema', 'id_subsistema', 'int4');
        $this->setParametro('id_periodo', 'id_periodo', 'int4');
        $this->setParametro('estado', 'estado', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarPeriodoSubsistema() {
        $this->procedimiento = 'param.ft_periodo_subsistema_ime';
        $this->transaccion = 'PM_PESU_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_periodo_subsistema', 'id_periodo_subsistema', 'int4');
        $this->setParametro('estado_reg', 'estado_reg', 'varchar');
        $this->setParametro('id_subsistema', 'id_subsistema', 'int4');
        $this->setParametro('id_periodo', 'id_periodo', 'int4');
        $this->setParametro('estado', 'estado', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarPeriodoSubsistema() {
        $this->procedimiento = 'param.ft_periodo_subsistema_ime';
        $this->transaccion = 'PM_PESU_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_periodo_subsistema', 'id_periodo_subsistema', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
    
    function generarPeriodoSubsistema() {
        $this->procedimiento = 'param.ft_periodo_subsistema_ime';
        $this->transaccion = 'PM_PESUGEN_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('codigo_subsistema', 'codigo_subsistema', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
    
    function switchEstadoPeriodo() {
        $this->procedimiento = 'param.ft_periodo_subsistema_ime';
        $this->transaccion = 'PM_SWESTPE_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_periodo_subsistema', 'id_periodo_subsistema', 'integer');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
}
?>