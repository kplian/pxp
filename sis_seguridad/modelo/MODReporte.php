<?php
/***
Nombre: 	MODRol.php
Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas
a la tabla trol del esquema SEGU
Autor:		Kplian
Fecha:		04/06/2011
 */
class MODReporte extends MODbase{

    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }

    function listarRepo(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='segu.f_reportes_sel';
        $this->transaccion='SE_REP_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        //Definicion de la lista del resultado del query
        $this->captura('id_subsistema','integer');
        $this->captura('nombre','varchar');
        $this->captura('organizacion_git','varchar');
        $this->captura('codigo_git','varchar');
        $this->captura('sw_importacion','varchar');
        //Ejecuta la funcion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        return $this->respuesta;

    }
    function listarBranch(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='segu.f_reportes_sel';
        $this->transaccion='SE_BRA_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        //Definicion de la lista del resultado del query
        $this->captura('id_branches','integer');
        $this->captura('id_subsistema','integer');
        $this->captura('name','varchar');
        //Ejecuta la funcion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        return $this->respuesta;
    }
    function reporteGitHub(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='segu.f_reportes_sel';
        $this->transaccion='SE_REPR_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion


        $this->setParametro('id_subsistema','id_subsistema','integer');
        // $this->setParametro('id_branches','id_branches','integer');
        $this->setParametro('estado','estado','varchar');
        $this->setParametro('id_programador','id_programador','varchar');
        $this->setParametro('fecha_ini','fecha_ini','date');
        $this->setParametro('fecha_fin','fecha_fin','date');
        $this->setCount(false);

        //Definicion de la lista del resultado del query
        $this->captura('id_subsistema','integer');
        $this->captura('id_programador','integer');
        $this->captura('sistema','varchar');
        $this->captura('number_issues','integer');
        $this->captura('titulo','text');
        $this->captura('estado','varchar');
        $this->captura('fecha_issues','date');
        $this->captura('creador_issues','text');
        $this->captura('issues','integer');
        $this->captura('id_branches','integer');
        $this->captura('name','varchar');
        $this->captura('message','text');
        $this->captura('fecha_commit','date');
        $this->captura('creador_commi','text');

        //Ejecuta la funcion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        // var_dump($this->respuesta); exit;
        return $this->respuesta;
    }


}
?>