<?php
class GENTabla { 
	
	private $nombre_tabla;
	private $nombre_esquema;
	private $titulo;
	private $carpeta_subsis;
	private $reemplazar;
	private $menu;
	private $alias;
	private $prefijo;
	private $direccion;
	private $llave_primaria;
	private $cantPrefijoTabla;
	private $aNombresArchivos;
	private $aNombresFunciones;
	private $quitarPrefijo;
	private $prefijoTabla;
	private $fecha_hora;
	private $aComentariosDefecto;
	private $aComentariosDefectoTrans;
	private $subsistema;
	private $nomArchPref='gen-';
	
	
	
	function __construct($arreglo){
		date_default_timezone_set('UTC');
		$this->nombre_tabla=$arreglo['nombre'];
		$this->nombre_esquema=$arreglo['esquema'];
		$this->titulo=$arreglo['titulo'];
		$this->carpeta_subsis=$arreglo['nombre_carpeta'];
		$this->reemplazar=$arreglo['reemplazar'];
		$this->menu=$arreglo['menu'];
		$this->alias=$arreglo['alias'];
		$this->prefijo=$arreglo['prefijo'];
		$this->direccion=$arreglo['direccion'];
		$this->llave_primaria=$arreglo['llave_primaria'];
		$this->cant_grupos=$arreglo['cant_grupos'];
		$this->subsistema=$arreglo['desc_subsistema'];
		
		//Para sacar el nombre de la tabla quitando los n caracteres del prefijo
		$this->cantPrefijoTabla=$_SESSION["_CANT_PREFIJO_TABLA"];
		$this->quitarPrefijo=$_SESSION["_QUITAR_CANT_PREFIJO_TABLA"];
		$this->prefijoTabla=$_SESSION["_PREFIJO_TABLA"];
		
		//Obtiene la hora de creaci�n
		$this->fecha_hora='_'.date("d-m-Y H:i");
		
		//Definici�n de los nombres de los archivos
		$this->definirNombresArchivosFunciones();
		
		//Definici�n de los comentarios por defecto de funciones y de transacciones
		$this->definirComentariosDefecto();
		$this->definirComentariosDefectoTrans();
		
	}
	
	//M�todos
	
	private function definirComentariosDefecto(){
		$this->aComentariosDefecto['bd_ime']="Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla '".$this->getNombreTablaCompleto()."'";
		$this->aComentariosDefecto['bd_sel']="Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla '".$this->getNombreTablaCompleto()."'";
		$this->aComentariosDefecto['modelo']="Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas";
		$this->aComentariosDefecto['custom']="Clase que centraliza todos los metodos de todas las clases del Sistema de ".$this->subsistema;
		$this->aComentariosDefecto['control']="Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo";
		$this->aComentariosDefecto['vista']="Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema";
	}
	
	private function definirComentariosDefectoTrans(){
		$this->aComentariosDefectoTrans['ins']="Insercion de registros";
		$this->aComentariosDefectoTrans['mod']="Modificacion de registros";
		$this->aComentariosDefectoTrans['del']="Eliminacion de registros";
		$this->aComentariosDefectoTrans['sel']="Consulta de datos";
		$this->aComentariosDefectoTrans['cont']="Conteo de registros";
	}
	
	//Genera los nombres para los archivos
	private function definirNombresArchivosFunciones(){
		//Nombres de archivos
		/*$this->aNombresArchivos['bd_ime']=$this->getNombreFuncionBDesquema()."_ime".$this->fecha_hora.".sql";
		$this->aNombresArchivos['bd_sel']=$this->getNombreFuncionBDesquema()."_sel".$this->fecha_hora.".sql";
		$this->aNombresArchivos['modelo']='MOD'.$this->getSujetoTablaJava().$this->fecha_hora.".php";
		$this->aNombresArchivos['custom']='Funciones'.$this->getCarpetaSistemaJava().$this->fecha_hora.".php";
		$this->aNombresArchivos['control']='ACT'.$this->getSujetoTablaJava().$this->fecha_hora.".php";
		$this->aNombresArchivos['vista']=$this->getSujetoTablaJava().$this->fecha_hora.".php";*/
		
		$this->aNombresArchivos['bd_ime']=$this->nomArchPref.$this->getNombreFuncionBDesquema()."_ime".".sql";
		$this->aNombresArchivos['bd_sel']=$this->nomArchPref.$this->getNombreFuncionBDesquema()."_sel".".sql";
		$this->aNombresArchivos['modelo']=$this->nomArchPref.'MOD'.$this->getSujetoTablaJava().".php";
		$this->aNombresArchivos['custom']=$this->nomArchPref.'Funciones'.$this->getCarpetaSistemaJava().".php";
		$this->aNombresArchivos['custom_anx']='Funciones'.$this->getCarpetaSistemaJava().".php";
		$this->aNombresArchivos['control']=$this->nomArchPref.'ACT'.$this->getSujetoTablaJava().".php";
		$this->aNombresArchivos['vista']=$this->nomArchPref.$this->getSujetoTablaJava().".php";
		
		//Nombres de funciones
		$this->aNombresFunciones['bd_ime']=$this->getNombreFuncionBDesquema()."_ime";
		$this->aNombresFunciones['bd_sel']=$this->getNombreFuncionBDesquema()."_sel";
		$this->aNombresFunciones['modelo']='MOD'.$this->getSujetoTablaJava();
		$this->aNombresFunciones['custom']='Funciones'.$this->getCarpetaSistemaJava();
		$this->aNombresFunciones['control']='ACT'.$this->getSujetoTablaJava();
		$this->aNombresFunciones['vista']=$this->getSujetoTablaJava();
		/*echo '<pre>';
		print_r($this->aNombresArchivos);
		echo '</pre>';
		exit;*/
	}
	
