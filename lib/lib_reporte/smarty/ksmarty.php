<?php
require_once('Smarty/libs/Smarty.class.php');

class ksmarty extends Smarty {
	
	private $arrValoresDefecto=array();
	private $strTplHeader;
	private $strTplFooter;
	private $strTplLabels;
	private $strFileName;
	private $objFile;
	private $strPath;
	private $arrReservadasPDF=array();
	private $strMarca;
	
	function __construct(){
		//Constructor del padre
		parent::__construct();
		
		//Rutas por defecto para la generacion de las plantillas
		$this->setTemplateDir(dirname(__FILE__).'/templates/');
		$this->setCompileDir(dirname(__FILE__).'/templates_c/');
		
		//Inicializacion de los valores por defecto
		$this->inicializarValoresDefecto();
		$this->setearValoresDefecto();
		
		//Linea que oculta errores no graves que genera smarty. Mejor si no se lo pone. Últi para poder detectar los errores de fondo
		$this->muteExpectedErrors();
		
	}
	
	protected function inicializarValoresDefecto(){
		//Variables reservadas para exportación pdf
		$this->strMarca='**';
		$this->arrReservadasPDF=array('main_pagina_actual','main_pagina_total');
		//Datos generales
		$this->arrValoresDefecto=array(	'main_ruta_logo'=>'..'.$_SESSION['_DIR_LOGO'],
										'main_title1'=>'REGISTRO',
										'main_title2'=>'Reporte PXP',
										'main_user'=>$_SESSION["_NOM_USUARIO"],
										'main_sistema'=>'kERP',
										'main_date'=>date('d-m-Y H:i:s'),
										'file_name'=>'pxp_reporte_html',
										'file_extension'=>'html',
										'ruta_archivo_generado'=>dirname(__FILE__).'/../../../../reportes_generados'
										);
		//Tpl header
		$this->strTplHeader='header1.tpl';
		//Tpl Footer
		$this->strTplFooter='footer1.tpl';
		//Tpl Labels
		$this->strTplLabels='labels1.tpl';
		
		//echo $this->arrValoresDefecto['main_ruta_logo']; exit;
	}
	
	protected function setearValoresDefecto(){
		$this->assign('main_ruta_logo',$this->arrValoresDefecto['main_ruta_logo']);
		$this->assign('main_title1',$this->arrValoresDefecto['main_title1']);
		$this->assign('main_title2',$this->arrValoresDefecto['main_title2']);
		$this->assign('main_user',$this->arrValoresDefecto['main_user']);
		$this->assign('main_sistema',$this->arrValoresDefecto['main_sistema']);
		$this->assign('main_date',$this->arrValoresDefecto['main_date']);
	}
	
	public function generarArchivo($pHtml,$pNombreArchivo='',$pRuta=''){
		//Genera el nombre del archivo
		$aux=$pNombreArchivo==''?$this->arrValoresDefecto['file_name']:$pNombreArchivo;
		$aux.='_'.date('dmY_His');
		$this->strFileName=$aux.'.'.$this->arrValoresDefecto['file_extension'];
		
		//Ruta
		$this->strPath=$pRuta==''?$this->arrValoresDefecto['ruta_archivo_generado']:$pRuta;
		
		//Incluye manejo de archivos
		require_once(dirname(__FILE__).'/../../lib_general/cls_archivos.php');
		
		//Instancia clase para manejar archivos
		if (!($this->objFile instanceof cls_archivos)){
			$this->objFile = new cls_archivos();
		}
		
		//Crea el archivo
		$this->objFile->crearArchivo($pHtml,$this->strFileName,$this->strPath);
		
		//Respuesta
		return true;
	
	}

	
	////////////////
	//Propiedades
	////////////////
	
	public function setTplHeader($pNombreTpl){
		$this->strTplHeader=$pNombreTpl;
	}
	
	public function setTplFooter($pNombreTpl){
		$this->strTplFooter=$pNombreTpl;
	}
	
	public function setTplLabels($pNombreTpl){
		$this->strTplFooter=$pNombreTpl;
	}
	
	public function getTplHeader(){
		return $this->strTplHeader;
	}
	
	public function getTplFooter(){
		return $this->strTplFooter;
	}
	
	public function getTplLabels(){
		return $this->strTplLabels;
	}
	
	public function getFileName(){
		return $this->strFileName;
	}
	
	public function getPath(){
		return $this->strPath;
	}

}

?>