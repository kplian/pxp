<?php
class MODColumna extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
	
	function listarColumna(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gen.ft_columna_sel';// nombre procedimiento almacenado
		$this->transaccion='GEN_COLUMN_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
	
		//Definicion de la lista del resultado del query
	
		$this->captura('id_columna','integer');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_tabla','integer');
		$this->captura('id_usuario_reg','integer');
		$this->captura('id_usuario_mod','integer');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('etiqueta','varchar');
		$this->captura('guardar','varchar');
		$this->captura('tipo_dato','varchar');
		$this->captura('longitud','text');
		$this->captura('nulo','varchar');
		$this->captura('checks','varchar');
		$this->captura('valor_defecto','varchar');
		$this->captura('grid_ancho','integer');
		$this->captura('grid_mostrar','varchar');
		$this->captura('form_ancho_porcen','integer');
		$this->captura('orden','smallint');
		$this->captura('grupo','smallint');
		
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//echo $this->consulta;exit;

		return $this->respuesta;
	}
	
	function insertarColumna(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gen.ft_columna_ime';
		$this->transaccion='GEN_COLUMN_INS';
		$this->tipo_procedimiento='IME';
		
		//Define los parametros para la funcion	
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_tabla','id_tabla','integer');
		$this->setParametro('id_usuario_reg','id_usuario_reg','integer');
		$this->setParametro('etiqueta','etiqueta','varchar');
		$this->setParametro('guardar','guardar','varchar');
		$this->setParametro('grid_ancho','grid_ancho','integer');
		$this->setParametro('grid_mostrar','grid_mostrar','varchar');
		$this->setParametro('form_ancho_porcen','form_ancho_porcen','integer');
		$this->setParametro('orden','orden','smallint');
		$this->setParametro('grupo','grupo','smallint');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	function modificarColumna(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gen.ft_columna_ime';
		$this->transaccion='GEN_COLUMN_MOD';
		$this->tipo_procedimiento='IME';
		
		//Define los parametros para la funcion	
		$this->setParametro('id_columna','id_columna','integer');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_tabla','id_tabla','integer');
		$this->setParametro('id_usuario_mod','id_usuario_mod','integer');
		$this->setParametro('etiqueta','etiqueta','varchar');
		$this->setParametro('guardar','guardar','varchar');
		$this->setParametro('longitud','longitud','text');
		$this->setParametro('grid_ancho','grid_ancho','integer');
		$this->setParametro('grid_mostrar','grid_mostrar','varchar');
		$this->setParametro('form_ancho_porcen','form_ancho_porcen','integer');
		$this->setParametro('orden','orden','smallint');
		$this->setParametro('grupo','grupo','smallint');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	
	function eliminarColumna(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gen.ft_columna_ime';
		$this->transaccion='GEN_COLUMN_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_columna','id_columna','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;
	}
	
	function listarDatosColumna(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gen.ft_columna_sel';// nombre procedimiento almacenado
		$this->transaccion='GEN_DATCOL_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
	
		//Definicion de la lista del resultado del query
	
		$this->captura('attnum','smallint');
		$this->captura('attname','name');
		$this->captura('typname','name');
		$this->captura('attlen','smallint');
		$this->captura('atttypmod','integer');
		$this->captura('attnotnull','boolean');
		$this->captura('atthasdef','boolean');
		$this->captura('obj_description','text');
		$this->captura('relname','name');
		$this->captura('nombre','varchar');
		$this->captura('etiqueta','varchar');
		$this->captura('guardar','varchar');
		
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		return $this->respuesta;
	}
	
}
?>
