<?php
class MODGenerador extends MODbase {
	
	function __construct(CTParametro $pParam=null){
		parent::__construct($pParam);
	}
	
	/**
	 * Método: listarColumnas
	 * Propósito: Obtener el listado de las columnas de la tabla
	 * Autor: RCM
	 * Fecha: 19/11/2010
	 *
	 * @return array
	 */
	function listarColumnas(){
		
		//Definición de variables para ejecución del procedimiento
		$this->procedimiento='gen.f_obtener_datos_tabla_sel';// nombre procedimiento almacenado
		$this->transaccion='GEN_COLUMN_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		//Definición de columnas
		$this->captura('id_usuario','integer');
		$this->captura('id_clasificador','integer');
		$this->captura('cuenta','varchar');
		$this->captura('contrasena','varchar');
		$this->captura('fecha_caducidad','date');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','estado_reg');
		$this->captura('estilo','varchar');
		$this->captura('contrasena_anterior','varchar');
		$this->captura('id_persona','integer');
		$this->captura('desc_person','text');
		$this->captura('descripcion','text');
			
		
		//Ejecuta la funcion
		$this->armarConsulta();
		//echo $this->consulta;
		//exit;
		
		$this->ejecutarConsulta();

		return $this->respuesta;

	}
	
	function listarDatosTabla(){
		
		//Definición de variables para ejecución del procedimiento
		$this->procedimiento='gen.f_obtener_datos_tabla_sel';// nombre procedimiento almacenado
		$this->transaccion='GEN_TABLA_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		//Definición de columnas
		$this->captura('id_usuario','integer');
		$this->captura('id_clasificador','integer');
		$this->captura('cuenta','varchar');
		$this->captura('contrasena','varchar');
		$this->captura('fecha_caducidad','date');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','estado_reg');
		$this->captura('estilo','varchar');
		$this->captura('contrasena_anterior','varchar');
		$this->captura('id_persona','integer');
		$this->captura('desc_person','text');
		$this->captura('descripcion','text');
			
		
		//Ejecuta la funcion
		$this->armarConsulta();
		//echo $this->consulta;
		//exit;
		
		$this->ejecutarConsulta();

		return $this->respuesta;

	}
	
}
?>