	//Funci�n substr que verifica si en el archivo de configuraci�n se eliminar� las letras del prefijo
	private function _substr($pCadena,$bd=1){
		if($bd){
			//Para BD pregunta si quita o no el prefijo de tabla
			if($this->quitarPrefijo=='si'){
				return substr($pCadena, $this->cantPrefijoTabla);
			} else{
				return $pCadena;
			}
		} else{
			//Para los otros casos siempre quita la cantidad del prefijo
			return substr($pCadena, $this->cantPrefijoTabla);
		}
	}
	
	function getSujetoTablaJava(){
		return ucfirst($this->_substr($this->getNombreTablaJava(),0));
	}
	
	function getSujetoTabla(){
		//return ucfirst($this->_substr(substr($this->getNombreTabla(),1),0));
		//return $this->_substr(substr($this->getNombreTabla(),1),0);
		return $this->_substr(substr($this->getNombreTabla(),0),0);
	}
	
	
	
	//Propiedades
	function getFechaHora(){
		return $this->fecha_hora;
	}
	function getComentariosDefecto($pTipo){
		return $this->aComentariosDefecto[$pTipo];
	}
	function getComentariosDefectoTrans($pTipo){
		return $this->aComentariosDefectoTrans[$pTipo];
	}
	function getSubsistema(){
		return $this->subsistema;
	}
	
	function getCantGrupos(){
		return $this->cant_grupos;
	}

	function getNombreArchivo($pArchivo){
		return $this->aNombresArchivos[$pArchivo];
	}
	function getNombreFuncion($pFuncion){
		return $this->aNombresFunciones[$pFuncion];
	}
	
	function getNombreTabla(){
		return $this->nombre_tabla;
	}
	function getNombreEsquema(){
		return $this->nombre_esquema;
	}
	function getTitulo(){
		return $this->titulo;
	}
	function getCarpetaSistema(){
		return $this->carpeta_subsis;
	}
	function getReemplazar(){
		return $this->reemplazar;
	}
	function getMenu(){
		return $this->menu;
	}
	function getAlias(){
		return $this->alias;
	}
	function getAliasLower(){
		return strtolower($this->alias);
	}
	function getPrefijo(){
		return $this->prefijo;
	}
	function getDireccion(){
		return $this->direccion;
	}
	function getNombreFuncionBDesquema(){
		return $this->nombre_esquema.'.'.$this->prefijoTabla. $this->_substr($this->nombre_tabla);
	}
	function getNombreFuncionBD(){
		return $_SESSION["_PREFIJO_TABLA"].substr($this->nombre_tabla,$this->cantPrefijoTabla).'_';
	}
	function getId(){
		return $this->llave_primaria;
	}
	function getNombreTransaccion(){
		return $this->prefijo."_".$this->alias."_";
	}
	function getNombreTablaCompleto(){
		return $this->nombre_esquema.".".$this->nombre_tabla;
	}
	function getNombreTablaJava(){
		$res='';
		$aux=explode('_',$this->nombre_tabla);
		foreach ($aux as $data){
			$res.=ucfirst($data);
		}
		return $res;
	}
	function getNombreFuncionBDesquemaComillasIME(){
		return "\"".$this->nombre_esquema."\"".".\"".$this->prefijoTabla. $this->_substr($this->nombre_tabla)."_ime\"";
	}
	function getNombreFuncionBDesquemaComillasSEL(){
		return "\"".$this->nombre_esquema."\"".".\"".$this->prefijoTabla. $this->_substr($this->nombre_tabla)."_sel\"";
	}
	function getCarpetaSistemaJava(){
		$res='';
		$aux=explode('_',$this->carpeta_subsis);
		foreach ($aux as $data){
			$res.=ucfirst($data);
		}
		return $res;
	}
	function getNombreTablaVista(){
		return substr($this->nombre_tabla,$this->cantPrefijoTabla);//,strlen($this->carpeta_subsis));
	}
}
?>