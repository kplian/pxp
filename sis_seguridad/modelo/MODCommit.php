<?php
/**
*@package pXP
*@file gen-MODCommit.php
*@author  (miguel.mamani)
*@date 09-01-2020 21:26:18
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-01-2020 21:26:18								CREACION

*/

class MODCommit extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCommit(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_commit_sel';
		$this->transaccion='SG_COM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_commit','int4');
		$this->captura('id_issues','int4');
		$this->captura('sha','text');
		$this->captura('html_url','varchar');
		$this->captura('author','varchar');
		$this->captura('id_programador','int4');
		$this->captura('message','text');
		$this->captura('fecha','date');
		$this->captura('id_subsistema','int4');
		$this->captura('id_branches','int4');
		$this->captura('issues','int4');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
    function importarCommitGitHub(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='segu.ft_commit_ime';
        $this->transaccion='SEG_JSON_INS';
        $this->tipo_procedimiento='IME';
        //Define los parametros para la funcion
        $this->setParametro('commit_data','commit_data','json_text');
        $this->setParametro('id_subsistema','id_subsistema','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>