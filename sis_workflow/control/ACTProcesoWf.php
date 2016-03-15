<?php
/**
*@package pXP
*@file gen-ACTProcesoWf.php
*@author  (admin)
*@date 18-04-2013 09:01:51
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
require_once(dirname(__FILE__).'/../reportes/DiagramadorGanttWF.php');
require_once(dirname(__FILE__).'/../reportes/RNumeroTramite.php');
require_once(dirname(__FILE__).'/../../pxpReport/DataSource.php');

class ACTProcesoWf extends ACTbase{    
			
	function listarProcesoWf(){
		$this->objParam->defecto('ordenacion','id_proceso_wf');

		$this->objParam->defecto('dir_ordenacion','asc');
		 
		 if($this->objParam->getParametro('id_proceso_macro')!=''){
            $this->objParam->addFiltro("pm.id_proceso_macro = ".$this->objParam->getParametro('id_proceso_macro'));    
        }
		
		 $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODProcesoWf','listarProcesoWf');
		} else{
			$this->objFunc=$this->create('MODProcesoWf');
			
			$this->res=$this->objFunc->listarProcesoWf($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarProcesoWfMobile(){
        $this->objParam->defecto('ordenacion','id_proceso_wf');

        $this->objParam->defecto('dir_ordenacion','asc');
         
         if($this->objParam->getParametro('id_proceso_macro')!=''){
            $this->objParam->addFiltro("pm.id_proceso_macro = ".$this->objParam->getParametro('id_proceso_macro'));    
        }
        
         $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODProcesoWf','listarProcesoWfMobile');
        } else{
            $this->objFunc=$this->create('MODProcesoWf');
            
            $this->res=$this->objFunc->listarProcesoWfMobile($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
        
				
	function insertarProcesoWf(){
	    $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
		$this->objFunc=$this->create('MODProcesoWf');	
		
		
		
		if($this->objParam->insertar('id_proceso_wf')){
			$this->res=$this->objFunc->insertarProcesoWf($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProcesoWf($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProcesoWf(){
			$this->objFunc=$this->create('MODProcesoWf');	
		$this->res=$this->objFunc->eliminarProcesoWf($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function chequeaEstadosMobile(){
	    $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->objFunc=$this->create('MODProcesoWf');
        $this->res=$this->objFunc->chequeaEstadosMobile($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	
	function siguienteEstadoProcesoWf(){
        $this->objFunc=$this->create('MODProcesoWf');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->siguienteEstadoProcesoWf($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function siguienteEstadoProcesoWfMobile(){
        $this->objFunc=$this->create('MODProcesoWf');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->siguienteEstadoProcesoWfMobile($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function verficarSigEstProcesoWf(){
        $this->objFunc=$this->create('MODProcesoWf');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->verficarSigEstProcesoWf($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function checkNextState(){
        $this->objFunc=$this->create('MODProcesoWf');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->checkNextState($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
      
    function evaluaPlantillaEstado(){
        $this->objFunc=$this->create('MODProcesoWf');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->evaluaPlantillaEstado($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    
    
    function anteriorEstadoProcesoWf(){
        $this->objFunc=$this->create('MODProcesoWf');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->anteriorEstadoProcesoWf($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	
	function listarGantWf(){
		$this->objParam->defecto('ordenacion','id_proceso_wf');
        $this->objParam->defecto('dir_ordenacion','asc');
		 
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODProcesoWf','listarGantWf');
		} else{
			$this->objFunc=$this->create('MODProcesoWf');
			
			$this->res=$this->objFunc->listarGantWf($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    
	function diagramaGanttTramite(){
					
				$dataSource = new DataSource();
			    //$idSolicitud = $this->objParam->getParametro('nro_tramite');
			    //$this->objParam->addParametroConsulta('id_plan_mant',$idPlanMant);
			    $this->objParam->addParametroConsulta('ordenacion','nro_tramite');
			    $this->objParam->addParametroConsulta('dir_ordenacion','ASC');
			    $this->objParam->addParametroConsulta('cantidad',1000);
			    $this->objParam->addParametroConsulta('puntero',0);
			    
			    $this->objFunc = $this->create('MODProcesoWf');
				
			    
			    $resultSolicitud = $this->objFunc->listarGantWf();
			    
			    if($resultSolicitud->getTipo()=='EXITO'){
			    
        			    $datosSolicitud = $resultSolicitud->getDatos();
        			    $dataSource->setDataset($datosSolicitud);
        			  	
        			    $nombreArchivo='diagramaGanttTramite.png';
        			    
        			    $diagramador = new DiagramadorGanttWF();
        				$diagramador->setDataSource($dataSource);
						//var_dump($dataSource); exit;
        				$diagramador->graficar($nombreArchivo);
        							
        			    $mensajeExito = new Mensaje();
        			    
        			    $mensajeExito->setMensaje('EXITO','DiagramaGanttTramite.php','Diagrama Gantt de tramite generado',
        			                                    'Se generó con éxito el diagrama para: '.$nombreArchivo,'control');
        			    
        			    $mensajeExito->setArchivoGenerado($nombreArchivo);
        			    $this->res = $mensajeExito;
        			    $this->res->imprimirRespuesta($this->res->generarJson());
			    
                }
                else{
                        
                     $resultSolicitud->imprimirRespuesta($resultSolicitud->generarJson());
                
				} 
		}
 
    function reclamarCaso(){
        $this->objFunc=$this->create('MODProcesoWf');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->reclamarCaso($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	function imprimirNumeroTramite() {
		$nombreArchivo=uniqid(md5(session_id()).'numero_tramite') . '.pdf';
		
		$url_archivo = dirname(__FILE__) . "/../../../reportes_generados/".$nombreArchivo;		
		//Instancia la clase de excel
		$this->objReporteFormato=new RNumeroTramite($this->objParam);		
		$this->objReporteFormato->generarReporte();
		$this->objReporteFormato->output($url_archivo,'F');
		$this->mensajeExito=new Mensaje();
		$this->mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado',
										'Se generó con éxito el reporte: '.$nombreArchivo,'control');
		$this->mensajeExito->setArchivoGenerado($nombreArchivo);
		$this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());
	}
	
	
	
	
	function diagramaGanttTramite_kendo(){
					
				$dataSource = new DataSource();
			    //$idSolicitud = $this->objParam->getParametro('nro_tramite');
			    //$this->objParam->addParametroConsulta('id_plan_mant',$idPlanMant);
			    $this->objParam->addParametroConsulta('ordenacion','nro_tramite');
			    $this->objParam->addParametroConsulta('dir_ordenacion','ASC');
			    $this->objParam->addParametroConsulta('cantidad',1000);
			    $this->objParam->addParametroConsulta('puntero',0);
			    
			    $this->objFunc = $this->create('MODProcesoWf');
				
				
			    
			    $resultSolicitud = $this->objFunc->listarGantWf();
				
				
			    
                        
               $resultSolicitud->imprimirRespuesta($resultSolicitud->generarJson());
                
		}
			
}

?>