<?php
/***
 Nombre: ACTUsuarioRol.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tusuario_rol 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTUsuarioRol extends ACTbase{    

	function listarUsuarioRol(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','rol');
		$this->objParam->defecto('dir_ordenacion','asc');
	
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODUsuarioRol','listarUsuarioRol');
		}
		else {
			$this->objFunSeguridad=$this->create('MODUsuarioRol');
			$this->res=$this->objFunSeguridad->listarUsuarioRol($this->objParam);
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarUsuarioRol(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODUsuarioRol');
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_usuario_rol')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarUsuarioRol($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarUsuarioRol($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarUsuarioRol(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODUsuarioRol');	
		$this->res=$this->objFunSeguridad->eliminarUsuarioRol($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

}

?>