<?php
/******************************************************************************************************
 Nombre: ACTMenu.php
 Proposito: Controlador para manejo del menu
 Autor:	Kplian
 Fecha:	01/07/2010
 
 ISSUE            FECHA:            AUTOR               DESCRIPCION  
 #0            01/07/2010           Kplian        Creacion
 #128          10/04/2020           RAC           Listado completo de menu para nuevas capa de vista REACT
 ************************************************************************************************************/
class ACTMenu extends ACTbase {
	/////////////
	//Constructor
	////////////
	function __construct(CTParametro $pParam){
		parent::__construct($pParam); 		
	}

	/////////
	//Metodos
	/////////
	
	//Genera las llaves publicas
	function listarPermisoArb() {
		
		$node=$this->objParam->getParametro('node');
		
		if($node=='id')
			$this->objParam->addParametro('id_padre','%');
		else 
			$this->objParam->addParametro('id_padre',$node);
		
		//var_dump($this->objParam);
		
		
		$this->funciones = $this->create('MODGui');
		$this->res=$this->funciones->ListarMenu();
		
		$this->res->setTipoRespuestaArbol();
		
		$arreglo=array();
		array_push($arreglo,array('nombre'=>'id','valor'=>'codigo_gui')); 
		array_push($arreglo,array('nombre'=>'text','valor'=>'nombre'));
		array_push($arreglo,array('nombre'=>'qtip','valor'=>'descripcion'));
		array_push($arreglo,array('nombre'=>'ruta','valor'=>'ruta_archivo'));
		
		
		
		array_push($arreglo,array('nombre'=>'icon','valor'=>'icono'));
	
	
		//se inserta el primer nivel al arbol incluyendo el arreglo de equivalencias
		$this->res->addNivelArbol('tipo_dato','carpeta',array('id_p'=>$node,
		                                                'singleClickExpand'=>true,
														'leaf'=>false,
														'allowDelete'=>false,
														'allowEdit'=>false,
		 												'cls'=>'xnd-text',
		 												//'iconCls'=>'blist',
		 												'iconCls'=>'xnd-icon',
		 												//'icon'=>'../../../lib/imagenes/form32x32.png',
		 												'tipo'=>'rama'),
		 												$arreglo);
		 
		//toma el valor de la clese de vista para la interfaces llamadas desde el menu
		 array_push($arreglo,array('nombre'=>'cls','valor'=>'clase_vista'));
		 														
		//se inserta otro nivel al arbol con el arreglo de equivalencias
		 $this->res->addNivelArbol('tipo_dato','hoja',array('id_p'=>$node,
														'leaf'=>true,
														'allowDelete'=>false,
														'allowEdit'=>false,
		 												'tipo'=>'hoja',
		 												//'cls'=>'xnd-text',
		 												'iconCls'=>'xnd-icon',
		 												'icon'=>'../../../lib/imagenes/form32x32.png'
		 												),
		 												$arreglo);
			
		if($node=='id'){
			$datos=$this->res->getDatos();
			array_push($datos,array(
					'text'=>"Salir",
					'nombre'=>"Salir",
					'id'=>'salir',
					'ruta'=>'../../control/auten/cerrar.php',
					'leaf'=> false,
					'allowDelete'=> false,
					'allowEdit'=> false,
					'allowDrag'=> false,
					'tipo'=>'hoja',
					'cls'=>'xnd-text',
					'icon'=>"../../../lib/imagenes/exit.png",
					'leaf'=>true));
			$this->res->setDatos($datos);
		}
		
		//Se imprime el json del arbol
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	 

	//#128 new menu in format json for new interfaces in REACT interfaces
	function getMenuJSON() {
		$this->funciones = $this->create('MODGui');
		$this->res=$this->funciones->getMenuJSON();
		//Se imprime el json del arbol
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

}

?>