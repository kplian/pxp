<?php
/***
 Nombre: ACTGuiRol.php
 Proposito: Metodos para la manipulacion de interfaces 
 Autor:	Kplian
 Fecha:	19/07/2010
 */
class ACTGuiRol extends ACTbase{ 

function listarGuiRol(){
	
	
	//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
	$this->objFunSeguridad=new FuncionesSeguridad();

	//obtiene el parametro nodo enviado por la vista
		$node=$this->objParam->getParametro('node');
		$id_gui_proc=$this->objParam->getParametro('id_gui_proc');
		$id_subsistema=$this->objParam->getParametro('id_subsistema');
		$id_rol=$this->objParam->getParametro('id_rol');
	
		
	//$param=new Parametro('SEL',$sort,$dir,$start,$limit,$filter,$par_combo,$query);
	 //$this->objParam->addParametro('id_padre',$node);
	
       if($node=='id')
			$this->objParam->addParametro('id_padre','%');
		else 
			$this->objParam->addParametro('id_padre',$id_gui_proc);
	
	//$this->objParam->addParametro('id_subsistema',$id_subsistema);
	$this->objParam->addParametro('id_rol',$id_rol);
	
	$this->res=$this->objFunSeguridad->listarGuiRol($this->objParam);
	
	
		
		$this->res->setTipoRespuestaArbol();
	
	/*Para que la respuesta sea un json de un arbol*/

	
	
	/*anadir niveles al arbol para todos los tipos (Los niveles son tipos de nodos comunes con
	caracteristicas similares)*/
	
	
	//Se pueden anadir atributos de un nodo q contengan el valor de algun otro atributo con un arreglo de equivalencias
	
	$arreglo=array();
	$arreglo_valores=array();
	
	//para cambiar un valor por otro en una variable
	array_push($arreglo_valores,array('variable'=>'checked','val_ant'=>'true','val_nue'=>true));
	array_push($arreglo_valores,array('variable'=>'checked','val_ant'=>'false','val_nue'=>false));
	$this->res->setValores($arreglo_valores);
	
	
	array_push($arreglo,array('nombre'=>'id','valor'=>'id_nodo'));
	array_push($arreglo,array('nombre'=>'id_gui_proc','valor'=>'id_gui'));
	array_push($arreglo,array('nombre'=>'text','valor'=>'nombre'));
	array_push($arreglo,array('nombre'=>'qtip','valor'=>'descripcion'));
	
	//se ande el primer nivel al arbol incluyendo el arreglo de equivalencias
	$this->res->addNivelArbol('tipo_meta','carpeta',array('id_p'=>$node,
													'leaf'=>false,
													'allowDelete'=>true,
													'allowEdit'=>true,
	 												'cls'=>'folder',
	 												'tipo'=>'rama'),
	 												$arreglo,
	 												$arreglo_valores);
	 	///////////////////////////////////											
	
	$arreglo=array();
	$arreglo_valores=array();
	
	//para cambiar un valor por otro en una variable
	array_push($arreglo_valores,array('variable'=>'checked','val_ant'=>'true','val_nue'=>true));
	array_push($arreglo_valores,array('variable'=>'checked','val_ant'=>'false','val_nue'=>false));
	$this->res->setValores($arreglo_valores);
	
	
	array_push($arreglo,array('nombre'=>'id','valor'=>'id_nodo'));
	array_push($arreglo,array('nombre'=>'id_gui_proc','valor'=>'id_gui'));
	array_push($arreglo,array('nombre'=>'text','valor'=>'nombre'));
	array_push($arreglo,array('nombre'=>'qtip','valor'=>'descripcion'));
	
	//se ande el primer nivel al arbol incluyendo el arreglo de equivalencias
	$this->res->addNivelArbol('tipo_meta','interface',array('id_p'=>$node,
													'leaf'=>false,
													'allowDelete'=>true,
													'allowEdit'=>true,
	 												//'cls'=>'folder',
	 												'icon'=>'../../../lib/imagenes/a_form.png',
	 												'tipo'=>'rama'),
	 												$arreglo,
	 												$arreglo_valores);											
	 	////////////////////////											
	//se crea otroa rreglo de equivalencias 												
	$arreglo=array();
	//array_push($arreglo,array('nombre'=>'id','valor'=>'id_procedimiento_gui'));
	
	array_push($arreglo,array('nombre'=>'id','valor'=>'id_nodo'));
	array_push($arreglo,array('nombre'=>'id_gui_proc','valor'=>'id_procedimiento_gui'));
	array_push($arreglo,array('nombre'=>'text','valor'=>'codigo'));
	array_push($arreglo,array('nombre'=>'qtip','valor'=>'descripcion'));									
	
	
	//se a�ade otro nivel al arbol con el arreglo de equivalencias
	
	 $this->res->addNivelArbol('tipo_meta','transaccion',array('id_p'=>$node,
													'leaf'=>true,
													'allowDelete'=>false,
													'allowEdit'=>false,
	 												'tipo'=>'hoja'),
	 												$arreglo,
	 												$arreglo_valores);
	 												
	 												
	 												
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
		$id_gui=$this->objParam->getParametro('id');
		$id_gui_padre=$this->objParam->getParametro('id_p');
		$tipo_dato=$this->objParam->getParametro('tipo_dato');
		
	
		
		//crea un objeto del tipo seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		
		
		
		if($tipo_dato != 'procedimiento'){
					
		//Si es un nodo tipo interfaz eliminamos el GUI	
				
				//adiciona parametros
				$this->objParam->addParametro('id_gui',$id_gui);
				$this->objParam->addParametro('id_gui_padre',$id_gui_padre);
				
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
		$id_gui=$this->objParam->getParametro('id');
		$id_gui_padre=$this->objParam->getParametro('id_p');
		$tipo_dato=$this->objParam->getParametro('tipo_dato');
		
		//adiciona parametros
		$this->objParam->addParametro('id_gui',$id_gui);
		$this->objParam->addParametro('id_gui_padre',$id_gui_padre);
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id')){

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
	
function checkGuiRol(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesSeguridad();
		
		//echo 'check';
		//exit;
		
		//recupera lso datos recibidos desde la vista y los pone en  variables
	
		$tipo_meta=$this->objParam->getParametro('tipo_meta');
		
		if($tipo_meta =='interface'  || $tipo_meta =='carpeta' ){
			
			$tipo_meta = 'gui';
		} 
		else{
			
			$tipo_meta = 'transaccion';
		}
		$this->objParam->addParametro('tipo_nodo',$tipo_meta);
		
	 $this->res=$this->objFunSeguridad->insertarGuiRol($this->objParam);			
	
	
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
   
	

}

?>