<?php
/**
*@package pXP
*@file gen-ACTCentroCosto.php
*@author  (admin)
*@date 19-02-2013 22:53:59
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
class ACTCentroCosto extends ACTbase{    
			
	function listarCentroCosto(){
		$this->objParam->defecto('ordenacion','id_centro_costo');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		
		if($this->objParam->getParametro('id_gestion')!=''){
            $this->objParam->addFiltro("cec.id_gestion = ".$this->objParam->getParametro('id_gestion'));    
        }
		
		if($this->objParam->getParametro('id_partida')!=''){
	    	$this->objParam->addFiltro("cec.id_centro_costo in (select id_presupuesto from pre.tpresup_partida where id_partida = " . $this->objParam->getParametro('id_partida') . ")");	
		}		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCentroCosto','listarCentroCosto');
		} else{
			$this->objFunc=$this->create('MODCentroCosto');
			
			$this->res=$this->objFunc->listarCentroCosto($this->objParam);
		}
		
		if($this->objParam->getParametro('_adicionar')!=''){
		    
			$respuesta = $this->res->getDatos();
			
										
		    array_unshift ( $respuesta, array(  'id_centro_costo'=>'0',
		                                'codigo_cc'=>'Todos',
									    'codigo_uo'=>'Todos',
										'nombre_uo'=>'Todos',
										'ep'=>'Todos',
										'gestion'=>'Todos',
										'codigo_cc'=>'Todos',
										'nombre_programa'=>'Todos',
										'nombre_proyecto'=>'Todos',
										'nombre_actividad'=>'Todos',
										'nombre_financiador'=>'Todos',
										'nombre_regional'=>'Todos') );
		    //var_dump($respuesta);
			$this->res->setDatos($respuesta);
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
	
	
	function listarCentroCostoGrid(){
		$this->objParam->defecto('ordenacion','id_centro_costo');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		 
		if($this->objParam->getParametro('id_gestion')!=''){
            $this->objParam->addFiltro("cec.id_gestion = ".$this->objParam->getParametro('id_gestion'));    
        }
		
		if($this->objParam->getParametro('id_partida')!=''){
	    	$this->objParam->addFiltro("cec.id_centro_costo in (select id_presupuesto from pre.tpresup_partida where id_partida = " . $this->objParam->getParametro('id_partida') . ")");	
		}		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCentroCosto','listarCentroCostoGrid');
		} else{
			$this->objFunc=$this->create('MODCentroCosto');
			
			$this->res=$this->objFunc->listarCentroCostoGrid($this->objParam);
		}
		
		if($this->objParam->getParametro('_adicionar')!=''){
		    
			$respuesta = $this->res->getDatos();
			
										
		    array_unshift ( $respuesta, array(  'id_centro_costo'=>'0',
		                                'codigo_cc'=>'Todos',
									    'codigo_uo'=>'Todos',
										'nombre_uo'=>'Todos',
										'ep'=>'Todos',
										'gestion'=>'Todos',
										'codigo_cc'=>'Todos',
										'nombre_programa'=>'Todos',
										'nombre_proyecto'=>'Todos',
										'nombre_actividad'=>'Todos',
										'nombre_financiador'=>'Todos',
										'nombre_regional'=>'Todos') );
		    //var_dump($respuesta);
			$this->res->setDatos($respuesta);
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
	function listarCentroCostoCombo(){
		$this->objParam->defecto('ordenacion','id_centro_costo');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		
		if($this->objParam->getParametro('id_gestion')!=''){
            $this->objParam->addFiltro("cec.id_gestion = ".$this->objParam->getParametro('id_gestion'));    
        }
        
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCentroCosto','listarCentroCostoCombo');
		} else{
			$this->objFunc=$this->create('MODCentroCosto');
			
			$this->res=$this->objFunc->listarCentroCostoCombo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarCentroCostoFiltradoXUsuaio(){
        $this->objParam->defecto('ordenacion','id_centro_costo');
		
		if($this->objParam->getParametro('tipo_pres') == 'gasto'){
				$tip_pres = "(''2'',''3'')"; 
				$this->objParam->addFiltro("cec.tipo_pres in  ".$tip_pres);   
		}
		
		if($this->objParam->getParametro('tipo_pres') == 'recurso'){
				$tip_pres = "(''1'')"; 
				$this->objParam->addFiltro("cec.tipo_pres in  ".$tip_pres);   
		}
		
		if($this->objParam->getParametro('tipo_pres') == 'recurso,administrativo'){
				$tip_pres = "(''1'',''0'')"; 
				$this->objParam->addFiltro("cec.tipo_pres in  ".$tip_pres);   
		    }
		
		if($this->objParam->getParametro('tipo_pres') == 'gasto,administrativo'){				
				$tip_pres = "(''0'',''2'',''3'')"; 
				$this->objParam->addFiltro("cec.tipo_pres in ".$tip_pres);   
		}

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('id_gestion')!=''){
            $this->objParam->addFiltro("cec.id_gestion = ".$this->objParam->getParametro('id_gestion'));    
        }
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODCentroCosto','listarCentroCostoFiltradoXUsuaio');
        } else{
            $this->objFunc=$this->create('MODCentroCosto');
            
            $this->res=$this->objFunc->listarCentroCostoFiltradoXUsuaio($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function listarCentroCostoFiltradoXDepto(){
        $this->objParam->defecto('ordenacion','id_centro_costo');

        $this->objParam->defecto('dir_ordenacion','asc');
		
		
		if($this->objParam->getParametro('tipo_pres')!=''){
			if($this->objParam->getParametro('tipo_pres') == 'gasto'){
				$tip_pres = "(''2'',''3'')"; 
				$this->objParam->addFiltro("cec.tipo_pres in ".$tip_pres);   
			}
			
			if($this->objParam->getParametro('tipo_pres') == 'recurso'){
				$tip_pres = "(''1'')"; 
				$this->objParam->addFiltro("cec.tipo_pres in  ".$tip_pres);   
		    }
			
			if($this->objParam->getParametro('tipo_pres') == 'recurso,administrativo'){
				$tip_pres = "(''1'',''0'')"; 
				$this->objParam->addFiltro("cec.tipo_pres in  ".$tip_pres);   
		    }
			
			if($this->objParam->getParametro('tipo_pres') == 'administrativo'){				
				$tip_pres = "(''0'')"; 
				$this->objParam->addFiltro("cec.tipo_pres in ".$tip_pres);   
			}
			
			if($this->objParam->getParametro('tipo_pres') == 'gasto,administrativo'){				
				$tip_pres = "(''0'',''2'',''3'')"; 
				$this->objParam->addFiltro("cec.tipo_pres in ".$tip_pres);   
			}
            
        }

        if($this->objParam->getParametro('id_uo')!=''){
            $this->objParam->addFiltro("cec.id_uo = ".$this->objParam->getParametro('id_uo'));    
        }
		
        if($this->objParam->getParametro('id_gestion')!=''){
            $this->objParam->addFiltro("cec.id_gestion = ".$this->objParam->getParametro('id_gestion'));    
        }
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODCentroCosto','listarCentroCostoFiltradoXDepto');
        } else{
            $this->objFunc=$this->create('MODCentroCosto');
            
            $this->res=$this->objFunc->listarCentroCostoFiltradoXDepto($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
				
	function insertarCentroCosto(){
		$this->objFunc=$this->create('MODCentroCosto');	
		if($this->objParam->insertar('id_centro_costo')){
			$this->res=$this->objFunc->insertarCentroCosto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCentroCosto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCentroCosto(){
			$this->objFunc=$this->create('MODCentroCosto');	
		$this->res=$this->objFunc->eliminarCentroCosto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarCentroCostoProyecto(){
        $this->objParam->defecto('ordenacion','id_centro_costo');
        $this->objParam->defecto('dir_ordenacion','asc');

        if($this->objParam->getParametro('id_proyecto')!=''){
            $this->objParam->addFiltro("py.id_proyecto = ".$this->objParam->getParametro('id_proyecto'));    
        }

        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODCentroCosto','listarCentroCostoProyecto');
        } else{
            $this->objFunc=$this->create('MODCentroCosto');
            $this->res=$this->objFunc->listarCentroCostoProyecto($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
			
}
?>