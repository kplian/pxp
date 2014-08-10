<?php
/*
Autor: RCM
Fecha: 03/06/2014
Archivo: absDriver.php
Descripción: Clase abstracta base con los métodos generales para los drivers de bases de datos
*/
abstract class absDriver {
	protected $transaccion_count;
	protected $id_categoria;
	
	//Definicion de variables a ser usadas para la llamada
	protected $consulta;
	protected $respuesta;
	protected $separador_inicial = '$**$';
	protected $separador_error = '#**#';
	protected $separador_funcion = '@**@';
	protected $mensaje_parametro;
	protected $res_parametro=array();

	/*variables de seleccion*/
	protected $filtro;
	protected $ordenacion;
	protected $direccion_ordenacion;
	protected $puntero;
	protected $cantidad;
	protected $parConsulta;//rac 23/09/2011 para mandar como parametro a la consulta de base de datos
	
	//rac 23/09/2001 array para recibir los parametros tipo bytea
	//protected $valoresFiles=array();
	public $valoresFiles;
	public $variablesFiles;
	protected $objCnx;//Objeto conexión base de datos
	protected $objLinkCnx;//Objeto link de conexión base de datos
	
	/*********************************/
	/*********************************/
	//escogidas
	protected $id_usuario;
	protected $id_usuario_ai;
	protected $nom_usuario_ai;
	protected $ip;
	protected $mac;
	private $consulta_armada;//para saber si la consulta ya fue armada ye sta lista para ser ejecutada
	protected $nombre_archivo;
	protected $tipo_conexion;
	protected $error_parametro;
	protected $count;
	protected $tipo_retorno;//por dfecto varchar
	protected $sw_boolean; //RAC - si la consulta reorna un tipo boleano se activa
	protected $addConsulta;
	//rac 26/09/2011  manejo de archivos
	protected $uploadFile;
	protected $extencion;
	protected $ruta_archivo;
	protected $create_thumb;
	protected $nombre_file;
	protected $nombre_col;
	protected $tipo_resp;
	
	protected $transaccion;
	protected $procedimiento;
	protected $nombres_booleanos=array();//RAC este array guardas los nombres de la variables booleanas
	protected $nom_sesion;
	protected $captura=array();
	protected $captura_tipo=array();
	protected $esMatriz;
	protected $valores=array();
	protected $variables=array();
	protected $tipos=array();
	protected $tipo_procedimiento;//SEL:para select y count IME:para inserciones o actualizaciones OTRO para otro tipo de funciones
	
	/*********************************/
	/*********************************/
	
	//nuevas
	protected $strMotorBD;
	protected $objDriver;
	
	/**
	 * Nombre funcion:	__construct
	 * Proposito:		Crea una instancia de driver llena los datos basicos para la ejecucion de funciones
	 * Fecha creacion:	12/04/2009
	 *
	 * @param cadena $procedimiento
	 * @param cadena $transaccion
	 * @param cadena $tipo
	 */
	function __construct($pMotorBD='pg') {
		//RAC 25/10/2011: validacion de varialbes
		if(isset($_SESSION["ss_id_usuario"])){
			$this->id_usuario=$_SESSION["ss_id_usuario"];
		}
		/*ob_start();
		$fb=FirePHP::getInstance(true);
		$fb->log('usuario:'.$_SESSION["ss_id_usuario"],"construct ABSDRIVER");*/
		
		if(isset($_SESSION["ss_id_usuario_ai"])){
            $this->id_usuario_ai=$_SESSION["ss_id_usuario_ai"];
        }
        
        if(isset($_SESSION["_NOM_USUARIO_AI"])){
                $this->nom_usuario_ai=$_SESSION["_NOM_USUARIO_AI"];
        }
		
		$this->ip=getenv("REMOTE_ADDR");
		$this->mac="99:99:99:99:99:99";
		$this->consulta_armada=false;
		$this->nombre_archivo='driver.php';
		$this->tipo_conexion=$_SESSION["_TIPO_CONEXION"];
		//$this->tipo_conexion='persistente';
		$this->error_parametro=false;
		$this->count=true;
		//rac 19032012
		$this->tipo_retorno = 'varchar';
		//rac - por defecto la consulta no regresa boleanos
		$this->sw_boolean =false;
		//para el manejo de erores y no mostrar consultas de la base de datos sin controlarlas
		//error_reporting(0);
		$this->addConsulta=false;
		//rac 23/09/2011 upload false apagado por defecto
		$this->uploadFile=false;
	}

