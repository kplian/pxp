<?php
/***
 Nombre: ACTRol.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla trol 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTRol extends ACTbase{    

	function listarRol(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','rol');
		$this->objParam->defecto('dir_ordenacion','asc');
			
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam);
			$this->res=$this->objReporte->generarReporteListado('FuncionesSeguridad','listarRol');
		}
		else {
			$this->objFunSeguridad=new FuncionesSeguridad();
			$this->res=$this->objFunSeguridad->listarRol($this->objParam);
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarRol(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_rol')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarRol($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarRol($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarRol(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();	
		$this->res=$this->objFunSeguridad->eliminarRol($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

}

?>