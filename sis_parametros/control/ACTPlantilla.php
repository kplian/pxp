<?php
/**
*@package pXP
*@file ACTPlantilla.php
*@author  Gonzalo Sarmiento Sejas
*@date 01-04-2013 19:57:55
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPlantilla extends ACTbase{    
			
	function listarPlantilla(){
		$this->objParam->defecto('ordenacion','id_plantilla');
        $this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('sw_compro')!=''){
            $this->objParam->addFiltro("sw_compro = ''".$this->objParam->getParametro('sw_compro')."''");  
        }
        
        if($this->objParam->getParametro('sw_tesoro')!=''){
            $this->objParam->addFiltro("sw_tesoro = ''".$this->objParam->getParametro('sw_tesoro')."''");  
        }
        
        if($this->objParam->getParametro('sw_monto_excento')!=''){
            $this->objParam->addFiltro("sw_monto_excento = ''".$this->objParam->getParametro('sw_monto_excento')."''");  
        }
        
        if($this->objParam->getParametro('id_plantilla')!=''){
            $this->objParam->addFiltro("id_plantilla=".$this->objParam->getParametro('id_plantilla'));  
        }
		
		if($this->objParam->getParametro('tipo_plantilla')!=''){
            $this->objParam->addFiltro("plt.tipo_plantilla=''".$this->objParam->getParametro('tipo_plantilla')."''");  
        }

        if($this->objParam->getParametro('filtrar')!=''){
            $this->objParam->addFiltro("plt.filtrar=''".$this->objParam->getParametro('filtrar')."''");  
        }
        
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPlantilla','listarPlantilla');
		} else{
			$this->objFunc=$this->create('MODPlantilla');
			
			$this->res=$this->objFunc->listarPlantilla($this->objParam);
		}

		if($this->objParam->getParametro('_adicionar')!=''){

			$respuesta = $this->res->getDatos();


			array_unshift ( $respuesta, array(
					'id_plantilla'=>'0',
					'estado_reg'=>'Todos',
					'desc_plantilla'=>'Todos',
					'sw_tesoro'=>'Todos',
					'sw_compro'=>'Todos',
					'nro_linea'=>'Todos',
					'fecha_reg'=>'Todos',
					'sw_descuento'=>'Todos',
					'tipo_plantilla'=>'Todos',
					'sw_nro_dui'=>'Todos') );
			//var_dump($respuesta);
			$this->res->setDatos($respuesta);
		}

		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPlantilla(){
		$this->objFunc=$this->create('MODPlantilla');	
		if($this->objParam->insertar('id_plantilla')){
			$this->res=$this->objFunc->insertarPlantilla($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPlantilla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPlantilla(){
			$this->objFunc=$this->create('MODPlantilla');	
		$this->res=$this->objFunc->eliminarPlantilla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>