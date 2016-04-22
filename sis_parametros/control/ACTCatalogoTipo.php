<?php
/**
*@package pXP
*@file gen-ACTCatalogoTipo.php
*@author  (admin)
*@date 27-11-2012 23:32:44
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCatalogoTipo extends ACTbase{    
			
	function listarCatalogoTipo(){
		$this->objParam->defecto('ordenacion','id_catalogo_tipo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_subsistema')!=''){
			$this->objParam->addFiltro("pacati.id_subsistema = ".$this->objParam->getParametro('id_subsistema'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarCatalogoTipo');
		} else{
			$this->objFunc=$this->create('MODCatalogoTipo');	
			$this->res=$this->objFunc->listarCatalogoTipo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCatalogoTipo(){
		$this->objFunc=$this->create('MODCatalogoTipo');	
		if($this->objParam->insertar('id_catalogo_tipo')){
			$this->res=$this->objFunc->insertarCatalogoTipo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCatalogoTipo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCatalogoTipo(){
		$this->objFunc=$this->create('MODCatalogoTipo');	
		$this->res=$this->objFunc->eliminarCatalogoTipo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function exportarDatos(){
		
		//crea el objetoFunProcesoMacro que contiene todos los metodos del sistema de workflow
		$this->objFunProcesoMacro=$this->create('MODCatalogoTipo');		
		
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
		$fileName = uniqid(md5(session_id()).'CatalogoTipo').'.sql';
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
			 if ($row['tipo_reg'] == 'maestro' ) {
			 	
				
					fwrite ($file, 
					 "select param.f_import_tcatalogo_tipo ('insert',".
							 (is_null($row['nombre'])?'NULL':"'".$row['nombre']."'") ."," .
							 (is_null($row['codigo_subsistema'])?'NULL':"'".$row['codigo_subsistema']."'") ."," .							 
							 (is_null($row['tabla'])?'NULL':"'".$row['tabla']."'").");\r\n");			
							 
							 	
				
			 } else if ($row['tipo_reg'] == 'detalle') {
				
					fwrite ($file, 
					 "select param.f_import_tcatalogo ('insert',".
							 (is_null($row['codigo_subsistema'])?'NULL':"'".$row['codigo_subsistema']."'") ."," .
							 (is_null($row['descripcion'])?'NULL':"'".$row['descripcion']."'") ."," .
							 (is_null($row['codigo'])?'NULL':"'".$row['codigo']."'")."," .							 
							 (is_null($row['desc_catalogo_tipo'])?'NULL':"'".$row['desc_catalogo_tipo']."'") .");\r\n");
				
			} 
         } //end for
		
		
		return $fileName;
	}
	
			
}

?>