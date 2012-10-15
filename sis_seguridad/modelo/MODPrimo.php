<?php
/***
 Nombre: 	MODPrimo.php
 Proposito: Clase de Modelo, que contiene la definicion y llamada a funciones especificas relacionadas 
 a la tabla tprimo del esquema SEGU
 Autor:		Kplian
 Fecha:		04/06/2011
 */ 
class MODPrimo extends MODbase
{
	function __construct(CTParametro $pParam=null){
		
		parent::__construct($pParam);
	}
	function ObtenerPrimo(){
		//definicion de datos
		$this->procedimiento='segu.ft_primo_sel';
		$this->transaccion='SEG_OBTEPRI_SEL';
		$this->tipo_procedimiento='SEL';
		
		//definicion de variables
		$this->tipo_conexion='seguridad';
		$this->count=false;
		
		//obtiene el random del id_primo
		$numer_ran=rand(1,1000);
		$this->arreglo=array("numero" =>$numer_ran);

		//defino parametros de envio a la funci�n
		$this->setParametro('id_primo','numero','integer');
		//defino varialbes que se captran como retornod e la funcion
		$this->captura('primo','integer');
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		//var_dump($this->respuesta);exit;
		return $this->respuesta;
	}
}
?>
