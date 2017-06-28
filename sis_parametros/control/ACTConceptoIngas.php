<?php
/**
*@package pXP
*@file gen-ACTConceptoIngas.php
*@author  (admin)
*@date 25-02-2013 19:49:23
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTConceptoIngas extends ACTbase{    
			
	function listarConceptoIngas(){
		$this->objParam->defecto('ordenacion','id_concepto_ingas');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		
        if($this->objParam->getParametro('tipo')!=''){
                    
                 if($this->objParam->getParametro('tipo')=='Bien'){
                   $this->objParam->addFiltro("conig.tipo =''Bien''");    
                 }
                 if($this->objParam->getParametro('tipo')=='Servicio'){
                   $this->objParam->addFiltro("conig.tipo =''Servicio''");    
                 }
        }
        
         if($this->objParam->getParametro('movimiento')!=''){
              $this->objParam->addFiltro("conig.movimiento =''".$this->objParam->getParametro('movimiento')."''");    
         }
		 
		 if($this->objParam->getParametro('id_entidad')!=''){
              $this->objParam->addFiltro("conig.id_entidad =".$this->objParam->getParametro('id_entidad'));    
         }
         
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODConceptoIngas','listarConceptoIngas');
		} else{
			$this->objFunc=$this->create('MODConceptoIngas');
			
			$this->res=$this->objFunc->listarConceptoIngas($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

    function listarConceptoIngasPartidaGestion(){
        $this->objParam->defecto('ordenacion','id_concepto_ingas');
        $this->objParam->defecto('dir_ordenacion','asc');

        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODConceptoIngas','listarConceptoIngasPartidaGestion');
        } else{
            $this->objFunc=$this->create('MODConceptoIngas');
            $this->res=$this->objFunc->listarConceptoIngasPartidaGestion($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	
	
	function listarConceptoIngasMasPartida(){
         $this->objParam->defecto('ordenacion','id_concepto_ingas');
         $this->objParam->defecto('dir_ordenacion','asc');
        
        
         if($this->objParam->getParametro('tipo')!=''){
                    
                 if($this->objParam->getParametro('tipo')=='Bien'){
                   $this->objParam->addFiltro("conig.tipo =''Bien''");    
                 }
                 if($this->objParam->getParametro('tipo')=='Servicio'){
                   $this->objParam->addFiltro("conig.tipo =''Servicio''");    
                 }
         }
        
         if($this->objParam->getParametro('movimiento')!=''){
         	  if(  $this->objParam->getParametro('movimiento') == 'ingreso_egreso'){
         	  	$this->objParam->addFiltro("conig.movimiento in (''ingreso'',''gasto'')");    
         	  }
			  else{
			  	$this->objParam->addFiltro("conig.movimiento =''".$this->objParam->getParametro('movimiento')."''");    
			  }
              
         }
         
         if($this->objParam->getParametro('id_gestion')!=''){
              $this->objParam->addFiltro("par.id_gestion =".$this->objParam->getParametro('id_gestion'));    
         }
		 
		 if($this->objParam->getParametro('requiere_ot')!=''){
              $this->objParam->addFiltro("conig.requiere_ot =''".$this->objParam->getParametro('requiere_ot')."''");    
         }
		 
		 if($this->objParam->getParametro('id_concepto_ingas')!=''){
              $this->objParam->addFiltro("conig.id_concepto_ingas =''".$this->objParam->getParametro('id_concepto_ingas')."''");    
         }
         
        
        
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODConceptoIngas','listarConceptoIngasMasPartida');
        } else{
            $this->objFunc=$this->create('MODConceptoIngas');
            
            $this->res=$this->objFunc->listarConceptoIngasMasPartida($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listarConceptoIngasPresupuesto(){
         $this->objParam->defecto('ordenacion','id_concepto_ingas');
         $this->objParam->defecto('dir_ordenacion','asc');
        
        
         if($this->objParam->getParametro('tipo')!=''){
                    
                 if($this->objParam->getParametro('tipo')=='Bien'){
                   $this->objParam->addFiltro("conig.tipo =''Bien''");    
                 }
                 if($this->objParam->getParametro('tipo')=='Servicio'){
                   $this->objParam->addFiltro("conig.tipo =''Servicio''");    
                 }
         }
        
         if($this->objParam->getParametro('movimiento')!=''){
              $this->objParam->addFiltro("conig.movimiento =''".$this->objParam->getParametro('movimiento')."''");    
         }
         
         if($this->objParam->getParametro('id_gestion')!=''){
              $this->objParam->addFiltro("par.id_gestion =".$this->objParam->getParametro('id_gestion'));    
         }
		 
		 if($this->objParam->getParametro('requiere_ot')!=''){
              $this->objParam->addFiltro("conig.requiere_ot =''".$this->objParam->getParametro('requiere_ot')."''");    
         }
		 
		 if($this->objParam->getParametro('id_concepto_ingas')!=''){
              $this->objParam->addFiltro("conig.id_concepto_ingas =''".$this->objParam->getParametro('id_concepto_ingas')."''");    
         }
         
        
        
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODConceptoIngas','listarConceptoIngasPresupuesto');
        } else{
            $this->objFunc=$this->create('MODConceptoIngas');
            
            $this->res=$this->objFunc->listarConceptoIngasPresupuesto($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

	
	
	function listarConceptoIngasPorPartidas(){
        $this->objParam->defecto('ordenacion','id_concepto_ingas');
        $this->objParam->defecto('dir_ordenacion','asc');
        
        
        if($this->objParam->getParametro('tipo')!=''){
                    
                 if($this->objParam->getParametro('tipo')=='Bien'){
                   $this->objParam->addFiltro("conig.tipo =''Bien''");    
                 }
                 if($this->objParam->getParametro('tipo')=='Servicio'){
                   $this->objParam->addFiltro("conig.tipo =''Servicio''");    
                 }
        }
        
         if($this->objParam->getParametro('movimiento')!=''){
              $this->objParam->addFiltro("conig.movimiento =''".$this->objParam->getParametro('movimiento')."''");    
         }
        
       
         
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODConceptoIngas','listarConceptoIngasPorPartidas');
        } else{
            $this->objFunc=$this->create('MODConceptoIngas');
            
            $this->res=$this->objFunc->listarConceptoIngasPorPartidas($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
				
	function insertarConceptoIngas(){
		$this->objFunc=$this->create('MODConceptoIngas');	
		if($this->objParam->insertar('id_concepto_ingas')){
			$this->res=$this->objFunc->insertarConceptoIngas($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarConceptoIngas($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarConceptoIngas(){
		$this->objFunc=$this->create('MODConceptoIngas');	
		$this->res=$this->objFunc->eliminarConceptoIngas($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function editOt(){
		$this->objFunc=$this->create('MODConceptoIngas');	
		$this->res=$this->objFunc->editOt($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function editAuto(){
		$this->objFunc=$this->create('MODConceptoIngas');	
		$this->res=$this->objFunc->editAuto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function subirImagen(){
		$this->objFunSeguridad=$this->create('MODConceptoIngas');	
		$this->res=$this->objFunSeguridad->subirImagen($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
		
	
	
			
}

?>