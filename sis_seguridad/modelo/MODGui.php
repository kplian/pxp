<?php
/***
 Nombre: 	MODActividad.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tgui del esquema SEGU
 Autor:		Kplian(RAC)
 Fecha:		19/07/2010
 */            
 class MODGui extends MODbase {
	
	function __construct(CTParametro &$pParam){
		parent::__construct($pParam);
	}
	public function __call($method, $args)
    {
        echo "Called method $method";
		exit;
    }
	
	//--------- LISTAR MENU----------//
	 /* Utilizada para la creacion del menu pricipal 
	 * que se encuentra a la izquierda en la pantalla*/
	 
	function listarMenu(){
	
		//echo $parametro->getOrdenacion;
		//var_dump('aaa',$this->objParam);
		
		$this->procedimiento='segu.ft_menu_sel';
		$this->transaccion='SEG_MENU_SEL';
		$this->tipo_procedimiento='SEL';
		
		$this->setCount(false);
						
		$this->setParametro('id_padre','id_padre','varchar');
		$this->setParametro('busqueda','busqueda','varchar');
		$this->setParametro('codigo','codigo','varchar');
				
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_gui','integer');
		$this->captura('nombre','varchar');
		$this->captura('codigo_gui','varchar');
		$this->captura('descripcion','text');
		$this->captura('nivel','integer');
		$this->captura('orden_logico','integer');
		$this->captura('ruta_archivo','text');
		$this->captura('clase_vista','varchar'); 
		$this->captura('tipo_dato','varchar');
		$this->captura('icono','varchar');
		$this->captura('json_parametros','text');
					
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;	
		
			
	}
	
	
	function listarMenuMobile(){
    
        $this->procedimiento='segu.ft_menu_sel';
        $this->transaccion='SEG_GUIMOB_SEL';
        $this->tipo_procedimiento='SEL';
        
        $this->setCount(false);
                        
        //defino varialbes que se captran como retornod e la funcion
        $this->captura('id_gui','integer');
        $this->captura('codigo_gui','varchar');
        $this->captura('nombre','varchar');
        $this->captura('codigo_mobile','varchar');
        $this->captura('desc_mobile','text'); 
        
        $this->armarConsulta();
        
        //echo  $this->consulta;
        $this->ejecutarConsulta();
        //var_dump($this->respuesta);
        return $this->respuesta;
   }
	
	
	//------- LISTAR GUI : Para llenar el arbol de interfaces ----//
   function listarGui(){
		  	
		$this->procedimiento='segu.ft_gui_sel';
		$this->transaccion='SEG_GUI_SEL';
		$this->tipo_procedimiento='SEL';
		
		$this->setCount(false);						
		$this->setParametro('id_padre','id_padre','varchar');		
		$this->setParametro('id_subsistema','id_subsistema','integer');			
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_gui','integer');
		$this->captura('id_subsistema','integer');
		$this->captura('id_gui_padre','integer');
		$this->captura('codigo_gui','varchar');	
		$this->captura('nombre','varchar');		
		$this->captura('descripcion','text'); 
		$this->captura('nivel','integer');
		$this->captura('visible','segu.si_no');		
		$this->captura('orden_logico','integer');
		$this->captura('ruta_archivo','text');
		$this->captura('icono','varchar');
		$this->captura('clase_vista','varchar');
		$this->captura('tipo_dato','varchar');
		$this->captura('id_nodo','varchar');
		$this->captura('json_parametros','text');
		
		$this->captura('codigo_mobile','varchar');
		$this->captura('sw_mobile','varchar');
		$this->captura('orden_mobile','numeric');
		
		
	
		$this->armarConsulta();
		

		$this->ejecutarConsulta();
		return $this->respuesta;	
	}



//------- LISTAR GUI : Para llenar el arbol de interfaces ----//
	function getGui(){
		  	
		$this->procedimiento='segu.ft_gui_sel';
		$this->transaccion='SEG_GETGUI_SEL';
		$this->tipo_procedimiento='SEL';
		
		$this->setCount(false);						
				
		$this->setParametro('id_gui','id_gui','integer');
		
		
			
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_gui','integer');
		$this->captura('id_subsistema','integer');
		$this->captura('id_gui_padre','integer');
		$this->captura('codigo_gui','varchar');	
		$this->captura('nombre','varchar');		
		$this->captura('descripcion','text'); 
		$this->captura('nivel','integer');
		$this->captura('visible','segu.si_no');		
		$this->captura('orden_logico','integer');
		$this->captura('ruta_archivo','text');
		$this->captura('icono','varchar');
		$this->captura('clase_vista','varchar');
		$this->captura('tipo_dato','varchar');
		$this->captura('id_nodo','varchar');
		
		$this->captura('imagen','varchar');
		$this->captura('json_parametros','text');
	
		$this->armarConsulta();
		

		$this->ejecutarConsulta();
		return $this->respuesta;	
	}


	function listarGuiSincronizacion(){
		  	
		$this->procedimiento='segu.ft_gui_sel';
		$this->transaccion='SEG_GUISINC_SEL';
		$this->tipo_procedimiento='SEL';
		
		$this->setCount(false);						
		$this->setParametro('id_subsistema','id_subsistema','integer');			
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_gui','integer');
		$this->captura('nombre','varchar');		
		$this->captura('descripcion','text'); 
		$this->captura('ruta_archivo','text');
		$this->captura('clase_vista','varchar');
		$this->captura('json_parametros','text');
		
		$this->armarConsulta();
		
		
		$this->ejecutarConsulta();
		//var_dump($this->respuesta);
		return $this->respuesta;	
	}

	
	
     function insertarGui(){
     
     	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_gui_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_GUI_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		//Define los parametros para la funcion	
		$this->setParametro('id_gui','id_gui','integer');
		$this->setParametro('id_gui_padre','id_gui_padre','integer');
		$this->setParametro('codigo_gui','codigo_gui','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('visible','visible','varchar');
		$this->setParametro('orden_logico','orden_logico','integer');
		$this->setParametro('ruta_archivo','ruta_archivo','text');
		$this->setParametro('nivel','nivel','integer');
	    $this->setParametro('icono','icono','varchar');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('clase_vista','clase_vista','varchar');
		$this->setParametro('tipo_dato','tipo_dato','varchar');
		$this->setParametro('parametros','json_parametros','json_text');
		
		$this->setParametro('sw_mobile','sw_mobile','varchar');
		$this->setParametro('codigo_mobile','codigo_mobile','varchar');
		$this->setParametro('orden_mobile','orden_mobile','numeric');
	
    	//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	function modificarGui(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_gui_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_GUI_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_gui','id_gui','integer');
		$this->setParametro('id_gui_padre','id_gui_padre','integer');
		$this->setParametro('codigo_gui','codigo_gui','varchar');
		$this->setParametro('nombre','nombre','codigo_html');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('visible','visible','varchar');
		$this->setParametro('orden_logico','orden_logico','integer');
		$this->setParametro('ruta_archivo','ruta_archivo','text');
		$this->setParametro('nivel','nivel','integer');
	    $this->setParametro('icono','icono','varchar');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('clase_vista','clase_vista','varchar');
		$this->setParametro('tipo_dato','tipo_dato','varchar');
		$this->setParametro('parametros','json_parametros','json_text');
		
		$this->setParametro('sw_mobile','sw_mobile','varchar');
        $this->setParametro('codigo_mobile','codigo_mobile','varchar');
        $this->setParametro('orden_mobile','orden_mobile','numeric');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}

	
	
	
	function eliminarGui(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_gui_ime';
		$this->transaccion='SEG_GUI_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_gui','id_gui','integer');
		$this->setParametro('id_gui_padre','id_gui_padre','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function guardarGuiDragDrop(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_gui_ime';
		$this->transaccion='SEG_GUIDD_IME';
		$this->tipo_procedimiento='IME';
		
	//Define los parametros para la funcion
		$this->setParametro('punto','point','varchar');
		$this->setParametro('id_nodo','id_nodo','integer');		
		$this->setParametro('id_old_parent','id_old_parent','integer');
		$this->setParametro('id_target','id_target','integer');
		
	
		
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}

	function guardarGuiSincronizacion(){
		
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_gui_ime';
		$this->transaccion='SEG_GUISINC_IME';
		$this->tipo_procedimiento='IME';
		
	//Define los parametros para la funcion
		
		$this->setParametro('nombre','nombre','varchar');		
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('ruta_archivo','ruta_archivo','text');
		$this->setParametro('clase_vista','clase_vista','varchar');	
		$this->setParametro('id_gui_padre','id_gui_padre','integer');
		$this->setParametro('combo_trigger','combo_trigger','varchar');
	
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		
				
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
	

}
?>