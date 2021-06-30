<?php
/****************************************************************************************
*@package pXP
*@file MODFuncionarioDispositivo.php
*@author  (valvarado)
*@date 30-03-2021 15:11:51
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                30-03-2021 15:11:51    valvarado             Creacion    
  #
*****************************************************************************************/

class MODFuncionarioDispositivo extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarFuncionarioDispositivo(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_funcionario_dispositivo_sel';
        $this->transaccion='PARAM_FUNDISP_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
		$this->captura('id','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('token','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('desc_funcionario1','text');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarFuncionarioDispositivo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_funcionario_dispositivo_ime';
        $this->transaccion='PARAM_FUNDISP_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('token','token','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarFuncionarioDispositivo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_funcionario_dispositivo_ime';
        $this->transaccion='PARAM_FUNDISP_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id','id','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('token','token','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarFuncionarioDispositivo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_funcionario_dispositivo_ime';
        $this->transaccion='PARAM_FUNDISP_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id','id','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>