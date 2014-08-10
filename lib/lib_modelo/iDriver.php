<?php
/*
Autor: RCM
Fecha: 02/06/2014
Archivo: iDriver.php
Descripcio: Interface para normalizar los metodos necesarios para los drivers de bases de datos
*/
interface iDriver {

	public function armarConsultaSel();
	
	public function armarConsultaCount();
	
	public function armarconsultaIme();
	
	public function armarConsultaOtro();

	public function ejecutarConsultaSel($res=null);
	
	public function ejecutarConsultaIme();
	
	public function ejecutarConsultaOtro();
	
	public function divRespuesta($cadena);

}

?>