<?php
/**
*@package pXP
*@file gen-ACTDocumentoWf.php
*@author  (admin)
*@date 15-01-2014 13:52:19
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
ISSUE	FORK		FECHA		AUTHOR        DESCRIPCION
#4 		EndeEtr  	02/01/2019	EGS			se agrego la logica para aumentar el tipo de extensiones desde una variable global
#98 	EndeEtr  	24/12/2019	JUAN		Reporte de lista de documentos en workflow con letras mas grandes
 * */
require_once(dirname(__FILE__).'/../reportes/RListaDocumentos.php');//#98
class ACTDocumentoWf extends ACTbase{    
			
	function listarDocumentoWf(){
		$this->objParam->defecto('ordenacion','id_documento_wf');

		$this->objParam->defecto('dir_ordenacion','asc');
		/*$this->objParam->addFiltro("tewf.nombre_estado != ''anulado''");
		$this->objParam->addFiltro("tewf.nombre_estado != ''cancelado''");*/
		
		if ($this->objParam->getParametro('anulados') == 'no') {
			$this->objParam->addFiltro("tewf.codigo not in (''anulada'',''anulado'',''cancelado'')");
		}
		
		if ($this->objParam->getParametro('modoConsulta') == 'si') {
			$this->objParam->addFiltro(" (dwf.chequeado = ''si'' or  td.action != '''') ");
		}
		
		if ($this->objParam->getParametro('categoria') != '') {
			$this->objParam->addFiltro("(''".$this->objParam->getParametro('categoria')."'' =ANY(td.categoria_documento) or td.categoria_documento is NULL or td.categoria_documento = ''{}'')" );
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDocumentoWf','listarDocumentoWf');
		} else{
			$this->objFunc=$this->create('MODDocumentoWf');
			
			$this->res=$this->objFunc->listarDocumentoWf($this->objParam);
			foreach($this->res->getDatos() as $documento){
				if($documento["tipo_documento"]=='generado'){					
					$_SESSION["permisos_temporales"][trim(str_replace('../','',$documento["action"]))] = 'si';					
				}
			}
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

    function getRutaDocumento(){
        $this->objParam->defecto('ordenacion','id_documento_wf');

        $this->objParam->defecto('dir_ordenacion','asc');
        /*$this->objParam->addFiltro("tewf.nombre_estado != ''anulado''");
        $this->objParam->addFiltro("tewf.nombre_estado != ''cancelado''");*/
        $this->objParam->addParametro('dominio',$_SERVER['HTTP_HOST'] . $_SESSION["_FOLDER"]);
        if ($this->objParam->getParametro('id_documento_wf') != '') {
            $this->objParam->addFiltro("dwf.id_documento_wf = " . $this->objParam->getParametro('id_documento_wf'));
        }


        $this->objFunc=$this->create('MODDocumentoWf');
        $this->res=$this->objFunc->getRutaDocumento($this->objParam);

        $this->res->imprimirRespuesta($this->res->generarJson());
    }
				
	function insertarDocumentoWf(){
		$this->objFunc=$this->create('MODDocumentoWf');	
		if($this->objParam->insertar('id_documento_wf')){
			$this->res=$this->objFunc->insertarDocumentoWf($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDocumentoWf($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDocumentoWf(){
			$this->objFunc=$this->create('MODDocumentoWf');	
		$this->res=$this->objFunc->eliminarDocumentoWf($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function subirArchivoWf(){
		//#4 02/01/2019	EGS	
		///Recuperamos los tipos de extensiones permitidos para el upload
		$this->objFunc=$this->create('MODDocumentoWf');
        $extension=$this->objFunc->extensionDocumento();
       
        $extension=$extension->getDatos();
		//armamos el array con las exetensiones
		$array = array();		
				    for ($i=0; $i < count($extension) ; $i++) {
					 array_push ( $array , $extension[$i]['extension'] );	
					
		 }
	    //añadimos como parametro para enviarlo al modelo
	    $this->objParam->addParametro('extension',$array);

        //#4 02/01/2019	EGS
		
        $this->objFunc=$this->create('MODDocumentoWf');
        $this->res=$this->objFunc->subirDocumentoWfArchivo();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function cambiarMomento(){
        $this->objFunc=$this->create('MODDocumentoWf'); 
        $this->res=$this->objFunc->cambiarMomento($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	
	function verificarConfiguracion(){
        $this->objFunc=$this->create('MODDocumentoWf'); 
        $this->res=$this->objFunc->verificarConfiguracion($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    	function extensionDocumento(){
        $this->objFunc=$this->create('MODDocumentoWf'); 
        $this->res=$this->objFunc->extensionDocumento($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	function ReportelistarDocumento(){//#98

		$nombreArchivo = uniqid(md5(session_id()).'Egresos') . '.pdf'; 
		$dataSource = $this->recuperarDatosDocumentoWF();

		$tamano = 'LETTER';
		$orientacion = 'L';
		$titulo = 'Consolidado';
		
		
		$this->objParam->addParametro('orientacion',$orientacion);
		$this->objParam->addParametro('tamano',$tamano);		
		$this->objParam->addParametro('titulo_archivo',$titulo);        
		$this->objParam->addParametro('nombre_archivo',$nombreArchivo);

		$reporte = new RListaDocumentos($this->objParam);  
		
		$reporte->datosHeader($dataSource->getDatos(),  $dataSource->extraData);
		
		$reporte->generarReporte();
		$reporte->output($reporte->url_archivo,'F');
		
		$this->mensajeExito=new Mensaje();
		$this->mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado','Se generó con éxito el reporte: '.$nombreArchivo,'control');
		$this->mensajeExito->setArchivoGenerado($nombreArchivo);
		$this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());


	}
	function recuperarDatosDocumentoWF(){//#98   

		$this->objParam->defecto('ordenacion','id_documento_wf');

		$this->objParam->defecto('dir_ordenacion','asc');

		
		if ($this->objParam->getParametro('anulados') == 'no') {
			$this->objParam->addFiltro("tewf.codigo not in (''anulada'',''anulado'',''cancelado'')");
		}
		
		if ($this->objParam->getParametro('modoConsulta') == 'si') {
			$this->objParam->addFiltro(" (dwf.chequeado = ''si'' or  td.action != '''') ");
		}
		
		/*if ($this->objParam->getParametro('categoria') != '') {
			$this->objParam->addFiltro("(''".$this->objParam->getParametro('categoria')."'' =ANY(td.categoria_documento) or td.categoria_documento is NULL or td.categoria_documento = ''{}'')" );
		}*/

		$this->objFunc = $this->create('MODDocumentoWf');
		$cbteHeader = $this->objFunc->ReportelistarDocumento($this->objParam);
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