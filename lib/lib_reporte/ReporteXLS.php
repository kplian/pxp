<?php
//incluimos la libreria
//echo dirname(__FILE__);
include_once(dirname(__FILE__).'/../PHPExcel/Classes/PHPExcel.php');
class ReporteXLS
{
	private $docexcel;
	private $objWriter;
	private $nombre_archivo;
	private $hoja;
	private $columnas=array();
	private $fila;
	private $equivalencias=array();
	
	private $indice, $m_fila, $titulo;
	private $swEncabezado=0; //variable que define si ya se imprimi� el encabezado
	
	function __construct($nom_archivo,$titulo){
		//ini_set('memory_limit','512M');
		set_time_limit(400);
		$titulo = substr($titulo, 0,30);
		$cacheMethod = PHPExcel_CachedObjectStorageFactory:: cache_to_phpTemp;
		$cacheSettings = array('memoryCacheSize'  => '10MB');
		PHPExcel_Settings::setCacheStorageMethod($cacheMethod, $cacheSettings);

		$this->docexcel = new PHPExcel();/*"../../reportes_generados/$nom_archivo");*/
		$this->docexcel->getProperties()->setCreator("XPHS")
							 ->setLastModifiedBy("XPHS")
							 ->setTitle($titulo)
							 ->setSubject($titulo)
							 ->setDescription('Reporte "'.$titulo.'", generado por el framework XPHS')
							 ->setKeywords("office 2007 openxml php")
							 ->setCategory("Report File");
		$this->docexcel->setActiveSheetIndex(0);
		$this->docexcel->getActiveSheet()->setTitle($titulo);
		$this->nombre_archivo=$nom_archivo;
		$this->titulo=$titulo;
		$this->fila=1;
		$this->equivalencias=array(0=>'A',1=>'B',2=>'C',3=>'D',4=>'E',5=>'F',6=>'G',7=>'H',8=>'I',
								9=>'J',10=>'K',11=>'L',12=>'M',13=>'N',14=>'O',15=>'P',16=>'Q',17=>'R',
								18=>'S',19=>'T',20=>'U',21=>'V',22=>'W',23=>'X',24=>'Y',25=>'Z',
								26=>'AA',27=>'AB',28=>'AC',29=>'AD',30=>'AE',31=>'AF',32=>'AG',33=>'AH',
								34=>'AI',35=>'AJ',36=>'AK',37=>'AL',38=>'AM',39=>'AN',40=>'AO',41=>'AP',
								42=>'AQ',43=>'AR',44=>'AS',45=>'AT',46=>'AU',47=>'AV',48=>'AW',49=>'AX',
								50=>'AY',51=>'AZ',
								52=>'BA',53=>'BB',54=>'BC',55=>'BD',56=>'BE',57=>'BF',58=>'BG',59=>'BH',
								60=>'BI',61=>'BJ',62=>'BK',63=>'BL',64=>'BM',65=>'BN',66=>'BO',67=>'BP',
								68=>'BQ',69=>'BR',70=>'BS',71=>'BT',72=>'BU',73=>'BV',74=>'BW',75=>'BX',
								76=>'BY',77=>'BZ');
		
									
	}
			
	function addTabla($tabla){
		foreach ($tabla as $data){
			$this->addFila($data);
		}
	}
	function defineDatosMostrar($col){
		
		$this->columnas=$col;
		$columna=0;

		foreach ($this->columnas as $data){
			//$this->hoja->setColumn($columna,$columna,$data['width']/8);
			
			$this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[$columna])->setWidth($data['width']/8);
			
			
			$this->docexcel->setActiveSheetIndex(0)
						->setCellValueByColumnAndRow($columna,$this->fila,$data['label']);
			
			$columna++;
		}
		$this->fila++;
		
	}
	function generarReporte(){
		//echo $this->nombre_archivo; exit;
		// Set active sheet index to the first sheet, so Excel opens this as the first sheet
		$this->docexcel->setActiveSheetIndex(0);
		$this->objWriter = PHPExcel_IOFactory::createWriter($this->docexcel, 'Excel2007');
		$this->objWriter->save("../../../reportes_generados/$this->nombre_archivo");
		//ini_set('memory_limit','128M');
		//unset($this->docexcel);
		//unset($this->objWriter);
		
		
		
	}
	
	function addFila($fila){
		$columna=0; //$indice=0;
		//$m_fila=$this->fila;
		
	
		if($this->fila<10000 ){ 
			$indice=0;
			$m_fila=$this->fila;  
		}else{ 
			if($this->fila%10000==0){
				$m_fila=1;
				$indice=$this->indice+1;
				$this->docexcel->createSheet($indice);
				
				
			}else 
			    { 
			    $m_fila=$this->m_fila+1;
			    $indice=$this->indice;
			    }
			}

			foreach ($this->columnas as $data){ 
				$this->docexcel->setActiveSheetIndex($indice)->setCellValueByColumnAndRow($columna,$m_fila,$fila[$data['name']]);
		   		// $this->docexcel->getActiveSheet()->setTitle('Exportacion Pag. '.$indice.'');
				/*$this->docexcel->setActiveSheetIndex(0)
						->setCellValueByColumnAndRow($columna,$this->fila,$data['label']);*/
				$columna++;	
		}
		
		$this->fila++;
		$this->indice=$indice;
		$this->m_fila=$m_fila;
	}
	
	function getNombreArchivo()
	{
		return $this->nombre_archivo;
	}
	
	
	function getTitulo(){
		return $this->titulo;
	}
	

}

?>