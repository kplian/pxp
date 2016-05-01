<?php
/**
*@package pXP
*@file gen-ACTTabla.php
*@author  (admin)
*@date 07-05-2014 21:39:40
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTabla extends ACTbase{
	
	
	function listarTablaCombo(){
		//obtiene la posicion de la tabla instanciada
		$_SESSION['_wf_ins_'.$this->objParam->getParametro('tipo_proceso').'_'.$this->objParam->getParametro('tipo_estado')] = $this->obtenerTablaInstancia();
		$id_maestro = $_SESSION['_wf_ins_'.$this->objParam->getParametro('tipo_proceso').'_'.$this->objParam->getParametro('tipo_estado')]['atributos']['vista_campo_maestro'];
		$codigo_tabla = $_SESSION['_wf_ins_'.$this->objParam->getParametro('tipo_proceso').'_'.$this->objParam->getParametro('tipo_estado')]['atributos']['bd_codigo_tabla'];
		
		//si existe como parametro el id del maestro se anade el filtro
		if ($this->objParam->getParametro($id_maestro) != '') {			
			$this->objParam->addFiltro($codigo_tabla . "." . $id_maestro  . " = ". $this->objParam->getParametro($id_maestro));
		}
		
		if ($this->objParam->getParametro('filtro_directo') != '') {			
			$this->objParam->addFiltro($this->objParam->getParametro('filtro_directo'));
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTabla','listarTablaCombo');
		} else{
			$this->objFunc=$this->create('MODTabla');			
			$this->res=$this->objFunc->listarTablaCombo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}    
			
	function listarTablaInstancia(){
		//obtiene la posicion de la tabla instanciada
		$_SESSION['_wf_ins_'.$this->objParam->getParametro('tipo_proceso').'_'.$this->objParam->getParametro('tipo_estado')] = $this->obtenerTablaInstancia();
		$id_maestro = $_SESSION['_wf_ins_'.$this->objParam->getParametro('tipo_proceso').'_'.$this->objParam->getParametro('tipo_estado')]['atributos']['vista_campo_maestro'];
		$codigo_tabla = $_SESSION['_wf_ins_'.$this->objParam->getParametro('tipo_proceso').'_'.$this->objParam->getParametro('tipo_estado')]['atributos']['bd_codigo_tabla'];
		
		//si existe como parametro el id del maestro se anade el filtro
		if ($this->objParam->getParametro($id_maestro) != '') {			
			$this->objParam->addFiltro($codigo_tabla . "." . $id_maestro  . " = ". $this->objParam->getParametro($id_maestro));
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTabla','listarTablaInstancia');
		} else{
			$this->objFunc=$this->create('MODTabla');			
			$this->res=$this->objFunc->listarTablaInstancia($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function insertarTablaInstancia(){
		$this->objFunc=$this->create('MODTabla');	
		//obtiene la posicion de la tabla instanciada
		$_SESSION['_wf_ins_'.$this->objParam->getParametro('tipo_proceso').'_'.$this->objParam->getParametro('tipo_estado')] = $this->obtenerTablaInstancia();
		
		if($this->objParam->insertar('id_' . $_SESSION['_wf_ins_'.$this->objParam->getParametro('tipo_proceso').'_'.$this->objParam->getParametro('tipo_estado')]['atributos']['bd_nombre_tabla'])){
			$this->res=$this->objFunc->insertarTablaInstancia($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTablaInstancia($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function eliminarTablaInstancia(){
		$this->objFunc=$this->create('MODTabla');
		$aux = $this->objParam->getParametro('0');			
		
		$_SESSION['_wf_ins_'.$aux['tipo_proceso'].'_'.$aux['tipo_estado']] = $this->obtenerTablaInstancia();
			
		
		$this->res=$this->objFunc->eliminarTablaInstancia($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarTabla(){
		$this->objParam->defecto('ordenacion','id_tabla');

		$this->objParam->defecto('dir_ordenacion','asc');
		if ($this->objParam->getParametro('id_tipo_proceso') != '') {
			$this->objParam->addFiltro("TABLA.id_tipo_proceso = ". $this->objParam->getParametro('id_tipo_proceso'));
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTabla','listarTabla');
		} else{
			$this->objFunc=$this->create('MODTabla');
			
			$this->res=$this->objFunc->listarTabla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTabla(){
		$this->objFunc=$this->create('MODTabla');	
		if($this->objParam->insertar('id_tabla')){
			$this->res=$this->objFunc->insertarTabla($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTabla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function ejecutarScriptTabla(){
		$this->objFunc=$this->create('MODTabla');	
				
		$this->res=$this->objFunc->ejecutarScriptTabla($this->objParam);
		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTabla(){
		$this->objFunc=$this->create('MODTabla');	
		$this->res=$this->objFunc->eliminarTabla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function cargarDatosTablaProceso(){
		$this->objParam->defecto('ordenacion','id_tabla');

		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->addFiltro("tp.codigo = ''". $this->objParam->getParametro('tipo_proceso')."''");
		$this->objParam->addFiltro("TABLA.vista_id_tabla_maestro is null");
		
		
		$this->objFunc=$this->create('MODTabla');
			
		$this->res=$this->objFunc->cargarDatosTablaProceso();
		//var_dump($this->res->getDatos());exit;
		$_SESSION['_wf_'.$this->objParam->getParametro('tipo_proceso').'_'.$this->objParam->getParametro('tipo_estado')] = $this->res->getDatos();
		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function obtenerTablaInstancia ($prof=array()) {
		if ($this->objParam->esMatriz()) {
			$aux = $this->objParam->getParametro('0');
			$cadena = '$_SESSION["_wf_' . $aux['tipo_proceso'] . "_" . $aux['tipo_estado'] . '"][0]';			
			$id_tabla = $aux['id_tabla'];
		} else {
			$cadena = '$_SESSION["_wf_' . $this->objParam->getParametro('tipo_proceso') . "_" . $this->objParam->getParametro('tipo_estado') . '"][0]';
			$id_tabla = $this->objParam->getParametro('id_tabla');
		}
		
		$res = 0 ;

		foreach ($prof as $value) {
			$cadena .=  "[detalles][$value]";
		}
		eval('$variable = '. $cadena . ';');		
						
		if ($variable['atributos']['id_tabla'] == $id_tabla) {
		    //echo 'FUCK';
		    //var_dump($variable);exit;
			return $variable;
		} else {
			for ($i = 0; $i < count($variable['detalles']);$i++ ) {
				array_push($prof,$i);
				$res = $this->obtenerTablaInstancia($prof);
				if ($res != 0) {
					return $res;
				}
			}
			return 0;
		}
	}			
}

?>