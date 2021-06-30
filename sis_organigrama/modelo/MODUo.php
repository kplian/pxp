<?php
/***
 Nombre: 	MODUo.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas a la tabla tuo del esquema RHUM
 Autor:		Kplian
 Fecha:		04/06/2011
 	ISSUE		FECHA			AUTHOR				DESCRIPCION
 *  #26			26/6/2019		EGS					Se agrega los Cmp centro y orden centro
 *  #RAS-8      21/05/2021      JJA                 Reporte de conductores asignados
 */
class MODUo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarUo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_uo_sel';// nombre procedimiento almacenado
		$this->transaccion='RH_UO_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('correspondencia','correspondencia','varchar');
		$this->setParametro('gerencia','gerencia','varchar');
		$this->setParametro('presupuesta','presupuesta','varchar');

        $this->setParametro('uo_nivel','uo_nivel','varchar'); //#RAS-8
		
		//Definicion de la lista del resultado del query
		$this->captura('id_uo','integer');
		$this->captura('cargo_individual','varchar');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('estado_reg','varchar');
        $this->captura('fecha_mod','timestamp');
        $this->captura('fecha_reg','timestamp');
       
		$this->captura('id_usuario_mod','integer');
        $this->captura('id_usuario_reg','integer');
        
        $this->captura('nombre_cargo','varchar');
        $this->captura('nombre_unidad','varchar');
        $this->captura('presupuesta','varchar');
        
        $this->captura('USUREG','text');
		$this->captura('USUMOD','text');
		
    	
		//Ejecuta la funcion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();

		return $this->respuesta;

	}


function listarUoFiltro(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.f_uo_arb_inicia';// nombre procedimiento almacenado
		$this->transaccion='RH_INIUOARB_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
		
		$this->setTipoRetorno('record');
		
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('criterio_filtro_arb','criterio_filtro_arb','varchar');
		$this->setParametro('p_activos','p_activos','varchar');
		//Definicion de la lista del resultado del query
		$this->captura('niveles','varchar');						  
		$this->captura('id_uo','integer');
		$this->captura('nombre_unidad','varchar');
		$this->captura('nombre_cargo','varchar');		
		$this->captura('cargo_individual','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('presupuesta','varchar');		
		$this->captura('codigo','varchar');
		$this->captura('nodo_base','varchar');
		$this->captura('gerencia','varchar');
		$this->captura('id_estructura_uo','integer');
		$this->captura('correspondencia','varchar');
		$this->captura('estado_reg','varchar');
        $this->captura('funcionarios','varchar');
        $this->captura('resaltar','varchar');
		$this->captura('id_uo_padre','integer');
		$this->captura('id_nivel_organizacional','integer');
		$this->captura('nombre_nivel','varchar');
		$this->captura('centro','varchar');//#26
		$this->captura('orden_centro','numeric');//#26
		//$this->captura('id_estructura_uo','integer');
		//Ejecuta la funcion
		$this->armarConsulta();
		/*echo $this->consulta;
			exit;*/
		//echo $this->getConsulta();
		$this->ejecutarConsulta();
		
		//var_dump($this->respuesta);exit;
		return $this->respuesta;

	}
	
	
	
}
?>