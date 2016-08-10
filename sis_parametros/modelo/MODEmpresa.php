<?php
/**
*@package pXP
*@file gen-MODEmpresa.php
*@author  (admin)
*@date 04-02-2013 16:03:19
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEmpresa extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEmpresa(){
		
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_empresa_sel';
		$this->transaccion='PM_EMP_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_empresa','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('logo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('nit','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('codigo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarEmpresa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_empresa_ime';
		$this->transaccion='PM_EMP_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('logo','logo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('nit','nit','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEmpresa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_empresa_ime';
		$this->transaccion='PM_EMP_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_empresa','id_empresa','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('logo','logo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('nit','nit','varchar');
		$this->setParametro('codigo','codigo','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEmpresa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_empresa_ime';
		$this->transaccion='PM_EMP_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_empresa','id_empresa','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function subirLogo(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_empresa_ime';
		$this->transaccion='PM_LOGMOD_IME';
		$this->tipo_procedimiento='IME';
		
		//apartir del tipo  del archivo obtiene la extencion
		$ext = pathinfo($this->arregloFiles['file_logo']['name']);
 		$this->arreglo['extension']= strtolower($ext['extension']);
		
		if($this->arreglo['extension']!='gif' && $this->arreglo['extension']!='png' && $this->arreglo['extension']!='jpg'&& $this->arreglo['extension']!='jpeg'){
			 throw new Exception("Solo se admiten archivos GIF, PNG, JPG , JPEG");
		}
		
		$verion = $this->arreglo['version'] +1;
		$this->arreglo['version']=$verion;
		$ruta_dir = './../../sis_parametros/control/_archivo/';
		$this->arreglo['ruta_archivo']=$ruta_dir.'/docLog'.$this->arreglo['id_empresa'].'.'.$this->arreglo['extension'];
		//Define los parametros para la funcion	
		$this->setParametro('id_empresa','id_empresa','integer');	
		$this->setParametro('ruta_archivo','ruta_archivo','varchar');
		
		//verficar si no tiene errores el archivo
		
		 //echo $_SERVER [ 'DOCUMENT_ROOT' ];
		
		if ($this->arregloFiles['file_logo']['error']) {
          switch ($this->arregloFiles['file_correspondencia']['error']){
                   case 1: // UPLOAD_ERR_INI_SIZE
                   throw new Exception("El archivo sobrepasa el limite autorizado por el servidor(archivo php.ini) !");
                   break;
                   case 2: // UPLOAD_ERR_FORM_SIZE
                   throw new Exception("El archivo sobrepasa el limite autorizado en el formulario HTML !");
                   break;
                   case 3: // UPLOAD_ERR_PARTIAL
                   throw new Exception("El envio del archivo ha sido suspendido durante la transferencia!");
                   break;
                   case 4: // UPLOAD_ERR_NO_FILE
                   throw new Exception("El archivo que ha enviado tiene un tamaño nulo !");
                   break;
          }
		}
		else {
		 // $_FILES['nom_del_archivo']['error'] vale 0 es decir UPLOAD_ERR_OK
		 // lo que significa que no ha habido ningún error
		}
				
		
		
		
		//verificar si existe la carpeta destino
		
		if(!file_exists($ruta_dir))
		{
			///si no existe creamos la carpeta destino	
			if(!mkdir($ruta_dir,0777)){
	           throw new Exception("Error al crear el directorio");		
			}
	
		}
		
		//movemos el archivo
		if(!move_uploaded_file($this->arregloFiles['file_logo']["tmp_name"],$this->arreglo['ruta_archivo'])){
			throw new Exception("Error al copiar archivo");	
		}
		
		
		//si la copia de archivo tuvo emodificamos el registro
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		
		return $this->respuesta;
	}
	
	
	function getEmpresa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_empresa_ime';
		$this->transaccion='PM_EMPGET_GET';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_empresa','id_empresa','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>