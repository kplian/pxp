<?php
class driver {
	
	private $objDriver;
	private $strMotorBD;
	protected $objParam;
	
	function __construct($pMotorBD='pg') {
		/*ob_start();
		$fb=FirePHP::getInstance(true);
		$fb->log($pMotorBD,"driver");*/
		$this->strMotorBD = $pMotorBD;
		if($pMotorBD=='pg'){
			$this->objDriver = new pgDriver();
		} else if($pMotorBD=='mssql'){
			$this->objDriver = new mssqlDriver();
		} else {
			throw new Exception('Driver: Motor de BD no soportado. (Soportado postgresql, mssql server');
		}
	}
	
	function addConsulta(){
		$this->objDriver->addConsulta();
	}

	function setTransaccion($transaccion){
		$this->objDriver->setTransaccion($transaccion);
	}

	function setProcedimiento($procedimiento){
		$this->objDriver->setProcedimiento($procedimiento);
	}
	
	/**
	 * Nombre funcion:	captura
	 * Proposito:		Aoade una variable que se recibira de un procedimiento de tipo sel
	 * Fecha creacion:	12/04/2009
	 * Autor: Jaime Rivera Rojas
	 * Fecah Modificacion: 2/09/2011
	 * Autor Mod: Rensinha Arteaga Copari
	 * Desc Mod: Aumenta un parametro para identificar varialbes de regreso boleanas
	 *           para traducri f -> false para compatibilizar con javaScript 
	 * @param $nombre Sera el nombre del campo
	 * @param $tipo Sera el tipo del campo
	 */
	function captura($nombre,$tipo,$nombre_file='',$extencion='jpg',$tipo_resp='archivo',$paramacon=null){
		$this->objDriver->captura($nombre,$tipo,$nombre_file='',$extencion='jpg',$tipo_resp='archivo',$paramacon=null);
	}

	function getArregloValores() {
		return $this->objDriver->getArregloValores();
	}

	/**
	 * Nombre funcion:	resetCaptura
	 * Proposito:		Elimina los valores de los arreglos de captura
	 * Fecha creacion:	20/11/2009
	 * 
	 */
	function resetCaptura(){
		$this->objDriver->resetCaptura();
	}
	
	/**
	 * Nombre funcion:	resetCaptura
	 * Proposito:		Elimina los valores de los arreglos de captura
	 * Fecha creacion:	20/11/2009
	 * 
	 */
	function resetParametros(){
		$this->objDriver->resetParametros();		
	}
	
	/**
	 * Nombre funcion:	setTipoRetorno
	 * Proposito:		Cambia el tipo de dato que retorna la funcion de base de datos
	 * Fecha creacion:	19/03/2012
	 * @param $tipo puede ser recrod por defecto es varchar
	 *  
	 */
	function setTipoRetorno($tipo){
		$this->objDriver->setTipoRetorno($tipo);
	}

	/**
	 * Nombre funcion:	setCount
	 * Proposito:		Cambia el valor de count
	 * Fecha creacion:	12/04/2009
	 * @param $logico si se aplica count o no tru o false
	 * 
	 */
	function setCount($logico){
		$this->objDriver->setCount($logico);
	}

	/**
	 * Nombre funcion:	setTipoConexion
	 * Proposito:		establece el tipo de conexion por defecto persistente
	 * Fecha creacion:	12/04/2009
	 * @param $cadena tipo de conexion: persistente/no_persistente
	 */
	function setTipoConexion($cadena){
		$this->objDriver->setTipoConexion($cadena);
	}

	/**
	 * Nombre funcion:	armarConsulta
	 * Proposito:		arma la consulta correspondiente al tipo de procedimeinto
	 * Fecha creacion:	12/04/2009
	 * 
	 */
	function armarConsulta(){
		$this->objDriver->armarConsulta();
	}

	/**
	 * Nombre funcion:	ejecutarConsulta
	 * Proposito:		ejecuta la consulta que esta armado
	 * Fecha creacion:	12/04/2009
	 * @return 	respuesta de tipo mensaje
	 */
	function ejecutarConsulta($res=null){
		//echo '4';exit;
		$this->objDriver->ejecutarConsulta($res=null);
		/*echo 'r3';
		var_dump($this->objDriver);
		exit;*/
	}

	/**
	 * Nombre funcion:	ejecutarConsulta
	 * Autor: Jaime Rivera Rojas
	 * Proposito:		ejecuta la consulta que esta armado
	 * Fecha creacion:	23/07/2010
	 * @return 	respuesta de tipo mensaje
	 */
	function ejecutarConsultaSegu($res=null){
		$this->objDriver->ejecutarConsultaSegu($res=null);
	}

	/**
	 * Nombre funcion:	null
	 * Proposito:		devuelve true si la cadena no esta definida
	 * Fecha creacion:	12/04/2009
	 * 
	 */
	function null($cadena){
		return $this->objDriver->null($cadena);
	}

	function cambiarFormatoFecha($fecha){
		return $this->objDriver->cambiarFormatoFecha($fecha);
	}

	/**
	 * Nombre funcion:	getConsulta
	 * Proposito:		devuelve la cadena de la consulta armada
	 * Fecha creacion:	12/04/2009
	 * @return consulta (cadena)
	 */
	function getConsulta(){
		return $this->objDriver->getConsulta();
	}

	function divRespuesta($cadena){
		return $this->objDriver->divRespuesta($cadena);
	}
	
	/***************
	* PROPIEDADES
	***************/
	public function getEsMatriz(){
		return $this->objDriver->getEsMatriz();
	}
	public function setEsMatriz($pValor){
		$this->objDriver->setEsMatriz($pValor);
	}
	public function getCount(){
		return $this->objDriver->getCount();
	}
	public function arrayPushVariables($pValor){
		$this->objDriver->arrayPushVariables($pValor);
	}
	public function arrayPushTipos($pValor){
		$this->objDriver->arrayPushTipos($pValor);
	}
	public function arrayPushValores($pValor){
		$this->objDriver->arrayPushValores($pValor);
	}
	public function setValores($x,$y,$pValor){
		$this->objDriver->setValores($x,$y,$pValor);
	}
	public function setTipoProcedimiento($pValor){
		$this->objDriver->setTipoProcedimiento($pValor);
	}
	public function getRespuesta(){
		return $this->objDriver->getRespuesta();
	}
	public function getTransaccion(){
		return $this->objDriver->getTransaccion();
	}
	
}
?>