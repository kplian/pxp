<?php
class MODTabla extends MODbase{
	
	function __construct(CTParametro $pParam){
		
		parent::__construct($pParam);
	}
	
	function listarTabla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gen.ft_tabla_sel';// nombre procedimiento almacenado
		$this->transaccion='GEN_TABLA_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
	
		//Definicion de la lista del resultado del query
	
		$this->captura('id_tabla','integer');
		$this->captura('esquema','varchar');
		$this->captura('nombre','varchar');
		$this->captura('titulo','varchar');
		$this->captura('id_subsistema','integer');
		$this->captura('id_usuario_reg','integer');
		$this->captura('id_usuario_mod','integer');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('desc_subsistema','varchar');
		$this->captura('prefijo','varchar');
		$this->captura('alias','varchar');
		$this->captura('reemplazar','varchar');
		$this->captura('menu','varchar');
		$this->captura('direccion','varchar');
		$this->captura('nombre_carpeta','varchar');
		$this->captura('llave_primaria','varchar');
		$this->captura('cant_grupos','integer');
		
		//Ejecuta la funcion
		$this->armarConsulta();
		//echo $this->consulta;exit();
		$this->ejecutarConsulta();

		return $this->respuesta;
	}
	function listarTablaCombo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gen.ft_tabla_sel';// nombre procedimiento almacenado
		$this->transaccion='GEN_TABLACOM_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
	
		//Definicion de la lista del resultado del query
	
		$this->captura('oid_esquema','integer');
		$this->captura('nombre_esquema','varchar');
		$this->captura('oid_tabla','integer');
		$this->captura('nombre','varchar');
				
		//Ejecuta la funcion
		$this->armarConsulta();
		/*echo $this->consulta;
		exit();*/
		$this->ejecutarConsulta();

		return $this->respuesta;
	}
	
	function insertarTabla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gen.ft_tabla_ime';
		$this->transaccion='GEN_TABLA_INS';
		$this->tipo_procedimiento='IME';
		
		//Define los parametros para la funcion	
		$this->setParametro('esquema','esquema','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('titulo','titulo','varchar');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('id_usuario_reg','id_usuario_reg','integer');
		$this->setParametro('alias','alias','varchar');
		$this->setParametro('reemplazar','reemplazar','varchar');
		$this->setParametro('menu','menu','varchar');
		$this->setParametro('direccion','direccion','varchar');
		$this->setParametro('cant_grupos','cant_grupos','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	function modificarTabla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gen.ft_tabla_ime';
		$this->transaccion='GEN_TABLA_MOD';
		$this->tipo_procedimiento='IME';
		
		//Define los parametros para la funcion	
		$this->setParametro('id_tabla','id_tabla','integer');
		$this->setParametro('esquema','esquema','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('titulo','titulo','varchar');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('id_usuario_mod','id_usuario_mod','integer');
		$this->setParametro('alias','alias','varchar');
		$this->setParametro('reemplazar','reemplazar','varchar');
		$this->setParametro('menu','menu','varchar');
		$this->setParametro('direccion','direccion','varchar');
		$this->setParametro('cant_grupos','cant_grupos','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	function eliminarTabla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gen.ft_tabla_ime';
		$this->transaccion='GEN_TABLA_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_tabla','id_tabla','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;
	}
	
}
?>