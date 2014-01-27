<?php
/***
 Nombre: 	MODbaseSeguridad.php
 Proposito: Clase de Modelo, que extiende la funcionalidad de la clase MODbase
 Autor:		Kplian
 Fecha:		04/06/2011
 */

abstract class MODbaseSeguridad extends MODbase{
	
	//Variables
	protected $funciones;
	protected $res;
	
	//Construtor
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		$this->funciones=new FuncionesSeguridad();	
	}
	
}

?>