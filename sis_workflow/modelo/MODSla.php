<?php
/**
*@package PXP
*@file
*@author
*@date
*@descriptiopuesta
HISTORIAL DE MODIFICACIONES:
 ISSUE            FECHA:              AUTOR                 DESCRIPCION
#143            29/05/2020           EGS                     Creacion
 * */

class MODSla extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
    function iniciaSla(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.f_sla_ime';
        $this->transaccion='WF_INISLA_IME';
        $this->tipo_procedimiento='IME';
        //definicion de variables
        $this->tipo_conexion='seguridad';

        $this->count=false;

        //$this->count=false;

        $this->setParametro('id_usuario','id_usuario','integer');
        $this->setParametro('habilitado','habilitado','varchar');

        //Define los parametros para la funcion
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();


        //Devuelve la respuesta
        var_dump( $this->respuesta);
        return $this->respuesta;
    }


}
?>