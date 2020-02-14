<?php
class driver
{
	//Definicion de datos bosicos para llamadas s parocedimeintos almacenados
	protected $id_usuario;
	protected $id_usuario_ai;
	protected $nom_usuario_ai;
	protected $ip;
	protected $mac;
	protected $procedimiento;
	protected $transaccion;
	protected $transaccion_count;
	protected $tipo_procedimiento;//SEL:para select y count IME:para inserciones o actualizaciones OTRO para otro tipo de funciones
	protected $id_categoria;
	protected $sw_boolean; //RAC - si la consulta reorna un tipo boleano se activa
	protected $nombres_booleanos=array();//RAC este array guardas los nombres de la variables booleanas
	//Definiciond e variables a ser usadas apra la llamada
	protected $consulta;
	protected $variables=array();
	protected $valores=array();
	protected $tipos=array();
	//RAC 31/12/2014 para gregar parametros al count
	protected $captura_count=array();
	protected $captura_tipo_count=array();


	protected $captura=array();
	protected $captura_tipo=array();
	protected $respuesta;
	protected $tipo_conexion;
	protected $separador_inicial = '$**$';
	protected $separador_error = '#**#';
	protected $separador_funcion = '@**@';
	protected $error_parametro;
	protected $mensaje_parametro;

	protected $res_parametro=array();

	/*variables de seleccion*/
	protected $filtro;
	protected $ordenacion;
	protected $direccion_ordenacion;
	protected $puntero;
	protected $cantidad;
	protected $nombre_archivo;
	protected $count;
	protected $addConsulta;
	protected $esMatriz;
	protected $remote = '';



	protected $parConsulta;//rac 23/09/2011 para mandar como parametro a la consulta de base de datos

	//rac 23/09/2001 array para recibir los parametros tipo bytea
	//protected $valoresFiles=array();
	protected $valoresFiles;
	protected $variablesFiles;

	//rac 26/09/2011  manejo de archivos
	protected $uploadFile;
	protected $extencion;
	protected $ruta_archivo;
	protected $create_thumb;
	protected $nombre_file;
	protected $nombre_col;
	protected $tipo_resp;

	protected $tipo_retorno;//por dfecto varchar




	var $consulta_armada;//para saber si la consulta ya fue armada ye sta lista para ser ejecutada
	/**
	 * Nombre funcion:	__construct
	 * Proposito:		Crea una instancia de driver llena los datos basicos para la ejecucion de funciones
	 * Fecha creacion:	12/04/2009
	 *
	 * @param cadena $procedimiento
	 * @param cadena $transaccion
	 * @param cadena $tipo
	 */
	function __construct(){


		//session_start();
		//RAC 25/10/2011: validacion de varialbes
		if(isset($_SESSION["ss_id_usuario"])){
				$this->id_usuario=$_SESSION["ss_id_usuario"];
		}

		if(isset($_SESSION["ss_id_usuario_ai"])){
                $this->id_usuario_ai=$_SESSION["ss_id_usuario_ai"];
        }

        if(isset($_SESSION["_NOM_USUARIO_AI"])){
                $this->nom_usuario_ai=$_SESSION["_NOM_USUARIO_AI"];
        }

		if (getenv('HTTP_CLIENT_IP')){
		    $this->ip = $_SERVER['HTTP_CLIENT_IP'];
		}
		else{
			if(isset($_SERVER['REMOTE_ADDR'])) {
			    $this->ip = $_SERVER['REMOTE_ADDR'];
			}
		}

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
		if (!isset($_REQUEST['pxp_verificarPermisos'])) {
			$_REQUEST['pxp_verificarPermisos']=true;
		}

	}


	function addConsulta(){
		//echo "ENTRA";
		//exit;

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
	 * Autor: Jaiminha Rivera Rojas
	 * Fecah Modificacion: 2/09/2011
	 * Autor Mod: Rensi Arteaga Copari
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

		if($tipo=='bytea')
		{
			$this->uploadFile=true;
			$this->extencion=$extencion;
			if($tipo_resp=='archivo')
			  $this->ruta_archivo=$paramacon;
			elseif($tipo_resp=='sesion')
			  $this->nom_sesion=$paramacon;//si esnombre variale sesion
			else
			  throw new Exception("El tipo de almacenamiento no esta definido correctamnete -".$tipo_resp);


			//$this->create_thumb=$create_thumb;
			$this->nombre_file=$nombre_file;
			$this->nombre_col=$nombre;

			$this->tipo_resp=$tipo_resp;//[listado, sesion,]



		}

		array_push($this->captura,$nombre);
		array_push($this->captura_tipo,$tipo);
	}

