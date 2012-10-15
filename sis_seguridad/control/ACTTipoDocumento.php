<?php
/***
 Nombre: ACTTipoDocumento.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla ttipo_documento
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTTipoDocumento extends ACTbase{    

	function listarTipoDocumento(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','nombre');
		$this->objParam->defecto('dir_ordenacion','asc');
				
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam);
			$this->res=$this->objReporte->generarReporteListado('FuncionesSeguridad','listarTipoDocumento');
		}
		else {
			$this->objFunSeguridad=new FuncionesSeguridad();
			$this->res=$this->objFunSeguridad->listarTipoDocumento($this->objParam);
		}
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarTipoDocumento(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_tipo_documento')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarTipoDocumento($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarTipoDocumento($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarTipoDocumento(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();	
		$this->res=$this->objFunSeguridad->eliminarTipoDocumento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

}
?>