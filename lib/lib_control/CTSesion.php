<?php
/***
 Nombre: CTSesion.php
 Proposito:
 - Gestionar el estado de la aplicacion:
   inactiva cuando el usuario no esta autentificado,
   preparada cuando sean intercambiado las llaves de cifrado
   activa cuando se ha validado la identidad y autenticidad del usuario
 - Insertar la la sesion en base de datos
 - Verifivar el estado de la sesion para evitar duplicidades
 - Registrar las sesiones  de usuario para evitar el robo de sesion y dulicidad.
 Autor:	Kplian (RAC)
 Fecha:	14/7/2010
 */
class CTSesion {
	private $estado; //inactiva || preparada || activa
	private $id_usuario;
	private $sid;
	private $sid_anterior;
	private $ip;
	private $sid_base;
	private $ip_base;
	private $conexion;

	/**
	 * Nombre funcion:	__construct
	 * Propposito		Crea una instancia de sesion
	 * Fecha creacin:	14/7/2010
	 * Autor: Rensi Arteaga Copari
	 * @param cadena $tipo_tran
	 */
	function __construct() {
		//session_start();
		$this->estado = 'inactiva';
		$this->sid = session_id ();
		$this->ip= $this->getIP();

	}

	/**
	 * Nombre funcion:	getEstado
	 * Proposito:		Devuleve el estado de la sesion
	 * Fecha creacin:	14/7/2010
	 * Autor: Rensi Arteaga Copari
	 *
	 *
	 * @return String estado sesion
	 */

	
	
	function getEstado() {
		return $this->estado;

	}
	
	/**
	 * 
	 * 
	 * FECHA 19 10 2011
	 * se aumenta una varilabe para almacenar las conexiones persistentes
	 * RAC
	 * 
	 * */
	
	function setConexion($link) {

		$this->conexion=$link;
	}
	
	function getConexion() {

		
		return  $this->conexion;
	}



	/**
	 *
	 */
	function setIdUsuario($id) {

		$this->id_usuario=$id;
	}

	function getIdUsuario() {
		return $this->id_usuario;
	}
	
	function actualizarLlaves($m,$e,$k,$p,$x,$z){
		$this->funSeguridad->actualizarLlaves($this->id_usuario, $m,$e,$k,$p,$x,$z);
	}

	function setEstado($est){
		$this->funSeguridad = new MODSesion();
		if ($est == 'activa') {
			$this->rotarSid ();
			$this->funSeguridad->insertarSesion ( $this->sid, $this->ip, $this->id_usuario,'');
			$this->estado = 'activa';

		} elseif ($est == 'inactiva') {

			$this->rotarSid ();
			$this->estado = 'inactiva';

		} elseif ($est == 'preparada') {

			$this->rotarSid ();
			$this->estado = 'preparada';

		} else {
			throw new Exception ( __METHOD__ . ': estado de sesion no definido' );

		}

	}
	function rotarSid() {

		$sid_anterior = session_id ();
		if (session_regenerate_id ()) {

			$this->sid = session_id ();
		}

	}

	function eliminarSesion() {
		$this->estado = 'inactiva';
		session_destroy ();

	}

	function validarSesion() {
		if ($this->estado == 'activa') {

			$this->recuparaSidBase();

			//echo "$this->sid_base =".session_id (). " !!!!!  $this->ip_base =".$this->getIP ();
			//exit;
            // en un entorno de internet esta valiacion no es util debido a NAT

			//if ($this->sid_base == session_id () && $this->ip_base == $this->getIP ()) {
		    		
		    	
		   //27/06/2018 ..comentado ,   TODO es necesario ahcer configurable..... 		
           // if ($this->sid_base == session_id () || $_SESSION["_ESTADO_SISTEMA"] == 'desarrollo') {
				return true;
					
			//}
		}

		return false;
	}

	private function recuparaSidBase() {


		$this->funSeguridad = new MODSesion();

		$res = $this->funSeguridad->recuparaSidBase($this->id_usuario);

		if($res->getTipo()=='ERROR'){
			$res->imprimirRespuesta($res->generarJson());
			exit;
		}

		$datos=$res->getDatos();

		$this->ip_base = $datos[0]["ip"];
		$this->sid_base =$datos[0]["variable"];

	}



	private function getIP() {
		if (isset ( $_SERVER ['HTTP_X_FORWARDED_FOR'] )) {
			$ip = $_SERVER ['HTTP_X_FORWARDED_FOR'];
		} elseif (isset ( $_SERVER ['HTTP_VIA'] )) {
			$ip = $_SERVER ['HTTP_VIA'];
		} elseif (isset ( $_SERVER ['REMOTE_ADDR'] )) {
			$ip = $_SERVER ['REMOTE_ADDR'];
		} else {
			$ip = "desconocida";
		}
		return $ip;

	}
	//metodos para sobre cargar la sesion de php

	/**
	 * Abre la sesión
	 * @return bool
	 */
	public static function open() {



	}

	/**
	 * Cierra la sesión
	 * @return bool
	 */
	public static function close() {
	}

	/**
	 * Lee la sesión
	 * @param int session id
	 * @return string contenido de la sesión
	 */
	public static function read($id) {
	}

	/**
	 * Guarda la sesión
	 * @param int session id
	 * @param string contenido de la sesión
	 */
	public static function write($id, $data) {
	}

	/**
	 * Destruye la sesión
	 * @param int session id
	 * @return bool
	 */
	public static function destroy($id) {
	}

	/**
	 * Colector de basura
	 * @param int life time (sec.)
	 * @return bool
	 */
	public static function gc($max) {
	}




}
?>