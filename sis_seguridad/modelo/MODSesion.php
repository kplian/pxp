<?php
/***
 Nombre: 	MODSesion.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tsesion del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODSesion extends MODbase {
	
	function __construct(CTParametro $pParam=null){
		parent::__construct($pParam);
	}
	
	
     function insertarSesion($sid,$ip,$id_usuario,$datos) {
		
			//$driver = new driver ( 'segu.ft_sesion_ime', 'SEG_SESION_INS', 'IME' );
			
			$this->procedimiento='segu.ft_sesion_ime';
		    $this->transaccion='SEG_SESION_INS';
		    $this->tipo_procedimiento='IME';
			
			//envia parametros para guardar la sesion en la base de datos 
			$this->arreglo=array("variable" =>$sid,"id_usuario" =>$id_usuario,"ip" =>$ip,"datos"=>$datos,"pid"=>getmypid());
	        $this->setParametro ( 'variable', 'variable', 'text' );
			$this->setParametro ( 'id_usuario', 'id_usuario', 'integer' );
			$this->setParametro ( 'ip', 'ip', 'varchar' );
			$this->setParametro ( 'datos', 'datos', 'text' );
			$this->setParametro ( 'pid', 'pid', 'integer' );
			
			$this->armarConsulta();
			$consulta = $this->getConsulta();
			
			$this->ejecutarConsulta();
			return $this->respuesta;;

	}
	 
	 function actualizarLlaves($id_usuario,$m,$e,$k,$p,$x,$z) {		
			//$driver = new driver ( 'segu.ft_sesion_ime', 'SEG_SESION_INS', 'IME' );			
			
			
			$this->procedimiento='segu.ft_sesion_ime';
		    $this->transaccion='SEG_ACTKEYS_UPD';
		    $this->tipo_procedimiento='IME';
			
			//envia parametros para guardar la sesion en la base de datos 
			$this->arreglo=array("id_usuario" =>$id_usuario,"m" =>$m,"e" =>$e,"k"=>$k,"p"=>$p,"x"=>$x,"z"=>$z);	        
	        $this->setParametro ( 'm', 'm', 'varchar' );
			$this->setParametro ( 'e', 'e', 'varchar' );
			$this->setParametro ( 'k', 'k', 'varchar' );
			$this->setParametro ( 'p', 'p', 'varchar' );
			$this->setParametro ( 'x', 'x', 'varchar' );
			$this->setParametro ( 'z', 'z', 'varchar' );
			
			$this->armarConsulta();
			$consulta = $this->getConsulta();
			
			$this->ejecutarConsulta ();
			
			
			return $this->respuesta;

	}
	 
	 function prepararLlavesSession(){
		$this->resetParametros();
		$this->resetCaptura();
		//definicion de datos
		$this->procedimiento='segu.ft_sesion_sel';
		$this->transaccion='SEG_RECLLAVES_SEL';
		$this->tipo_procedimiento='SEL';
		$this->setCount(false);
        //definicion de variables
		$this->tipo_conexion='seguridad';
		//defino parametros de envio a la funci�n
		$this->setParametro('sessionid','sessionid','varchar');
		$this->captura ( 'm', 'varchar' );
		$this->captura ( 'e', 'varchar' );
		$this->captura ( 'k', 'varchar' );
		$this->captura ( 'p', 'varchar' );
		$this->captura ( 'x', 'varchar' );
		$this->captura ( 'z', 'varchar' );	
		$this->armarConsulta();
		$consulta = $this->getConsulta();
			
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function recuparaSidBase($id_usuario) {

		$this->procedimiento='segu.ft_sesion_sel';
		$this->transaccion='SEG_SESION_SEL';
		$this->tipo_procedimiento='SEL';
		$this->setCount(false);
		
		//echo "id_usuario $id_usuario";exit;

		//defino varialbes que se evio a la base 
		
		$this->arreglo=array("id_usuario" =>$id_usuario,"pid"=>getmypid());
		$this->setParametro ('id_usuario','id_usuario', 'integer');
		$this->setParametro ('pid','pid', 'integer');
		//defino las columnas de retorno
		$this->captura ( 'id_usuario', 'integer' );
		$this->captura ( 'variable', 'text' );
		$this->captura ( 'ip', 'varchar' );
		$this->captura ( 'data', 'text' );
		
		$this->captura ( 'm', 'varchar' );
		$this->captura ( 'e', 'varchar' );
		$this->captura ( 'k', 'varchar' );
		$this->captura ( 'p', 'varchar' );
		$this->captura ( 'x', 'varchar' );
		$this->captura ( 'z', 'varchar' );
		
		
		 
		
		$this->armarConsulta();
		$consulta = $this->getConsulta();
			
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	
	
}
?>