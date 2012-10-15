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
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();	
		   
		$id_funcion=$this->objParam->getParametro('id_funcion');
		
		if(isset($id_funcion)){

			$this->objParam -> addFiltro("(fun.id_funcion = $id_funcion)");
		
		}
		
		   
		//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
		$this->res=$this->objFunSeguridad->listarProcedimientoCmb($this->objParam);
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarSubsistema(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_subsistema')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarSubsistema($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarSubsistema($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarSubsistema(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();	
		$this->res=$this->objFunSeguridad->eliminarSubsistema($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

}

?>