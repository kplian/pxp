<?php
/**
*@package pXP
*@file gen-ACTTipoDocumento.php
*@author  (admin)
*@date 14-01-2014 17:43:47
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
require_once(dirname(__FILE__).'/../../pxpReport/DataSource.php');

class ACTTipoDocumento extends ACTbase{    
			
	function listarTipoDocumento(){
		            
		$this->objParam->defecto('ordenacion','id_tipo_documento');
        $this->objParam->defecto('dir_ordenacion','asc');
        
        if($this->objParam->getParametro('id_tipo_proceso')!=''){
            $this->objParam->addFiltro("tipdw.id_tipo_proceso = ".$this->objParam->getParametro('id_tipo_proceso'));    
        }
		
		if($this->objParam->getParametro('id_tipo_documentos')!=''){
            $this->objParam->addFiltro("tipdw.id_tipo_documento in (".$this->objParam->getParametro('id_tipo_documentos').')');    
        }
        
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoDocumento','listarTipoDocumento');
		} else{
			$this->objFunc=$this->create('MODTipoDocumento');
			
			$this->res=$this->objFunc->listarTipoDocumento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoDocumento(){
		$this->objFunc=$this->create('MODTipoDocumento');	
		if($this->objParam->insertar('id_tipo_documento')){
			$this->res=$this->objFunc->insertarTipoDocumento($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoDocumento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoDocumento(){
		$this->objFunc=$this->create('MODTipoDocumento');	
		$this->res=$this->objFunc->eliminarTipoDocumento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    
    function listarColumnasPlantillaDocumento(){
        $this->objParam->defecto('ordenacion','column_name');
        $this->objParam->defecto('dir_ordenacion','asc');
        
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTipoDocumento','listarColumnasPlantillaDocumento');
        } else{
            $this->objFunc=$this->create('MODTipoDocumento');
            
            $this->res=$this->objFunc->listarColumnasPlantillaDocumento($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function listarTipoDocumentoXTipoPRocesoEstado(){
                    
        $this->objParam->defecto('ordenacion','id_tipo_documento');
        $this->objParam->defecto('dir_ordenacion','asc');
        
        if($this->objParam->getParametro('id_tipo_proceso')!=''){
            $this->objParam->addFiltro("tp.id_tipo_proceso = ".$this->objParam->getParametro('id_tipo_proceso'));    
        }
         
        if($this->objParam->getParametro('estado_desc')!=''){
            $this->objParam->addFiltro("te.codigo = ''".$this->objParam->getParametro('estado_desc')."''");    
        }
        
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTipoDocumento','listarTipoDocumentoXTipoPRocesoEstado');
        } else{
            $this->objFunc=$this->create('MODTipoDocumento');
           
            $this->res=$this->objFunc->listarTipoDocumentoXTipoPRocesoEstado($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function generarDocumento(){
        $pPlantilla=$this->objParam->getParametro('nombre_archivo_plantilla');
        $this->objFunc=$this->create('MODTipoDocumento');
        include_once(dirname(__FILE__).'/../../sis_workflow/reportes/RTipoDocumento.php');
        
        //Obtiene los datos de la vista
        $datos=$this->res=$this->objFunc->generarDocumento($this->objParam);
		//var_dump($datos);exit;
        
        //Setea los valores en el datasource
        $dataSource = new DataSource();
        $dat = $datos->getDatos();
        
        foreach($dat as $valor){
            foreach($valor as $clave => $valor1){
                $dataSource->putParameter($clave, $valor1);
            }
        }

        //Generar el reporte
        $documento = new RTipoDocumento($pPlantilla);
        $documento->setDataSource($dataSource);
        
        //Obtiene el nombre del reporte
        $aux=strrchr($pPlantilla,'/');
        if($aux!=''){
            $nombreArchivo = substr($aux, 1,strpos($aux,'.')-1);
        } else {
            $nombreArchivo = substr($pPlantilla, 0,strpos($pPlantilla,'.'));
        }
        $nombreArchivo = $nombreArchivo.'_'.rand(0,99999).'.docx';
        //echo dirname(__FILE__).'/../../reportes_generados/'.$nombreArchivo;exit;
        $documento->write(dirname(__FILE__).'/../../../reportes_generados/'.$nombreArchivo);
        
        $mensajeExito = new Mensaje();
        $mensajeExito->setMensaje('EXITO','Documento.php','Documento generado', 'Se generó con éxito el documento: '.$nombreArchivo,'control');
        $mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->res = $mensajeExito;
        $this->res->imprimirRespuesta($this->res->generarJson());

    }

	function subirPlantilla(){
	
		$this->objParam->addParametro('id_tipo_proceso',$this->objParam->getParametro('id_tipo_proceso'));
		$this->objFunc=$this->create('MODTipoProceso');
		
		$this->res=$this->objFunc->obtenerSubsistemaTipoProceso($this->objParam);
		//$ext = pathinfo($this->arregloFiles['archivo']['name']);
		//var_dump($this->objParam->getFiles());exit;
		//var_dump($this->aPostFiles);
		$ruta_archivo = '../../../sis_'.$this->res->datos[nombre_carpeta].'/reportes/plantillas/'.$this->arregloFiles['archivo']['name'];
		//$this->objParam->addParametro('nombre_archivo_plantilla',$ruta_archivo);
		//var_dump($ruta_archivo);exit;
		
		$this->objFunc=$this->create('MODTipoDocumento');
		   
		
		
		
		//var_dump($this->objParam);exit;
		//Obtener la carpeta del sistema que sube la plantilla 
		$this->res=$this->objFunc->subirPlantilla($this->objParam);
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	
			
}

?>