	/**
	 * Nombre funcion:	capturaCount
	 * Proposito:		Captura valores del count, no se admite bytea ni archiso
	 * Fecha creacion:	12/04/2009
	 * Autor: RAC
	 *
	 * @param $nombre Sera el nombre del campo
	 * @param $tipo Sera el tipo del campo
	 */
	function capturaCount($nombre,$tipo){

		array_push($this->captura_count,$nombre);
		array_push($this->captura_tipo_count,$tipo);
	}

    //RAC 10/08/2016 agregas 'E , en los valores para que respete los retornos de carro almacenados en base de datos
    //OJO  puede traer algun otro problema, en la pruebas basicos no tuvimos ninguno
    //JRR 27/11/2016 Escapara backslash de las cadenas
	function getArregloValores(){

		$arreglo='array[';

		if($this->esMatriz){
			foreach ($this->valores as $row){
				$arreglo.='array[';
				foreach ($row as $valor){
                    $valor = str_replace('\\','\\\\',$valor);

					$arreglo.="E'$valor',";
				}
				$arreglo = substr ($arreglo, 0, -1);
				$arreglo.='],';
			}

		}
		else{
			foreach ($this->valores as $valor){
                $valor = str_replace('\\','\\\\',$valor);
				$arreglo.="E'$valor',";
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
		//rac
		$this->nombres_booleanos=array();
		//Rac 31/12/2014 agregar variables para que el count tenga la opcion de retornar  mas valores
		$this->captura_count=array();
		$this->captura_tipo_count=array();
	}
	/**
	 * Nombre funcion:	resetCaptura
	 * Proposito:		Elimina los valores de los arreglos de captura
	 * Fecha creacion:	20/11/2009
	 *
	 */
	function resetParametros(){
		$this->variables=array();
		$this->tipos=array();
		$this->valores=array();
		$this->setUsuarioAi();

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
	 * Nombre funcion:	setRemote
	 * Proposito:		Define un servidor remoto pxp al que conectarse
	 * Fecha creacion:	12/04/2009
	 * @param $servidor nombre del servidor remoto
	 *
	 */
	function setRemote($servidor){
		$this->remote=$servidor;

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
		}
		elseif ($this->tipo_procedimiento=='IME'){
			$this->armarConsultaIme();
		}
		else{
			$this->armarConsultaOtro();

		}
		$this->consulta_armada=true;

	}

	/**
	 * Nombre funcion:	armarConsultaSel
	 * Proposito:		arma la consulta correspondiente al tipo seleccion
	 * Fecha creacion:	12/04/2009
	 *
	 */

	function armarConsultaSel(){

		$this->consulta='select * from pxp.f_intermediario_sel(';

		//agrega parametros fijos a la consulta intermediario sel
		if($this->null($this->id_usuario)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.=$this->id_usuario.',';
		}

		if($this->null($this->id_usuario_ai)){
            $this->consulta.='NULL,';
        }
       else{
            $this->consulta.=$this->id_usuario_ai.',';

        }

        if($this->null($this->nom_usuario_ai)){
            $this->consulta.='NULL::varchar,';
        }
        else{
            $this->consulta.="'".$this->nom_usuario_ai."',";
        }



		$this->consulta.="'".session_id()."',";
		$this->consulta.=getmypid().',';
		if($this->null($this->ip)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->ip."',";
		}

		if($this->null($this->mac)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->mac."',";
		}

		if($this->null($this->procedimiento)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->procedimiento."',";
		}

		if($this->null($this->transaccion)){
			$this->consulta.='NULL,';

		}
		else{

			$this->consulta.="'".$this->transaccion."',";
		}

		if($this->null($this->id_categoria)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.$this->id_categoria.',';
		}

		 if( !isset($_SESSION["_LOGIN"]) || !isset($_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]])){

			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.='array[';
			for($i=0;$i<count($_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]]);$i++){
				if($i==0){
					$this->consulta.="'".$_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]][$i]."'";
				}
				else{
					$this->consulta.=",'".$_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]][$i]."'";
				}
			}
			$this->consulta.='],';
		}


		if(count($this->variables)==0){
			$this->consulta.='NULL,NULL,NULL)';
		}
		else
		{
			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->variables[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->variables[$i]."'";
				}
			}
			$this->consulta.='],';
			$this->consulta=$this->consulta.$this->getArregloValores().",";


			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->tipos[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->tipos[$i]."'";
				}
			}

			$this->consulta.=']';

		}


        $tipo_retorno=' as (';

		for($i=0;$i<count($this->captura);$i++){
			if($i==0){
				$tipo_retorno.=$this->captura[$i]." ".$this->captura_tipo[$i];
			}
			else{
				$tipo_retorno.=",".$this->captura[$i]." ".$this->captura_tipo[$i];
			}
		}

		$tipo_retorno.=')';

       //rac 19032012 aumenta tipo de retorno
       if($this->tipo_retorno=='varchar')
	   {
		if($_REQUEST['pxp_verificarPermisos']==true)
			$this->consulta.=",false";
		else
			$this->consulta.=",true";
        $this->consulta.=',\'varchar\',NULL)';
		$this->consulta.=$tipo_retorno;
	   }
	   else{
		 if($_REQUEST['pxp_verificarPermisos']==true)
			$this->consulta.=",false";
		 else
			$this->consulta.=",true";
		 $this->consulta.=",'record','$tipo_retorno')";
		 $this->consulta.=$tipo_retorno;

	   }



	}

	/**
	 * Nombre funcion:	armarConsulta
	 * Proposito:		arma la consulta correspondiente al tipo conteo de datos
	 * Fecha creacion:	12/04/2009
	 *
	 */

	function armarConsultaCount(){
		$this->consulta='select * from pxp.f_intermediario_sel(';

		if($this->null($this->id_usuario)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.=$this->id_usuario.',';
		}

		if($this->null($this->id_usuario_ai)){
            $this->consulta.='NULL,';
        }
        else{
            $this->consulta.=$this->id_usuario_ai.',';
        }

        if($this->null($this->nom_usuario_ai)){
            $this->consulta.='NULL::varchar,';
        }
        else{
            $this->consulta.="'".$this->nom_usuario_ai."',";
        }

		$this->consulta.="'".session_id()."',";
		$this->consulta.=getmypid().',';
		if($this->null($this->ip)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->ip."',";
		}

		if($this->null($this->mac)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->mac."',";
		}

		if($this->null($this->procedimiento)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->procedimiento."',";
		}

		if($this->null($this->transaccion)){
			$this->consulta.='NULL,';

		}
		else{

			$this->consulta.="'".$this->transaccion_count."',";
		}

		if($this->null($this->id_categoria)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.$this->id_categoria.',';
		}

		 if( !isset($_SESSION["_LOGIN"]) || !isset($_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]])){

			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.='array[';
			for($i=0;$i<count($_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]]);$i++){
				if($i==0){
					$this->consulta.="'".$_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]][$i]."'";
				}
				else{
					$this->consulta.=",'".$_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]][$i]."'";
				}
			}
			$this->consulta.='],';
		}


		if(count($this->variables)==0){
			$this->consulta.='NULL,NULL,NULL,';
		}
		else
		{
			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->variables[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->variables[$i]."'";
				}
			}
			$this->consulta.='],';

			$this->consulta=$this->consulta.$this->getArregloValores().",";

			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->tipos[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->tipos[$i]."'";
				}
			}
			$this->consulta.=']';

		}


		 //rac 19032012 aumenta tipo de retorno
       if($this->tipo_retorno=='varchar')
	   {
        $this->consulta.=',NULL,\'varchar\',NULL)';
	   }
	   else{
	   	$this->consulta.=",NULL,'record','as (total bigint)')";
		}
        //
		$this->consulta.= $this->armaRetornoCount();

	}

    /**
	 * Nombre funcion:	armaRetornoCount
	 * Proposito:		prepra el string para las variable de retorno del count, por defecto si no hay datos de captura coloca el total bogint
	 * Fecha creacion:	12/04/2014
	 *
	 */

    function armaRetornoCount(){

		$tipo_retorno=' as (total bigint';

		for($i=0;$i<count($this->captura_count);$i++){
			$tipo_retorno.=",".$this->captura_count[$i]." ".$this->captura_tipo_count[$i];

		}

		$tipo_retorno.=')';

		return  $tipo_retorno;
    }


	/**
	 * Nombre funcion:	armarConsulta
	 * Proposito:		arma la consulta correspondiente al tipo insertar,modificar o eliminar
	 * Fecha creacion:	12/04/2009
	 *
	 */
	function armarconsultaIme(){
		$this->consulta='select * from pxp.f_intermediario_ime(';

		if($this->null($this->id_usuario)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.=$this->id_usuario.',';
		}

		if($this->null($this->id_usuario_ai)){
            $this->consulta.='NULL,';
        }
        else{
            $this->consulta.=$this->id_usuario_ai.',';
        }

        if($this->null($this->nom_usuario_ai)){
            $this->consulta.='NULL::varchar,';
        }
        else{
             $this->consulta.="'".$this->nom_usuario_ai."',";
        }

		$this->consulta.="'".session_id()."',";
		$this->consulta.=getmypid().',';
		if($this->null($this->ip)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->ip."',";
		}

		if($this->null($this->mac)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->mac."',";
		}

		if($this->null($this->procedimiento)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->procedimiento."',";
		}

		if($this->null($this->transaccion)){

			$this->consulta.='NULL,';
		}
		else{

			$this->consulta.="'".$this->transaccion."',";
		}

		if($this->null($this->id_categoria)){

			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.=$this->id_categoria.',';
		}

		if(!$this->esMatriz){

			$this->consulta.="'no',";
		}
		else{
			$this->consulta.="'si',";
		}

	    if( !isset($_SESSION["_LOGIN"]) || !isset($_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]])){

			$this->consulta.='NULL,';
		}
		else{

			$this->consulta.='array[';
			for($i=0;$i<count($_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]]);$i++){
				if($i==0){
					$this->consulta.="'".$_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]][$i]."'";
				}
				else{
					$this->consulta.=",'".$_SESSION["_IP_ADMIN"][$_SESSION["_LOGIN"]][$i]."'";
				}
			}
			$this->consulta.='],';
		}



		if(count($this->valores)==0){
			$this->consulta.='NULL,NULL,NULL';
		}
		else
		{
			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->variables[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->variables[$i]."'";
				}
			}
			$this->consulta.='],';
			$this->consulta=$this->consulta.$this->getArregloValores().",";

			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->tipos[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->tipos[$i]."'";
				}
			}
			$this->consulta.=']';

		}
		//manda la consulta como un parametro adicional
		//cunado son archivo upload file esto duplicaria la cantida archivos
		//rac 23/09/2011
		if ($this->uploadFile){
			//armar array de valores

			//rac 27/09/2011  consulta para no repetir
			$this->parConsulta=$this->consulta.",'".str_replace("'","''",$this->consulta).",NULL,NULL)'";
			$this->consulta.=",'".str_replace("'","''",$this->consulta).",NULL,'$this->valoresFiles')',$this->valoresFiles,$this->variablesFiles)";

		}
		else{
		  $this->consulta.=",'".str_replace("'","''",$this->consulta).",NULL,NULL,NULL)',NULL,NULL)";
		}


	}
	function armarConsultaOtro(){

	}

	/**
	 * Nombre funcion:	ejecutarConsulta
	 * Proposito:		ejecuta la consulta que esta armado
	 * Fecha creacion:	12/04/2009
	 * @return 	respuesta de tipo mensaje
	 */

  function ejecutarConsulta($res=null){
		/*
		echo "WWW  ".$t."  OOO<br>";
		//exit;
		*/



		if($this->consulta_armada){
			if($this->tipo_procedimiento=='SEL'){
				//echo 'b:'.$res;exit;
				$this->ejecutarConsultaSel($res);
			}
			elseif ($this->tipo_procedimiento=='IME'){
				//echo 'c';exit;
				$this->ejecutarConsultaIme($res);
			}

			else{
				//echo 'd';exit;
				$this->ejecutarConsultaOtro($res);

			}

		}
		else{
			//echo 'e';exit;
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
			//echo 'b';exit;
			if($this->tipo_procedimiento=='SEL'){
				$this->ejecutarConsultaSel($res);
			}
			elseif ($this->tipo_procedimiento=='IME'){
				//echo 'c';exit;
				$this->ejecutarConsultaIme($res);
			}

			else{
				//echo 'd';exit;
				$this->ejecutarConsultaOtro($res);

			}

		}
		else{
			//echo 'e';exit;
			$this->respuesta=new Mensaje();
			//rac 23/09/2011 para que no regrese la consulta ejecuta con el archivo insertado
			if($this->uploadFile){
				$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'Error al ejecutar la transaccion','La consulta no fue armada para ser ejecutada','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->parConsulta);
			}
			else{
      			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'Error al ejecutar la transaccion','La consulta no fue armada para ser ejecutada','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			}
		}


	}

	/**
	 * Nombre funcion:	ejecutarConsultaSel
	 * Autor:    Jaime Rivera Rojas
	 * Proposito:		ejecuta la consulta detipo seleccion y conteo de datos
	 * Fecha creacion:	12/04/2009
	 * Autor Modificacion: Jaime Rivera
	 * Fecha mod 02/09/2011
	 * Desc mod:  Modificaicon para que recupera datos boleanos en formato javaScript
	 *
	 */
	function ejecutarConsultaSel($res=null){

		$array=Array();
		if($res!=null){
			//echo 'aa';exit;
			$this->respuesta=$res;
		} else{
			//echo 'bb';exit;
			$this->respuesta=new Mensaje();
		}

		$cone=new conexion();

		if($this->tipo_conexion=='persistente'){
			//echo 'fff';exit;
			$link=$cone->conectarp();
		}
	    elseif($this->tipo_conexion=='seguridad'){
	    	//echo 'aaa';exit;
			$link=$cone->conectarSegu();
		}
		else{
			//echo 'sss';exit;
			$link=$cone->conectarnp($this->remote);
		}



		if($link==0){

			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'No se puede conectar a la base de datos','Revise la cadena de conexion a la BD','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
		}
		//Si tengo conexion a la Bd ejecuto la consulta
		else{

			$res=pg_query($link,$this->consulta);
   		if($res)
			{

				//RAC 26/09/2011
				 if($this->tipo_resp=='sesion'){

				 	$_SESSION[$this->nom_sesion]=array();
				 }

				while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC)){
			     	//RAC 02/09/2011
			     	//modificacion
					if($this->sw_boolean){

						//echo '>>> '.$i;
						for($i=0;$i<count($this->nombres_booleanos);$i++){

							if(isset($row[$this->nombres_booleanos[$i]])){

								if($row[$this->nombres_booleanos[$i]]=='f')
								  $row[$this->nombres_booleanos[$i]]="false";
								else
							      $row[$this->nombres_booleanos[$i]]="true";
							}
						}

					}

					if($this->uploadFile){

						//RAC 19/05/2011

						if($this->tipo_resp=='archivo'){

							//crea un archivo fisico en el servidor
							if($row[$this->nombre_file]!=''&&$row[$this->extencion]!='')
							{
							 $handle=fopen($this->ruta_archivo.$row[$this->nombre_file].'.'.$row[$this->extencion], "w+"); //abrir un enlace a la imagen de acuerdo al oid
				             $row[$this->nombre_col]=base64_decode(pg_unescape_bytea($row[$this->nombre_col]));//decodificar la imagen
					         fwrite($handle, $row[$this->nombre_col]);
					         fclose($handle);
					         $row[$this->nombre_col]=$row[$this->nombre_file].'.'.$row[$this->extencion];

							}
						   }
	                     elseif($this->tipo_resp=='sesion'){


	                     	 //$row[$this->nombre_col]=
	                     	//guardamos los datos de archivos en variable de sesion
	                     	//para no crear un archivo fisico
	                     	$_SESSION[$this->nom_sesion][$row[$this->nombre_file].'.'.$row[$this->extencion]]= base64_decode(pg_unescape_bytea($row[$this->nombre_col]));//decodificar la imagen


	                     	$row[$this->nombre_col]=$row[$this->nombre_file].'.'.$row[$this->extencion];
	                     	//$row[$this->nombre_col]=$row[$this->nombre_file];

	                     }
	                     else{
	                     		throw new Exception("No esta definido el tipo de respuesta BYTEA son admitidos (archivo,sesion) no se reconcoe -> $this->tipo_resp");

	                     }

					}

					array_push ($array, $row);

				}
				//Libera la memoria
				pg_free_result($res);


				//EXITO en la transaccion
				$this->respuesta->setMensaje('EXITO',$this->nombre_archivo,'Consulta ejecutada con exito','Consulta ejecutada con exito','base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				if($this->addConsulta){

					$this->respuesta->setDatos(array_merge($this->respuesta->getDatos(),$array));
				//var_dump($array);

				}
				else {
					$this->respuesta->setDatos($array);



				}


				//si hay count
				$this->transaccion_count=str_replace('_SEL','_CONT',$this->transaccion);
				$this->armarConsultaCount();
				unset($array);
				$array=Array();

				if($this->count){

					//TODO ,...agegar parametros de suma a la consulta del  count ....



					//Hago la consulta de count
					if($res = pg_query($link,$this->consulta))
					{

						while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC))
						{
							array_push ($array, $row);
						}

						//Libera la memoria
						pg_free_result($res);

						//EXITO en la transaccion
						$this->respuesta->setTotal($array[0]['total']);

						//RAC 31/12/2014  add extra param from count query
						$extra_data = array();

						for($i=0;$i<count($this->captura_count);$i++){
							$extra_data[$this->captura_count[$i]] = $array[0][$this->captura_count[$i]];

						}
						$this->respuesta->setExtraData($extra_data);

						//armo la consulta original
						$this->armarConsultaSel();

						//Hago la consulta de count
					}
					else
					{
						$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));

						//Existe error en la base de datos tomamamos el mensaje y el mensaje tecnico
						$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'Error al ejecutar la consulta',$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion_count,$this->tipo_procedimiento,$this->consulta);
						//armo la consulta original
						$this->armarConsultaSel();

					}//fin count

				}

			}
			else
			{

				//echo 'mensaje:'.str_replace('ERROR:  ','', pg_last_error($link));exit;
				$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));

				//Existe error en la base de datos tomamamos el mensaje y elmensaje tecnico
				$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);

			}
		}

       $cone->desconectarnp($link);


	}

	/**
	 * Nombre funcion:	ejecutarConsultaIme
	 * Proposito:		ejecuta la consulta de tipo insercion o modificacion o eliminacion
	 * Fecha creacion:	12/04/2009
	 *
	 */
	function ejecutarConsultaIme(){
		$array=Array();
		$this->respuesta=new Mensaje();
		$cone=new conexion();
		if($this->tipo_conexion=='persistente'){
			$link=$cone->conectarp();
		}
		elseif($this->tipo_conexion=='seguridad'){
			$link=$cone->conectarSegu();
		}
		else{
			$link=$cone->conectarnp($this->remote);
		}

		if($link==0){

			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'No se puede conectar a la base de datos','Revise la cadena de conexion a la BD','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
		}
		//Si tengo conexion a la Bd ejecuto la consulta
		else{

			//echo $this->consulta;
			//exit;

			if($res = pg_query($link,$this->consulta))
			{

				while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC))
				{
					array_push ($array, $row);
				}

				//Libera la memoria
				pg_free_result($res);

				//Verifica si se produjo algon error logico en la funcion
				$resp_procedimiento = $this->divRespuesta($array[0]['f_intermediario_ime']);
				  if($this->uploadFile){
					$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->parConsulta);
				  }
				  else{
	      			$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				  }

                 $this->respuesta->setDatos($resp_procedimiento['datos']);


			}
			else
			{

				$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));
				$this->respuesta->setDatos($resp_procedimiento['datos']);
				  if($this->uploadFile){

					$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->parConsulta);
				  }
				  else{
	      			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				  }


			}
		}

   $cone->desconectarnp($link);


	}
	function ejecutarConsultaOtro(){

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
		$res=array();
		//echo $cadena;exit;
		//Limpia el json si corresponde
		$aux=strripos ($cadena,'}');
		$cadena=substr($cadena,0,$aux+1);
		//echo $cadena;exit;

		//jrr:removiendo saltos de linea y tabas para una buena decodificacion del json
		$cadena = preg_replace(array('/\s{2,}/', '/[\t\n]/'), ' ', $cadena);

		$res=json_decode($cadena,true);


		$res['datos']=$res;


		if(count($res['datos'])>0)
			$aux=array_shift($res['datos']);

		if(count($res['datos'])>0)
			$aux=array_shift($res['datos']);

		if(count($res['datos'])>0)
			$aux=array_shift($res['datos']);

		if(count($res['datos'])>0)
			$aux=array_shift($res['datos']);

		//var_dump($aux);exit;

		if($res['tipo_respuesta']=='EXITO'){
			$res['mensaje']="La transacción se ha ejecutado con éxito";
			$res['mensaje_tec']="La transacción se ha ejecutado con éxito";
		}
		else
		{
			if($res['codigo_error']!='P0001' && $_SESSION["_ESTADO_SISTEMA"] != "desarrollo"){
				$res['mensaje']="Ha ocurrido un incidente. Comunique el registro (".$res['id_log'].")";
			}
			$res['mensaje_tec']=$res['mensaje']."   Procedimientos: ".$res['procedimientos'];
		}

		return $res;

	}


}
?>