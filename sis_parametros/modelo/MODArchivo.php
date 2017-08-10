<?php
/**
*@package pXP
*@file gen-MODArchivo.php
*@author  (admin)
*@date 05-12-2016 15:04:48
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODArchivo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);

		$this->cone = new conexion();
		$this->link = $this->cone->conectarpdo(); //conexion a pxp(postgres)

	}
			
	function listarArchivo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_archivo_sel';
		$this->transaccion='PM_ARCH_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_archivo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('folder','varchar');
		$this->captura('extension','varchar');
		$this->captura('id_tabla','int4');
		$this->captura('nombre_archivo','varchar');
		$this->captura('id_tipo_archivo','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('tabla','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}



	function insertarArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_archivo_ime';
		$this->transaccion='PM_ARCH_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('folder','folder','varchar');
		$this->setParametro('extension','extension','varchar');
		$this->setParametro('id_tabla','id_tabla','int4');
		$this->setParametro('nombre_archivo','nombre_archivo','varchar');
		$this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_archivo_ime';
		$this->transaccion='PM_ARCH_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_archivo','id_archivo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('folder','folder','varchar');
		$this->setParametro('extension','extension','varchar');
		$this->setParametro('id_tabla','id_tabla','int4');
		$this->setParametro('nombre_archivo','nombre_archivo','varchar');
		$this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarArchivo(){
		//Definicion de variables para ejecucion del procedimiento

        exit;
		$this->procedimiento='param.ft_archivo_ime';
		$this->transaccion='PM_ARCH_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_archivo','id_archivo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function eliminarArchivo2(){
		//Definicion de variables para ejecucion del procedimiento



        $file = $this->aParam->getParametro('folder').$this->aParam->getParametro('nombre_archivo').'.'.$this->aParam->getParametro('extension');
        if (!unlink($file))
        {
            echo ("Error deleting $file");
        }
        else
        {
            $this->procedimiento='param.ft_archivo_ime';
            $this->transaccion='PM_ARCH_ELI';
            $this->tipo_procedimiento='IME';

            //Define los parametros para la funcion
            $this->setParametro('id_archivo','id_archivo','int4');

            //Ejecuta la instruccion
            $this->armarConsulta();
            $this->ejecutarConsulta();

            //Devuelve la respuesta
            return $this->respuesta;
        }
        
        

	}


	function listarArchivoCodigo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_archivo_sel';
		$this->transaccion='PM_ARCOD_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

		$this->setParametro('id_tabla','id_tabla','varchar');

		//Definicion de la lista del resultado del query
		$this->captura('id_archivo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('folder','varchar');
		$this->captura('extension','varchar');
		$this->captura('id_tabla','int4');
		$this->captura('nombre_archivo','varchar');
		$this->captura('id_tipo_archivo','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('tabla','varchar');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('multiple','varchar');
		$this->captura('nombre_descriptivo','varchar');
		/*$this->captura('nombre_archivo','varchar');
		$this->captura('extension','varchar');
		$this->captura('id_tabla','int4');*/


	
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();


		//Devuelve la respuesta
		return $this->respuesta;
	}


	function subirArchivo()
	{



		$cone = new conexion();
		$link = $cone->conectarpdo();
		$copiado = false;
		try {
			$link->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$link->beginTransaction();

			if ($this->arregloFiles['archivo']['name'] == "") {
				throw new Exception("El archivo no puede estar vacio");
			}


            $tipo_archivo  = $this->verTipoArchivo($this->aParam->getParametro('id_tipo_archivo'));
            if (count($tipo_archivo) == 0) {
                throw new Exception("no exite una configuracion para subir archivos en la tabla que enviaste", 1);
            }





            $tipo_archivo_nombre = $tipo_archivo[0]['tipo_archivo'];
            $multiple = $tipo_archivo[0]['multiple'];
            $nombre_id = $tipo_archivo[0]['nombre_id'];
            $id_tipo_archivo = $tipo_archivo[0]['id_tipo_archivo'];

            $extensiones_permitidas = $tipo_archivo[0]['extensiones_permitidas'];
            $nombre_tipo_archivo = $tipo_archivo[0]['nombre'];
            $tamano_tipo_archivo = $tipo_archivo[0]['tamano'];


            if((($this->arregloFiles['archivo']['size'] / 1000) / 1024) > $tamano_tipo_archivo  ){
                throw new Exception("El tamaño del Archivo supera a la configuración");

            }


            //sacamos la ruta para ver donde se guardara si es vacio se guardara en que sistema y en que control
            $ruta_guardar =  $tipo_archivo[0]['ruta_guardar'];
            if($ruta_guardar == 'null' || $ruta_guardar == null){
               $ruta_guardar = '';
            }

            //si mandamos una ruta desde la vista entonces tomamos en cuenta esa agregandole el nombre de tipo de archivo
            if($this->aParam->getParametro('ruta_perzonalizada') != ''){
                $ruta_guardar = $this->aParam->getParametro('ruta_perzonalizada').'/'.$nombre_tipo_archivo.'/';
            }



            //si no envian sistema/control entonces el folder sera vacio para que entre donde corresponda
            $folder = $ruta_guardar;



			//Definicion de variables para ejecucion del procedimiento
			$this->procedimiento='param.ft_archivo_ime';
			$this->transaccion='PM_ARCH_INS';
			$this->tipo_procedimiento='IME';


			$ext = pathinfo($this->arregloFiles['archivo']['name']);
			$this->arreglo['extension'] = $ext['extension'];
			$extension = $ext['extension'];
            $unico_id = uniqid();


            
			//crea un unico id para el nombre
			$this->aParam->addParametro('unico_id', $unico_id);
			$this->arreglo['unico_id'] = $unico_id;
			$this->setParametro('unico_id','unico_id','varchar');




			//validar que no sea un arhvio en blanco
			$file_name = $this->getFileName2('archivo', 'unico_id', $folder, false);




			//Define los parametros para la funcion
			$this->setParametro('extension','extension','varchar');

			//manda como parametro la url completa del archivo
			$this->aParam->addParametro('file_name', $file_name[2]);
			$this->arreglo['file_name'] = $file_name[2];
			$this->setParametro('file_name','file_name','varchar');




			//manda como parametro el folder del arhivo
			$this->aParam->addParametro('folder2', $file_name[1]);
			$this->arreglo['folder2'] = $file_name[1];
			$this->setParametro('folder2','folder2','varchar');
			$this->setParametro('folder','folder2','varchar');

			//manda como parametro el solo el nombre del arhivo  sin extencion
			$this->aParam->addParametro('only_file2', $file_name[0]);
			$this->arreglo['only_file2'] = $file_name[0];
			$this->setParametro('only_file2','only_file2','varchar');
			$this->setParametro('nombre_archivo','only_file2','varchar');










			$tabla = $this->aParam->getParametro('tabla');
			$id_tabla = $this->aParam->getParametro('id_tabla');


			//mandamos el id_tipo_archivo
			$this->aParam->addParametro('id_tipo_archivo', $id_tipo_archivo);
			$this->arreglo['id_tipo_archivo'] = $id_tipo_archivo;
			$this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');
			//mandamos el id_tabla
			$this->aParam->addParametro('id_tabla', $id_tabla);
			$this->arreglo['id_tabla'] = $id_tabla;
			$this->setParametro('id_tabla','id_tabla','int4');


			//enviamos el nombre de archivo
            $this->setParametro('nombre_descriptivo','nombre_descriptivo','varchar');



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
				//cipiamos el nuevo archivo
				$this->setFile('archivo',
                    'unico_id',
                    false,
                    100000,
                    preg_split('~,~', $extensiones_permitidas),
                    $folder
                );




				//damos las rutas a guardar las conversiones de tamanios

				if($tipo_archivo_nombre == 'imagen'){
					$url_original = $file_name[1];
					$url_mediano = $file_name[1]."mediano/";
					$url_pequeno = $file_name[1]."pequeno/";

					$mediana = $this->convertirTamanoImagen('file_name',400,'extension',$url_mediano,$file_name[0]);
					$pequena = $this->convertirTamanoImagen('file_name',200,'extension',$url_pequeno,$file_name[0]);
				}


			}






			$link->commit();
			$this->respuesta=new Mensaje();
			$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			$this->respuesta->setDatos($respuesta);



		}catch (Exception $e) {
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



	function subirArchivoMultiple(){


		$cone = new conexion();
		$link = $cone->conectarpdo();
		$copiado = false;
		try {
			$link->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$link->beginTransaction();


			$tipo_archivo  = $this->verTipoArchivo($this->aParam->getParametro('tabla'));
			if (count($tipo_archivo) == 0) {
				throw new Exception("no exite una configuracion para subir archivos en la tabla que enviaste", 1);
			}


			$tipo_archivo_nombre = $tipo_archivo[0]['tipo_archivo'];
			$multiple = $tipo_archivo[0]['multiple'];
			$nombre_id = $tipo_archivo[0]['nombre_id'];
			$id_tipo_archivo = $tipo_archivo[0]['id_tipo_archivo'];


			$tabla = $this->aParam->getParametro('tabla');
			$id_tabla = $this->aParam->getParametro('id_tabla');


			//mandamos el id_tipo_archivo
			$this->aParam->addParametro('id_tipo_archivo', $id_tipo_archivo);
			$this->arreglo['id_tipo_archivo'] = $id_tipo_archivo;
			$this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');
			//mandamos el id_tabla
			$this->aParam->addParametro('id_tabla', $id_tabla);
			$this->arreglo['id_tabla'] = $id_tabla;
			$this->setParametro('id_tabla','id_tabla','int4');


			$arra = array();

			$ruta_destino="./../../../uploaded_files/sis_parametros/Archivo/";
			$url_mediano = $ruta_destino.'mediano/';
			$url_pequeno = $ruta_destino.'pequeno/';

			$aux = count($this->arregloFiles['archivo']['name']);
			for ($i = 0; $i < $aux; $i++){
				$img = pathinfo($this->arregloFiles['archivo']['name'][$i]);
				$tmp_name = $this->arregloFiles['archivo']['tmp_name'][$i];
				$tamano= ($this->arregloFiles['archivo']['size'][$i] / 1000)."Kb"; //Obtenemos el tama�o en KB

				$nombre_archivo = $img['filename'];
				$extension = $img['extension'];
				$basename = $img['basename'];

				$unico_id = uniqid();

				$file_name = md5($unico_id . $_SESSION["_SEMILLA"]);
				$file_server_name = $file_name . ".$extension";
				move_uploaded_file($tmp_name, $ruta_destino . $file_server_name);

				$ruta_de_grabado =  $ruta_destino.$file_server_name;



				$this->aParam->addParametro('ruta_de_grabado', $ruta_de_grabado);
				$this->arreglo['ruta_de_grabado'] = $ruta_de_grabado; // esta ruta contiene con el archivo mas

				$this->aParam->addParametro('extension', $ruta_de_grabado);
				$this->arreglo['extension'] = $extension;



				$mediana = $this->convertirTamanoImagen('ruta_de_grabado',720,'extension',$url_mediano,$file_name);
				$mediana = $this->convertirTamanoImagen('ruta_de_grabado',400,'extension',$url_pequeno,$file_name);


				$arra[] = array(
					"nombre_archivo" => $file_name,
					"extension" => $extension,
					"folder" => $ruta_destino
				);

			}

			$arra_json = json_encode($arra);

			$this->aParam->addParametro('arra_json', $arra_json);
			$this->arreglo['arra_json'] = $arra_json;



			//Definicion de variables para ejecucion del procedimiento
			$this->procedimiento='param.ft_archivo_ime';
			$this->transaccion='PM_ARCHJSON_INS';
			$this->tipo_procedimiento='IME';


			$this->setParametro('arra_json','arra_json','text');

			//Ejecuta la instruccion
			$this->armarConsulta();
			$stmt = $link->prepare($this->consulta);
			$stmt->execute();
			$result = $stmt->fetch(PDO::FETCH_ASSOC);
			$resp_procedimiento = $this->divRespuesta($result['f_intermediario_ime']);




			if ($resp_procedimiento['tipo_respuesta']=='ERROR') {
				throw new Exception("Error al ejecutar en la bd", 3);
			}

			$link->commit();
			$this->respuesta=new Mensaje();
			$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			$this->respuesta->setDatos($respuesta);



		}catch (Exception $e) {
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



	function verTipoArchivo($id_tipo_archivo){

		$res = $this->link->prepare("select * from  param.ttipo_archivo WHERE id_tipo_archivo = '$id_tipo_archivo' limit 1");

		$res->execute();
		$result = $res->fetchAll(PDO::FETCH_ASSOC);
		return $result;
	}




	function listarArchivoHistorico(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_archivo_sel';
		$this->transaccion='PM_ARVER_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);

		$this->setParametro('id_archivo','id_archivo','int4');

		//Definicion de la lista del resultado del query
		$this->captura('id_archivo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('folder','varchar');
		$this->captura('extension','varchar');
		$this->captura('id_tabla','int4');
		$this->captura('nombre_archivo','varchar');
		$this->captura('id_tipo_archivo','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('version','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function listarArchivoTabla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_archivo_sel';
		$this->transaccion='PM_ARTABLA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		//$this->setCount(false);


        $this->captura('tipo_archivo','varchar');
        $this->captura('extension','varchar');
        $this->captura('nombre_archivo','varchar');
        $this->captura('folder','varchar');
        $this->captura('nombre_descriptivo','varchar');


        $datos = json_decode($this->objParam->getParametro('campos'));



        $arra = array();
        $campos = '';
        $conteo = count($datos);
        foreach ($datos as $key=> $dato) {



            if($dato->alias != ''){
                $campos .= $dato->alias.".".$dato->nombre .' as '.$dato->renombrar;
                $this->captura($dato->renombrar,$dato->tipo_dato);


            }else{
                $campos .= "tabla.".$dato->nombre;
                $this->captura($dato->nombre,$dato->tipo_dato);
            }


            if (($key+1) < $conteo){
                $campos.= ",";
            }

        }

      

        $this->aParam->addParametro('campos', $campos);
        $this->arreglo['campos'] = $campos;
        $this->setParametro('campos','campos','varchar');
        $this->setParametro('tipo_archivo','tipo_archivo','varchar');








        //Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}




}
?>