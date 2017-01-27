<?php
/**
*@package pXP
*@file gen-ACTCargo.php
*@author  (admin)
*@date 14-01-2014 19:16:06
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCargo extends ACTbase{    
			
	function listarCargo(){
		$this->objParam->defecto('ordenacion','id_cargo');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('id_uo') != '') {
			$this->objParam->addFiltro("cargo.id_uo = ". $this->objParam->getParametro('id_uo'));
		}		
				
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCargo','listarCargo');
		} else{
			$this->objFunc=$this->create('MODCargo');
			
			$this->res=$this->objFunc->listarCargo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

    function listarCargoAcefalo(){

        //el objeto objParam contiene todas la variables recibidad desde la interfaz

        // parametros de ordenacion por defecto
        $this->objParam->defecto('ordenacion','c.nombre');
        $this->objParam->defecto('dir_ordenacion','asc');


        //si aplicar filtro de usuario, fitlramos el listado segun el tipod e contrato
        if($this->objParam->getParametro('tipo_contrato') =='planta'){
            $this->objParam->addFiltro("tc.codigo = ''PLA''");
        }

        //si aplicar filtro de usuario, fitlramos el listado segun el tipod e contrato
        if($this->objParam->getParametro('tipo_contrato') =='eventual'){
            $this->objParam->addFiltro("tc.codigo = ''EVE''");
        }

        //si aplicar filtro de id_uo gerencia aplicamos el filtro
        if($this->objParam->getParametro('id_gerencia') !=''){
            $this->objParam->addFiltro("ger.id_uo = ''" . $this->objParam->getParametro('id_gerencia') . "''");
        }


        //si aplicar filtro de usuario, fitlramos el listado segun el nombre del cargo
        if($this->objParam->getParametro('cargo')!=''){
            $cargo = trim($this->objParam->getParametro('cargo'));
            $cargo = str_replace(' ', '%', $cargo);
            $this->objParam->addFiltro("lower(c.nombre) like lower(''%" .  $cargo ."%'')");
        }

        //crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
        if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte=new Reporte($this->objParam, $this);
            $this->res=$this->objReporte->generarReporteListado('MODCargo','listarCargoAcefalo');
        }
        else {
            $this->objFunSeguridad=$this->create('MODCargo');
            //ejecuta el metodo de lista funcionarios a travez de la intefaz objetoFunSeguridad
            $this->res=$this->objFunSeguridad->listarCargoAcefalo($this->objParam);

        }

        //imprime respuesta en formato JSON para enviar lo a la interface (vista)
        $this->res->imprimirRespuesta($this->res->generarJson());



    }
				
	function insertarCargo(){
		$this->objFunc=$this->create('MODCargo');	
		if($this->objParam->insertar('id_cargo')){
			$this->res=$this->objFunc->insertarCargo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCargo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCargo(){
			$this->objFunc=$this->create('MODCargo');	
		$this->res=$this->objFunc->eliminarCargo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>