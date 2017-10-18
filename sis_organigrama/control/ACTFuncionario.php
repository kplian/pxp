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
	
	   
        //si aplicar filtro de usuario, fitlramos el listado segun el funionario del usuario
        if($this->objParam->getParametro('tipo_filtro')=='usuario'){
            $this->objParam->addFiltro("FUNCIO.id_funcionario= ".$_SESSION["_ID_FUNCIOANRIO_OFUS"]);    
        }	
		
		if( $this->objParam->getParametro('es_combo_solicitud') == 'si' ) {
			$this->objParam->addFiltro("FUNCIO.id_funcionario IN (select * 
										FROM orga.f_get_funcionarios_x_usuario_asistente(now()::date, " .
																						 $_SESSION["ss_id_usuario"] . ") AS (id_funcionario INTEGER)) ");
		}
			
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
		
		if($this->objParam->getParametro('todos')!=''){

			$respuesta = $this->res->getDatos();


			array_unshift ( $respuesta, array(  'id_funcionario'=>'0',
					'desc_person'=>'Todos',
					'ci'=>'Todos',
					'documento'=>'Todos',
					'telefono'=>'Todos') );
			$this->res->setDatos($respuesta);
		}
		
		

		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		 
		
	}

	function getDatosFuncionario(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','PERSON.nombre_completo1');
		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->addFiltro("FUNCIO.estado_reg = ''activo''");


		//si aplicar filtro de usuario, fitlramos el listado segun el funionario del usuario
		if($this->objParam->getParametro('id_funcionario')!=''){

			$this->objParam->addFiltro("FUNCIO.id_funcionario = ".$this->objParam->getParametro('id_funcionario')." ");
		}


		//si aplicar filtro de usuario, fitlramos el listado segun el funionario del usuario
        if($this->objParam->getParametro('nombre_empleado')!=''){
        	$nombre_empleado = trim($this->objParam->getParametro('nombre_empleado'));
			$nombre_empleado = str_replace(' ', '%', $nombre_empleado);
            $this->objParam->addFiltro("(lower(PERSON.nombre_completo1) like lower(''%" .  $nombre_empleado ."%'') or 
            							lower(PERSON.nombre_completo2) like lower(''%" .  $nombre_empleado ."%'') or 
            							lower(CAR.nombre) like lower(''%" .  $nombre_empleado ."%''))");    
        }	
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODFuncionario','getDatosFuncionario');
		}
		else {
			$this->objFunSeguridad=$this->create('MODFuncionario');
			//ejecuta el metodo de lista funcionarios a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->getDatosFuncionario($this->objParam);
			
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		 
		
	}
	
	function getCumpleaneros(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','FUNCIO.desc_funcionario1');
		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->addFiltro("FUNCIO.estado_reg = ''activo''");		
	
	   
        //si aplicar filtro de usuario, fitlramos el listado segun el funionario del usuario
        if($this->objParam->getParametro('dia')!=''){
            $this->objParam->addFiltro("extract (day from PERSON.fecha_nacimiento) = " . $this->objParam->getParametro('dia'));    
        }
		
		if($this->objParam->getParametro('mes')!=''){
            $this->objParam->addFiltro("extract (month from PERSON.fecha_nacimiento) = " . $this->objParam->getParametro('mes'));    
        }	
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODFuncionario','getCumpleaneros');
		}
		else {
			$this->objFunSeguridad=$this->create('MODFuncionario');
			//ejecuta el metodo de lista funcionarios a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->getCumpleaneros($this->objParam);
			
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		 
		
	}
	
	function listarFuncionarioCargo(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','descripcion_cargo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_funcionario_dependiente')!=''){
		     //por defecto filtra solo superior con presupuesto    
		     $presupuesto = 'si';    
		     if($this->objParam->getParametro('presupuesto')!=''){
		         $presupuesto = $this->objParam->getParametro('presupuesto');
		     } 
		     
		     //por defecto no filtra por gerencias   
             $gerencia = 'todos';    
             if($this->objParam->getParametro('gerencia')!=''){
                 $gerencia = $this->objParam->getParametro('gerencia');
             } 
			 
			 //verifica si existe un lista de nivel organizacionales permitidos
			 $lista_blanca = 'todos';    
             if($this->objParam->getParametro('lista_blanca')!=''){
                 $lista_blanca = $this->objParam->getParametro('lista_blanca');
             } 
			 
			 //verifica si existe un lista de nivel organizacionales NO permitidos
			 $lista_negra = 'ninguno';    
             if($this->objParam->getParametro('lista_negra')!=''){
                 $lista_negra = $this->objParam->getParametro('lista_negra');
             } 
			 
			 
			 
			 
		    
            $this->objParam->addFiltro("FUNCAR.id_funcionario IN (select * from orga.f_get_aprobadores_x_funcionario(''" . $this->objParam->getParametro('fecha') . "'',". $this->objParam->getParametro('id_funcionario_dependiente'). ",''".$presupuesto."'',''".$gerencia."'',''".$lista_blanca."'',''".$lista_negra."'')	 AS (id_funcionario INTEGER))");    
        }

      
		
        
        if($this->objParam->getParametro('fecha')!=''){
            	
            $this->objParam->addFiltro(" ((FUNCAR.fecha_asignacion  <= ''".$this->objParam->getParametro('fecha')."'' and FUNCAR.fecha_finalizacion  >= ''".$this->objParam->getParametro('fecha')."'') or (FUNCAR.fecha_asignacion  <= ''".$this->objParam->getParametro('fecha')."'' and FUNCAR.fecha_finalizacion  is NULL))");    
        }
		
		if( $this->objParam->getParametro('es_combo_solicitud') == 'si' ) {
			if($this->objParam->getParametro('fecha')==''){
				$date = date('d/m/Y');
			} else {
				$date = $this->objParam->getParametro('fecha');
			}
			$this->objParam->addFiltro("FUNCAR.id_funcionario IN (select * 
										FROM orga.f_get_funcionarios_x_usuario_asistente(''" . $date . "'', " .
																						 $_SESSION["ss_id_usuario"] . ") AS (id_funcionario INTEGER)) ");
		}
		
		if( $this->objParam->getParametro('filter_rpc') == 'si' ) {
			$this->objParam->addFiltro("FUNCAR.id_cargo NOT in (select rpc.id_cargo from adq.trpc rpc where rpc.estado_reg = ''activo'') ");
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

		if($this->objParam->getParametro('todos')!=''){

			$respuesta = $this->res->getDatos();


			array_unshift ( $respuesta, array(  'id_funcionario'=>'0',
					'desc_funcionario1'=>'Todos',
					'nombre_cargo'=>'Todos',
					'email_empresa'=>'Todos',
					'carnet_discapacitado'=>'Todos') );
			$this->res->setDatos($respuesta);
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
	
	function getEmailEmpresa(){
        //@id_funcionario -> funcionario del que vamos a recuperar el correo
        //crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
        $this->objFunSeguridad=$this->create('MODFuncionario'); 
        $this->res=$this->objFunSeguridad->getEmailEmpresa($this->objParam);
        
        //adiciona correo de notificaciones desde la onfiguracion  general
        
        $array = $this->res->getDatos();
        
        if(isset($_SESSION['_MAIL_NITIFICACIONES_1'])){
            $array['email_notificaciones_1'] = $_SESSION['_MAIL_NITIFICACIONES_1'];
        }
        if(isset($_SESSION['_MAIL_NITIFICACIONES_2'])){
            $array['email_notificaciones_2'] = $_SESSION['_MAIL_NITIFICACIONES_2'];
        }
        
        $this->res->setDatos($array);
        
        $this->res->imprimirRespuesta($this->res->generarJson());

    }
	
	function alertarCumpleaneroDia(){
		$this->objFunc=$this->create('MODFuncionario');	
		$this->res=$this->objFunc->alertarCumpleaneroDia($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	

}

?>