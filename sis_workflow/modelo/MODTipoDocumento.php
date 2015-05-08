<?php
/**
*@package pXP
*@file gen-MODTipoDocumento.php
*@author  (admin)
*@date 14-01-2014 17:43:47
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoDocumento extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoDocumento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_documento_sel';
		$this->transaccion='WF_TIPDW_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_documento','int4');
		$this->captura('nombre','varchar');
		$this->captura('id_proceso_macro','int4');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','text');
		$this->captura('estado_reg','varchar');
		$this->captura('tipo','varchar');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('action','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('solo_lectura','varchar');
		$this->captura('categoria_documento','varchar');
		$this->captura('orden','numeric');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoDocumento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_documento_ime';
		$this->transaccion='WF_TIPDW_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		
		$this->setParametro('action','action','varchar');
		$this->setParametro('solo_lectura','solo_lectura','varchar');
		$this->setParametro('categoria_documento','categoria_documento','varchar');
		$this->setParametro('orden','orden','numeric');
        $this->setParametro('nombre_vista','nombre_vista','varchar');
        $this->setParametro('nombre_archivo_plantilla','nombre_archivo_plantilla','text');
		$this->setParametro('esquema_vista','esquema_vista','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoDocumento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_documento_ime';
		$this->transaccion='WF_TIPDW_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_documento','id_tipo_documento','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('action','action','varchar');
		$this->setParametro('solo_lectura','solo_lectura','varchar');
        $this->setParametro('categoria_documento','categoria_documento','varchar');
		$this->setParametro('orden','orden','numeric');
        $this->setParametro('nombre_vista','nombre_vista','varchar');
        $this->setParametro('nombre_archivo_plantilla','nombre_archivo_plantilla','text');
        $this->setParametro('esquema_vista','esquema_vista','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoDocumento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_documento_ime';
		$this->transaccion='WF_TIPDW_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_documento','id_tipo_documento','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    
    function listarColumnasPlantillaDocumento(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.ft_tipo_documento_sel';
        $this->transaccion='WF_TIDOCPLAN_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->captura('column_name','varchar');
        $this->captura('data_type','varchar');
        $this->captura('character_maximum_length','int4');
        
        $this->setParametro('nombre_vista','nombre_vista','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
    
    function listarTipoDocumentoXTipoPRocesoEstado(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.ft_tipo_documento_sel';
        $this->transaccion='WF_TPROTIDOC_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->captura('id_tipo_documento','int4');
        $this->captura('nombre','varchar');
        $this->captura('id_proceso_macro','int4');
        $this->captura('codigo','varchar');
        $this->captura('descripcion','text');
        $this->captura('estado_reg','varchar');
        $this->captura('tipo','varchar');
        $this->captura('id_tipo_proceso','int4');
        $this->captura('action','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('solo_lectura','varchar');
        $this->captura('nombre_vista','varchar');
        $this->captura('nombre_archivo_plantilla','text');
        $this->captura('esquema_vista','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }

    function obtenerColumnasVista(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.ft_tipo_documento_sel';
        $this->transaccion='WF_TIDOCPLAN_SEL';
        $this->tipo_procedimiento='SEL';
        $this->setCount(false);
        $this->resetParametros();
        $this->resetCaptura();
        
        $this->setParametrosConsulta();
                
        //Definición de columnas
        $this->captura('column_name','varchar');
        $this->captura('data_type','varchar');
        $this->captura('character_maximum_length','int4');
        
        $this->setParametro('nombre_vista','nombre_vista','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }

    function generarDocumento(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.ft_tipo_documento_sel';
        $this->transaccion='WF_TIDOCPLAN_SEL';
        $this->tipo_procedimiento='SEL';
        $this->setCount(false);
        $this->resetParametros();
        $this->resetCaptura();
        
        $this->setParametrosConsulta();
                
        //Definición de columnas
        $this->captura('column_name','varchar');
        $this->captura('data_type','varchar');
        $this->captura('character_maximum_length','int4');
        
        $this->setParametro('nombre_vista','nombre_vista','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        if ($link == 0) {
            $cone = new conexion(); 
            $link = $cone->conectarnp();
            $primera_vez = 0;           
        }
        
        $array = array();
        try {
            $res = pg_query($link,$this->consulta);
            
            if ($res) {
                $i = 0;
                while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC)){
                    //obtener las columnas
                    array_push ($array, $row);
                    
                }
                pg_free_result($res);
               
                if(count($array)==0){
                    $resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));              
                    //Existe error en la base de datos tomamamos el mensaje y elmensaje tecnico
                    $this->respuesta=new Mensaje();
                    $this->respuesta->setMensaje('ERROR','MODTipoDocumento.php','El Documento no tiene una vista de base de datos asociado.','El Documento no tiene una vista de base de datos asociada.','Control',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
                    return $this->respuesta;
                }
                
                ////////////////////////////////////////////////////////////////////
                //Obtención de la definición de columnas de la vista del documento
                ////////////////////////////////////////////////////////////////////
                $arrDefCols = array();
                $i=0;
                foreach ($array as $clave => $valor){
                    $j=0;
                    foreach ($valor as $clave1 => $valor1){
                        $arrDefCols[$i][$j]=$valor1;
                        $j++;
                    }
                    $i++;
                }
                //var_dump($arrDefCols);
                
                ///////////////////////////////////////////////////////////
                //Ejecución de consulta para obtener los datos de la vista
                ///////////////////////////////////////////////////////////
                $this->procedimiento='wf.ft_tipo_documento_sel';
                $this->transaccion='WF_VISTA_SEL';
                $this->tipo_procedimiento='SEL';
                $this->setCount(false);
                $this->resetParametros();
                $this->resetCaptura();
                
                $this->setParametrosConsulta();
                
                //Definición de columnas
                foreach($arrDefCols as $clave => $valor){
                    $columna=array();
                    $j=0;
                    foreach ($valor as $clave1 => $valor1){
                        $columna[$j]=$valor1;
                        $j++;
                    }
                    //echo $columna[0] .': '.$columna[1];
                    $this->captura($columna[0],$columna[1]);
                }
                
                //Envío de parámetro id_proceso_wf
                $this->setParametro('id_proceso_wf','id_proceso_wf','int4');
                $this->setParametro('nombre_vista','nombre_vista','varchar');
                $this->setParametro('esquema_vista','esquema_vista','varchar');
                
                //Ejecuta la instruccion
                $this->armarConsulta();
                $this->ejecutarConsulta();
                
                return $this->respuesta;
 
            } else {
                $resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));              
                //Existe error en la base de datos tomamamos el mensaje y elmensaje tecnico
                $this->respuesta=new Mensaje();
                $this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
                return $this->respuesta;
            }
        } catch (Exception $e) {
            $this->respuesta=new Mensaje();
            $resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));
            $this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
            return $this->respuesta;
        }

    }
			
}
?>