	function addConsulta(){
		$this->addConsulta=true;
	}

	function setTransaccion($transaccion){
		$this->transaccion=$transaccion;
	}

	function setProcedimiento($procedimiento){
		$this->procedimiento=$procedimiento;
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
		if($tipo=='boolean'){
			$this->sw_boolean =true;
			array_push($this->nombres_booleanos,$nombre);
		}
		
		if($tipo=='bytea'){
			$this->uploadFile=true;
			$this->extencion=$extencion;
			if($tipo_resp=='archivo'){
				$this->ruta_archivo=$paramacon;
			} elseif($tipo_resp=='sesion') {
				$this->nom_sesion=$paramacon;//si esnombre variale sesion
			} else {
				throw new Exception("El tipo de almacenamiento no esta definido correctamnete -".$tipo_resp);	
			}
			$this->nombre_file=$nombre_file;
			$this->nombre_col=$nombre;			
			$this->tipo_resp=$tipo_resp;//[listado, sesion,]
		}
		array_push($this->captura,$nombre);
		array_push($this->captura_tipo,$tipo);
	}

	function getArregloValores() {
		$arreglo='array[';
		if($this->esMatriz){
			foreach ($this->valores as $row){
				$arreglo.='array[';
				foreach ($row as $valor){
					$arreglo.="'$valor',";
				}
				$arreglo = substr ($arreglo, 0, -1);
				$arreglo.='],';
			}
		} else{
			foreach ($this->valores as $valor){
				$arreglo.="'$valor',";
			}
		}
		$arreglo = substr ($arreglo, 0, -1);
		$arreglo.=']';
		return $arreglo;
	}

	/**
	 * Nombre funcion:	resetCaptura
	 * Proposito:		Elimina los valores de los arreglos de captura
	 * Fecha creacion:	20/11/2009
	 * 
	 */
	function resetCaptura(){
		$this->captura=array();
		$this->captura_tipo=array();
		$this->nombres_booleanos=array();
	}
	
	/**
	 * Nombre funcion:	resetParametros
	 * Proposito:		Elimina los valores de los arreglos de captura
	 * Fecha creacion:	20/11/2009
	 * 
	 */
	function resetParametros(){
		$this->variables=array();
		$this->tipos=array();
		$this->valores=array();		
	}
	
	/**
	 * Nombre funcion:	setTipoRetorno
	 * Proposito:		Cambia el tipo de dato que retorna la funcion de base de datos
	 * Fecha creacion:	19/03/2012
	 * @param $tipo puede ser recrod por defecto es varchar
	 *  
	 */
	function setTipoRetorno($tipo){
		$this->tipo_retorno=$tipo;
	}

	/**
	 * Nombre funcion:	setCount
	 * Proposito:		Cambia el valor de count
	 * Fecha creacion:	12/04/2009
	 * @param $logico si se aplica count o no tru o false
	 * 
	 */
	function setCount($logico){
		$this->count=$logico;
	}

	/**
	 * Nombre funcion:	setTipoConexion
	 * Proposito:		establece el tipo de conexion por defecto persistente
	 * Fecha creacion:	12/04/2009
	 * @param $cadena tipo de conexion: persistente/no_persistente
	 */
	function setTipoConexion($cadena){
		$this->tipo_conexion=$cadena;
	}

