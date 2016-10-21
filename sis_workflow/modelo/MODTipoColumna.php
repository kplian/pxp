<?php
/**
*@package pXP
*@file gen-MODTipoColumna.php
*@author  (admin)
*@date 07-05-2014 21:41:15
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoColumna extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoColumna(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_columna_sel';
		$this->transaccion='WF_TIPCOL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_columna','int4');
		$this->captura('id_tabla','int4');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('bd_campos_adicionales','text');
		$this->captura('form_combo_rec','varchar');
		$this->captura('bd_joins_adicionales','text');
		$this->captura('bd_descripcion_columna','text');
		$this->captura('bd_tamano_columna','varchar');
		$this->captura('bd_formula_calculo','text');
		$this->captura('form_sobreescribe_config','text');
		$this->captura('form_tipo_columna','varchar');
		$this->captura('grid_sobreescribe_filtro','text');
		$this->captura('estado_reg','varchar');
		$this->captura('bd_nombre_columna','varchar');
		$this->captura('form_es_combo','varchar');
		$this->captura('form_label','varchar');
		$this->captura('grid_campos_adicionales','text');
		$this->captura('bd_tipo_columna','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('bd_prioridad','integer');
		$this->captura('form_grupo','integer');
        $this->captura('bd_campos_subconsulta','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

    function listarColumnasFormulario(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.ft_tipo_columna_sel';
        $this->transaccion='WF_TIPCOLFOR_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setCount(false);

        //Definicion de la lista del resultado del query
        $this->setParametro('codigo_proceso','codigo_proceso','varchar');
        $this->setParametro('proceso_macro','proceso_macro','varchar');
        $this->setParametro('id_estado_wf','id_estado_wf','int4');

        $this->captura('nombre_columna','varchar');
        $this->captura('momento','varchar');
        $this->captura('regla','boolean');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
			
	function insertarTipoColumna(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_columna_ime';
		$this->transaccion='WF_TIPCOL_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tabla','id_tabla','int4');
		$this->setParametro('bd_campos_adicionales','bd_campos_adicionales','text');
		$this->setParametro('form_combo_rec','form_combo_rec','varchar');
		$this->setParametro('bd_joins_adicionales','bd_joins_adicionales','text');
		$this->setParametro('bd_descripcion_columna','bd_descripcion_columna','text');
		$this->setParametro('form_sobreescribe_config','form_sobreescribe_config','text');
		$this->setParametro('form_tipo_columna','form_tipo_columna','varchar');
		$this->setParametro('grid_sobreescribe_filtro','grid_sobreescribe_filtro','text');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('bd_nombre_columna','bd_nombre_columna','varchar');
		$this->setParametro('form_es_combo','form_es_combo','varchar');
		$this->setParametro('grid_campos_adicionales','grid_campos_adicionales','text');
		$this->setParametro('bd_tipo_columna','bd_tipo_columna','varchar');
		$this->setParametro('bd_formula_calculo','bd_formula_calculo','text');
		$this->setParametro('bd_tamano_columna','bd_tamano_columna','varchar');
		$this->setParametro('form_label','form_label','varchar');
		$this->setParametro('bd_prioridad','bd_prioridad','integer');
		$this->setParametro('form_grupo','form_grupo','integer');
        $this->setParametro('bd_campos_subconsulta','bd_campos_subconsulta','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoColumna(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_columna_ime';
		$this->transaccion='WF_TIPCOL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_columna','id_tipo_columna','int4');
		$this->setParametro('id_tabla','id_tabla','int4');
		$this->setParametro('bd_campos_adicionales','bd_campos_adicionales','text');
		$this->setParametro('form_combo_rec','form_combo_rec','varchar');
		$this->setParametro('bd_joins_adicionales','bd_joins_adicionales','text');
		$this->setParametro('bd_descripcion_columna','bd_descripcion_columna','text');
		$this->setParametro('form_sobreescribe_config','form_sobreescribe_config','text');
		$this->setParametro('form_tipo_columna','form_tipo_columna','varchar');
		$this->setParametro('grid_sobreescribe_filtro','grid_sobreescribe_filtro','text');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('bd_nombre_columna','bd_nombre_columna','varchar');
		$this->setParametro('form_es_combo','form_es_combo','varchar');
		$this->setParametro('grid_campos_adicionales','grid_campos_adicionales','text');
		$this->setParametro('bd_tipo_columna','bd_tipo_columna','varchar');
		$this->setParametro('bd_formula_calculo','bd_formula_calculo','text');
		$this->setParametro('bd_tamano_columna','bd_tamano_columna','varchar');
		$this->setParametro('form_label','form_label','varchar');
		$this->setParametro('bd_prioridad','bd_prioridad','integer');
		$this->setParametro('form_grupo','form_grupo','integer');
        $this->setParametro('bd_campos_subconsulta','bd_campos_subconsulta','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoColumna(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_columna_ime';
		$this->transaccion='WF_TIPCOL_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_columna','id_tipo_columna','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>