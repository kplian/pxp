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
		if($this->objParam->getParametro('id_persona')!=''){
            $this->objParam->addFiltro("p.id_persona = " . $this->objParam->getParametro('id_persona'));    
        }
		
		if($this->objParam->getParametro('usuario_activo') == 'si'){
            $this->objParam->addFiltro("p.id_persona = " . $_SESSION["ss_id_persona"]);    
        }
		if($this->objParam->getParametro('no_es_proveedor')!=''){
            $this->objParam->addFiltro("p.id_persona not in (select id_persona 
            															from param.tproveedor 
            															where id_persona = p.id_persona)");    
        }
		if($this->objParam->getParametro('id_institucion')>0){
            $this->objParam->addFiltro("p.id_persona in (select instiper.id_persona 
            															from param.tinstitucion_persona instiper 
            															where instiper.id_institucion = " . $this->objParam->getParametro('id_institucion') . ")");    
        }
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
	
	function listarAlmacenApiREST(){
            
        
            
        
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

    function subirFotoPersona()
    {
        $estado_res = 'ERROR';
        $mensaje_completo = "Fallo inesperado, comuniquese con el departamento de soporte del sistema";
        $arregloFiles = $this->objParam->getArregloFiles();
        $ext = pathinfo($arregloFiles['foto']['name']);
        $ci = $this->objParam->getParametro('ci');
        $nombre_archivo_foto = $this->objParam->getParametro('ci') . '.' . $ext['extension'];
        $this->objParam->addParametro('extension', $ext['extension']);
        $this->objParam->addParametro('nombre_archivo_foto', $nombre_archivo_foto);

        $this->objFunSeguridad = $this->create('MODPersona');
        $destino = dirname(__DIR__) . '/../../' . $_SESSION["_FOLDER_FOTOS_PERSONA"] . '/' . $ci . '.' . $ext['extension'];
        $allowedExts = array("jpeg", "jpg", "png");
        $allowedMineTypes = array("image/jpeg", "image/jpg", "image/png");;
        if (in_array($arregloFiles['foto']["type"], $allowedMineTypes)
            && ($arregloFiles['foto']["size"] < 2048000)
            && in_array($ext['extension'], $allowedExts)) {
            if (move_uploaded_file($arregloFiles['foto']['tmp_name'], $destino)) {
                $this->res = $this->objFunSeguridad->subirFotoPersona();
                $mensaje_completo = $this->res->getMensaje();
                $estado_res = $this->res->getTipo();
            } else {
                $mensaje_completo = "Error al guardar el archivo en disco";
                $estado_res = 'ERROR';
            }
        } else {
            $mensaje_completo = "Solo es posible subir archivos (" . implode(', ', $allowedExts) . '), peso m&aacute;ximo (2mb)';
            $estado_res = 'ERROR';
        }
        $this->res = new Mensaje();
        $this->res->setMensaje($estado_res, 'ACTPersona.php', $mensaje_completo,
            $mensaje_completo, 'control');
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	
	function validarPersona(){
		$this->objFunc=$this->create('MODPersona');		
		$this->res=$this->objFunc->validarPersona();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	

}

?>