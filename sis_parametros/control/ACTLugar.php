<?php
/**
*@package pXP
*@file gen-ACTLugar.php
*@author  (rac)
*@date 29-08-2011 09:19:28
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTLugar extends ACTbase{    
			
	function listarLugar(){
		$this->objParam->defecto('ordenacion','id_lugar');

		$this->objParam->defecto('dir_ordenacion','asc');
					
		$this->objFunc=new FuncionesParametros();	
		$this->res=$this->objFunc->listarLugar($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
      function listarLugarArb(){
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunc=new FuncionesParametros();	
		
		//obtiene el parametro nodo enviado por la vista
		$node=$this->objParam->getParametro('node');
		$id_lugar=$this->objParam->getParametro('id_lugar');
		
		
		if($node=='id'){
			$this->objParam->addParametro('id_padre','%');
		}
		else {
			$this->objParam->addParametro('id_padre',$id_lugar);
		}	
	
		//$this->objParam->addParametro('id_subsistema',$id_subsistema);
		$this->res=$this->objFunc->listarLugarArb($this->objParam);
		
		$this->res->setTipoRespuestaArbol();
		
		$arreglo=array();
		
		array_push($arreglo,array('nombre'=>'id','valor'=>'id_lugar'));
		array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_lugar_fk'));
		
		array_push($arreglo,array('nombre'=>'text','valor'=>'nombre'));
		array_push($arreglo,array('nombre'=>'cls','valor'=>'descripcion'));
		array_push($arreglo,array('nombre'=>'qtip','valores'=>'<b> #codigo_largo#</b><br> #nombre#'));
		
		
		//array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_lugar_Fk'));
		
	
		/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
		  es importante que entre los resultados devueltos por la base exista la variable\
		  tipo_dato que tenga el valor en texto = 'carpeta' */
	
		$this->res->addNivelArbol('tipo_nodo','raiz',array('leaf'=>false,
														'allowDelete'=>true,
														'allowEdit'=>true,
		 												'cls'=>'folder',
		 												'tipo_nodo'=>'raiz',
		 												'icon'=>'../../../lib/imagenes/a_form.png'),
		 												$arreglo);
		 
		
		
		/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
		  es importante que entre los resultados devueltos por la base exista la variable\
		  tipo_dato que tenga el valor en texto = 'hoja' */
		 														

		 $this->res->addNivelArbol('tipo_nodo','hijo',array(
														'leaf'=>false,
														'allowDelete'=>true,
														'allowEdit'=>true,
		 												'tipo_nodo'=>'hijo',
		 												'icon'=>'../../../lib/imagenes/a_form.png'),
		 												$arreglo);
			

		//Se imprime el arbol en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		

	}
	
				
	function insertarLugar(){
		$this->objFunc=new FuncionesParametros();	
		if($this->objParam->insertar('id_lugar')){
			$this->res=$this->objFunc->insertarLugar($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarLugar($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLugar(){
		$this->objFunc=new FuncionesParametros();	
		$this->res=$this->objFunc->eliminarLugar($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>