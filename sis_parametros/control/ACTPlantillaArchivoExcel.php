<?php
/****************************************************************************************
*@package pXP
*@file ACTPlantillaArchivoExcel.php
*@author  (gsarmiento)
*@date 15-12-2016 20:46:39
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*****************************************************************************************
 ISSUE  SIS     FECHA      	AUTOR       DESCRIPCION
 #1		PAR		21/11/2018	EGS			se agrego funciones para exportar la configuracion de plantilla  
 #185 	PAR 	07/07/2020	RCM			Crear opción para generar plantilla excel en blanco
*****************************************************************************************
*/
include_once(dirname(__FILE__).'/../reportes/RPlantillaXls.php');//#185

class ACTPlantillaArchivoExcel extends ACTbase{    
			
	function listarPlantillaArchivoExcel(){
		$this->objParam->defecto('ordenacion','id_plantilla_archivo_excel');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPlantillaArchivoExcel','listarPlantillaArchivoExcel');
		} else{
			$this->objFunc=$this->create('MODPlantillaArchivoExcel');
			
			$this->res=$this->objFunc->listarPlantillaArchivoExcel($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPlantillaArchivoExcel(){
		$this->objFunc=$this->create('MODPlantillaArchivoExcel');	
		if($this->objParam->insertar('id_plantilla_archivo_excel')){
			$this->res=$this->objFunc->insertarPlantillaArchivoExcel($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPlantillaArchivoExcel($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPlantillaArchivoExcel(){
			$this->objFunc=$this->create('MODPlantillaArchivoExcel');	
		$this->res=$this->objFunc->eliminarPlantillaArchivoExcel($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	//#1 21/11/2018		EGS
	function exportarDatos(){
		
		//crea el objetoFunProcesoMacro que contiene todos los metodos del sistema de workflow
		$this->objFunProcesoMacro=$this->create('MODPlantillaArchivoExcel');		
		
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
		$fileName = uniqid(md5(session_id()).'PlantillaExcel').'.sql';
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
			 	
				if ($row['estado_reg'] == 'inactivo') {
					fwrite ($file, 
					"select param.f_import_tplantilla_archivo_excel ('delete','".							 
							$row['codigo']."',
							NULL,NULL,NULL,NULL,NULL,
							NULL,NULL,NULL,NULL,NULL);\r\n");
							
				} else {
					fwrite ($file, 
					 "select param.f_import_tplantilla_archivo_excel ('insert','".
								$row['codigo']."'," .
						     (is_null($row['nombre'])?'NULL':"'".$row['nombre']."'") ."," .
							 (is_null($row['estado_reg'])?'NULL':"'".$row['estado_reg']."'") ."," .
							 (is_null($row['hoja_excel'])?'NULL':"'".$row['hoja_excel']."'") ."," .
							 (is_null($row['fila_inicio'])?'NULL':"'".$row['fila_inicio']."'") ."," .							 
							 (is_null($row['fila_fin'])?'NULL':"'".$row['fila_fin']."'") ."," .							 
							 (is_null($row['filas_excluidas'])?'NULL':"'".$row['filas_excluidas']."'") ."," .							 
							 (is_null($row['tipo_archivo'])?'NULL':"'".$row['tipo_archivo']."'") ."," .							 
							 (is_null($row['delimitador'])?'NULL':"'".$row['delimitador']."'").");\r\n");						
							 
							 	
				}
			 } else if ($row['tipo_reg'] == 'detalle') {
				if ($row['estado_reg'] == 'inactivo') {
						
					fwrite ($file, 
					"select param.f_import_tcolumna_plantilla_archivo_excel ('delete','".							 
							$row['codigo_plantilla']."',
							NULL,NULL,NULL,NULL,NULL,
							NULL,NULL,NULL,NULL,NULL,NULL,NULL);\r\n");	
	
			} else {
					
					fwrite ($file, 
					 "select param.f_import_tcolumna_plantilla_archivo_excel ('insert',".
							 (is_null($row['codigo'])?'NULL':"'".$row['codigo']."'") ."," .
							 (is_null($row['codigo_plantilla'])?'NULL':"'".$row['codigo_plantilla']."'") ."," .
							 (is_null($row['sw_legible'])?'NULL':"'".$row['sw_legible']."'") ."," .
							 (is_null($row['formato_fecha'])?'NULL':"'".$row['formato_fecha']."'") ."," .
							 (is_null($row['anio_fecha'])?'NULL':"'".$row['anio_fecha']."'") ."," .
							 (is_null($row['numero_columna'])?'NULL':"'".$row['numero_columna']."'") ."," .
							 (is_null($row['nombre_columna'])?'NULL':"'".$row['nombre_columna']."'") ."," .
							 (is_null($row['nombre_columna_tabla'])?'NULL':"'".$row['nombre_columna_tabla']."'") ."," .
							 (is_null($row['tipo_valor'])?'NULL':"'".$row['tipo_valor']."'") ."," .
							 (is_null($row['punto_decimal'])?'NULL':"'".$row['punto_decimal']."'") ."," .	
							 (is_null($row['estado_reg'])?'NULL':"'".$row['estado_reg']."'") .");\r\n");
							 
							 						
				}
			} 
         } //end for
		
		
		return $fileName;
	}
	//#1 21/11/2018		EGS

	//Inicio #185
	function generarPlantilla(){
		//Configuración archivo excel
		$nombreArchivo = 'tpl-'.$this->objParam->getParametro('nombre').'.xls';
		$this->objParam->addParametro('orientacion', 'L');
		$this->objParam->addParametro('tamano', 'LETTER');
		$this->objParam->addParametro('titulo_archivo', 'Plantilla '.$this->objParam->getParametro('nombre'));
		$this->objParam->addParametro('nombre_archivo', $nombreArchivo);

		//Obtención de datos
		$dataSource = $this->getPlantilla();

		//Generación del reporte
		$reporte = new RPlantillaXls($this->objParam);
		$reporte->setData($dataSource->getDatos());
		$reporte->generarReporte();

		$this->mensajeExito = new Mensaje();
		$this->mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado','Se generó con éxito el reporte: '.$nombreArchivo,'control');
		$this->mensajeExito->setArchivoGenerado($nombreArchivo);
		$this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());
	}

	function getPlantilla() {
		$this->objParam->defecto('ordenacion','numero_columna');
		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->defecto('puntero','0');
		$this->objParam->defecto('cantidad','2000');

		if($this->objParam->getParametro('id_plantilla_archivo_excel')!=''){
            $this->objParam->addFiltro("ae.id_plantilla_archivo_excel = ".$this->objParam->getParametro('id_plantilla_archivo_excel'));
		}
		if($this->objParam->getParametro('codigo')!=''){
            $this->objParam->addFiltro("ae.codigo = ''".$this->objParam->getParametro('codigo')."''");
        }

		$this->objFunc = $this->create('MODPlantillaArchivoExcel');
		$data = $this->objFunc->generarPlantilla($this->objParam);

		if($data->getTipo() == 'EXITO'){
			return $data;
		} else {
		    $data->imprimirRespuesta($data->generarJson());
			exit;
		}
	}
	//Fin #185
			
}

?>