<?php
/***
 Nombre: 	MODUoFuncionario.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas a la tabla tuo_funcionario del esquema RHUM
 Autor:		Kplian
 Fecha:		04/06/2011
 * 
 * 
 * ***************************************************************************************************   
    HISTORIAL DE MODIFICACIONES:
       
 ISSUE            FECHA:              AUTOR                 DESCRIPCION
   
 #6           09/01/2019      RAC KPLIAN      añade listarAsignacionFuncionario * 
 #32          18/07/2019      RAC KPLIAN      añade carga horaria
 #81		  08.11.2019	  MZM ETR		  Adicion de campo prioridad
 #94          12/12/2019      APS             Filtro de funcionarios por gestion y periodo
 */
class MODUoFuncionario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarUoFuncionario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_uo_funcionario_sel';// nombre procedimiento almacenado
		$this->transaccion='RH_UOFUNC_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setParametro('id_uo','id_uo','integer');
        $this->setParametro('gestion','gestion','integer');                                         //#94
        $this->setParametro('periodo','periodo','integer');                                         //#94

		//Definicion de la lista del resultado del query
		$this->captura('id_uo_funcionario','integer');
		$this->captura('id_uo','integer');
		$this->captura('id_funcionario','integer');
		$this->captura('ci','varchar');
		$this->captura('codigo','varchar');
        $this->captura('desc_funcionario1','text');
        $this->captura('desc_funcionario2','text');
        $this->captura('num_doc','integer');
        $this->captura('fecha_asignacion','date');
        $this->captura('fecha_finalizacion','date');
        $this->captura('estado_reg','varchar');
        $this->captura('fecha_mod','timestamp');
        $this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','integer');
        $this->captura('id_usuario_reg','integer');
        $this->captura('USUREG','text');
		$this->captura('USUMOD','text');
		$this->captura('id_cargo','integer');
		$this->captura('desc_cargo','text');
		$this->captura('observaciones_finalizacion','varchar');
		$this->captura('nro_documento_asignacion','varchar');
		$this->captura('fecha_documento_asignacion','date');
		$this->captura('tipo','varchar');
		$this->captura('carga_horaria','integer'); //#32
		$this->captura('prioridad','numeric'); //#81
		//Ejecuta la funcion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();

		return $this->respuesta;

	}
	
	function insertarUoFuncionario(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_uo_funcionario_ime';// nombre procedimiento almacenado
		$this->transaccion='RH_UOFUNC_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('id_funcionario','id_funcionario','integer');
		$this->setParametro('fecha_asignacion','fecha_asignacion','date');
		$this->setParametro('fecha_finalizacion','fecha_finalizacion','date');
		$this->setParametro('id_cargo','id_cargo','integer');		
		$this->setParametro('observaciones_finalizacion','observaciones_finalizacion','varchar');
		$this->setParametro('nro_documento_asignacion','nro_documento_asignacion','varchar');
		$this->setParametro('fecha_documento_asignacion','fecha_documento_asignacion','date');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('carga_horaria','carga_horaria','integer'); //#32
		$this->setParametro('prioridad','prioridad','numeric'); //#81
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarUoFuncionario(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_uo_funcionario_ime';// nombre procedimiento almacenado
		$this->transaccion='RH_UOFUNC_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_uo_funcionario','id_uo_funcionario','integer');	
		$this->setParametro('id_uo','id_uo','integer');
		$this->setParametro('id_funcionario','id_funcionario','integer');
		$this->setParametro('fecha_asignacion','fecha_asignacion','date');
		$this->setParametro('fecha_finalizacion','fecha_finalizacion','date');
		$this->setParametro('id_cargo','id_cargo','integer');		
		$this->setParametro('observaciones_finalizacion','observaciones_finalizacion','varchar');
		$this->setParametro('nro_documento_asignacion','nro_documento_asignacion','varchar');
		$this->setParametro('fecha_documento_asignacion','fecha_documento_asignacion','date');
		$this->setParametro('carga_horaria','carga_horaria','integer'); //#32
		$this->setParametro('prioridad','prioridad','numeric'); //#81
		
	
		//Ejecuta la instruccion
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	function eliminarUoFuncionario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_uo_funcionario_ime';
		$this->transaccion='RH_UOFUNC_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_uo_funcionario','id_uo_funcionario','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	//#6
	function listarAsignacionFuncionario(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='orga.ft_uo_funcionario_sel';// nombre procedimiento almacenado
        $this->transaccion='RH_ASIG_FUNC_SEL';//nombre de la transaccion
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setParametro('id_uo','id_uo','integer');
        //Definicion de la lista del resultado del query
        $this->captura('id_uo_funcionario','integer');
        $this->captura('id_uo','integer');
        $this->captura('id_funcionario','integer');
        $this->captura('ci','varchar');
        $this->captura('codigo','varchar');
        $this->captura('desc_funcionario1','text');
        $this->captura('desc_funcionario2','text');
        $this->captura('num_doc','integer');
        $this->captura('fecha_asignacion','date');
        $this->captura('fecha_finalizacion','date');
        $this->captura('estado_reg','varchar');
        $this->captura('fecha_mod','timestamp');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','integer');
        $this->captura('id_usuario_reg','integer');
        $this->captura('USUREG','text');
        $this->captura('USUMOD','text');
        $this->captura('id_cargo','integer');
        $this->captura('desc_cargo','text');
        $this->captura('observaciones_finalizacion','varchar');
        $this->captura('nro_documento_asignacion','varchar');
        $this->captura('fecha_documento_asignacion','date');
        $this->captura('tipo','varchar');
        $this->captura('haber_basico','numeric');
        $this->captura('tipo_contrato','varchar');
        //Ejecuta la funcion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        return $this->respuesta;
    }
	
}
?>