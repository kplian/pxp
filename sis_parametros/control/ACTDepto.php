<?php
/***
 Nombre: ACTDepartamento.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tdepartamento 
 Autor:	Kplian
 Fecha:	04/06/2011
 */
class ACTDepto extends ACTbase{    

	function listarDepto(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','depto');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam);
			$this->res=$this->objReporte->generarReporteListado('FuncionesParametros','listarDepto');
		}
		else {
			$this->objFunSeguridad=new FuncionesParametros();
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarDepto($this->objParam);
			
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function insertarDepto(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesParametros();
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_depto')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarDepto($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarDepto($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarDepto(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesParametros();	
		$this->res=$this->objFunSeguridad->eliminarDepto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	
	

}

?>