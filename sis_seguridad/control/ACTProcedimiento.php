<?php
/***
 Nombre: ACTProcedimiento.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tprocedimiento
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTProcedimiento extends ACTbase{    

	function listarProcedimientoCmb(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','codigo');
		$this->objParam->defecto('dir_ordenacion','asc');
		//echo $this->objParam->getParametro('id_funcion'); exit;
		   
		$id_funcion=$this->objParam->getParametro('id_funcion');
		
		if(isset($id_funcion)){

			$this->objParam -> addFiltro("(fun.id_funcion = $id_funcion)");
		
		}
		
		 //crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODProcedimiento');	
		  
		//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
		$this->res=$this->objFunSeguridad->listarProcedimientoCmb($this->objParam);
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarProcedimiento(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODProcedimiento');
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_procedimiento')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarProcedimiento($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarProcedimiento($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarProcedimiento(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODProcedimiento');	
		$this->res=$this->objFunSeguridad->eliminarProcedimiento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

}

?>