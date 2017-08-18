<?php
/**
*@package pXP
*@file gen-ACTTipoArchivo.php
*@author  (admin)
*@date 05-12-2016 15:03:38
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoArchivo extends ACTbase{    
			
	function listarTipoArchivo(){
		$this->objParam->defecto('ordenacion','id_tipo_archivo');

		$this->objParam->defecto('dir_ordenacion','asc');

        if($this->objParam->getParametro('tabla')!=''){
            $this->objParam->addFiltro("tipar.tabla = ''".$this->objParam->getParametro('tabla')."''");
        }
        if($this->objParam->getParametro('multiple')!=''){
            $this->objParam->addFiltro("tipar.multiple = ''".$this->objParam->getParametro('multiple')."''");
        }

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoArchivo','listarTipoArchivo');
		} else{
			$this->objFunc=$this->create('MODTipoArchivo');
			
			$this->res=$this->objFunc->listarTipoArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoArchivo(){
		$this->objFunc=$this->create('MODTipoArchivo');	
		if($this->objParam->insertar('id_tipo_archivo')){
			$this->res=$this->objFunc->insertarTipoArchivo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoArchivo(){
			$this->objFunc=$this->create('MODTipoArchivo');	
		$this->res=$this->objFunc->eliminarTipoArchivo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

    function exportarConfiguracion(){


        $this->objParam->parametros_consulta['ordenacion'] = 'id_tipo_archivo';
        $this->objParam->parametros_consulta['dir_ordenacion'] = 'ASC';
        $this->objParam->parametros_consulta['cantidad'] = '1000';
        $this->objParam->parametros_consulta['puntero'] = '0';
        $this->objParam->parametros_consulta['filtro'] = ' 0 = 0 ';
        $this->objParam->addFiltro("tipar.id_tipo_archivo = ''" . $this->objParam->getParametro('id_tipo_archivo') . "'' ");


        $this->objFunc=$this->create('MODTipoArchivo');
        $this->res=$this->objFunc->listarTipoArchivo($this->objParam);

        if ($this->res->getTipo() == 'ERROR') {
            $this->res->imprimirRespuesta($this->res->generarJson());
            exit;
        }

        $tipo_archivo = $this->res->getDatos();
        $tipo_archivo = json_encode($tipo_archivo[0]);


        //sacamos los campos
        $this->objParam->parametros_consulta['filtro'] = ' 0 = 0 ';
        $this->objParam->addFiltro("tipcam.id_tipo_archivo = ''" . $this->objParam->getParametro('id_tipo_archivo') . "'' ");

        $this->objFunc=$this->create('MODTipoArchivoCampo');
        $this->res=$this->objFunc->listarTipoArchivoCampo($this->objParam);

        if ($this->res->getTipo() == 'ERROR') {
            $this->res->imprimirRespuesta($this->res->generarJson());
            exit;
        }
        $tipo_archivo_campo = $this->res->getDatos();
        $tipo_archivo_campo = json_encode($tipo_archivo_campo);




        ////////////sacamos los joins
        $this->objParam->parametros_consulta['filtro'] = ' 0 = 0 ';
        $this->objParam->addFiltro("tajoin.id_tipo_archivo = ''" . $this->objParam->getParametro('id_tipo_archivo') . "'' ");

        $this->objFunc=$this->create('MODTipoArchivoJoin');
        $this->res=$this->objFunc->listarTipoArchivoJoin($this->objParam);

        if ($this->res->getTipo() == 'ERROR') {
            $this->res->imprimirRespuesta($this->res->generarJson());
            exit;
        }
        $tipo_archivo_join = $this->res->getDatos();
        $tipo_archivo_join = json_encode($tipo_archivo_join);




        $nombreArchivo = $this->crearArchivoExportacion($tipo_archivo,$tipo_archivo_campo,$tipo_archivo_join);

        $this->mensajeExito=new Mensaje();
        $this->mensajeExito->setMensaje('EXITO','Reporte.php','Se genero con exito el sql'.$nombreArchivo,
            'Se genero con exito el sql'.$nombreArchivo,'control');
        $this->mensajeExito->setArchivoGenerado($nombreArchivo);

        $this->res->imprimirRespuesta($this->mensajeExito->generarJson());



    }


    function crearArchivoExportacion($tipo_archivo,$tipo_archivo_campo,$tipo_archivo_join) {
        $fileName = uniqid(md5(session_id()).'ExportDataParamTipoArchivo').'.sql';
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
           
        
         fwrite ($file," select param.f_import_tipo_archivo ('".$tipo_archivo."', '".$tipo_archivo_campo."', '".$tipo_archivo_join."');\r\n");

            
        
        return $fileName;
    }
    

			
}

?>