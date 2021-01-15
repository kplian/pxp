<?php
/**
 *@package pXP
 *@file gen-MODProveedor.php
 *@author  (mzm)
 *@date 15-11-2011 10:44:58
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
    ISSUE        FECHA         AUTHOR              DESCRIPCION
   	#7           21/01/2019     RAC                combo proveedor se agrego el desc_proveedor2
 *  #47          20/08/2019     EG                 se Agrego Cmp id_auxiliar
 *  #MSA-43     15/0/2021       EGS                 Se incrementa el valor del integer
 */

class MODProveedor extends MODbase{

    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }

    function listarProveedor(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.f_tproveedor_sel';
        $this->transaccion='PM_PROVEE_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        //Definicion de la lista del resultado del query
        $this->captura('id_proveedor','int4');
        $this->captura('id_persona','int4');
        $this->captura('codigo','varchar');
        $this->captura('numero_sigma','varchar');
        $this->captura('tipo','varchar');

        $this->captura('estado_reg','varchar');
        $this->captura('id_institucion','int4');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','int4');

        $this->captura('fecha_mod','timestamp');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('nombre_completo1','text');
        $this->captura('nombre','varchar');

        $this->captura('nit','varchar');
        $this->captura('id_lugar','int4');
        $this->captura('lugar','varchar');
        $this->captura('pais','varchar');

        $this->captura('correos','varchar');
        $this->captura('telefonos','varchar');
        $this->captura('items','varchar');
        $this->captura('servicios','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        //echo $this->consulta;exit;
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function listarProveedorCombos(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.f_tproveedor_sel';
        $this->transaccion='PM_PROVEEV_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        //Definicion de la lista del resultado del query
        $this->setParametro('id_lugar','id_lugar','int4');

        $this->captura('id_proveedor','INTEGER');
        $this->captura('id_persona','INTEGER');
        $this->captura('codigo','VARCHAR');
        $this->captura('numero_sigma','VARCHAR');
        $this->captura('tipo','VARCHAR');
        $this->captura('id_institucion','INTEGER');
        $this->captura('desc_proveedor','VARCHAR');
        $this->captura('nit','VARCHAR');
        $this->captura('id_lugar','int4');
        $this->captura('lugar','varchar');
        $this->captura('pais','varchar');
        $this->captura('rotulo_comercial','varchar');
        $this->captura('email','varchar');
		$this->captura('desc_proveedor2','VARCHAR'); ///#7 
		
        //Ejecuta la instruccion
        $this->armarConsulta();
        //echo $this->consulta; exit;
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function listarProveedorV2(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.f_tproveedor_sel';
        $this->transaccion='PM_PROVEEDOR_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        $this->setParametro('tipo','tipo','varchar');
        //Definicion de la lista del resultado del query
        $this->captura('id_proveedor','int4');
        $this->captura('id_institucion','int4');
        $this->captura('id_persona','int4');
        $this->captura('tipo','varchar');
        $this->captura('numero_sigma','varchar');
        $this->captura('codigo','varchar');
        $this->captura('nit','varchar');
        $this->captura('id_lugar','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('nombre_completo1','text');
        $this->captura('nombre','varchar');
        $this->captura('lugar','varchar');
        $this->captura('nombre_proveedor','varchar');
        $this->captura('rotulo_comercial','varchar');
        $this->captura('ci','varchar');
        $this->captura('desc_dir_proveedor','varchar');
        $this->captura('contacto','text');
        $this->captura('id_proceso_wf','int4');
        $this->captura('id_estado_wf','int4');
        $this->captura('nro_tramite','varchar');
        $this->captura('estado','varchar');
        $this->captura('internacional','varchar');
        $this->captura('autorizacion','varchar');
        $this->captura('id_auxiliar','int4');//#47



        //Ejecuta la instruccion
        $this->armarConsulta();
        //echo $this->consulta;exit;
        $this->ejecutarConsulta();
        //Devuelve la respuesta
        return $this->respuesta;
    }

    function listarProveedorWf(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.f_tproveedor_sel';
        $this->transaccion='PM_PROVEEDORWF_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        $this->setParametro('tipo','tipo','varchar');
        $this->setParametro('tipo_interfaz','tipo_interfaz','varchar');
        $this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');


        //Definicion de la lista del resultado del query
        $this->captura('id_proveedor','int4');
        $this->captura('id_institucion','int4');
        $this->captura('id_persona','int4');
        $this->captura('tipo','varchar');
        $this->captura('numero_sigma','varchar');
        $this->captura('codigo','varchar');
        $this->captura('nit','varchar');
        $this->captura('id_lugar','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('nombre_completo1','text');
        $this->captura('nombre','varchar');
        $this->captura('lugar','varchar');
        $this->captura('nombre_proveedor','varchar');
        $this->captura('rotulo_comercial','varchar');
        $this->captura('ci','varchar');
        $this->captura('desc_dir_proveedor','varchar');
        $this->captura('contacto','text');
        $this->captura('id_proceso_wf','int4');
        $this->captura('id_estado_wf','int4');
        $this->captura('nro_tramite','varchar');
        $this->captura('estado','varchar');



        //Ejecuta la instruccion
        $this->armarConsulta();
        //echo $this->consulta;exit;
        $this->ejecutarConsulta();
        //Devuelve la respuesta
        return $this->respuesta;
    }





    function insertarProveedor(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.f_tproveedor_ime';
        $this->transaccion='PM_PROVEE_INS';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        //Define los parametros para la funcion
        $this->setParametro('id_persona','id_persona','int4');
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('numero_sigma','numero_sigma','varchar');
        $this->setParametro('tipo','tipo','varchar');
        //$this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('id_institucion','id_institucion','int4');
        $this->setParametro('doc_id','doc_id','bigint');
        $this->setParametro('nombre_institucion','nombre_institucion','varchar');
        $this->setParametro('direccion_institucion','direccion_institucion','varchar');
        $this->setParametro('casilla','casilla','bigint');
        $this->setParametro('telefono1_institucion','telefono1_institucion','bigint');
        $this->setParametro('telefono2_institucion','telefono2_institucion','bigint');
        $this->setParametro('celular1_institucion','celular1_institucion','bigint');
        $this->setParametro('celular2_institucion','celular2_institucion','bigint');
        $this->setParametro('fax','fax','bigint');
        $this->setParametro('email1_institucion','email1_institucion','varchar');
        $this->setParametro('email2_institucion','email2_institucion','varchar');
        $this->setParametro('pag_web','pag_web','varchar');
        $this->setParametro('observaciones','observaciones','varchar');
        $this->setParametro('codigo_banco','codigo_banco','varchar');
        $this->setParametro('codigo_institucion','codigo_institucion','varchar');

        $this->setParametro('nit','nit','varchar');
        $this->setParametro('id_lugar','id_lugar','int4');

        $this->setParametro('register','register','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('apellido_paterno','apellido_paterno','varchar');
        $this->setParametro('apellido_materno','apellido_materno','varchar');
        $this->setParametro('ci','ci','int4');
        $this->setParametro('correo','correo','varchar');
        $this->setParametro('celular1','celular1','varchar');
        $this->setParametro('celular2','celular2','varchar');
        $this->setParametro('telefono1','telefono1','varchar');
        $this->setParametro('telefono2','telefono2','varchar');
        $this->setParametro('genero','genero','varchar');
        $this->setParametro('fecha_nacimiento','fecha_nacimiento','date');
        $this->setParametro('direccion','direccion','varchar');
        $this->setParametro('rotulo_comercial','rotulo_comercial','varchar');
        $this->setParametro('contacto','contacto','text');
        $this->setParametro('internacional','internacional','varchar');
        $this->setParametro('id_auxiliar','id_auxiliar','int4');//#47


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        //var_dump($this); exit;
        //Devuelve la respuesta
        return $this->respuesta;
    }

    function modificarProveedor(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.f_tproveedor_ime';
        $this->transaccion='PM_PROVEE_MOD';
        $this->tipo_procedimiento='IME';


        //Define los parametros para la funcion
        $this->setParametro('id_proveedor','id_proveedor','int4');
        $this->setParametro('id_persona','id_persona','int4');
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('numero_sigma','numero_sigma','varchar');
        $this->setParametro('tipo','tipo','varchar');
        $this->setParametro('id_institucion','id_institucion','int4');
        $this->setParametro('doc_id','doc_id','int8');//#MSA-43
        $this->setParametro('nombre_institucion','nombre_institucion','varchar');
        $this->setParametro('direccion_institucion','direccion_institucion','varchar');
        $this->setParametro('casilla','casilla','bigint');
        $this->setParametro('telefono1_institucion','telefono1_institucion','bigint');
        $this->setParametro('telefono2_institucion','telefono2_institucion','bigint');
        $this->setParametro('celular1_institucion','celular1_institucion','bigint');
        $this->setParametro('celular2_institucion','celular2_institucion','bigint');
        $this->setParametro('fax','fax','bigint');
        $this->setParametro('email1_institucion','email1_institucion','varchar');
        $this->setParametro('email2_institucion','email2_institucion','varchar');
        $this->setParametro('pag_web','pag_web','varchar');
        $this->setParametro('observaciones','observaciones','varchar');
        $this->setParametro('codigo_banco','codigo_banco','varchar');
        $this->setParametro('codigo_institucion','codigo_institucion','varchar');

        $this->setParametro('nit','nit','varchar');
        $this->setParametro('id_lugar','id_lugar','int4');

        $this->setParametro('register','register','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('apellido_paterno','apellido_paterno','varchar');
        $this->setParametro('apellido_materno','apellido_materno','varchar');
        $this->setParametro('ci','ci','int4');
        $this->setParametro('correo','correo','varchar');
        $this->setParametro('celular1','celular1','bigint');
        $this->setParametro('celular2','celular2','bigint');
        $this->setParametro('telefono1','telefono1','bigint');
        $this->setParametro('telefono2','telefono2','bigint');
        $this->setParametro('genero','genero','varchar');
        $this->setParametro('fecha_nacimiento','fecha_nacimiento','date');
        $this->setParametro('direccion','direccion','varchar');
        $this->setParametro('rotulo_comercial','rotulo_comercial','varchar');
        $this->setParametro('contacto','contacto','text');
        $this->setParametro('internacional','internacional','varchar');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function eliminarProveedor(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.f_tproveedor_ime';
        $this->transaccion='PM_PROVEE_ELI';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_proveedor','id_proveedor','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }


    function iniciarTramite(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.f_tproveedor_ime';
        $this->transaccion='PM_INITRA_IME';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion

        $this->setParametro('id_proveedor','id_proveedor','int4');
        $this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function siguienteEstadoProveedor(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'param.f_tproveedor_ime';
        $this->transaccion = 'PM_SIGESTP_IME';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id_proveedor','id_proveedor','int4');
        $this->setParametro('id_proceso_wf_act','id_proceso_wf_act','int4');
        $this->setParametro('id_estado_wf_act','id_estado_wf_act','int4');
        $this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('id_funcionario_wf','id_funcionario_wf','int4');
        $this->setParametro('id_depto_wf','id_depto_wf','int4');
        $this->setParametro('obs','obs','text');
        $this->setParametro('json_procesos','json_procesos','text');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }


    function anteriorEstadoProveedor(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.f_tproveedor_ime';
        $this->transaccion='PM_ANTEPRO_IME';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_proceso_wf','id_proceso_wf','int4');
        $this->setParametro('id_estado_wf','id_estado_wf','int4');
        $this->setParametro('obs','obs','varchar');
        $this->setParametro('estado_destino','estado_destino','varchar');



        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    function estadoProveedor(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.f_tproveedor_ime';
        $this->transaccion='PM_ESTA_IME';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('autorizacion','autorizacion','varchar');
        $this->setParametro('id_proveedor','id_proveedor','int4');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

}
?>