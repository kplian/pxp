<?php
class MODEsquema extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
	
	function listarEsquema(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('gen.ft_esquema_sel');// nombre procedimiento almacenado
		$this->setTransaccion('GEN_ESQUEM_SEL');//nombre de la transaccion
		$this->setTipoProcedimiento('SEL');//tipo de transaccion
	
		//Definicion de la lista del resultado del query
	
		$this->captura('oid','integer');
		$this->captura('nombre','varchar');
		$this->captura('usuario','varchar');
				
		//Ejecuta la funcion
		$this->armarConsulta();
		/*echo $this->consulta;
		exit();*/
		$this->ejecutarConsulta();

		return $this->getRespuesta();
	}
	
	
}
?>