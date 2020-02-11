<?php
class RReporteIssuesXLS{
    private $docexcel;
    private $objWriter;
    public $fila_aux = 0;
    private $equivalencias=array();
    private $commits=array();
    private $issues = array();
    private $objParam;
    public  $url_archivo;

    function __construct(CTParametro $objParam)
    {
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
        $this->equivalencias=array( 0=>'A',1=>'B',2=>'C',3=>'D',4=>'E',5=>'F',6=>'G',7=>'H',8=>'I',
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
    function imprimeCabecera() {
        $this->docexcel->createSheet();
        $this->docexcel->getActiveSheet()->setTitle('Issues');
        $this->docexcel->setActiveSheetIndex(0);
        $styleTitulos1 = array(
            'font'  => array(
                'bold'  => true,
                'size'  => 12,
                'name'  => 'Arial'
            ),
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
            ),
        );
        $styleTitulos2 = array(
            'font'  => array(
                'bold'  => true,
                'size'  => 9,
                'name'  => 'Arial',
                'color' => array(
                    'rgb' => 'FFFFFF'
                )
            ),
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
            ),
            'fill' => array(
                'type' => PHPExcel_Style_Fill::FILL_SOLID,
                'color' => array(
                    'rgb' => '0066CC'
                )
            ),
            'borders' => array(
                'allborders' => array(
                    'style' => PHPExcel_Style_Border::BORDER_THIN
                )
            ));
        $styleTitulos3 = array(
            'font'  => array(
                'bold'  => true,
                'size'  => 11,
                'name'  => 'Arial'
            ),
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
            ),
        );
        //modificacionw
        $this->docexcel->getActiveSheet()->setCellValueByColumnAndRow(0,3,'Reporte '.$this->objParam->getParametro('github').' Issues ');
        $this->docexcel->getActiveSheet()->getStyle('A3:F3')->applyFromArray($styleTitulos1);
        $this->docexcel->getActiveSheet()->mergeCells('A3:F3');

        $this->docexcel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
        $this->docexcel->getActiveSheet()->getColumnDimension('B')->setWidth(10);
        $this->docexcel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
        $this->docexcel->getActiveSheet()->getColumnDimension('D')->setWidth(35);
        $this->docexcel->getActiveSheet()->getColumnDimension('E')->setWidth(85);
        $this->docexcel->getActiveSheet()->getColumnDimension('F')->setWidth(15);
        $this->docexcel->getActiveSheet()->getStyle('A5:F5')->getAlignment()->setWrapText(true);
        $this->docexcel->getActiveSheet()->getStyle('A5:F5')->applyFromArray($styleTitulos2);

        $this->docexcel->getActiveSheet()->setCellValue('A5','Nro');
        $this->docexcel->getActiveSheet()->setCellValue('B5','Issues');
        $this->docexcel->getActiveSheet()->setCellValue('C5','Sistema');
        $this->docexcel->getActiveSheet()->setCellValue('D5','Programador');
        $this->docexcel->getActiveSheet()->setCellValue('E5','Mensaje');
        $this->docexcel->getActiveSheet()->setCellValue('F5','Fecha');
    }
    function generarDatos(){
        $this->imprimeCabecera();
        $datos = $this->objParam->getParametro('datos');
        $fila = 6;
        $num = 0;
        $sistema = '';
        $iss = '';
        // var_dump($datos);exit;
        foreach ($datos as $value){
            if ($value['sistema'] != $sistema) {
                $this->imprimeSubtitulo($fila,$value['sistema']);
                $sistema = $value['sistema'];
                $fila++;
                $num ++;
            }
            if ($value['number_issues'] != $iss) {
                $this->imprimeIss($fila,$value);
                $iss = $value['number_issues'];
                $fila++;
            }
            $this->docexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $fila, $num);
            $this->docexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $fila, $value['number_issues']);
            $this->docexcel->getActiveSheet()->setCellValueByColumnAndRow(2, $fila, $value['sistema']);
            $this->docexcel->getActiveSheet()->setCellValueByColumnAndRow(3, $fila, $value['creador_issues']);
            $this->docexcel->getActiveSheet()->setCellValueByColumnAndRow(4, $fila, $value['message']);
            $this->docexcel->getActiveSheet()->setCellValueByColumnAndRow(5, $fila, $value['fecha_commit']);

            $fila++;
            $num ++;
        }

    }
    function fecha_aleatoria($formato = "Y-m-d", $limiteInferior = "2019-12-01", $limiteSuperior = "2019-12-31"){
        $milisegundosLimiteInferior = strtotime($limiteInferior);
        $milisegundosLimiteSuperior = strtotime($limiteSuperior);
        $milisegundosAleatorios = mt_rand($milisegundosLimiteInferior, $milisegundosLimiteSuperior);
        return date($formato, $milisegundosAleatorios);
    }
    function imprimeSubtitulo($fila, $valor) {
        $styleTitulos = array(
            'font'  => array(
                'bold'  => true,
                'size'  => 10,
                'name'  => 'Arial'
            ),
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
            ),
            'fill' => array(
                'type' => PHPExcel_Style_Fill::FILL_SOLID,
                'color' => array(
                    'rgb' => 'F0ECEB'
                )
            ),
            );
        $this->docexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $fila, $valor);
        $this->docexcel->getActiveSheet()->mergeCells("A$fila:F$fila");
        $this->docexcel->getActiveSheet()->getStyle("A$fila:A$fila")->applyFromArray($styleTitulos);
    }
    function imprimeIss($fila, $valor) {
        $styleTitulos = array(
            'font'  => array(
                'bold'  => true,
                'size'  => 9,
                'name'  => 'Arial'
            ),

            );
        $this->docexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $fila, "#".$valor['number_issues']." ".$valor['titulo']);
        $this->docexcel->getActiveSheet()->getStyle("A$fila:F$fila")->applyFromArray($styleTitulos);
        $this->docexcel->getActiveSheet()->mergeCells("A$fila:F$fila");
    }
    function generarReporte(){
        $this->objWriter = PHPExcel_IOFactory::createWriter($this->docexcel, 'Excel5');
        $this->objWriter->save($this->url_archivo);
    }
}
?>

