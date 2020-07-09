<?php
/****************************************************************************************
*@package pXP
*@file RDetalleDepXls.php
*@author  RCM
*@date 07/07/2020
*@description Reporte para plantillas de importación de datos
*****************************************************************************************
 ISSUE  SIS     FECHA      	AUTOR       DESCRIPCION
 #185 	PAR 	07/07/2020	RCM			Crear opción para generar plantilla excel en blanco
*****************************************************************************************
*/
class RPlantillaXls
{
	private $objParam;
	public  $url_archivo;
	private $docexcel;
	private $dataSetMaster;
    private $dataSet;
    private $letter = array(
        'A','B','C','D','E','F','G','H','I','J','K','L','M','O','P','Q','R','S','T','U','V','W','X','Y','Z',
        'AA','AB','AC','AD','AE','AF','AG','AH','AI','AJ','AK','AL','AM','AO','AP','AQ','AR','AS','AT','AU','AV','AW','AX','AY','AZ',
        'BA','BB','BC','BD','BE','BF','BG','BH','BI','BJ','BK','BL','BM','BO','BP','BQ','BR','BS','BT','BU','BV','BW','BX','BY','BZ'
    );

	function __construct(CTParametro $objParam){
		$this->objParam = $objParam;
		$this->url_archivo = "../../../reportes_generados/".$this->objParam->getParametro('nombre_archivo');
		set_time_limit(400);
        
        $cacheMethod = PHPExcel_CachedObjectStorageFactory:: cache_to_phpTemp;
		$cacheSettings = array('memoryCacheSize'  => '10MB');
		PHPExcel_Settings::setCacheStorageMethod($cacheMethod, $cacheSettings);
        
        $this->docexcel = new PHPExcel();
		$this->docexcel->getProperties()->setCreator("PXP")
                        ->setLastModifiedBy("PXP")
                        ->setTitle($this->objParam->getParametro('titulo_archivo'))
                        ->setSubject($this->objParam->getParametro('titulo_archivo'))
                        ->setDescription('Reporte "'.$this->objParam->getParametro('titulo_archivo').'", generado por el framework PXP')
                        ->setKeywords("office 2007 openxml php")
                        ->setCategory("Report File");

		$this->docexcel->setActiveSheetIndex(0);
		$this->docexcel->getActiveSheet()->setTitle($this->objParam->getParametro('titulo_archivo'));
		$this->initializeColumnWidth($this->docexcel->getActiveSheet());
		$this->printerConfiguration();
	}

	function setData($data) {
		$this->dataSet = $data;
	}

	function generarReporte() {
		$sheet = $this->docexcel->setActiveSheetIndex(0);
		$this->mainBox($sheet);

        //Set active sheet index to the first sheet, so Excel opens this as the first sheet
		$this->docexcel->setActiveSheetIndex(0);
		$this->objWriter = PHPExcel_IOFactory::createWriter($this->docexcel, 'Excel5');
		$this->objWriter->save($this->url_archivo);
    }
    
	function mainBox($sheet){
        //Renderiza los datos
		for($i=0;$i<count($this->dataSet);$i++) {
            $sheet->setCellValue($this->letter[$i].'1',strtoupper($this->dataSet[$i]['nombre_columna'].' ('.$this->dataSet[$i]['tipo_valor'].')'));
        }
	}












	

	function printerConfiguration(){
		$this->docexcel->setActiveSheetIndex(0)->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
		$this->docexcel->setActiveSheetIndex(0)->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);
		$this->docexcel->setActiveSheetIndex(0)->getPageSetup()->setFitToWidth(1);
		$this->docexcel->setActiveSheetIndex(0)->getPageSetup()->setFitToHeight(0);

	}

	function initializeColumnWidth($sheet){
		$sheet->getColumnDimension('A')->setWidth(25);
		$sheet->getColumnDimension('B')->setWidth(25);
		$sheet->getColumnDimension('C')->setWidth(25);
		$sheet->getColumnDimension('D')->setWidth(25);
		$sheet->getColumnDimension('E')->setWidth(25);
		$sheet->getColumnDimension('F')->setWidth(25);
		$sheet->getColumnDimension('G')->setWidth(25);
		$sheet->getColumnDimension('H')->setWidth(25);
		$sheet->getColumnDimension('I')->setWidth(25);
		$sheet->getColumnDimension('J')->setWidth(25);
		$sheet->getColumnDimension('K')->setWidth(25);
		$sheet->getColumnDimension('L')->setWidth(25);
		$sheet->getColumnDimension('M')->setWidth(25);
		$sheet->getColumnDimension('N')->setWidth(25);
		$sheet->getColumnDimension('O')->setWidth(25);
		$sheet->getColumnDimension('P')->setWidth(25);
		$sheet->getColumnDimension('Q')->setWidth(25);
		$sheet->getColumnDimension('R')->setWidth(25);
		$sheet->getColumnDimension('S')->setWidth(25);
		$sheet->getColumnDimension('T')->setWidth(25);
		$sheet->getColumnDimension('U')->setWidth(25);
		$sheet->getColumnDimension('V')->setWidth(25);
		$sheet->getColumnDimension('W')->setWidth(25);
		$sheet->getColumnDimension('X')->setWidth(25);
		$sheet->getColumnDimension('Y')->setWidth(25);
		$sheet->getColumnDimension('Z')->setWidth(25);
		$sheet->getColumnDimension('AA')->setWidth(25);
		$sheet->getColumnDimension('AB')->setWidth(25);
		$sheet->getColumnDimension('AC')->setWidth(25);
		$sheet->getColumnDimension('AD')->setWidth(25);
		$sheet->getColumnDimension('AE')->setWidth(25);
		$sheet->getColumnDimension('AF')->setWidth(25);
		$sheet->getColumnDimension('AG')->setWidth(25);
		$sheet->getColumnDimension('AH')->setWidth(25);
		$sheet->getColumnDimension('AI')->setWidth(25);
        $sheet->getColumnDimension('AJ')->setWidth(25);
        $sheet->getColumnDimension('AK')->setWidth(25);
        $sheet->getColumnDimension('AL')->setWidth(25);
        $sheet->getColumnDimension('AM')->setWidth(25);
        $sheet->getColumnDimension('AN')->setWidth(25);
        $sheet->getColumnDimension('AO')->setWidth(25);
        $sheet->getColumnDimension('AP')->setWidth(25);
        $sheet->getColumnDimension('AQ')->setWidth(25);
        $sheet->getColumnDimension('AR')->setWidth(25);
        $sheet->getColumnDimension('AS')->setWidth(25);
        $sheet->getColumnDimension('AT')->setWidth(25);
        $sheet->getColumnDimension('AU')->setWidth(25);
        $sheet->getColumnDimension('AV')->setWidth(25);
        $sheet->getColumnDimension('AW')->setWidth(25);
        $sheet->getColumnDimension('AX')->setWidth(25);
        $sheet->getColumnDimension('AY')->setWidth(25);
        $sheet->getColumnDimension('AZ')->setWidth(25);
	}

}

?>