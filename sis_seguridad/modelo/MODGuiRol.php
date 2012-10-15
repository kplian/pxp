<?php
/***
 Nombre: 	MODGuiRol.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tgui_rol del esquema SEGU
 Autor:		Kplian(RAC)
 Fecha:		19/07/2010
*/
class MODGuiRol extends MODbase {
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
	
	
	
	function listarGuiRol(){
		
		
		$this->procedimiento='segu.ft_gui_rol_sel';
		$this->transaccion='SEG_GUIROL_SEL';
		$this->tipo_procedimiento='SEL';
		$this->setCount(false);
		
	    $this->setParametro('id_padre','id_padre','varchar');
		//$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('id_rol','id_rol','integer');
		
		
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('id_estructura_gui','integer');
		$this->captura('id_gui','integer');
		$this->captura('id_subsistema','integer');
		$this->captura('desc_subsistema','varchar');
		$this->captura('id_p','integer');
		$this->captura('nivel','integer');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','text');
		$this->captura('codigo_gui','varchar');
		$this->captura('visible','segu.si_no');
		$this->captura('orden_logico','integer');
		$this->captura('ruta_archivo','text');
		$this->captura('icono','varchar');
		$this->captura('checked','varchar');
		$this->captura('tipo_meta','varchar');
		$this->captura('id_nodo','varchar');
		$this->captura('id_rol','integer');
	
		
		
		$this->armarConsulta();
	
		$consulta=$this->getConsulta();
		
		$_SESSION['PRUEBA']=0;
        $this->ejecutarConsulta();
        
        
		
		/*obtencion de procedimientos*/
		
        
		if($this->respuesta->getTipo()=='ERROR'){
			return $this->respuesta;
		}
		else{
		    $this->procedimiento='segu.ft_rol_procedimiento_gui_sel';
			$this->transaccion='SEG_ROLPROGUI_SEL';
			$this->tipo_procedimiento='SEL';
			//$this->setCount(false);
			$this->resetCaptura();
			$this->addConsulta();
			$this->captura('id_procedimiento_gui','integer');
			$this->captura('id_gui','integer');
			$this->captura('id_procedimiento','integer');
			$this->captura('codigo','varchar');
			$this->captura('descripcion','text');
			$this->captura('checked','varchar');
			$this->captura('tipo_meta','varchar');
			$this->captura('id_nodo','varchar');
			$this->captura('id_rol','integer');
			$this->armarConsulta();
			$consulta=$this->getConsulta();
			
	  
			$this->ejecutarConsulta($this->respuesta);
		}
		
        
       return $this->respuesta;
		
	}
	
	function insertarGuiRol(){
		
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_gui_rol_ime';// nombre procedimiento almacenado
		$this->transaccion='SEG_GUIROL_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
	
		
		//Define los parametros para la funcion	
        $this->setParametro('id','id_gui_proc','integer');
		$this->setParametro('id_rol','id_rol','integer');
		$this->setParametro('id_subsistema','id_subsistema','integer');
		$this->setParametro('tipo','tipo_nodo','varchar');
		$this->setParametro('checked','checked','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->respuesta;
		
	}
}
?>