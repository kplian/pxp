<?php
/*** 
 Nombre: ACTUsuario.php  
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tusuario 
 Autor:	Kplian
 Fecha:	01/07/2010
 */

class ACTUsuario extends ACTbase{    

	function listarUsuario(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz

        //$this->dispararEventoWS();


        if($this->objParam->getParametro('ws')=='si'){


            $data = array(

                "mensaje" => "obtenerUsuariosConectados",

            );

            $send = array(
                "tipo" => "obtenerUsuariosConectados",
                "data" => $data
            );

            $usuarios_socket = $this->dispararEventoWS($send);

            $usuarios_socket =json_decode($usuarios_socket, true);

            $array_keys = array_keys($usuarios_socket);
            $implode = implode(',', $array_keys);


            $this->objParam->addFiltro("USUARI.id_usuario in (" . $implode ." ) ");
        }


		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','desc_person');
		$this->objParam->defecto('dir_ordenacion','asc');
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODUsuario','listarUsuario');
		}
		else {
			$this->objFunSeguridad=$this->create('MODUsuario');
			$this->res=$this->objFunSeguridad->listarUsuario($this->objParam);
		}

		if($this->objParam->getParametro('_adicionar')!=''){

			$respuesta = $this->res->getDatos();


			array_unshift ( $respuesta, array(  'id_usuario'=>'0',
					'id_clasificador'=>'Todos',
					'cuenta'=>'Todos',
					'fecha_reg'=>'Todos',
					'estado_reg'=>'Todos',
					'estilo'=>'Todos',
					'id_persona'=>'Todos',
					'desc_person'=>'Todos',
					'id_roles'=>'Todos',
					'autentificacion'=>'Todos') );
			//var_dump($respuesta);
			$this->res->setDatos($respuesta);
		}

		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	/*
	 * GUARDAR USUARIO
	 * 
	 * */
	function guardarUsuario(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODUsuario');
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_usuario')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarUsuario($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarUsuario($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
		/*
		 * ELIMINAR USUARIO
		 * */	
	function eliminarUsuario(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODUsuario');	
		$this->res=$this->objFunSeguridad->eliminarUsuario($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
    function listarGrupoUsuario(){

        //el objeto objParam contiene todas la variables recibidad desde la interfaz

        // parametros de ordenacion por defecto
        $this->objParam->defecto('ordenacion','desc_person');
        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('id_grupo')!=''){
            $this->objParam->addFiltro("ug.id_grupo = ".$this->objParam->getParametro('id_grupo'));
        }

        if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte=new Reporte($this->objParam, $this);
            $this->res=$this->objReporte->generarReporteListado('MODUsuario','listarUsuario');
        }
        else {
            $this->objFunSeguridad=$this->create('MODUsuario');
            $this->res=$this->objFunSeguridad->listarGrupoUsuario($this->objParam);
        }

        if($this->objParam->getParametro('_adicionar')!=''){
            $respuesta = $this->res->getDatos();
            array_unshift ( $respuesta, array(  'id_usuario'=>'0',
                'id_clasificador'=>'Todos',
                'cuenta'=>'Todos',
                'fecha_reg'=>'Todos',
                'estado_reg'=>'Todos',
                'estilo'=>'Todos',
                'id_persona'=>'Todos',
                'desc_person'=>'Todos',
                'id_roles'=>'Todos',
                'autentificacion'=>'Todos') );
            //var_dump($respuesta);
            $this->res->setDatos($respuesta);
        }
        //imprime respuesta en formato JSON para enviar lo a la interface (vista)
        $this->res->imprimirRespuesta($this->res->generarJson());
        
    }

}

?>