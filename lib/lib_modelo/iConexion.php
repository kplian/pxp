<?php
/*
Autor: RCM
Fecha: 30/05/2014
Archivo: Interface para conexiones en pxp
Descripción: Métodos básicos para las conexiones a las distintas bases de datos
*/
interface iConexion {
	
	public function conectarnp();
	
	public function conectarpdo($externo='');
	
	public function desconectarnp();
	
	public function conectarp();
	
	public function conectarSegu();
	
	public function getConexion();

}

?>