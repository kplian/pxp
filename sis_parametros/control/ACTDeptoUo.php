<?php
/**
*@package pXP
*@file gen-ACTDeptoUo.php
*@author  (m)
*@date 19-10-2011 12:59:45
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

#HISTORIAL DE MODIFICACIONES:
#ISSUE          FECHA        AUTOR        DESCRIPCION
#187      		29/07/2020  manu       actualizacion de version php
*/

class ACTDeptoUo extends ACTbase{    
			
	function listarDeptoUo(){
		$this->objParam->defecto('ordenacion','id_depto_uo');

		$this->objParam->defecto('dir_ordenacion','asc');
					
		$this->objFunc=$this->create('MODDeptoUo');	
		$id_depto=$this->objParam->getParametro('id_depto');
		#187
		if($id_depto!= null && $id_depto!='undefined' && $id_depto!='' && strlen($id_depto)>0){
		   $this->objParam->addParametro('id_depto',$id_depto);
		}		
		$this->res=$this->objFunc->listarDeptoUo();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDeptoUo(){
		$this->objFunc=$this->create('MODDeptoUo');	
		if($this->objParam->insertar('id_depto_uo')){
			$this->res=$this->objFunc->insertarDeptoUo();			
		} else{			
			$this->res=$this->objFunc->modificarDeptoUo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDeptoUo(){
		$this->objFunc=$this->create('MODDeptoUo');	
		$this->res=$this->objFunc->eliminarDeptoUo();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>