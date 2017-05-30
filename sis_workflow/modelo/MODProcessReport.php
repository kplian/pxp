<?php
/**
 *@package pXP
 *@file gen-MODDetalleSol.php
 *@author  (admin)
 *@date 23-12-2016 13:13:01
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODDetalleSol extends MODbase{

    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }

    function listarDetalleSol(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.f_process_report_sel';
        $this->transaccion='WF_PRO_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion


        //Definicion de la lista del resultado del query
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('id_proceso_macro','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        //var_dump($this->respuesta); exit;
        //Devuelve la respuesta
        return $this->respuesta;
    }

}
?>