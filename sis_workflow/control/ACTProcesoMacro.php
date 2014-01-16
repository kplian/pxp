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
	
	function ExportarDatosProcesoMacro(){
		
		//crea el objetoFunProcesoMacro que contiene todos los metodos del sistema de workflow
		$this->objFunProcesoMacro=$this->create('MODProcesoMacro');		
		
		$this->res = $this->objFunProcesoMacro->ExportarDatosProcesoMacro();
		
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
						  "--COPY LINES TO data.sql FILE  \r\n".
						  "---------------------------------\r\n".
						  "\r\n" );
		foreach ($data as $row) {			
			 if ($row['tipo'] == 'proceso_macro' ) {
			 	
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_delete_tproceso_macro ('".							 
							$row['codigo']."');\r\n");
					
				} else {
					fwrite ($file, 
					 "select wf.f_insert_tproceso_macro ('".
								$row['codigo']."', '" . 
							 $row['nombre']."', '" . 
							 $row['inicio']."', '" . 
							 $row['estado_reg']."', '" . 
								$row['subsistema']."');\r\n");					
				}				
				
			}			
			elseif ($row['tipo'] =='tipo_proceso' ) {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select wf.f_delete_ttipo_proceso ('". 
							$row['codigo']."');\r\n");
					
				} else {								
					fwrite ($file, 
						"select wf.f_insert_ttipo_proceso ('". 
							$row['nombre_tipo_estado']."', '" . 
							$row['nombre']."', '" . 
							$row['codigo']."', '" . 
							$row['tabla']."', '" . 
							$row['columna_llave']."', '" . 
							$row['estado_reg']."', '" . 
							$row['inicio']."', '" . 
							$row['cod_proceso_macro']."');\r\n");						
				}
				
			}  elseif ($row['tipo'] == 'tipo_estado' ) {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
						"select wf.f_delete_ttipo_estado ('".					 
							$row['codigo']."');\r\n");
					
				} else {							
					fwrite ($file, 
						"select wf.f_insert_ttipo_estado ('".
								$row['codigo']."', '" . 
								$row['nombre_estado']."', '" . 
								$row['inicio']."', '" . 
								$row['disparador']."', '" . 
								$row['fin']."', '" .
								$row['tipo_asignacion']."', '" . 
								$row['nombre_func_list']."', '" .
								$row['depto_asignacion']."', '" .    
								$row['nombre_depto_func_list']."', '" .
								$row['obs']."', '" .    
								$row['estado_reg']."', '" .
								$row['codigo_proceso']."', '" .
								$row['tipos_proceso']."');\r\n");
				}
				
			} elseif ($row['tipo'] == 'estructura_estado' ) {
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
						"select wf.f_delete_testructura_estado ('". 
							$row['nombre_estado_padre']."', '" . 
							$row['nombre_estado_hijo']."');\r\n");
					
				} else {
					if ($row['prioridad'] == '') {
						$row['prioridad'] = 'NULL';
					}             									
					fwrite ($file, 
						"select wf.f_insert_testructura_estado ('".
								$row['codigo_estado_padre']."', '" .
								$row['codigo_proceso_estado_padre']."', '" . 
								$row['codigo_estado_hijo']."', '" .
								$row['codigo_proceso_estado_hijo']."', " .
								$row['prioridad'].", '" .
								$row['regla']."', '" . 
								$row['estado_reg']."');\r\n");
				}				
			}
		}
		return $fileName;
	}
			
}

?>