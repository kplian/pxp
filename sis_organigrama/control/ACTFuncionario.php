<?php
/***
 Nombre: ACTFuncionario.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tfuncionario 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTFuncionario extends ACTbase{    

	function listarFuncionario(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','PERSON.nombre_completo1');
		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->addFiltro("FUNCIO.estado_reg = ''activo''");		
				
			
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODFuncionario','listarFuncionario');
		}
		else {
			$this->objFunSeguridad=$this->create('MODFuncionario');
			//ejecuta el metodo de lista funcionarios a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarFuncionario($this->objParam);
			
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		 
		
	} 
	
	function listarFuncionarioCargo(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','PERSON.nombre_completo1');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_funcionario')!=''){
            $this->objParam->addFiltro("FUNCAR.id_funcionario IN (select * from orga.f_get_aprobadores_x_funcionario(''" . $this->objParam->getParametro('fecha') . "''," . $this->objParam->getParametro('id_funcionario') . ")
            														 AS (id_funcionario INTEGER))");    
        }
        
        if($this->objParam->getParametro('fecha')!=''){
            $this->objParam->addFiltro(" ( (FUNCAR.fecha_asignacion  <= ''".$this->objParam->getParametro('fecha')."'' and FUNCAR.fecha_finalizacion  >= ''".$this->objParam->getParametro('fecha')."'') or (FUNCAR.fecha_asignacion  <= ''".$this->objParam->getParametro('fecha')."'' and FUNCAR.fecha_finalizacion  is NULL))");    
        }
		
		if( $this->objParam->getParametro('es_combo_solicitud') == 'si' ) {
			$this->objParam->addFiltro("FUNCAR.id_funcionario IN (select * 
										FROM orga.f_get_funcionarios_x_usuario_asistente(''" . $this->objParam->getParametro('fecha') . "'', " .
																						 $_SESSION["ss_id_usuario"] . ") AS (id_funcionario INTEGER)) ");
		}
		
		        		
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODFuncionario','listarFuncionarioCargo');
		}
		else {
			$this->objFunSeguridad=$this->create('MODFuncionario');
			//ejecuta el metodo de lista funcionarios a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarFuncionarioCargo($this->objParam);
			
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
		
	}
	
	
	function guardarFuncionario(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODFuncionario');
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_funcionario')){

			//ejecuta el metodo de insertar de la clase MODFuncionario a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarFuncionario($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar funcionario de la clase MODFuncionario a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarFuncionario($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarFuncionario(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODFuncionario');	
		$this->res=$this->objFunSeguridad->eliminarFuncionario($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

}

?>