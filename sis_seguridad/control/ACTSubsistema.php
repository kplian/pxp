<?php
/***
 Nombre: ACTSubsistema.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tsubsistema
 Autor:	Kplian
 Fecha:	01/07/2010
* 	ISSUE			AUTHOR				FECHA					DESCRIPCION
*	#3				EGS					03/12/2018				se aumento funcion para solo mostrar estrucutura gui y insert gui activos visibles
																se agrego las funciones que solo exporte procedimientos ,funciones y roles
    #63             EGS                 16/09/2019              filtro por codigo e id de subsistemas
 * #104			27-02-2020 				MMV ETR     			Import github commit data, problems, branch and repository

 */
class ACTSubsistema extends ACTbase{    

	function listarSubsistema(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','codigo');
		$this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('codigo')!=''){//#63
            $this->objParam->addFiltro("subsis.codigo = ''".$this->objParam->getParametro('codigo')."''");
        }
        if($this->objParam->getParametro('id_subsistema')!=''){//#63
            $this->objParam->addFiltro("subsis.id_subsistema = ''".$this->objParam->getParametro('id_subsistema')."''");
        }
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODSubsistema','listarSubsistema');
		}
		else {
			$this->objFunSeguridad=$this->create('MODSubsistema');
			$this->res=$this->objFunSeguridad->listarSubsistema($this->objParam);
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarSubsistema(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODSubsistema');
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_subsistema')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarSubsistema($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarSubsistema($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			 
	function eliminarSubsistema(){		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODSubsistema');	
		$this->res=$this->objFunSeguridad->eliminarSubsistema($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function obtenerVariableGlobal(){		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODSubsistema');	
		$this->res=$this->objFunSeguridad->obtenerVariableGlobal($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function exportarDatosSeguridad(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODSubsistema');		
		
		$this->res = $this->objFunSeguridad->exportarDatosSeguridad();
	
		if($this->res->getTipo()=='ERROR'){
			$this->res->imprimirRespuesta($this->res->generarJson());
			exit;
		}
		if($this->objParam->getParametro('todo') == 'actual'){
		$nombreArchivo = $this->crearArchivoExportacionActual($this->res);
		}
		else{		
		$nombreArchivo = $this->crearArchivoExportacion($this->res);
		}
		$this->mensajeExito=new Mensaje();
		$this->mensajeExito->setMensaje('EXITO','Reporte.php','Se genero con exito el sql'.$nombreArchivo,
										'Se genero con exito el sql'.$nombreArchivo,'control');
		$this->mensajeExito->setArchivoGenerado($nombreArchivo);
		
		$this->res->imprimirRespuesta($this->mensajeExito->generarJson());

	}
	
	function crearArchivoExportacion($res) {
		$data = $res -> getDatos();
		$fileName = uniqid(md5(session_id()).'ExportDataSegu').'.sql';
		//create file
		$file = fopen("../../../reportes_generados/$fileName", 'w');
		
		$sw_gui = 0;
		$sw_funciones=0;
		$sw_procedimiento=0;
		$sw_rol=0; 
		$sw_rol_pro=0;
		fwrite ($file,"----------------------------------\r\n".
						  "--COPY LINES TO data.sql FILE  \r\n".
						  "---------------------------------\r\n".
						  "\r\n" );
		foreach ($data as $row) {
			 if ($row['tipo'] == 'gui' ) {
			 	
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select pxp.f_delete_tgui ('". 
							$row['codigo_gui']."');\r\n");
					
				} else {
					fwrite ($file, 
					"select pxp.f_insert_tgui ('". 
							$row['nombre']."', '" . 
							$row['descripcion']."', '" . 
							$row['codigo_gui']."', '" . 
							$row['visible']."', " . 
							$row['orden_logico'].", '" . 
							$row['ruta_archivo']."', " . 
							$row['nivel'].", '" . 
							$row['icono']."', '" . 
							$row['clase_vista']."', '" . 
							$row['subsistema']."');\r\n");
					
				}				
				
			}			
			elseif ($row['tipo'] =='funcion' ) {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
						"select pxp.f_delete_tfuncion ('". 
							$row['nombre']."', '" . 
							$row['subsistema']."');\r\n");
					
				} else {								
					fwrite ($file, 
						"select pxp.f_insert_tfuncion ('".
								$row['nombre']."', '" . 
								$row['descripcion']."', '" . 
								$row['subsistema']."');\r\n");
				}
				
			}  elseif ($row['tipo'] == 'procedimiento' ) {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
						"select pxp.f_delete_tprocedimiento ('".					 
							$row['codigo']."');\r\n");
					
				} else {							
					fwrite ($file, 
						"select pxp.f_insert_tprocedimiento ('".
								$row['codigo']."', '" . 
								trim($row['descripcion'])."', '" . 
								$row['habilita_log']."', '" . 
								$row['autor']."', '" . 
								$row['fecha_creacion']."', '" . 
								$row['funcion']."');\r\n");
				}
				
			} elseif ($row['tipo'] == 'rol' ) {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
						"select pxp.f_delete_trol ('". 
							$row['rol']."');\r\n");
					
				} else {
             									
					fwrite ($file, 
						"select pxp.f_insert_trol ('".
								$row['descripcion']."', '" . 
								$row['rol']."', '" . 
								$row['desc_codigo']."');\r\n");
				}
				
			}
		}		
		
		
		fwrite ($file,"----------------------------------\r\n".
						  "--COPY LINES TO dependencies.sql FILE  \r\n".
						  "---------------------------------\r\n".
						  "\r\n" );
		
		foreach ($data as $row) {
			if ($row['tipo'] == 'estructura_gui' ) {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
						"select pxp.f_delete_testructura_gui ('". 
							$row['codigo_gui']."', '" . 
							$row['fk_codigo_gui']."');\r\n");
					
				} else {
					fwrite ($file, 
						"select pxp.f_insert_testructura_gui ('".
								$row['codigo_gui']."', '" . 
								$row['fk_codigo_gui']."');\r\n");
				}
				
			} elseif ($row['tipo'] == 'procedimiento_gui' ) {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
						"select pxp.f_delete_tprocedimiento_gui ('". 
							$row['codigo']."', '" . 
							$row['codigo_gui']."');\r\n");
					
				} else {		
				
					fwrite ($file, 
						"select pxp.f_insert_tprocedimiento_gui ('".
								$row['codigo']."', '" . 
								$row['codigo_gui']."', '" . 
								$row['boton']."');\r\n");
				}
				
			} elseif ($row['tipo'] == 'gui_rol' ) {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
						"select pxp.f_delete_tgui_rol ('". 
							$row['codigo_gui']."', '" . 
							$row['rol']."');\r\n");
					
				} else {
					fwrite ($file, 
						"select pxp.f_insert_tgui_rol ('".
								$row['codigo_gui']."', '" . 
								$row['rol']."');\r\n");
				}
				
			} elseif ($row['tipo'] == 'rol_procedimiento_gui' ) {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
						"select pxp.f_delete_trol_procedimiento_gui ('". 
							$row['rol']."', '" . 
							$row['codigo']."', '" .
							$row['codigo_gui']."');\r\n");
					
				} else {
					fwrite ($file, 
						"select pxp.f_insert_trol_procedimiento_gui ('".
								$row['rol']."', '" . 
								$row['codigo']."', '" . 
								$row['codigo_gui']."');\r\n");
				}
				
			}
		}
		return $fileName;
	}

	function crearArchivoExportacionActual($res) {
		$data = $res -> getDatos();
		$fileName = uniqid(md5(session_id()).'ExportDataSegu').'.sql';
		//create file
		$file = fopen("../../../reportes_generados/$fileName", 'w');
		
		$sw_gui = 0;
		$sw_funciones=0;
		$sw_procedimiento=0;
		$sw_rol=0; 
		$sw_rol_pro=0;
		fwrite ($file,"----------------------------------\r\n".
						  "--COPY LINES TO data.sql FILE  \r\n".
						  "---------------------------------\r\n".
						  "\r\n" );
		foreach ($data as $row) {
			 if ($row['tipo'] == 'gui' ) {
			 	
				if ($row['estado_reg'] == 'activo' && $row['visible']== 'si') {
	
					fwrite ($file, 
					"select pxp.f_insert_tgui ('". 
							$row['nombre']."', '" . 
							$row['descripcion']."', '" . 
							$row['codigo_gui']."', '" . 
							$row['visible']."', " . 
							$row['orden_logico'].", '" . 
							$row['ruta_archivo']."', " . 
							$row['nivel'].", '" . 
							$row['icono']."', '" . 
							$row['clase_vista']."', '" . 
							$row['subsistema']."');\r\n");
					
				}				
				
			}
		}		
		
		
		fwrite ($file,"----------------------------------\r\n".
						  "--COPY LINES TO dependencies.sql FILE  \r\n".
						  "---------------------------------\r\n".
						  "\r\n" );
		
		foreach ($data as $row) {
			if ($row['tipo'] == 'estructura_gui' ) {
				if ($row['estado_reg'] == 'activo') {
					fwrite ($file, 
						"select pxp.f_insert_testructura_gui ('".
								$row['codigo_gui']."', '" . 
								$row['fk_codigo_gui']."');\r\n");
				}
				
			} 
		}
		return $fileName;
	}
	///#2				EGS					05/12/2018		
	function ExportarDatosRolProcedimiento(){
						
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODSubsistema');		
		
		$this->res = $this->objFunSeguridad->exportarDatosSeguridad();
	
		if($this->res->getTipo()=='ERROR'){
			$this->res->imprimirRespuesta($this->res->generarJson());
			exit;
		}
		
		$nombreArchivo = $this->crearArchivoExportacionRolProcedimiento($this->res);
		
		$this->mensajeExito=new Mensaje();
		$this->mensajeExito->setMensaje('EXITO','Reporte.php','Se genero con exito el sql'.$nombreArchivo,
										'Se genero con exito el sql'.$nombreArchivo,'control');
		$this->mensajeExito->setArchivoGenerado($nombreArchivo);
		
		$this->res->imprimirRespuesta($this->mensajeExito->generarJson());
	}
	function crearArchivoExportacionRolProcedimiento($res) {
		$data = $res -> getDatos();
		$fileName = uniqid(md5(session_id()).'ExportDataSegu').'.sql';
		//create file
		$file = fopen("../../../reportes_generados/$fileName", 'w');
		
		$sw_gui = 0;
		$sw_funciones=0;
		$sw_procedimiento=0;
		$sw_rol=0; 
		$sw_rol_pro=0;
		fwrite ($file,"----------------------------------\r\n".
						  "--COPY LINES TO data.sql FILE  \r\n".
						  "---------------------------------\r\n".
						  "\r\n" );
		foreach ($data as $row) {
			if ($row['tipo'] =='funcion' ) {
				if ($row['estado_reg'] == 'activo') {
								
					fwrite ($file, 
						"select pxp.f_insert_tfuncion ('".
								$row['nombre']."', '" . 
								$row['descripcion']."', '" . 
								$row['subsistema']."');\r\n");
				}
				
			} 
			elseif ($row['tipo'] == 'procedimiento' ) {
				if ($row['estado_reg'] == 'activo') {
							
					fwrite ($file, 
						"select pxp.f_insert_tprocedimiento ('".
								$row['codigo']."', '" . 
								trim($row['descripcion'])."', '" . 
								$row['habilita_log']."', '" . 
								$row['autor']."', '" . 
								$row['fecha_creacion']."', '" . 
								$row['funcion']."');\r\n");
				}
				
			} elseif ($row['tipo'] == 'rol' ) {
				if ($row['estado_reg'] == 'activo') {
             									
					fwrite ($file, 
						"select pxp.f_insert_trol ('".
								$row['descripcion']."', '" . 
								$row['rol']."', '" . 
								$row['desc_codigo']."');\r\n");
				}
				
			}
		}		
		
		
		fwrite ($file,"----------------------------------\r\n".
						  "--COPY LINES TO dependencies.sql FILE  \r\n".
						  "---------------------------------\r\n".
						  "\r\n" );
		
		foreach ($data as $row) {
		if ($row['tipo'] == 'procedimiento_gui' ) {
				if ($row['estado_reg'] == 'activo') {
	
				
					fwrite ($file, 
						"select pxp.f_insert_tprocedimiento_gui ('".
								$row['codigo']."', '" . 
								$row['codigo_gui']."', '" . 
								$row['boton']."');\r\n");
				}
				
			} elseif ($row['tipo'] == 'gui_rol' ) {
				if ($row['estado_reg'] == 'activo') {

					fwrite ($file, 
						"select pxp.f_insert_tgui_rol ('".
								$row['codigo_gui']."', '" . 
								$row['rol']."');\r\n");
				}
				
			} elseif ($row['tipo'] == 'rol_procedimiento_gui' ) {
				if ($row['estado_reg'] == 'activo') {

					fwrite ($file, 
						"select pxp.f_insert_trol_procedimiento_gui ('".
								$row['rol']."', '" . 
								$row['codigo']."', '" . 
								$row['codigo_gui']."');\r\n");
				}
				
			}
		}
		return $fileName;
	}
		///#2				EGS					05/12/2018
    function obtenerFechaUltimoRegistro(){
        $this->objFunSeguridad=$this->create('MODSubsistema');
        $this->res=$this->objFunSeguridad->obtenerFechaUltimoRegistro($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function importarApiGitHub(){ //#104
        $subsistema = $this->objParam->getParametro('id_subsistema');
        $org  = $this->objParam->getParametro('organizacion_git');
        $repo = $this->objParam->getParametro('codigo_git');

        $requestBranch = 'https://api.github.com/repos/'.$org.'/'.$repo.'/branches';
        // var_dump($requestBranch);exit;

        $session = curl_init($requestBranch);
        curl_setopt($session, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($session, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'User-Agent: request')
        );
        $resultBranch = curl_exec($session);
         //var_dump($resultBranch);exit;

        curl_close($session);
        $respuestaBranch = json_decode($resultBranch);

        $array_branch = array();
        $branch = array();
        foreach ($respuestaBranch as $value){
            $data = json_decode(json_encode($value), true);
            $array_branch []= array(
                "id_subsistema" => (int)$subsistema,
                "name" => $data['name'],
                "sha" => (string)$data['commit']['sha'],
                "url" => (string)$data['commit']['url'],
                "protected" => (bool)$data['protected']
            );
            $branch []=array( "name" => $data['name']);
        }
        // Issues
        $requestIssues = 'https://api.github.com/repos/'.$org.'/'.$repo.'/issues?state=all';
        $session = curl_init($requestIssues);
        curl_setopt($session, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($session, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'User-Agent: request')
        );
        $resultIssues = curl_exec($session);
        curl_close($session);
        $respuestaIssues = json_decode($resultIssues);
        $array_issues = array();
         foreach ($respuestaIssues as $value){
            $data = json_decode(json_encode($value), true);
            $array_issues[] = array(
                "id_subsistema" => (int)$subsistema,
                "html_url" =>  (string)$data['html_url'],
                "number_issues" =>$data['number'],
                "title" => (string)$data['title'],
                "state" => (string)$data["state"],
                "author" => (string)$data["user"]["login"],
                "created_at" => $data["created_at"],
                "updated_at" => $data["updated_at"],
                "closed_at" => $data["closed_at"]
            );
         }

        $json_branch = json_encode($array_branch);
        $json_issues = json_encode($array_issues);

        $this->objParam->addParametro('branch_json',$json_branch);
        $this->objParam->addParametro('issues_json',$json_issues);

        $this->objFunc = $this->create('MODSubsistema');
        $this->res=$this->objFunc->importarApiGitHub($this->objParam);

        $this->mensajeRes=new Mensaje();
        $this->mensajeRes->setMensaje('EXITO','ACTSubsistema.php','El archivo fue ejecutado con éxito',
            'El archivo fue ejecutado con éxito','control');
        // Recorer las remas
        foreach ($branch as $key){
            $this->insertarCommit($this->onCommit($org,$repo,$key["name"]));
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function onCommit ($org,$repo,$name){ //#104
        $subsistema = $this->objParam->getParametro('id_subsistema');

        $requestCommit = 'https://api.github.com/repos/'.$org.'/'.$repo.'/commits?sha='.$name;
        $session = curl_init($requestCommit);
        curl_setopt($session, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($session, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'User-Agent: request')
        );
        $resultCommit = curl_exec($session);
        curl_close($session);
        $respuestaCommit = json_decode($resultCommit);

        $array_commit= array();
        foreach ($respuestaCommit as $value) {
            $data = json_decode(json_encode($value), true);
            $array = explode(" ", $data["commit"]["message"]);
            $int = 0;
            $author = (string)$data ["committer"]['login'];
            if (count($array)>0){
                foreach ($array as $value){
                    if (strpos($value, '#') !== false) {
                        $int = (int) filter_var($value, FILTER_SANITIZE_NUMBER_INT);
                        break;
                    }
                }
            } else {
                throw new Exception("No no.. Error", 3);
            }
            if ($data ["committer"]['login'] == null){
                $author = (string)$data["commit"]['committer']['name'];
            }
            $array_commit[] = array(
                "id_subsistema" => $subsistema,
                "sha" =>  (string)$data['sha'],
                "html_url" =>  (string)$data['html_url'],
                "author" =>  $author,
                "message" =>  (string)$data["commit"]["message"],
                "fecha" =>  (string)$data["commit"]["author"]["date"],
                "rama" => $name,
                "issues" => $int
            );
        }
        return json_encode($array_commit);
    }
    function insertarCommit($json_commit){ //#104
        $this->objParam->addParametro('commit_data',$json_commit);
        $this->objFunc = $this->create('sis_seguridad/MODCommit');
        $cbteHeader = $this->objFunc->importarCommitGitHub($this->objParam);
        if($cbteHeader->getTipo() == 'EXITO'){
            return $cbteHeader;
        }
        else{
            $cbteHeader->imprimirRespuesta($cbteHeader->generarJson());
            exit;
        }

    }
}
?>