<?php
/**
*@package pXP
*@file gen-ACTProcesoMacro.php
*@author  (FRH)
*@date 19-02-2013 13:51:29
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProcesoMacro extends ACTbase{    
			
	function listarProcesoMacro(){
		$this->objParam->defecto('ordenacion','id_proceso_macro');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('codigo_subsistema')!=''){
	    	$this->objParam->addFiltro("subs.codigo = ''".$this->objParam->getParametro('codigo_subsistema')."''");	
		}
		
		if($this->objParam->getParametro('codigo_proceso')!=''){
	    	$this->objParam->addFiltro("promac.codigo = ''".$this->objParam->getParametro('codigo_proceso')."''");	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODProcesoMacro','listarProcesoMacro');
		} else{
			$this->objFunc=$this->create('MODProcesoMacro');
			
			$this->res=$this->objFunc->listarProcesoMacro($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProcesoMacro(){
		$this->objFunc=$this->create('MODProcesoMacro');	
		if($this->objParam->insertar('id_proceso_macro')){
			$this->res=$this->objFunc->insertarProcesoMacro($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProcesoMacro($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProcesoMacro(){
			$this->objFunc=$this->create('MODProcesoMacro');	
		$this->res=$this->objFunc->eliminarProcesoMacro($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function exportarDatosWf(){
		
		//crea el objetoFunProcesoMacro que contiene todos los metodos del sistema de workflow
		$this->objFunProcesoMacro=$this->create('MODProcesoMacro');		
		
		$this->res = $this->objFunProcesoMacro->exportarDatosWf();
		
		if($this->res->getTipo()=='ERROR'){
			$this->res->imprimirRespuesta($this->res->generarJson());
			exit;
		}

		$nombreArchivo = $this->crearArchivoExportacion($this->res);
		
		$this->mensajeExito=new Mensaje();
		$this->mensajeExito->setMensaje('EXITO','Reporte.php','Se genero con exito el sql'.$nombreArchivo,
										'Se genero con exito el sql'.$nombreArchivo,'control');
		$this->mensajeExito->setArchivoGenerado($nombreArchivo);
		
		$this->res->imprimirRespuesta($this->mensajeExito->generarJson());

	}
	function crearArchivoExportacion($res) {
		$data = $res -> getDatos();
		$fileName = uniqid(md5(session_id()).'ExportDataProcesoMacro').'.sql';
		//create file
		$file = fopen("../../../reportes_generados/$fileName", 'w');
		
		$sw_gui = 0;
		$sw_funciones=0;
		$sw_procedimiento=0;
		$sw_rol=0; 
		$sw_rol_pro=0;
		fwrite ($file,"----------------------------------\r\n".
						  "--COPY LINES TO SUBSYSTEM data.sql FILE  \r\n".
						  "---------------------------------\r\n".
						  "\r\n" );
		foreach ($data as $row) {			
			 if ($row['tipo'] == 'proceso_macro' ) {
			 	
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_tproceso_macro ('delete','".							 
							$row['codigo']."',NULL,NULL,NULL);\r\n");
					
				} else {
					fwrite ($file, 
					 "select wf.f_import_tproceso_macro ('insert','".
								$row['codigo']."', '" . 
							 $row['codigo_subsistema']."', '" . 
							 $row['nombre']."'," . 
							 (is_null($row['inicio'])?'NULL':"'".$row['inicio']."'").");\r\n");			
				}
			 } else if ($row['tipo'] == 'categoria_documento' ) {
			 	
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_tcategoria_documento ('delete','".							 
							$row['codigo']."',NULL,NULL,NULL);\r\n");
					
				} else {
					fwrite ($file, 
					 "select wf.f_import_tcategoria_documento ('insert','".
								$row['codigo']."', '" .							 
							 $row['nombre']."');\r\n");			
				}				
				
						
				
			} else if ($row['tipo'] == 'tipo_proceso') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_ttipo_proceso ('delete','".							 
							$row['codigo']."',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);\r\n");
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_ttipo_proceso ('insert',".
							 (is_null($row['codigo'])?'NULL':"'".$row['codigo']."'") ."," .
							 (is_null($row['codigo_tipo_estado'])?'NULL':"'".$row['codigo_tipo_estado']."'") ."," .
							 (is_null($row['codigo_tipo_proceso_estado'])?'NULL':"'".$row['codigo_tipo_proceso_estado']."'") ."," .
							 (is_null($row['codigo_pm'])?'NULL':"'".$row['codigo_pm']."'") ."," .
							 (is_null($row['nombre'])?'NULL':"'".$row['nombre']."'") ."," .
							 (is_null($row['tabla'])?'NULL':"'".$row['tabla']."'") ."," .
							 (is_null($row['columna_llave'])?'NULL':"'".$row['columna_llave']."'") ."," .
							 (is_null($row['inicio'])?'NULL':"'".$row['inicio']."'") ."," .
							 (is_null($row['funcion_validacion'])?'NULL':"'".$row['funcion_validacion']."'") ."," .
							 (is_null($row['tipo_disparo'])?'NULL':"'".$row['tipo_disparo']."'") ."," .
							 (is_null($row['descripcion'])?'NULL':"'".$row['descripcion']."'") ."," .
							 (is_null($row['codigo_llave'])?'NULL':"'".$row['codigo_llave']."'") ."," .
							 (is_null($row['funcion_disparo_wf'])?'NULL':"'".$row['funcion_disparo_wf']."'") .");\r\n");				
				}
			}

			else if ($row['tipo'] == 'tabla') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_ttabla ('delete','".							 
							$row['codigo_tabla']."','".
							$row['codigo_tipo_proceso']."',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
							NULL,NULL,NULL,NULL,NULL,NULL,NULL);\r\n");							
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_ttabla ('insert',".
							 (is_null($row['codigo_tabla'])?'NULL':"'".$row['codigo_tabla']."'") ."," .
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .
							 (is_null($row['nombre_tabla'])?'NULL':"'".$row['nombre_tabla']."'") ."," .
							 (is_null($row['descripcion'])?'NULL':"'".$row['descripcion']."'") ."," .
							 (is_null($row['scripts_extras'])?'NULL':"'".$row['scripts_extras']."'") ."," .
							 (is_null($row['vista_tipo'])?'NULL':"'".$row['vista_tipo']."'") ."," .
							 (is_null($row['vista_posicion'])?'NULL':"'".$row['vista_posicion']."'") ."," .
							 (is_null($row['vista_codigo_tabla_maestro'])?'NULL':"'".$row['vista_codigo_tabla_maestro']."'") ."," .
							 (is_null($row['vista_campo_ordenacion'])?'NULL':"'".$row['vista_campo_ordenacion']."'") ."," .
							 (is_null($row['vista_dir_ordenacion'])?'NULL':"'".$row['vista_dir_ordenacion']."'") ."," .
							 (is_null($row['vista_campo_maestro'])?'NULL':"'".$row['vista_campo_maestro']."'") ."," .
							 (is_null($row['vista_scripts_extras'])?'NULL':"'".$row['vista_scripts_extras']."'") ."," .
							 (is_null($row['menu_nombre'])?'NULL':"'".$row['menu_nombre']."'") ."," .
							 (is_null($row['menu_icono'])?'NULL':"'".$row['menu_icono']."'") ."," .
							 (is_null($row['menu_codigo'])?'NULL':"'".$row['menu_codigo']."'") ."," .
							 (is_null($row['vista_estados_new'])?'NULL':"'".$row['vista_estados_new']."'") ."," .
							 (is_null($row['vista_estados_delete'])?'NULL':"'".$row['vista_estados_delete']."'") .");\r\n");
							 
							 						
				}
			} 

			else if ($row['tipo'] == 'tipo_estado') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_ttipo_estado ('delete','".							 
							$row['codigo']."','".
							$row['codigo_tipo_proceso']."',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
							NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
							NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);\r\n");
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_ttipo_estado ('insert',".
							 (is_null($row['codigo'])?'NULL':"'".$row['codigo']."'") ."," .
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .
							 (is_null($row['nombre_estado'])?'NULL':"'".$row['nombre_estado']."'") ."," .
							 (is_null($row['inicio'])?'NULL':"'".$row['inicio']."'") ."," .
							 (is_null($row['disparador'])?'NULL':"'".$row['disparador']."'") ."," .
							 (is_null($row['fin'])?'NULL':"'".$row['fin']."'") ."," .
							 (is_null($row['tipo_asignacion'])?'NULL':"'".$row['tipo_asignacion']."'") ."," .
							 (is_null($row['nombre_func_list'])?'NULL':"'".$row['nombre_func_list']."'") ."," .
							 (is_null($row['depto_asignacion'])?'NULL':"'".$row['depto_asignacion']."'") ."," .
							 (is_null($row['nombre_depto_func_list'])?'NULL':"'".$row['nombre_depto_func_list']."'") ."," .
							 (is_null($row['obs'])?'NULL':"'".$row['obs']."'") ."," .
							 (is_null($row['alerta'])?'NULL':"'".$row['alerta']."'") ."," .
							 (is_null($row['pedir_obs'])?'NULL':"'".$row['pedir_obs']."'") ."," .
							 (is_null($row['descripcion'])?'NULL':"'".$row['descripcion']."'") ."," .
							 (is_null($row['plantilla_mensaje'])?'NULL':"'".$row['plantilla_mensaje']."'") ."," .
							 (is_null($row['plantilla_mensaje_asunto'])?'NULL':"'".$row['plantilla_mensaje_asunto']."'") ."," .
							 (is_null($row['cargo_depto'])?'NULL':"'".$row['cargo_depto']."'") ."," .
							 (is_null($row['mobile'])?'NULL':"'".$row['mobile']."'") ."," .
							 (is_null($row['funcion_inicial'])?'NULL':"'".$row['funcion_inicial']."'") ."," .
							 (is_null($row['funcion_regreso'])?'NULL':"'".$row['funcion_regreso']."'") ."," .
							 (is_null($row['acceso_directo_alerta'])?'NULL':"'".$row['acceso_directo_alerta']."'") ."," .
							 (is_null($row['nombre_clase_alerta'])?'NULL':"'".$row['nombre_clase_alerta']."'") ."," .
							 (is_null($row['tipo_noti'])?'NULL':"'".$row['tipo_noti']."'") ."," .
							 (is_null($row['titulo_alerta'])?'NULL':"'".$row['titulo_alerta']."'") ."," .
							 (is_null($row['parametros_ad'])?'NULL':"'".$row['parametros_ad']."'") ."," .
                             (is_null($row['codigo_estado_anterior'])?'NULL':"'".$row['codigo_estado_anterior']."'") ."," .
                             (is_null($row['admite_obs'])?'NULL':"'".$row['admite_obs']."'") ."," .
                             (is_null($row['etapa'])?'NULL':"'".$row['etapa']."'") ."," .
                             (is_null($row['grupo_doc'])?'NULL':"'".$row['grupo_doc']."'") ."," .
                             (is_null($row['icono'])?'NULL':"'".$row['icono']."'") ."," .
                             (is_null($row['dias_alerta'])?'NULL':$row['dias_alerta']) ."," .
                             (is_null($row['sla'])?'NULL':"'".$row['sla']."'") ."," .
                             (is_null($row['dias_limite'])?'NULL':$row['dias_limite']) ."," .
                             (is_null($row['dias_envio'])?'NULL':"'".$row['dias_envio']."'") ."," .
							 (is_null($row['hrs_envio'])?'NULL':"'".$row['hrs_envio']."'") .");\r\n");

							 						
				}				
			
			}

			else if ($row['tipo'] == 'tipo_columna') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_ttipo_columna ('delete','".							 
							$row['nombre_columna']."','".
							$row['codigo_tabla']."','".
							$row['codigo_tipo_proceso']."',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
							NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);\r\n");
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_ttipo_columna ('insert',".
							 (is_null($row['nombre_columna'])?'NULL':"'".$row['nombre_columna']."'") ."," .
							 (is_null($row['codigo_tabla'])?'NULL':"'".$row['codigo_tabla']."'") ."," .
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .
							 (is_null($row['tipo_columna'])?'NULL':"'".$row['tipo_columna']."'") ."," .
							 (is_null($row['descripcion'])?'NULL':"'".$row['descripcion']."'") ."," .
							 (is_null($row['tamano'])?'NULL':"'".$row['tamano']."'") ."," .
							 (is_null($row['campos_adicionales'])?'NULL':"'".$row['campos_adicionales']."'") ."," .
							 (is_null($row['joins_adicionales'])?'NULL':"'".$row['joins_adicionales']."'") ."," .
							 (is_null($row['formula_calculo'])?'NULL':"'".$row['formula_calculo']."'") ."," .
							 (is_null($row['grid_sobreescribe_filtro'])?'NULL':"'".$row['grid_sobreescribe_filtro']."'") ."," .
							 (is_null($row['grid_campos_adicionales'])?'NULL':"'".$row['grid_campos_adicionales']."'") ."," .
							 (is_null($row['form_tipo_columna'])?'NULL':"'".$row['form_tipo_columna']."'") ."," .
							 (is_null($row['form_label'])?'NULL':"'".$row['form_label']."'") ."," .
							 (is_null($row['form_es_combo'])?'NULL':"'".$row['form_es_combo']."'") ."," .
							 (is_null($row['form_combo_rec'])?'NULL':"'".$row['form_combo_rec']."'") ."," .
							 (is_null($row['form_sobreescribe_config'])?'NULL':"'".$row['form_sobreescribe_config']."'") . "," .
							 (is_null($row['bd_prioridad'])?'NULL':$row['bd_prioridad']) . "," .
                             (is_null($row['form_grupo'])?'NULL':$row['form_grupo']) ."," .
                             (is_null($row['bd_campos_subconsulta'])?'NULL':"'".$row['bd_campos_subconsulta']."'") ."," .
                             (is_null($row['transacciones_permiso'])?'NULL':"'".$row['transacciones_permiso']."'") ."," .
							 (is_null($row['orden'])?'NULL':$row['orden']) . ");\r\n");

				}				
			
			} 
			
			else if ($row['tipo'] == 'tipo_documento') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_ttipo_documento ('delete','".							 
							$row['codigo']."','".
							$row['codigo_tipo_proceso']."',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);\r\n");
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_ttipo_documento ('insert',".
							 (is_null($row['codigo'])?'NULL':"'".$row['codigo']."'") ."," .
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .
							 (is_null($row['nombre'])?'NULL':"'".$row['nombre']."'") ."," .
							 (is_null($row['descripcion'])?'NULL':"'".$row['descripcion']."'") ."," .
							 (is_null($row['action'])?'NULL':"'".$row['action']."'") ."," .	
							 (is_null($row['tipo_documento'])?'NULL':"'".$row['tipo_documento']."'") ."," .	
							 (is_null($row['orden'])?'NULL':$row['orden']) ."," .
                             (is_null($row['categoria_documento'])?'NULL':"'".$row['categoria_documento']."'") ."," .
                             (is_null($row['solo_lectura'])?'NULL':"'".$row['solo_lectura']."'") ."," .
                             (is_null($row['nombre_vista'])?'NULL':"'".$row['nombre_vista']."'") ."," .
                             (is_null($row['nombre_archivo_plantilla'])?'NULL':"'".$row['nombre_archivo_plantilla']."'") ."," .
							 (is_null($row['esquema_vista'])?'NULL':"'".$row['esquema_vista']."'") .");\r\n");
							 					
				}				
			
			}
			
			else if ($row['tipo'] == 'labores') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_tlabores_tipo_proceso ('delete','".							 
							$row['codigo']."','".
							$row['codigo_tipo_proceso']."',NULL,NULL);\r\n");	
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_tlabores_tipo_proceso ('insert',".
							 (is_null($row['codigo'])?'NULL':"'".$row['codigo']."'") ."," .
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .
							 (is_null($row['nombre'])?'NULL':"'".$row['nombre']."'") ."," .							 						 
							 (is_null($row['descripcion'])?'NULL':"'".$row['descripcion']."'") .");\r\n");
							 					
				}				
			
			} 

			else if ($row['tipo'] == 'columna_estado') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_tcolumna_estado ('delete','".							 
							$row['nombre_tipo_columna']."','".
							$row['codigo_tabla']."','".
							$row['codigo_tipo_proceso']."','".
							$row['codigo_tipo_estado']."',NULL,NULL);\r\n");	
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_tcolumna_estado ('insert',".
							 (is_null($row['nombre_tipo_columna'])?'NULL':"'".$row['nombre_tipo_columna']."'") ."," .
							 (is_null($row['codigo_tabla'])?'NULL':"'".$row['codigo_tabla']."'") ."," .
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .	
							 (is_null($row['codigo_tipo_estado'])?'NULL':"'".$row['codigo_tipo_estado']."'") ."," .
							 (is_null($row['momento'])?'NULL':"'".$row['momento']."'") ."," .						 						 
							 (is_null($row['regla'])?'NULL':"'".$row['regla']."'") .");\r\n");
							 				
				}				
			
			}

			else if ($row['tipo'] == 'estructura_estado') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_testructura_estado ('delete','".							 
							$row['codigo_estado_padre']."','".
							$row['codigo_estado_hijo']."','".							
							$row['codigo_tipo_proceso']."',NULL,NULL,NULL);\r\n");
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_testructura_estado ('insert',".
							 (is_null($row['codigo_estado_padre'])?'NULL':"'".$row['codigo_estado_padre']."'") ."," .
							 (is_null($row['codigo_estado_hijo'])?'NULL':"'".$row['codigo_estado_hijo']."'") ."," .
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .							 
							 (is_null($row['prioridad'])?'NULL':$row['prioridad']) ."," .
                             (is_null($row['regla'])?'NULL':"'".$row['regla']."'") ."," .
							 (is_null($row['bucle'])?'NULL':"'".$row['bucle']."'") .");\r\n");
				}				
			
			}

			else if ($row['tipo'] == 'funcionario_tipo_estado') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_tfuncionario_tipo_estado ('delete','".							 
							$row['codigo_tipo_estado']."','".
							$row['codigo_tipo_proceso']."',".
							(is_null($row['ci'])?'NULL':"'".$row['ci']."'") ."," .	
							(is_null($row['codigo_depto'])?'NULL':"'".$row['codigo_depto']."'") .",NULL,NULL);\r\n");
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_tfuncionario_tipo_estado ('insert',".
							 (is_null($row['codigo_tipo_estado'])?'NULL':"'".$row['codigo_tipo_estado']."'") ."," .
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .
							 (is_null($row['ci'])?'NULL':"'".$row['ci']."'") ."," .							 
							 (is_null($row['codigo_depto'])?'NULL':"'".$row['codigo_depto']."'") ."," .
                             (is_null($row['regla'])?'NULL':"'".$row['regla']."'") ."," .
							 (is_null($row['id_labores_tipo_proceso'])?'NULL':$row['id_labores_tipo_proceso']) .");\r\n");

				}				
			
			}
			
			else if ($row['tipo'] == 'plantilla_correo') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_tplantilla_correo ('delete','".
							$row['codigo']."','".							 
							$row['codigo_tipo_estado']."','".
							$row['codigo_tipo_proceso']."',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);\r\n");
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_tplantilla_correo ('insert',".
					 		 (is_null($row['codigo'])?'NULL':"'".$row['codigo']."'") ."," .
							 (is_null($row['codigo_tipo_estado'])?'NULL':"'".$row['codigo_tipo_estado']."'") ."," .
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .
							 (is_null($row['regla'])?'NULL':"'".$row['regla']."'") ."," .							 
							 (is_null($row['plantilla'])?'NULL':"'".$row['plantilla']."'") ."," .
							 (is_null($row['correos'])?'NULL':"'".$row['correos']."'") ."," .
                             (is_null($row['asunto'])?'NULL':"'".$row['asunto']."'") ."," .
                             (is_null($row['documentos'])?'NULL':"'".$row['documentos']."'") ."," .
                             (is_null($row['requiere_acuse'])?'NULL':"'".$row['requiere_acuse']."'") ."," .
                             (is_null($row['url_acuse'])?'NULL':"'".$row['url_acuse']."'") ."," .
                             (is_null($row['mensaje_acuse'])?'NULL':"'".$row['mensaje_acuse']."'") ."," .
                             (is_null($row['mensaje_link_acuse'])?'NULL':"'".$row['mensaje_link_acuse']."'") ."," .
                             (is_null($row['mandar_automaticamente'])?'NULL':"'".$row['mandar_automaticamente']."'") ."," .
                             (is_null($row['funcion_acuse_recibo'])?'NULL':"'".$row['funcion_acuse_recibo']."'") ."," .
                             (is_null($row['funcion_creacion_correo'])?'NULL':"'".$row['funcion_creacion_correo']."'") ."," .
                             (is_null($row['cc'])?'NULL':"'".$row['cc']."'") ."," .
							 (is_null($row['bcc'])?'NULL':"'".$row['bcc']."'") .");\r\n");
							 				
				}		
			}		 		
			
		}
		
		fwrite ($file,"----------------------------------\r\n".
						  "--COPY LINES TO SUBSYSTEM dependencies.sql FILE  \r\n".
						  "---------------------------------\r\n".
						  "\r\n" );
		foreach ($data as $row) {				  
			if ($row['tipo'] == 'proceso_origen') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_ttipo_proceso_origen ('delete','".							 
							$row['codigo_tipo_proceso']."','".
							$row['codigo_pm']."','".
							$row['codigo_tipo_proceso_origen']."','".
							$row['codigo_tipo_estado']."',NULL,NULL);\r\n");	
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_ttipo_proceso_origen ('insert',".
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .
							 (is_null($row['codigo_pm'])?'NULL':"'".$row['codigo_pm']."'") ."," .
							 (is_null($row['codigo_tipo_proceso_origen'])?'NULL':"'".$row['codigo_tipo_proceso_origen']."'") ."," .							 
							 (is_null($row['codigo_tipo_estado'])?'NULL':"'".$row['codigo_tipo_estado']."'") ."," .	
							 (is_null($row['tipo_disparo'])?'NULL':"'".$row['tipo_disparo']."'") ."," .						 						 
							 (is_null($row['funcion_validacion_wf'])?'NULL':"'".$row['funcion_validacion_wf']."'") .");\r\n");
							 				
				}				
			
			}
			else if ($row['tipo'] == 'tipo_documento_estado') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_ttipo_documento_estado ('delete','".							 
							$row['codigo_tipo_documento']."','".
							$row['codigo_tipo_proceso']."','".
							$row['codigo_tipo_estado']."','".
							$row['codigo_tipo_proceso_externo']."',".							
							"NULL,NULL,NULL);\r\n");	
					
				} else {
					
					fwrite ($file, 
					 "select wf.f_import_ttipo_documento_estado ('insert',".
							 (is_null($row['codigo_tipo_documento'])?'NULL':"'".$row['codigo_tipo_documento']."'") ."," .
							 (is_null($row['codigo_tipo_proceso'])?'NULL':"'".$row['codigo_tipo_proceso']."'") ."," .
							 (is_null($row['codigo_tipo_estado'])?'NULL':"'".$row['codigo_tipo_estado']."'") ."," .	
							 (is_null($row['codigo_tipo_proceso_externo'])?'NULL':"'".$row['codigo_tipo_proceso_externo']."'") ."," .	
							 (is_null($row['momento'])?'NULL':"'".$row['momento']."'") ."," .
							 (is_null($row['tipo_busqueda'])?'NULL':"'".$row['tipo_busqueda']."'") ."," .						 						 
							 (is_null($row['regla'])?'NULL':"'".$row['regla']."'") .");\r\n");
							 				
				}				
			
			}

			else if ($row['tipo'] == 'tipo_estado_rol') {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_import_ttipo_estado_rol ('delete','".							 
							$row['codigo_tipo_proceso']."','".
							$row['codigo_tipo_estado']."','".
							$row['codigo_rol']."');\r\n");	
					
				} else {
					
					fwrite ($file, 
					"select wf.f_import_ttipo_estado_rol ('insert','".							 
							$row['codigo_tipo_proceso']."','".
							$row['codigo_tipo_estado']."','".
							$row['codigo_rol']."');\r\n");
							 				
				}				
			
			}
		}
		
		return $fileName;
	}
			
}

?>