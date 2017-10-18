<?php
/***
 Nombre: 	MODFuncionario.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tfuncionario del esquema RHUM
 Autor:		Kplian
 Fecha:		04/06/2011
 */
class MODFuncionario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
	}
	
	function listarFuncionario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_sel';// nombre procedimiento almacenado
		$this->transaccion='RH_FUNCIO_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('id_uo','id_uo','integer');	
		//Definicion de la lista del resultado del query
	
		//defino varialbes que se captran como retornod e la funcion
		
		$this->captura('id_funcionario','integer');
		$this->captura('codigo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_persona','integer');
		$this->captura('id_usuario_reg','integer');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','integer');
		$this->captura('email_empresa','varchar');
		$this->captura('interno','varchar');
		$this->captura('fecha_ingreso','date');
		$this->captura('desc_person','text');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('ci','varchar');
		$this->captura('num_documento','integer');
		$this->captura('telefono1','varchar');
		$this->captura('celular1','varchar');
		$this->captura('correo','varchar');
		$this->captura('telefono_ofi','varchar');
		$this->captura('antiguedad_anterior','integer');
		
		$this->captura('estado_civil','varchar');
		$this->captura('genero','varchar');
		$this->captura('fecha_nacimiento','date');
		$this->captura('id_lugar','integer');
		$this->captura('nombre_lugar','varchar');
		$this->captura('nacionalidad','varchar');
		$this->captura('discapacitado','varchar');
		$this->captura('carnet_discapacitado','varchar');
		$this->captura('id_biometrico','int4');

		
		//Ejecuta la funcion
		$this->armarConsulta();		
		//echo $this->getConsulta(); exit;
		$this->ejecutarConsulta();
		return $this->respuesta;

	}

	function getDatosFuncionario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_sel';// nombre procedimiento almacenado
		$this->transaccion='RH_GETDAFUN_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
			
		//defino varialbes que se captran como retornod e la funcion
		
		$this->captura('id_funcionario','integer');
		$this->captura('nombre_funcionario','varchar');
		$this->captura('cargo','varchar');
		$this->captura('telefonos_corporativos','varchar');
		$this->captura('correo_corporativo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('apellido','varchar');
		$this->captura('oficina','varchar');
		$this->captura('lugar','varchar');
		$this->captura('gerencia','varchar');
		$this->captura('direccion','varchar');
		$this->captura('celular1','varchar');
        $this->captura('interno','varchar');

		
		//Ejecuta la funcion
		$this->armarConsulta();		
		//echo $this->getConsulta(); exit;
		$this->ejecutarConsulta();
		return $this->respuesta;

	}
	
	function getCumpleaneros(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_sel';// nombre procedimiento almacenado
		$this->transaccion='RH_GETCUMPLEA_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
			
		//defino varialbes que se captran como retornod e la funcion
		
		$this->captura('id_funcionario','integer');
		$this->captura('nombre_funcionario','varchar');
		$this->captura('cargo','varchar');		
		$this->captura('correo_corporativo','varchar');
		
		
		//Ejecuta la funcion
		$this->armarConsulta();		
		//echo $this->getConsulta(); exit;
		$this->ejecutarConsulta();
		return $this->respuesta;

	}
	
	function alertarCumpleaneroDia(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='orga.ft_funcionario_ime';
        $this->transaccion='RH_CUMPLECORR_INS';
        $this->tipo_procedimiento='IME';
        //definicion de variables
		$this->tipo_conexion='seguridad';        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
		
        //Devuelve la respuesta
        return $this->respuesta;
    }
	
	function listarFuncionarioCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_sel';// nombre procedimiento almacenado
		$this->transaccion='RH_FUNCIOCAR_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		//ENVIA ESTAS VARIALBES PARA EL FILTRO
		$this->setParametro('estado_reg_fun','estado_reg_fun','varchar');
		$this->setParametro('estado_reg_asi','estado_reg_asi','varchar');
		
	
		$this->captura('id_uo_funcionario','integer');
		$this->captura('id_funcionario','integer');
		$this->captura('desc_funcionario1','text');
		$this->captura('desc_funcionario2','text');	
		$this->captura('id_uo','integer');
		$this->captura('nombre_cargo','varchar');
		$this->captura('fecha_asignacion','date');
		$this->captura('fecha_finalizacion','date');
		$this->captura('num_doc','integer');
		$this->captura('ci','varchar');
		$this->captura('codigo','varchar');
		$this->captura('email_empresa','varchar');
		$this->captura('estado_reg_fun','varchar');
		$this->captura('estado_reg_asi','varchar');
		
		$this->captura('id_cargo','integer');
		$this->captura('descripcion_cargo','varchar');
		$this->captura('cargo_codigo','varchar');
		
		
		$this->captura('id_lugar','integer');
		$this->captura('id_oficina','integer');
		$this->captura('lugar_nombre','varchar');
		$this->captura('oficina_nombre','varchar');
		
		
		
		
		
		
		
                            
		$this->setParametro('antiguedad_anterior','antiguedad_anterior','varchar');
		//Ejecuta la funcion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	function insertarFuncionario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_ime';// nombre procedimiento almacenado
		$this->transaccion='RH_FUNCIO_INS';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		
		
		$this->setParametro('id_funcionario','id_funcionario','integer');	
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_persona','id_persona','integer');
		$this->setParametro('correo','correo','varchar');
		$this->setParametro('celular','celular','varchar');
		$this->setParametro('telefono','telefono','varchar');
		$this->setParametro('documento','documento','integer');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_ingreso','fecha_ingreso','date');
		$this->setParametro('email_empresa','email_empresa','varchar');
		$this->setParametro('interno','interno','varchar');
		$this->setParametro('telefono_ofi','telefono_ofi','varchar');
		$this->setParametro('antiguedad_anterior','antiguedad_anterior','integer');
		
		$this->setParametro('estado_civil','estado_civil','varchar');
		$this->setParametro('genero','genero','varchar');
		$this->setParametro('fecha_nacimiento','fecha_nacimiento','date');
		$this->setParametro('id_lugar','id_lugar','integer');
		$this->setParametro('nacionalidad','nacionalidad','varchar');
		$this->setParametro('discapacitado','discapacitado','varchar');
		$this->setParametro('carnet_discapacitado','carnet_discapacitado','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	function modificarFuncionario(){
	
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_ime';// nombre procedimiento almacenado
		$this->transaccion='RH_FUNCIO_MOD';//nombre de la transaccion
		$this->tipo_procedimiento='IME';//tipo de transaccion
		
		//Define los parametros para la funcion	
		$this->setParametro('id_funcionario','id_funcionario','integer');	
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_persona','id_persona','integer');
		$this->setParametro('correo','correo','varchar');
		$this->setParametro('celular','celular','varchar');
		$this->setParametro('telefono','telefono','varchar');
		$this->setParametro('documento','documento','integer');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_ingreso','fecha_ingreso','date');
		$this->setParametro('email_empresa','email_empresa','varchar');
		$this->setParametro('interno','interno','varchar');
		$this->setParametro('telefono_ofi','telefono_ofi','varchar');
		$this->setParametro('antiguedad_anterior','antiguedad_anterior','integer');
		
		$this->setParametro('estado_civil','estado_civil','varchar');
		$this->setParametro('genero','genero','varchar');
		$this->setParametro('fecha_nacimiento','fecha_nacimiento','date');
		$this->setParametro('id_lugar','id_lugar','integer');
		$this->setParametro('nacionalidad','nacionalidad','varchar');
		$this->setParametro('discapacitado','discapacitado','varchar');
		$this->setParametro('carnet_discapacitado','carnet_discapacitado','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	function eliminarFuncionario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_funcionario_ime';
		$this->transaccion='RH_FUNCIO_ELI';
		$this->tipo_procedimiento='IME';
			
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario','id_funcionario','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();
				
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function getEmailEmpresa(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='orga.ft_funcionario_ime';
        $this->transaccion='RH_MAILFUN_GET';
        $this->tipo_procedimiento='IME';
            
        //Define los parametros para la funcion
        $this->setParametro('id_funcionario','id_funcionario','integer');
        //Ejecuta la instruccion
        $this->armarConsulta();
                
        $this->ejecutarConsulta();
        return $this->respuesta;
    }

}
?>
