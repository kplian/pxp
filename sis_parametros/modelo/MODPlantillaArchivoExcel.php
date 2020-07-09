<?php
/****************************************************************************************
*@package pXP
*@file gen-MODPlantillaArchivoExcel.php
*@author  (gsarmiento)
*@date 15-12-2016 20:46:39
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*****************************************************************************************
 ISSUE  SIS     FECHA      	AUTOR       DESCRIPCION
 #1		PAR		21/11/2018	EGS			se agrego funciones para exportar la configuracion de plantilla  
 #185 	PAR 	07/07/2020	RCM			Crear opción para generar plantilla excel en blanco
*****************************************************************************************
*/
class MODPlantillaArchivoExcel extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPlantillaArchivoExcel(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_plantilla_archivo_excel_sel';
		$this->transaccion='PM_ARXLS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_plantilla_archivo_excel','int4');
		$this->captura('nombre','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('hoja_excel','varchar');
		$this->captura('fila_inicio','int4');
		$this->captura('fila_fin','int4');
		$this->captura('filas_excluidas','text');
		$this->captura('tipo_archivo','varchar');
		$this->captura('delimitador','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPlantillaArchivoExcel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_plantilla_archivo_excel_ime';
		$this->transaccion='PM_ARXLS_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('hoja_excel','hoja_excel','varchar');
		$this->setParametro('fila_inicio','fila_inicio','int4');
		$this->setParametro('fila_fin','fila_fin','int4');
		$this->setParametro('filas_excluidas','filas_excluidas','text');
		$this->setParametro('tipo_archivo','tipo_archivo','varchar');
		$this->setParametro('delimitador','delimitador','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPlantillaArchivoExcel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_plantilla_archivo_excel_ime';
		$this->transaccion='PM_ARXLS_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla_archivo_excel','id_plantilla_archivo_excel','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('hoja_excel','hoja_excel','varchar');
		$this->setParametro('fila_inicio','fila_inicio','int4');
		$this->setParametro('fila_fin','fila_fin','int4');
		$this->setParametro('filas_excluidas','filas_excluidas','text');
		$this->setParametro('tipo_archivo','tipo_archivo','varchar');
		$this->setParametro('delimitador','delimitador','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPlantillaArchivoExcel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_plantilla_archivo_excel_ime';
		$this->transaccion='PM_ARXLS_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla_archivo_excel','id_plantilla_archivo_excel','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	//	#1			21/11/2018		EGS	
		function exportarDatos() {
		
		$this->procedimiento='param.ft_plantilla_archivo_excel_sel';
			$this->transaccion='PARAM_EXPPAE_SEL';
			$this->tipo_procedimiento='SEL';
			$this->setCount(false);
			
		    $this->setParametro('id_plantilla_archivo_excel','id_plantilla_archivo_excel','integer');
			
			//Definicion de la lista del resultado del query
				$this->captura('tipo_reg','varchar');
				$this->captura('id_plantilla_archivo_excel','int4');
				$this->captura('codigo','varchar');
				$this->captura('nombre','varchar');
				$this->captura('estado_reg','varchar');
				$this->captura('hoja_excel','varchar');
				$this->captura('fila_inicio','int4');
				$this->captura('fila_fin','int4');
				$this->captura('filas_excluidas','text');
				$this->captura('tipo_archivo','varchar');
				$this->captura('delimitador','varchar');
				$this->captura('id_usuario_reg','int4');
				$this->captura('usuario_ai','varchar');
				$this->captura('fecha_reg','timestamp');
				$this->captura('id_usuario_ai','int4');
				$this->captura('fecha_mod','timestamp');
				$this->captura('id_usuario_mod','int4');
				$this->captura('usr_reg','varchar');
				$this->captura('usr_mod','varchar');
			
		
		$this->armarConsulta();	
		
        $this->ejecutarConsulta(); 
		 		
		////////////////////////////
		
		
		if($this->respuesta->getTipo() == 'ERROR'){
			return $this->respuesta;
		}
		else {
		    $this->procedimiento = 'param.ft_plantilla_archivo_excel_sel';
			$this->transaccion = 'PARAM_EXPPAEC_SEL';
			$this->tipo_procedimiento = 'SEL';
			$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();	
				
			$this->captura('tipo_reg','varchar');
			$this->captura('id_columna_archivo_excel','int4');
			$this->captura('id_plantilla_archivo_excel','int4');
			$this->captura('codigo','varchar');
			$this->captura('codigo_plantilla','varchar');
			$this->captura('sw_legible','varchar');
			$this->captura('formato_fecha','varchar');
			$this->captura('anio_fecha','int4');
			$this->captura('numero_columna','int4');
			$this->captura('nombre_columna','varchar');
			$this->captura('nombre_columna_tabla','varchar');
			$this->captura('tipo_valor','varchar');
			$this->captura('punto_decimal','varchar');
			$this->captura('estado_reg','varchar');
			$this->captura('id_usuario_ai','int4');
			$this->captura('id_usuario_reg','int4');
			$this->captura('fecha_reg','timestamp');
			$this->captura('usuario_ai','varchar');
			$this->captura('fecha_mod','timestamp');
			$this->captura('id_usuario_mod','int4');
			$this->captura('usr_reg','varchar');
			$this->captura('usr_mod','varchar');
			
		
			
			$this->armarConsulta();
			$consulta=$this->getConsulta();			
	  
			$this->ejecutarConsulta($this->respuesta);
		}

		
       return $this->respuesta;		
	
	}
	//	#1			21/11/2018		EGS			

	//Inicio #185
	function generarPlantilla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento = 'param.ft_plantilla_archivo_excel_sel';
		$this->transaccion = 'PM_GETPLA_SEL';
		$this->tipo_procedimiento = 'SEL';//tipo de transaccion
		$this->setCount(false);
				
		//Definicion de la lista del resultado del query
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('nombre_columna','varchar');
		$this->captura('tipo_valor','varchar');
		$this->captura('formato','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		//Devuelve la respuesta
		return $this->respuesta;
	}
	//Fin #185
			
}
?>