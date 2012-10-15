<?php
/***
 Nombre: ACTDocumento.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tdocumento 
 Autor:	Kplian
 Fecha:	06/06/2011
 */
class ACTDocumento extends ACTbase{    

	function listarDocumento(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','documento');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam);
			$this->res=$this->objReporte->generarReporteListado('FuncionesParametros','listarDocumento');
		}
		else {
			$this->objFunSeguridad=new FuncionesParametros();
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarDocumento($this->objParam);
			
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarDocumento(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesParametros();
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_documento')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarDocumento($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarDocumento($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarDocumento(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesParametros();	
		$this->res=$this->objFunSeguridad->eliminarDocumento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	
	

}

?>