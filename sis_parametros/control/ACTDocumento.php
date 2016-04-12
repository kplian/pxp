<?php
/***
 Nombre: ACTDocumento.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tdocumento 
 Autor:	Kplian
 Fecha:	06/06/2011
 */
class ACTDocumento extends ACTbase{    

	function listarDocumento(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','documento');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('codigosis')!=''){
              $this->objParam->addFiltro("SUBSIS.codigo =''".$this->objParam->getParametro('codigosis')."''");    
         }
		
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODDocumento','listarDocumento');
		}
		else {
			$this->objFunSeguridad=$this->create('MODDocumento');
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarDocumento($this->objParam);
			
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarDocumento(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODDocumento');
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_documento')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarDocumento($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarDocumento($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarDocumento(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODDocumento');	
		$this->res=$this->objFunSeguridad->eliminarDocumento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	
	function subirPlantilla(){
		$this->objFunSeguridad=$this->create('MODDocumento');	
		$this->res=$this->objFunSeguridad->subirPlantilla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function exportarDatos(){
		
		//crea el objetoFunProcesoMacro que contiene todos los metodos del sistema de workflow
		$this->objFunProcesoMacro=$this->create('MODDocumento');		
		
		$this->res = $this->objFunProcesoMacro->exportarDatos();
		
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
		$fileName = uniqid(md5(session_id()).'PlantillaCalculo').'.sql';
		
		//create file
		$file = fopen("../../../reportes_generados/$fileName", 'w');
		
		$sw_gui = 0;
		$sw_funciones = 0;
		$sw_procedimiento = 0;
		$sw_rol = 0; 
		$sw_rol_pro = 0;
		
		fwrite ($file,"----------------------------------\r\n".
					  "--COPY LINES TO SUBSYSTEM data.sql FILE  \r\n".
					  "---------------------------------\r\n".
					  "\r\n" );
		
		foreach ($data as $row) {			
			
			 	fwrite ($file, 
					 "select param.f_import_tdocumento ('insert','".
								$row['codigo']."'," .
						     (is_null($row['descripcion'])?'NULL':"'".$row['descripcion']."'") ."," .
							 (is_null($row['codigo_subsis'])?'NULL':"'".$row['codigo_subsis']."'") ."," .
							 (is_null($row['tipo_numeracion'])?'NULL':"'".$row['tipo_numeracion']."'") ."," .
							 (is_null($row['periodo_gestion'])?'NULL':"'".$row['periodo_gestion']."'") ."," .							 
							 (is_null($row['tipo'])?'NULL':"'".$row['tipo']."'") ."," .							 
							 (is_null($row['formato'])?'NULL':"'".$row['formato']."'").");\r\n");			
							 
			 
         } //end for
		
		return $fileName;
	}
	
	

}

?>