	/**
	 * Nombre funcion:	armarConsulta
	 * Proposito:		arma la consulta correspondiente al tipo de procedimeinto
	 * Fecha creacion:	12/04/2009
	 * 
	 */
	function armarConsulta(){
		if($this->tipo_procedimiento=='SEL'){
			$this->armarConsultaSel();
		} elseif($this->tipo_procedimiento=='IME'){
			$this->armarConsultaIme();
		} else{
			$this->armarConsultaOtro();
		}
		$this->consulta_armada=true;
	}

	/**
	 * Nombre funcion:	ejecutarConsulta
	 * Proposito:		ejecuta la consulta que esta armado
	 * Fecha creacion:	12/04/2009
	 * @return 	respuesta de tipo mensaje
	 */
	function ejecutarConsulta($res=null){
		if($this->consulta_armada){
			if($this->tipo_procedimiento=='SEL'){
				$this->ejecutarConsultaSel($res);
			} elseif ($this->tipo_procedimiento=='IME'){
				//echo '5';exit;
				$this->ejecutarConsultaIme($res);
				//echo 'r1';exit;
			} else {
				$this->ejecutarConsultaOtro($res);
			}
			//echo 'r2';exit;
		} else{
			$this->respuesta=new Mensaje();
			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'Error al ejecutar la transaccion','La consulta no fue armada para ser ejecutada','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
		}
	}

	/**
	 * Nombre funcion:	ejecutarConsulta
	 * Autor: Jaime Rivera Rojas
	 * Proposito:		ejecuta la consulta que esta armado
	 * Fecha creacion:	23/07/2010
	 * @return 	respuesta de tipo mensaje
	 */
	function ejecutarConsultaSegu($res=null){
		if($this->consulta_armada){
			if($this->tipo_procedimiento=='SEL'){
				$this->objDriver->ejecutarConsultaSel($res);
			} elseif ($this->tipo_procedimiento=='IME'){
				$this->objDriver->ejecutarConsultaIme($res);
			} else{
				$this->objDriver->ejecutarConsultaOtro($res);
			}
		} else{
			$this->respuesta=new Mensaje();
			//rac 23/09/2011 para que no regrese la consulta ejecuta con el archivo insertado
			if($this->uploadFile){
				$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'Error al ejecutar la transaccion','La consulta no fue armada para ser ejecutada','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->parConsulta);
			} else{
      			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'Error al ejecutar la transaccion','La consulta no fue armada para ser ejecutada','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			}
		}
	}

	/**
	 * Nombre funcion:	null
	 * Proposito:		devuelve true si la cadena no esta definida
	 * Fecha creacion:	12/04/2009
	 * 
	 */
	function null($cadena){
		if(trim($cadena)==''){
			return true;
		}
	}

	function cambiarFormatoFecha($fecha){
		list($dia,$mes,$anio)=explode("/",$fecha);
		return $mes."/".$dia."/".$anio;
	}

	/**
	 * Nombre funcion:	getConsulta
	 * Proposito:		devuelve la cadena de la consulta armada
	 * Fecha creacion:	12/04/2009
	 * @return consulta (cadena)
	 */
	function getConsulta(){
		return $this->consulta;
	}

	function divRespuesta($cadena){
		return $this->objDriver->divRespuesta($cadena);
	}
	
	/***************
	* PROPIEDADES
	***************/
	public function getEsMatriz(){
		return $this->esMatriz;
	}
	public function setEsMatriz($pValor){
		$this->esMatriz = $pValor;
	}
	public function getCount(){
		return $this->count;
	}
	public function ArrayPushVariables($pValor){
		array_push($this->variables,$pValor);
	}
	public function ArrayPushTipos($pValor){
		array_push($this->tipos,$pValor);
	}
	public function ArrayPushValores($pValor){
		array_push($this->valores,$pValor);
	}
	public function setValores($x,$y,$pValor){
		$this->valores[$x][$y] = $pValor;
	}
	public function setTipoProcedimiento($pValor){
		$this->tipo_procedimiento = $pValor;
	}
	public function getRespuesta(){
		return $this->respuesta;
	}
	function getTransaccion(){
		return $this->transaccion;
	}

}
?>