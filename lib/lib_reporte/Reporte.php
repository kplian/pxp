<?php
class Reporte
{
	protected $objParam;
	protected $res;
	protected $objReporteFormato;
	protected $mensajeExito;
	protected $nombreArchivo;
	protected $tamano_hoja;
	protected $orientacion_hoja;
	protected $titulo='sin_titulo'; //Variable que contendrá el título del reporte
	protected $control;
	protected $swNumeracion='si';

	/**
	 * Nombre funcion:	__construct
	 * Proposito:		Constructor del generador de reporte
	 * Fecha creación:	11/10/2010
	 *
	 * @param CTParametro $pParam -> objeto parametro con todas las propiedades para la generación del reporte
	 * 
	 */
	function __construct(CTParametro $pParam, $control){

		$this->objParam=$pParam;
		$this->control = $control;
		if($this->objParam->getParametro('titulo')!=''){
			$this->titulo=$this->objParam->getParametro('titulo');
		}
		
		//Genera el nombre del archivo (aleatorio + titulo)
		$this->nombreArchivo=uniqid(md5(session_id()).$this->titulo);

		//Si es un reporte de excel que se genera desde el grid
		if($this->objParam->getParametro('tipoReporte')=='excel_grid'){
			//Agrega la extensión al nombre de archivo
			$this->nombreArchivo.='.xls';
			//Instancia la clase de excel
			$this->objReporteFormato=new ReporteXLS($this->nombreArchivo,$this->titulo);
			//Se definen las columnas que se van a mostrar
			$this->objReporteFormato->defineDatosMostrar($this->objParam->getColumnasReporte());
		} 
		//Si es un reporte en pdf que se genera desde el grid
		else if($this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			//Agrega la extensión al nombre de archivo
			$this->nombreArchivo.='.pdf';
			$this->objParam->addParametro('orientacion',$this->objParam->getParametro('pdfOrientacion'));
			$this->objParam->addParametro('tamano','Letter');
			$this->objParam->addParametro('nombre_archivo',$this->nombreArchivo);
			$this->objParam->addParametro('titulo_archivo',$this->titulo);

			//Instancia la clase de pdf
			$this->objReporteFormato=new ReportePDF($this->objParam);
			
			//Setea propiedades para generación del reporte
			$this->objReporteFormato->setTitulo1($this->objParam->getParametro('titulo'));
			$this->objReporteFormato->setTitulo2($this->objParam->getParametro('titulo1'));
			//Se definen las columnas que se vana mostrar
			$this->objReporteFormato->defineDatosMostrar($this->objParam->getColumnasReporte());
		}
		//Si es un reporte excel
		else if($this->objParam->getParametro('tipoReporte')=='excel'){
			$this->nombreArchivo.='.xls';
		}
		//Si es un reporte pdf
		else if($this->objParam->getParametro('tipoReporte')=='pdf'){
			$this->nombreArchivo.='.pdf';
			$this->objParam->addParametro('nombre_archivo',$this->nombreArchivo);
			$this->objParam->addParametro('titulo_archivo',"Reporte ".$this->titulo);
			$this->objParam->addParametro('tipoReporte',$this->objParam->getParametro('tipoReporte'));
			$this->objReporteFormato=new ReportePDF($this->objParam);
			
			//Verifica la orientación del papel para definir los márgenes
			if($this->objParam->getParametro('orientacion')=='P'){
				$this->objReporteFormato->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP+5, PDF_MARGIN_RIGHT);
			} elseif($this->objParam->getParametro('orientacion')=='L'){
				$this->objReporteFormato->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP+10.4, PDF_MARGIN_RIGHT);
			}
		}
	}
	
	
	/**
	 * Nombre funcion:	generarReporteListado
	 * Proposito:		genera un reporte de un listado de datos ya sea excel o pdf
	 * Fecha creación:	11/10/2010
	 *
	 * @param cadena $nombre_clase -> es el nombre de la clase de funciones ej:FuncionesSeguridad
	 * @param cadena $metodo_ejecutar -> es el metodo a ejecutar de la clase de funciones
	 */
	function generarReporteListado($nombre_clase,$metodo_ejecutar){
		$puntero=0;
		$this->objParam->addParametroConsulta('puntero','0');
		$this->objParam->addParametroConsulta('cantidad',$_SESSION['cantidad_reportes']);
		
		if($this->objParam->getParametro('tipoReporte')=='pdf_grid')
			$this->objReporteFormato->SetFont('helvetica', '', 4);
		$cad = $this->create($nombre_clase);
		
		//eval('$cad = new $nombre_clase();');
		eval('$this->res=$cad->'.$metodo_ejecutar.'($this->objParam);');
		if($this->res->getTipo()=='ERROR'){
			return $this->res;
		}
		
		$cantidad_registros=$this->res->getTotal();
	
		
		$puntero=$puntero+$_SESSION['cantidad_reportes'];
						
		//Imprime los títulos de las columnas para exportación pdf_grid
		if($this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporteFormato->imprimirColsGrid();
		}
		
		$intNro=1;
		$arrTmp=$this->res->getDatos();
		if($this->swNumeracion=='si'){
			for($i=0;$i<count($arrTmp);$i++){
				$arrTmp[$i]['nro']=$intNro;
				$intNro++;
				//var_dump($rec);
			}
		}
		
		$this->objReporteFormato->addTabla($arrTmp);

		while($cantidad_registros > $puntero){
			
			$this->objParam->addParametroConsulta('puntero',$puntero);
			eval('$cad = new $nombre_clase($this->objParam);');
			eval('$this->res=$cad->'.$metodo_ejecutar.'();');
			if($this->res->getTipo()=='ERROR'){
				return $this->res;
			}
			
			$arrTmp=$this->res->getDatos();
			if($this->swNumeracion=='si'){
				for($i=0;$i<count($arrTmp);$i++){
					$arrTmp[$i]['nro']=$intNro;
					$intNro++;
					//var_dump($rec);
				}
			}
			
			$this->objReporteFormato->addTabla($arrTmp);
			
			$puntero=$puntero+$_SESSION['cantidad_reportes'];
		}
		
		$this->objReporteFormato->generarReporte();
		
		$this->mensajeExito=new Mensaje();
		$this->mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado',
										'Se generó con éxito el reporte: '.$this->nombreArchivo,'control');
		$this->mensajeExito->setArchivoGenerado($this->nombreArchivo);
	
		return $this->mensajeExito;
		
	}

	//RCM 22-11-2011: Para cargar los datos de la cabecera
	/*public function cargarMaestroBD($pCustom, $pMetodo){
		if($this->objParam->getParametro('tipoReporte')=='pdf'){
			$this->objReporteFormato->cargarMaestroBD($pCustom, $pMetodo);
		} elseif ($this->objParam->getParametro('tipoReporte')=='excel'){
			
		}
	}*/
	
	//Método para generar la salida
	public function getReporte(){
		return $this->objReporteFormato;
	}
	
	public function generarReporte(){
		$this->objReporteFormato->generarReporte();
		$this->mensajeExito=new Mensaje();
		$this->mensajeExito->setMensaje('EXITO','Reporte.php','Se genero con exito el reporte'.$this->nombreArchivo,
										'Se genero con exito el reporte'.$this->nombreArchivo,'control');
		$this->mensajeExito->setArchivoGenerado($this->nombreArchivo);
		return $this->mensajeExito;
	}
	
	function create($className) {
		$myArray = explode("/", $className);
		$reflector = new ReflectionClass(get_class($this->control));
		//si el tamano del array es dos se debe incluir un modelo en otro subsistema
		//si el tamano del array es uno se incluye un modelo del mismo subsistema
		// sino se de lanzar una excepcion
		if (sizeof($myArray) == 1) {			
			$includeDir = dirname($reflector->getFileName()) . "/../modelo/";
			$fileName = $myArray [0] . '.php';			
			
		} else if (sizeof($myArray) == 2) {			
			$includeDir = dirname($reflector->getFileName()) . "/../../" . $myArray[0] . "modelo/";
			$fileName = $myArray [1] . '.php';			
			
		} else {
			throw new Exception(__METHOD__.': No se pudo incluir el modelo '.$className);
		}
		
		include_once $includeDir . $fileName;
		eval('$modelObj = new $myArray[0]($this->objParam);');
		return $modelObj;		
	}	
}
?>
