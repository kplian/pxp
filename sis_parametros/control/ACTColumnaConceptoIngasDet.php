<?php
/**
*@package pXP
*@file gen-ACTColumnaConceptoIngasDet.php
*@author  (egutierrez)
*@date 06-09-2019 13:01:53
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTColumnaConceptoIngasDet extends ACTbase{    
			
	function listarColumnaConceptoIngasDet(){
		$this->objParam->defecto('ordenacion','id_columna_concepto_ingas_det');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODColumnaConceptoIngasDet','listarColumnaConceptoIngasDet');
		} else{
			$this->objFunc=$this->create('MODColumnaConceptoIngasDet');
			
			$this->res=$this->objFunc->listarColumnaConceptoIngasDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarColumnaConceptoIngasDet(){
		$this->objFunc=$this->create('MODColumnaConceptoIngasDet');	
		if($this->objParam->insertar('id_columna_concepto_ingas_det')){
			$this->res=$this->objFunc->insertarColumnaConceptoIngasDet($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarColumnaConceptoIngasDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarColumnaConceptoIngasDet(){
			$this->objFunc=$this->create('MODColumnaConceptoIngasDet');	
		$this->res=$this->objFunc->eliminarColumnaConceptoIngasDet($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarColumnaConceptoIngasDetCombo(){
		$this->objParam->defecto('ordenacion','id_columna_concepto_ingas_det');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('columna')!='') {
			
            $filtro_defecto=$this->objParam->parametros_consulta['filtro'];
			$this->objParam->parametros_consulta['ordenacion']='nombre_columna';				
            $this->objParam->addFiltro("col.nombre_columna =''".$this->objParam->getParametro('columna')."''");
			      
			//var_dump('$this->objParam',$this->objParam);
			
			$this->objFunc=$this->create('MODColumna');
	        $this->res=$this->objFunc->listarColumna($this->objParam);
	        $datos = $this->res->datos;
			
			//var_dump('$datos',$datos[0]['id_columna']);
			
			$this->objParam->parametros_consulta['filtro']=$filtro_defecto;
			$this->objParam->parametros_consulta['ordenacion']='valor';
			$this->objParam->addFiltro("colcigd.id_columna =''".$datos[0]['id_columna']."''");
		}
		

		$this->objFunc=$this->create('MODColumnaConceptoIngasDet');
			
		$this->res=$this->objFunc->listarColumnaConceptoIngasDetCombo($this->objParam);

		$this->res->imprimirRespuesta($this->res->generarJson());
	}
		
			
}

?>