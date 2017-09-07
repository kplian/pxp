<?php
/**
*@package pXP
*@file gen-MODConceptoIngas.php
*@author  (admin)
*@date 25-02-2013 19:49:23
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODConceptoIngas extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarConceptoIngas(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_concepto_ingas_sel';
		$this->transaccion='PM_CONIG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_concepto_ingas','int4');
		$this->captura('desc_ingas','varchar');
		$this->captura('tipo','varchar');
		$this->captura('movimiento','varchar');
		$this->captura('sw_tes','varchar');
		$this->captura('id_oec','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('activo_fijo','varchar');
		$this->captura('almacenable','varchar');
		$this->captura('id_grupo_ots','varchar');
		$this->captura('filtro_ot','varchar');
		$this->captura('requiere_ot','varchar');
		$this->captura('sw_autorizacion','varchar');
		$this->captura('id_entidad','integer');
		$this->captura('descripcion_larga','text');
		$this->captura('id_unidad_medida','int4');
		$this->captura('desc_unidad_medida','varchar');
		$this->captura('nandina','varchar');		
		$this->captura('ruta_foto','varchar');		
		$this->captura('id_cat_concepto','int4');
		$this->captura('desc_cat_concepto','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

	function listarConceptoIngasPartidaGestion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_concepto_ingas_sel';
		$this->transaccion='PM_CONIGPARGES_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

		$this->setParametro('id_gestion','id_gestion','int4');
		//Definicion de la lista del resultado del query
		$this->captura('desc_ingas','varchar');
		$this->captura('codigo','varchar');
		$this->captura('nombre_partida','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('movimiento','varchar');
		$this->captura('tipo_partida','varchar');
		$this->captura('tipo','varchar');
		$this->captura('activo_fijo','varchar');
		$this->captura('almacenable','varchar');
		$this->captura('exige_ot','varchar');
		$this->captura('sistemas','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	/*
	Author RAC
	Date 20 Junio 2014
	Lista conceptos de gastos y los nobmre de las partidas
	es necesario filtrar ppor gestion 
	
	*/
	function listarConceptoIngasMasPartida(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.f_concepto_ingas_sel';
        $this->transaccion='PM_CONIGPAR_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $this->setParametro('autorizacion','autorizacion','varchar');
		$this->setParametro('autorizacion_nulos','autorizacion_nulos','varchar');
        //Definicion de la lista del resultado del query
        $this->captura('id_concepto_ingas','int4');
        $this->captura('desc_ingas','varchar');
        $this->captura('tipo','varchar');
        $this->captura('movimiento','varchar');
        $this->captura('sw_tes','varchar');
        $this->captura('id_oec','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('activo_fijo','varchar');
        $this->captura('almacenable','varchar');
        $this->captura('desc_partida','text');
		$this->captura('id_grupo_ots','varchar');
		$this->captura('filtro_ot','varchar');
		$this->captura('requiere_ot','varchar');
		$this->captura('sw_autorizacion','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
	
	function listarConceptoIngasPorPartidas(){
        //Definicion de variables para ejecucion del procedimientp
        //necesita sistema de presupuestos
        $this->procedimiento='param.f_concepto_ingas_sel';
        $this->transaccion='PM_CONIGPP_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->setParametro('id_partidas','id_partidas','varchar');
        $this->captura('id_concepto_ingas','int4');
        $this->captura('desc_ingas','varchar');
        $this->captura('tipo','varchar');
        $this->captura('movimiento','varchar');
        $this->captura('sw_tes','varchar');
        $this->captura('id_oec','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
		$this->captura('activo_fijo','varchar');
		$this->captura('almacenable','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
    /*
	 * Autor RAC
	 * DESC  lista concepto de gasto permitidos dentro de un presupeusto es necesario enviar el id presupuesto
	 * */

    function listarConceptoIngasPresupuesto(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.f_concepto_ingas_sel';
        $this->transaccion='PM_CONIGPRE_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $this->setParametro('autorizacion','autorizacion','varchar');
		$this->setParametro('autorizacion_nulos','autorizacion_nulos','varchar');
		$this->setParametro('id_presupuesto','id_presupuesto','integer');
		
		        
        //Definicion de la lista del resultado del query
        $this->captura('id_concepto_ingas','int4');
        $this->captura('desc_ingas','varchar');
        $this->captura('tipo','varchar');
        $this->captura('movimiento','varchar');
        $this->captura('sw_tes','varchar');
        $this->captura('id_oec','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('activo_fijo','varchar');
        $this->captura('almacenable','varchar');
        $this->captura('desc_partida','text');
		$this->captura('id_grupo_ots','varchar');
		$this->captura('filtro_ot','varchar');
		$this->captura('requiere_ot','varchar');
		$this->captura('sw_autorizacion','varchar');
		$this->captura('desc_gestion','varchar');
		
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
			
	function insertarConceptoIngas(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_concepto_ingas_ime';
		$this->transaccion='PM_CONIG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('desc_ingas','desc_ingas','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('movimiento','movimiento','varchar');
		$this->setParametro('sw_tes','sw_tes','varchar');
		$this->setParametro('id_oec','id_oec','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('activo_fijo','activo_fijo','varchar');
		$this->setParametro('almacenable','almacenable','varchar');
		
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('nandina','nandina','varchar');
		
		$this->setParametro('id_cat_concepto','id_cat_concepto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarConceptoIngas(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_concepto_ingas_ime';
		$this->transaccion='PM_CONIG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
		$this->setParametro('desc_ingas','desc_ingas','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('movimiento','movimiento','varchar');
		$this->setParametro('sw_tes','sw_tes','varchar');
		$this->setParametro('id_oec','id_oec','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('activo_fijo','activo_fijo','varchar');
		$this->setParametro('almacenable','almacenable','varchar');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('nandina','nandina','varchar');		
		$this->setParametro('id_cat_concepto','id_cat_concepto','int4');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarConceptoIngas(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_concepto_ingas_ime';
		$this->transaccion='PM_CONIG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function editOt(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_concepto_ingas_ime';
		$this->transaccion='PM_CONEDOT_IME';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
		$this->setParametro('id_grupo_ots','id_grupo_ots','varchar');
		$this->setParametro('requiere_ot','requiere_ot','varchar');
		$this->setParametro('filtro_ot','filtro_ot','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

    function editAuto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_concepto_ingas_ime';
		$this->transaccion='PM_COAUTO_IME';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
		$this->setParametro('sw_autorizacion','sw_autorizacion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function subirImagen(){
		
		
		 $cone = new conexion();
			$link = $cone->conectarpdo();
			$copiado = false;			
			try {
				
				$link->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);		
		  	    $link->beginTransaction();
				
				if ($this->arregloFiles['file_documento']['name'] == "") {
					throw new Exception("El archivo no puede estar vacio");
				}
				
				$this->procedimiento='param.f_concepto_ingas_ime';
		        $this->transaccion='PM_CIGIMG_MOD';
		        $this->tipo_procedimiento='IME';
				
				
				
				//validar que no sea un arhvio en blanco
				$file_name = $this->getFileName2('file_documento', 'id_concepto_ingas', '','_v');
				
				

			   
			    //manda como parametro la url completa del archivo 
	            $this->aParam->addParametro('ruta_foto', $file_name[2]);
	            $this->arreglo['ruta_foto'] = $file_name[2];
	            $this->setParametro('ruta_foto','ruta_foto','varchar'); 
				
				
				//Define los parametros para la funcion	
		        $this->setParametro('id_concepto_ingas','id_concepto_ingas','integer');

				      
	            //Ejecuta la instruccion
	            $this->armarConsulta();
				$stmt = $link->prepare($this->consulta);		  
			  	$stmt->execute();
				$result = $stmt->fetch(PDO::FETCH_ASSOC);				
				$resp_procedimiento = $this->divRespuesta($result['f_intermediario_ime']);
				
				
				if ($resp_procedimiento['tipo_respuesta']=='ERROR') {
					throw new Exception("Error al ejecutar en la bd", 3);
				}
				
	            
				  
	            if($resp_procedimiento['tipo_respuesta'] == 'EXITO'){
	              
				   //revisamos si ya existe el archivo la verison anterior sera mayor a cero
				   $respuesta = $resp_procedimiento['datos'];
				   //var_dump($respuesta);
				   
				   
				   //cipiamos el nuevo archivo 
	               $this->setFile('file_documento','id_concepto_ingas', false,100000 ,array('jpg','jpeg','bmp','gif','png'), $folder = '','_v'.$version);
	            }
				
				$link->commit();
				$this->respuesta=new Mensaje();
				$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				$this->respuesta->setDatos($respuesta);
				 
				
				
			}
			catch (Exception $e) {
		    		
								
		    	$link->rollBack(); 
				
				
		    	$this->respuesta=new Mensaje();
				if ($e->getCode() == 3) {//es un error de un procedimiento almacenado de pxp
					$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				} else if ($e->getCode() == 2) {//es un error en bd de una consulta
					$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$e->getMessage(),$e->getMessage(),'modelo','','','','');
				} else {//es un error lanzado con throw exception
					throw new Exception($e->getMessage(), 2);
				}
		}    
	    
	    return $this->respuesta;
		
		
		

	}
	
	
			
}
?>