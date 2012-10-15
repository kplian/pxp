<?php
/***
 Nombre: ACTActividad.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tclasificador 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTClasificador extends ACTbase{    

	function listarClasificador(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		$this->objParam->defecto('ordenacion','prioridad');
		$this->objParam->defecto('dir_ordenacion','asc');
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam);
			$this->res=$this->objReporte->generarReporteListado('FuncionesSeguridad','listarClasificador');
		}
		else {
			$this->objFunSeguridad=new FuncionesSeguridad();
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarClasificador($this->objParam);
			
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarClasificador(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_clasificador')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarClasificador($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarClasificador($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarClasificador(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();	
		$this->res=$this->objFunSeguridad->eliminarClasificador($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

}

?>