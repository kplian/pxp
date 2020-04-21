<?php
/****************************************************************************************
*@package pXP
*@file gen-MODGrupoIdioma.php
*@author  (admin)
*@date 21-04-2020 02:29:46
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                21-04-2020 02:29:46    admin             Creacion    
  #
*****************************************************************************************/

class MODGrupoIdioma extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarGrupoIdioma(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_grupo_idioma_sel';
        $this->transaccion='PM_GRI_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
		$this->captura('id_grupo_idioma','int4');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('tipo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre_tabla','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
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
            
    function insertarGrupoIdioma(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_grupo_idioma_ime';
        $this->transaccion='PM_GRI_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_tabla','nombre_tabla','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarGrupoIdioma(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_grupo_idioma_ime';
        $this->transaccion='PM_GRI_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_grupo_idioma','id_grupo_idioma','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_tabla','nombre_tabla','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarGrupoIdioma(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_grupo_idioma_ime';
        $this->transaccion='PM_GRI_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
		$this->setParametro('id_grupo_idioma','id_grupo_idioma','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>