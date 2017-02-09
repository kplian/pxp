<?php
/**
*@package pXP
*@file gen-ACTDashboard.php
*@author  (admin)
*@date 10-09-2016 11:29:58
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDashboard extends ACTbase{    
			
	function listarDashboard(){
		$this->objParam->defecto('ordenacion','id_dashboard');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		
		
		$this->objFunc=$this->create('MODDashboard');
		$this->res=$this->objFunc->listarDashboard($this->objParam);
		$this->res->setTipoRespuestaArbol();
		
		
		$arreglo=array();
		//array_push($arreglo,array('nombre'=>'id','valor'=>'id_gui'));
		array_push($arreglo,array('nombre'=>'id','valor'=>'id_nodo'));
		
		array_push($arreglo,array('nombre'=>'text','valor'=>'nombre'));
		array_push($arreglo,array('nombre'=>'ruta','valor'=>'ruta_archivo'));
		array_push($arreglo,array('nombre'=>'clase','valor'=>'clase'));
		
		$this->res->addNivelArbol('tipo_dato','carpeta',array('leaf'=>true,
														'allowDelete'=>true,
														'allowEdit'=>true,
														'tipo'=>'interface',
		 												'icon'=>'../../../lib/imagenes/a_form.png'),
		 												$arreglo);
														
		//Se imprime el arbol en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDashboard(){
		$this->objFunc=$this->create('MODDashboard');	
		if($this->objParam->insertar('id_dashboard')){
			$this->res=$this->objFunc->insertarDashboard($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDashboard($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDashboard(){
			$this->objFunc=$this->create('MODDashboard');	
		$this->res=$this->objFunc->eliminarDashboard($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>