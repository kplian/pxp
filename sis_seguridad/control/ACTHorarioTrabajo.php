<?php
/***
 Nombre: ACTActividad.php
 Proposito: Control de los  horarios de uso del sistema por usuario 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTHorarioTrabajo extends ACTbase{    

	function listarHorarioTrabajo(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','tipo_evento');
		$this->objParam->defecto('dir_ordenacion','asc');
			
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam);
			$this->res=$this->objReporte->generarReporteListado('FuncionesSeguridad','listarHorarioTrabajo');
		}
		else {
			$this->objFunSeguridad=new FuncionesSeguridad();
			$this->res=$this->objFunSeguridad->listarHorarioTrabajo($this->objParam);
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	/*
	 * GUARDAR  HORARIO TRABAJO
	 * 
	 * */
	function guardarHorarioTrabajo(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_horario_trabajo')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarHorarioTrabajo($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarHorarioTrabajo($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
		/*
		 * ELIMINAR HORARIO TRABAJO
		 * */	
	function eliminarHorarioTrabajo(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();	
		$this->res=$this->objFunSeguridad->eliminarHorarioTrabajo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

}

?>