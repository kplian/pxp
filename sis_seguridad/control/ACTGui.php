<?php
/***
 Nombre: ACTGui.php
 Proposito: Metodos para la manipulacion de interfaces 
 Autor:	Kplian (RAC)
 Fecha:	19/07/2010
 */
class ACTGui extends ACTbase{    

   /*
    * Listar GUI
    * 
    * */
	function listarGui(){
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		
		//obtiene el parametro nodo enviado por la vista
		$node=$this->objParam->getParametro('node');
		$id_gui=$this->objParam->getParametro('id_gui');
		$id_subsistema=$this->objParam->getParametro('id_subsistema');
		
		if($node=='id'){
			$this->objParam->addParametro('id_padre','%');
		}
		else {
			$this->objParam->addParametro('id_padre',$id_gui);
		}	
	
		$this->objParam->addParametro('id_subsistema',$id_subsistema);
		$this->res=$this->objFunSeguridad->listarGui($this->objParam);
		
		$this->res->setTipoRespuestaArbol();
		
		$arreglo=array();
		//array_push($arreglo,array('nombre'=>'id','valor'=>'id_gui'));
		array_push($arreglo,array('nombre'=>'id','valor'=>'id_nodo'));
		
		array_push($arreglo,array('nombre'=>'text','valor'=>'nombre'));
		array_push($arreglo,array('nombre'=>'ruta','valor'=>'ruta_archivo'));
		array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_gui_padre'));
		
		
		
	
	
		/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
		  es importante que entre los resultados devueltos por la base exista la variable\
		  tipo_dato que tenga el valor en texto = 'carpeta' */
	
		$this->res->addNivelArbol('tipo_dato','carpeta',array('leaf'=>false,
														'allowDelete'=>true,
														'allowEdit'=>true,
		 												'cls'=>'folder',
		 												'tipo'=>'rama'),
		 												$arreglo);
		 
		array_push($arreglo,array('nombre'=>'cls','valor'=>'descripcion'));
		
		/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
		  es importante que entre los resultados devueltos por la base exista la variable\
		  tipo_dato que tenga el valor en texto = 'hoja' */
		 														

		 $this->res->addNivelArbol('tipo_dato','interface',array(
														'leaf'=>false,
														'allowDelete'=>true,
														'allowEdit'=>true,
		 												'tipo'=>'interface',
		 												'icon'=>'../../../lib/imagenes/a_form.png'),
		 												$arreglo);
			

		//Se imprime el arbol en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		

	}
	
	/*
	 * ELIMINAR GUI
	 * 
	 * 
	 * */
	
	function eliminarGui(){
		//recupera lso datos recibidos desde la vista y los pone en  variables
	    $tipo_dato=$this->objParam->getParametro('tipo_dato');
        //crea un objeto del tipo seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		
		if($tipo_dato != 'procedimiento'){
					
		    //Si es un nodo tipo interfaz eliminamos el GUI	
	
			$this->res=$this->objFunSeguridad->eliminarGui($this->objParam);
			$this->res->imprimirRespuesta($this->res->generarJson());
	
		}
		else{
			//si es un nodo tipo procedimiento,  eliminamos la relacion con el procedimiento
			 
			
		}
		

	}
	/*
	 * GUARDAR GUI (INSERTAR O MODIFICAR GUI)
	 * Inserta nueva interfaces en el arbol de interfaces 
	 * segu.tgui
	 * segu.testructura_gui
	 * 
	 * 
	 * */

	function guardarGui(){
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		//recupera lso datos recibidos desde la vista y los pone en  variables
		$id_gui=$this->objParam->getParametro('id_gui');
	    //preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_gui')){
			
			
			
            //ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			
		
			$this->res=$this->objFunSeguridad->insertarGui($this->objParam);	

			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
		    $this->res=$this->objFunSeguridad->modificarGui($this->objParam);
		}
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	
	function guardarGuiDragDrop(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		//recupera lso datos recibidos desde la vista y los pone en  variables
		//ejecuta el metodo de insertar de la clase MODPersona a travez 
		//de la intefaz objetoFunSeguridad
		$this->res=$this->objFunSeguridad->guardarGuiDragDrop($this->objParam);	
		$this->res->imprimirRespuesta($this->res->generarJson());
		

	}
	
	
   
	

}

?>