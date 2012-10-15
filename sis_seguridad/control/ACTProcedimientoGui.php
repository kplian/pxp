<?php
/***
 Nombre: ACTProcedimientoGui.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tprocedimiento_gui
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTProcedimientoGui extends ACTbase{    

	function listarProcedimientoGui(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','codigo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam);
			$this->res=$this->objReporte->generarReporteListado('FuncionesSeguridad','listarProcedimientoGui');
		}
		else {
			$this->objFunSeguridad=new FuncionesSeguridad();
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarProcedimientoGui($this->objParam);
			
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarProcedimientoGui(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_procedimiento_gui')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarProcedimientoGui($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarProcedimientoGui($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarProcedimientoGui(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();	
		$this->res=$this->objFunSeguridad->eliminarProcedimientoGui($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

}

?>