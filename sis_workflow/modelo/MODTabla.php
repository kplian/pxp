<?php
/**
*@package pXP
*@file gen-MODTabla.php
*@author  (admin)
*@date 07-05-2014 21:39:40
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTabla extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTabla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tabla_sel';
		$this->transaccion='WF_tabla_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tabla','int4');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('vista_id_tabla_maestro','int4');
		$this->captura('bd_scripts_extras','text');
		$this->captura('vista_campo_maestro','int4');
		$this->captura('vista_scripts_extras','text');
		$this->captura('bd_descripcion','text');
		$this->captura('vista_tipo','varchar');
		$this->captura('menu_icono','varchar');
		$this->captura('menu_nombre','varchar');
		$this->captura('vista_campo_ordenacion','varchar');
		$this->captura('vista_posicion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('menu_codigo','varchar');
		$this->captura('bd_nombre_tabla','varchar');
		$this->captura('bd_codigo_tabla','varchar');
		$this->captura('vista_dir_ordenacion','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_tabla_maestro','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTabla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tabla_ime';
		$this->transaccion='WF_tabla_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('vista_id_tabla_maestro','vista_id_tabla_maestro','int4');
		$this->setParametro('bd_scripts_extras','bd_scripts_extras','text');
		$this->setParametro('vista_campo_maestro','vista_campo_maestro','int4');
		$this->setParametro('vista_scripts_extras','vista_scripts_extras','text');
		$this->setParametro('bd_descripcion','bd_descripcion','text');
		$this->setParametro('vista_tipo','vista_tipo','varchar');
		$this->setParametro('menu_icono','menu_icono','varchar');
		$this->setParametro('menu_nombre','menu_nombre','varchar');
		$this->setParametro('vista_campo_ordenacion','vista_campo_ordenacion','varchar');
		$this->setParametro('vista_posicion','vista_posicion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('menu_codigo','menu_codigo','varchar');
		$this->setParametro('bd_nombre_tabla','bd_nombre_tabla','varchar');
		$this->setParametro('bd_codigo_tabla','bd_codigo_tabla','varchar');
		$this->setParametro('vista_dir_ordenacion','vista_dir_ordenacion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTabla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tabla_ime';
		$this->transaccion='WF_tabla_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tabla','id_tabla','int4');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('vista_id_tabla_maestro','vista_id_tabla_maestro','int4');
		$this->setParametro('bd_scripts_extras','bd_scripts_extras','text');
		$this->setParametro('vista_campo_maestro','vista_campo_maestro','int4');
		$this->setParametro('vista_scripts_extras','vista_scripts_extras','text');
		$this->setParametro('bd_descripcion','bd_descripcion','text');
		$this->setParametro('vista_tipo','vista_tipo','varchar');
		$this->setParametro('menu_icono','menu_icono','varchar');
		$this->setParametro('menu_nombre','menu_nombre','varchar');
		$this->setParametro('vista_campo_ordenacion','vista_campo_ordenacion','varchar');
		$this->setParametro('vista_posicion','vista_posicion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('menu_codigo','menu_codigo','varchar');
		$this->setParametro('bd_nombre_tabla','bd_nombre_tabla','varchar');
		$this->setParametro('bd_codigo_tabla','bd_codigo_tabla','varchar');
		$this->setParametro('vista_dir_ordenacion','vista_dir_ordenacion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTabla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tabla_ime';
		$this->transaccion='WF_tabla_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tabla','id_tabla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function ejecutarScriptTabla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tabla_ime';
		$this->transaccion='WF_EJSCTABLA_PRO';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tabla','id_tabla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function cargarDatosTablaProceso($link=0){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tabla_sel';
		$this->transaccion='WF_tabla_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
		$this->resetParametros();
		$this->resetCaptura();
		$primera_vez = 1;
		
		$this->setParametrosConsulta();		
		
		//obtener los datos de la tabla maestro (datos de tabla y columnas)
		$this->captura('id_tabla','int4');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('vista_id_tabla_maestro','int4');
		$this->captura('bd_scripts_extras','text');
		$this->captura('vista_campo_maestro','int4');
		$this->captura('vista_scripts_extras','text');
		$this->captura('bd_descripcion','text');
		$this->captura('vista_tipo','varchar');
		$this->captura('menu_icono','varchar');
		$this->captura('menu_nombre','varchar');
		$this->captura('vista_campo_ordenacion','varchar');
		$this->captura('vista_posicion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('menu_codigo','varchar');
		$this->captura('bd_nombre_tabla','varchar');
		$this->captura('bd_codigo_tabla','varchar');
		$this->captura('vista_dir_ordenacion','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_tabla_maestro','varchar');
		
		$this->armarConsulta();	
		if ($link == 0) {
			$cone = new conexion();	
			$link = $cone->conectarnp();
			$primera_vez = 0;			
		}
		
		$array = array();
		try {
			$res = pg_query($link,$this->consulta);
		} catch (Exception $e) {
			$this->respuesta=new Mensaje();
			$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));
			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			return $this->respuesta;
		}
		
		if ($res) {
			$i = 0;
			while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC)){
				//obtener las columnas
				$array[$i] = array();
				
				$array[$i]['atributos'] = $row;
				
				
				$this->arreglo_consultas['filtro'] = ' tipcol.id_tabla = '. $row['id_tabla'];
				$columnas = $this->cargarDatosColumnaProceso($link);//llama a la funcion para obtener atributos de una tabla
				
				if ($columnas instanceof Mensaje)//Si es instancia de mensaje
					return $columnas;
					//retornar en mensaje
				
				$array[$i]['columnas'] = $columnas;
				
				//obtener las tablas
				//se cambia el filtro para la siguiente consulta
				$this->arreglo_consultas['filtro'] = ' tabla.vista_id_tabla_maestro = '. $row['id_tabla'];
				$tablas = $this->cargarDatosTablaProceso($link);//Llama a esta misma funcion que me devolvera las tablas detalle
				
				if ($tablas instanceof Mensaje)//Si es instancia de mensaje
					return $tablas;
					//retornar en mensaje			
				$array[$i]['detalles'] = $tablas;
				$i++;
				
			}
			pg_free_result($res);
		} else {
			$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));				
			//Existe error en la base de datos tomamamos el mensaje y elmensaje tecnico
			$this->respuesta=new Mensaje();
			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			return $this->respuesta;
		}
		
		if ($primera_vez == 0) {
			
			$this->respuesta=new Mensaje();
			$this->respuesta->setMensaje('EXITO',$this->nombre_archivo,'Consulta ejecutada con exito','Consulta ejecutada con exito','base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			$this->respuesta->setDatos($array);
			return $this->respuesta;
		} else {
			return $array;
		}		
	}

	function cargarDatosColumnaProceso($link=0){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_columna_sel';
		$this->transaccion='WF_TIPCOLES_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
		$this->resetParametros();
		$this->resetCaptura();
		
		$this->setParametrosConsulta();	
		$this->setParametro('tipo_estado','tipo_estado','varchar');
				
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
		$this->captura('momento','varchar');
		
		$this->armarConsulta();	
				
		$array = array();
		$res = pg_query($link,$this->consulta);
		if ($res) {
			while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC)){
				array_push ($array, $row);
			}
			pg_free_result($res);
			return $array;
		} else {
			$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));
			$this->respuesta=new Mensaje();				
			//Existe error en la base de datos tomamamos el mensaje y elmensaje tecnico
			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			return $this->respuesta;
		}
	}
			
}
?>