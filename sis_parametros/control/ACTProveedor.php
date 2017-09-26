<?php
/**
*@package pXP
*@file gen-ACTProveedor.php
*@author  (mzm)
*@date 15-11-2011 10:44:58
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProveedor extends ACTbase{    
			
	function listarProveedor(){
		$this->objParam->defecto('ordenacion','id_proveedor');
		$this->objParam->defecto('dir_ordenacion','asc');
		//echo $this->objParam->getParametro('id_servicio');exit;
		
		if($this->objParam->getParametro('id_servicio')!=null){
			$aux="provee.id_proveedor in (select id_proveedor from param.tproveedor_item_servicio itserv where itserv.id_servicio = ".$this->objParam->getParametro('id_servicio').")";
			$this->objParam->addFiltro($aux);
		} 
		if($this->objParam->getParametro('id_item')!=null){
			$aux="provee.id_proveedor in (select id_proveedor from param.tproveedor_item_servicio itserv where itserv.id_item = ".$this->objParam->getParametro('id_item').")";
			$this->objParam->addFiltro($aux);
		}
		
		
		
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODProveedor','listarProveedor');
		} else{
			$this->objFunc=$this->create('MODProveedor');	
			$this->res=$this->objFunc->listarProveedor();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

   function listarProveedorV2(){
		$this->objParam->defecto('ordenacion','id_proveedor');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('prov_estado')=='borrador'){
             $this->objParam->addFiltro("provee.estado in (''borrador'')");
        }
        if($this->objParam->getParametro('prov_estado')=='en_proceso'){
             $this->objParam->addFiltro("provee.estado not in (''borrador'',''aprobado'',''anulado'')");
        }
        if($this->objParam->getParametro('prov_estado')=='finalizados'){
             $this->objParam->addFiltro("provee.estado in (''aprobado'',''anulado'')");
        }
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODProveedor','listarProveedorV2');
		} else{
			$this->objFunc=$this->create('MODProveedor');	
			$this->res=$this->objFunc->listarProveedorV2();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

   function listarProveedorWf(){
		$this->objParam->defecto('ordenacion','id_proveedor');
		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]);
		
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODProveedor','listarProveedorWf');
		} else{
			$this->objFunc=$this->create('MODProveedor');	
			$this->res=$this->objFunc->listarProveedorWf();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}



	function listarProveedorCombos(){
		$this->objParam->defecto('ordenacion','id_proveedor');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODProveedor','listarProveedorCombos');
		} else{
			$this->objFunc=$this->create('MODProveedor');
			$this->res=$this->objFunc->listarProveedorCombos();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProveedor(){
		$this->objFunc=$this->create('MODProveedor');
		//print_r($this->objParam); exit;
		if($this->objParam->insertar('id_proveedor')){
			$this->res=$this->objFunc->insertarProveedor();			
		} else{			
			$this->res=$this->objFunc->modificarProveedor();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProveedor(){
		$this->objFunc=$this->create('MODProveedor');
		$this->res=$this->objFunc->eliminarProveedor();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function iniciarTramite(){
		$this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
		$this->objFunc=$this->create('MODProveedor');	
		$this->res=$this->objFunc->iniciarTramite();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function siguienteEstadoProveedor(){
        $this->objFunc=$this->create('MODProveedor');  
        $this->res=$this->objFunc->siguienteEstadoProveedor($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

   function anteriorEstadoProveedor(){
        $this->objFunc=$this->create('MODProveedor');  
        $this->res=$this->objFunc->anteriorEstadoProveedor($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
			
}

?>