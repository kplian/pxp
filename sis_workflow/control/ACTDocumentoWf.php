<?php
/**
*@package pXP
*@file gen-ACTDocumentoWf.php
*@author  (admin)
*@date 15-01-2014 13:52:19
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

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
    
    
			
}

?>