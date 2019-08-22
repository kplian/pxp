<?php
/***
 Nombre: ACTPersonaRelacion.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tpersona 
 * ISSUE	FECHA		EMPRESA		AUTOR	DETALLE
 #41	31.07.2019	etr			mzm		adicion de relacion persona_dependiente
 *
 */
class ACTPersonaRelacion extends ACTbase{
	        
	function listarPersonaRelacion(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','ap_paterno');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('id_persona_fk')!=''){
            $this->objParam->addFiltro("pr.id_persona_fk = " . $this->objParam->getParametro('id_persona_fk'));    
        }
		
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODPersonaRelacion','listarPersonaRelacion');
		}
		else {
			$this->objFunSeguridad = $this->create('MODPersonaRelacion');
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarPersonaRelacion();
			
		}
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
	function insertarPersonaRelacion(){
			
		$this->objFunSeguridad = $this->create('MODPersonaRelacion');
			
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_persona_relacion')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarPersonaRelacion();			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarPersonaRelacion();
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarPersonaRelacion(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad = $this->create('MODPersonaRelacion');	
		$this->res=$this->objFunSeguridad->eliminarPersonaRelacion();
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	
	
	

}

?>