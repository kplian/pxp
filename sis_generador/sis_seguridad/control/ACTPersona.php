<?php
/***
 Nombre: ACTPersona.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tpersona 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTPersona extends ACTbase{    

	function listarPersona(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','ap_paterno');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODPersona','listarPersona');
		}
		else {
			$this->objFunSeguridad = $this->create('MODPersona');
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarPersona();
			
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
		
	}
	
	function listarPersonaFoto(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','ap_paterno');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam,$this);
			$this->res=$this->objReporte->generarReporteListado('MODPersona','listarPersonaFoto');
		}
		else {
			$this->objFunSeguridad = $this->create('MODPersona');
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarPersonaFoto();
			
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
		
	}
	
	function obtenerPersonaFoto(){

        //el objeto objParam contiene todas la variables recibidad desde la interfaz
        
        // parametros de ordenacion por defecto
        $this->objParam->defecto('ordenacion','ap_paterno');
        $this->objParam->defecto('dir_ordenacion','asc');
        
        //crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
        if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte=new Reporte($this->objParam,$this);
            $this->res=$this->objReporte->generarReporteListado('MODPersona','obtenerPersonaFoto');
        }
        else {
            $this->objFunSeguridad = $this->create('MODPersona');
            //ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
            $this->res=$this->objFunSeguridad->obtenerPersonaFoto();
            
        }
        
        //imprime respuesta en formato JSON para enviar lo a la interface (vista)
        $this->res->imprimirRespuesta($this->res->generarJson());
        
        
        
    }
	
	function guardarPersona(){
			
		$this->objFunSeguridad = $this->create('MODPersona');
			
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_persona')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarPersona();			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarPersona();
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarPersona(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad = $this->create('MODPersona');	
		$this->res=$this->objFunSeguridad->eliminarPersona();
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	
	function subirFotoPersona(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad = $this->create('MODPersona');
		$this->res=$this->objFunSeguridad->subirFotoPersona();
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	

}

?>