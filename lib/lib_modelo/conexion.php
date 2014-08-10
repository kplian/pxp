<?php
/**
 * *********************************
 * Autor:RCM
 * Fecha: 02/06/2014
 * Clase: conexion
 * Descripcion: Clase maestra para conexiones a las BDS implementadas
 */
class conexion implements iConexion {

	private $strMotorBD;
	private $objCnx;
	
	function __construct($pMotorBD='pg'){
		$this->strMotorBD = $pMotorBD;
		if($pMotorBD=='pg'){
			$this->objCnx = new pgConexion();
		} else if($pMotorBD=='mssql'){
			$this->objCnx = new mssqlConexion();
		} else {
			throw new Exception('Conexion: Motor de BD no soportado. (Soportado postgresql (pg), mssql server (mssql)');
		}
	}

	function conectarnp(){
		$this->objCnx->conectarnp();
	}

	function conectarpdo($externo=''){
		$this->objCnx->conectarpdo($externo);
	}
	
	function desconectarnp(){
		$this->objCnx->desconectarnp();
	}
	
	function conectarp(){
		$this->objCnx->conectarp();
	}

	function conectarSegu(){
		return $this->objCnx->conectarSegu();
	}

	function getConexion(){
		return $this->objCnx->getConexion();
	}
}

?>
