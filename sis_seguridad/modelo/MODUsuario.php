<?php
/***
 Nombre: 	MODUsuario.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tusuario del esquema SEGU
 Autor:		Kplian 
 Fecha:		04/06/2011  
 */ 
class MODUsuario extends MODbase {
	
	function __construct(CTParametro $pParam=null){
		parent::__construct($pParam);
	}
	
	function ValidaUsuario(){
		//Definicion de variables para ejecucion del procedimientp
		/*$this->setProcedimiento('segu.ft_validar_usuario_ime');
		$this->setTransaccion('SEG_VALUSU_SEG');*/
		$this->setProcedimiento('segu.ft_validar_usuario_ime');
		$this->setTransaccion('SEG_VALUSU_SEG');
		
		//definicion de variables
		//$this->setTipoConexion('seguridad');
		$this->setTipoConexion('seguridad');
		
		//$this->setTipoProcedimiento('IME');
		$this->setTipoProcedimiento('IME');
		//$this->setCount(false);
		$this->setCount(false);
		
		$this->arreglo=array("usuario" =>$this->arreglo['usuario'],
							 "contrasena"=>$this->arreglo['contrasena'],
							 "dir_ip"=>getenv("REMOTE_ADDR"));
				
		//Define los parametros para ejecucion de la funcion
		$this->setParametro('login','usuario','varchar');
		$this->setParametro('password','contrasena','varchar');		
		$this->setParametro('dir_ip','dir_ip','varchar'); 
		
		//Se definen los datos para las variables de sesion
		$_SESSION["_LOGIN"]=$this->arreglo['usuario'];
		$_SESSION["_CONTRASENA"]=md5($_SESSION["_SEMILLA"].$this->arreglo['contrasena']);
		$_SESSION["_CONTRASENA_MD5"] = $this->arreglo['contrasena'];

		$this->armarConsulta();
		$this->ejecutarConsulta();

		//return $this->getRespuesta();
		return $this->getRespuesta();
	}
	
	
	function listarUsuario(){
		
		
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.ft_usuario_sel');// nombre procedimiento almacenado
		$this->setTransaccion('SEG_USUARI_SEL');//nombre de la transaccion
		$this->setTipoProcedimiento('SEL');//tipo de transaccion
		
		
		
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_usuario','integer');
		$this->captura('id_clasificador','integer');
		$this->captura('cuenta','varchar');
		$this->captura('contrasena','varchar');
		$this->captura('fecha_caducidad','date');
		$this->captura('fecha_reg','date');
		$this->captura('estado_reg','pxp.estado_reg');
		$this->captura('estilo','varchar');
		$this->captura('contrasena_anterior','varchar');
		$this->captura('id_persona','integer');
		$this->captura('desc_person','text');
		$this->captura('descripcion','text');
		$this->captura('id_roles','text');
		$this->captura('autentificacion','varchar');
			
		
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->getRespuesta();

	}

	function listarUsuarioSeguridad(){
		
		
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.ft_validar_usuario_ime');// nombre procedimiento almacenado
		$this->setTransaccion('SEG_LISTUSU_SEG');//nombre de la transaccion
		$this->setTipoProcedimiento('IME');//tipo de transaccion
		
		//definicion de variables
		$this->setTipoConexion('seguridad');		
		
		$this->setParametro('login','usuario','varchar');
			
		
		//Ejecuta la funcion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->getRespuesta();

	}
	
function insertarUsuario(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.ft_usuario_ime');// nombre procedimiento almacenado
		$this->setTransaccion('SEG_USUARI_INS');//nombre de la transaccion
		$this->setTipoProcedimiento('IME');//tipo de transaccion
		
		
		
		$this->arreglo['contrasena'] = md5($this->arreglo['contrasena']);
				
		//Define los setParametros para la funcion	
		//setParametro (nombre, valor , tipo , black, )
		$this->setParametro('id_clasificador','id_clasificador','integer');
		$this->setParametro('id_persona','id_persona','integer');
		$this->setParametro('cuenta','cuenta','varchar');
		$this->setParametro('contrasena','contrasena','varchar');
		$this->setParametro('fecha_caducidad','fecha_caducidad','date');
		$this->setParametro('estilo','estilo','varchar');
		$this->setParametro('id_roles','id_roles','varchar');
		$this->setParametro('autentificacion','autentificacion','varchar');
		
			
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	function modificarUsuario(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.ft_usuario_ime');// nombre procedimiento almacenado
		$this->setTransaccion('SEG_USUARI_MOD');//nombre de la transaccion
		$this->setTipoProcedimiento('IME');//tipo de transaccion
		
		//si la contrasena es distinta de la contrase;a anterior
		//fue modificada y necesario encriptarla
		if($this->arreglo['contrasena'] != $this->arreglo['contrasena_old']){
			$this->arreglo['contrasena'] = md5($this->arreglo['contrasena']);
		}
		
		//Define los setParametros para la funcion	
		$this->setParametro('id_usuario','id_usuario','integer');	
		$this->setParametro('id_clasificador','id_clasificador','integer');
		$this->setParametro('id_persona','id_persona','integer');
		$this->setParametro('cuenta','cuenta','varchar');
		$this->setParametro('contrasena','contrasena','varchar');
		$this->setParametro('contrasena_old','contrasena_old','varchar');
		$this->setParametro('fecha_caducidad','fecha_caducidad','date');
		$this->setParametro('estilo','estilo','varchar');
		$this->setParametro('id_roles','id_roles','varchar');
		$this->setParametro('autentificacion','autentificacion','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	function eliminarUsuario(){
	
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_usuario_ime');
		$this->setTransaccion('SEG_USUARI_ELI');
		$this->setTipoProcedimiento('IME');
			
		//Define los setParametros para la funcion
		$this->setParametro('id_usuario','id_usuario','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->getRespuesta();
	}
	
	
	
	
	
}
?>
