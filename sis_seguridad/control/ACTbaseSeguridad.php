<?php
/***
 Nombre: ACTbaseSeguridad.php
 Proposito: Clase que hereda de la Clase Base de lib_control para el Sistema de 
 Seguridad para centralizar las operaciones y variables basicas. 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
abstract class ACTbaseSeguridad extends ACTbase{
	
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