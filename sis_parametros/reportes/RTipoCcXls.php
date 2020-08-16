<?php
class REntregaXls
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
    private $objParam;
    public  $url_archivo;

    var $datos_titulo;
    var $datos_detalle;
    var $ancho_hoja;
    var $gerencia;
    var $numeracion;
    var $ancho_sin_totales;
    var $cantidad_columnas_estaticas;
    var $s1;
    var $t1;
    var $tg1;
    var $total;
    var $datos_entidad;
    var $datos_periodo;
    var $ult_codigo_partida;
    var $ult_concepto;



    function __construct(CTParametro $objParam){
        $this->objParam = $objParam;
        $this->url_archivo = "../../../reportes_generados/".$this->objParam->getParametro('nombre_archivo');
        //ini_set('memory_limit','512M');
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

    function datosHeader ( $detalle, $id_entrega) {

        $this->datos_detalle = $detalle;
        $this->id_entrega = $id_entrega;

    }

    function ImprimeCabera(){

    }

    function imprimeDatos(){
        $datos = $this->datos_detalle;

        $styleTitulos = array(
            'font'  => array(
                'bold'  => true,
                'size'  => 9,
                'name'  => 'Arial'
            ),
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
            ),
            'fill' => array(
                'type' => PHPExcel_Style_Fill::FILL_SOLID,
                'color' => array('rgb' => 'BDD7EE')
            ),
            'borders' => array(
                'allborders' => array(
                    'style' => PHPExcel_Style_Border::BORDER_THIN
                )
            ));

        $inicio_filas = 4;


        $operaciones = array('add','del');
        $arrayOperaciones=array("add" => "INSERCIÓN", "mod" => "MODIFICACIÓN", "del" => "ELIMINACIÓN");


        $fila = $inicio_filas+1;
        $contador = 1;
        $sw = true;

        $fila_ini = $fila+2;
        $fila_fin = $fila;

        $styleArrayGroup = array(
            'font'  => array('bold'  => true,'color' => array('rgb' => 'FFFFFF')),
            'alignment' => array('horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER),
            'fill' => array('type' => PHPExcel_Style_Fill::FILL_SOLID,'color' => array('rgb' => '34495E')),
            'borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN))

        );

        $styleArrayGroupCg = array(
            'font'  => array('bold'  => true),
            'alignment' => array('horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER),
            'fill' => array('type' => PHPExcel_Style_Fill::FILL_SOLID,'color' => array('rgb' => 'BDD7EE')),
            'borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN))
        );

        /////////////////////***********************************Detalle***********************************************

        $primerData = false;
        $tmp_rec = $datos[0];
        for ($fi = 0; $fi < count($datos); $fi++) {
            $value = $datos[$fi];
            $antiguo = (array) json_decode($value['datos_antiguo'], true);
            $nuevo = (array) json_decode($value['datos_nuevo'], true);

            if(($tmp_rec['id_tipo_cc'] != $value['id_tipo_cc']) or $fi == 0){
                if(($tmp_rec['id_tipo_cc'] != $value['id_tipo_cc'])){
                    if(($tmp_rec['fecha_reg'] != $value['fecha_reg']) and !is_null($tmp_rec['id_historico'])){
                        $fila_fin = $fila;
                        $this->docexcel->setActiveSheetIndex(0)->mergeCells("A".($fila_ini).":A".($fila_fin-1));
                        $this->docexcel->setActiveSheetIndex(0)->mergeCells("D".($fila_ini).":D".($fila_fin-1));
                        $this->docexcel->setActiveSheetIndex(0)->mergeCells("E".($fila_ini).":E".($fila_fin-1));
                        for ($row = $fila_ini; $row <= $fila_fin-1; ++$row) {
                            $this->docexcel->setActiveSheetIndex(0)->getRowDimension($row)->setOutlineLevel(1)->setVisible(false)->setCollapsed(true);
                        }
                        $fila_ini = $fila;
                    }
                    $fila++;
                    $fila++;
                    $fila_ini = $fila+2;
                    $primerData = true;
                }
                $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0,$fila,'TIPO CC');
                $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$fila,$value['codigo_padre'].' - '.$value['descripcion']);
                $this->docexcel->setActiveSheetIndex(0)->mergeCells("B".($fila).":E".($fila));
                $this->docexcel->getActiveSheet()->getStyle("A".($fila).":E".($fila))->applyFromArray($styleArrayGroup);
                $fila++;
                //*************************************Cabecera*****************************************
                $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[0])->setWidth(20);
                $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0,$fila,'FECHA Y HORA');
                $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[1])->setWidth(30);
                $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[2])->setWidth(30);
                $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$fila,'DETALLE DE MOVIMIENTO (ANTIGUO | NUEVO)');
                $this->docexcel->setActiveSheetIndex(0)->mergeCells("B".($fila).":C".($fila));
                $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3,$fila,'USUARIO');
                $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[3])->setWidth(35);
                $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4,$fila,'OPERACIÓN');
                $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[4])->setWidth(15);
                $this->docexcel->getActiveSheet()->getStyle("A".($fila).":E".($fila))->applyFromArray($styleArrayGroup);

                $fila++;
                //*************************************Fin Cabecera*****************************************
            }

            if(!is_null($value['id_historico'])){
                $singleFila = $fila;
                if(($tmp_rec['fecha_reg'] != $value['fecha_reg']) and  !$primerData){
                    $fila_fin = $fila;
                    $this->docexcel->setActiveSheetIndex(0)->mergeCells("A".($fila_ini).":A".($fila_fin-1));
                    $this->docexcel->setActiveSheetIndex(0)->mergeCells("D".($fila_ini).":D".($fila_fin-1));
                    $this->docexcel->setActiveSheetIndex(0)->mergeCells("E".($fila_ini).":E".($fila_fin-1));
                    for ($row = $fila_ini; $row <= $fila_fin-1; ++$row) {
                        $this->docexcel->setActiveSheetIndex(0)->getRowDimension($row)->setOutlineLevel(1)->setVisible(false)->setCollapsed(true);
                    }

                    $fila_ini = $fila;
                }

                $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0,$fila,date_format(new DateTime($value['fecha_reg']), 'Y-m-d  H:i:s'));

                if (($nuevo['tipo'] != $antiguo['tipo']) or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Tipo de Aplicacion: '.$antiguo['tipo']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Tipo de Aplicacion: '.$nuevo['tipo']);
                }
                if ($nuevo['id_ep'] != $antiguo['id_ep']  or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'EP: '.$antiguo['id_ep']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'EP: '.$nuevo['id_ep']);
                }
                if ($nuevo['codigo'] != $antiguo['codigo']  or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Codigo: '.$antiguo['codigo']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Codigo: '.$nuevo['codigo']);
                }
                if ($nuevo['mov_pres'] != $antiguo['mov_pres']  or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Ingreso / Egreso: '.$antiguo['mov_pres']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Ingreso / Egreso: '.$nuevo['mov_pres']);
                }
                if ($nuevo['operativo'] != $antiguo['operativo']  or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Operativo: '.$antiguo['operativo']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Operativo: '.$nuevo['operativo']);
                }
                if ($nuevo['movimiento'] != $antiguo['movimiento']  or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Transaccional: '.$antiguo['movimiento']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Transaccional: '.$nuevo['movimiento']);
                }
                if ($nuevo['descripcion'] != $antiguo['descripcion'] or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Descripcion: '.$antiguo['descripcion']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Descripcion: '.$nuevo['descripcion']);
                }
                if ($nuevo['fecha_inicio'] != $antiguo['fecha_inicio'] or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Fecha inicio: '.$antiguo['fecha_inicio']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Fecha inicio: '.$nuevo['fecha_inicio']);
                }
                if ($nuevo['fecha_final'] != $antiguo['fecha_final'] or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Fecha final: '.$antiguo['fecha_final']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Fecha final: '.$nuevo['fecha_final']);
                }
                if ($nuevo['momento_pres'] != $antiguo['momento_pres'] or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Momentos: '.$antiguo['momento_pres']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Momentos: '.$nuevo['momento_pres']);
                }
                if ($nuevo['control_techo'] != $antiguo['control_techo'] or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Techo: '.$antiguo['control_techo']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Techo: '.$nuevo['control_techo']);
                }
                if ($nuevo['id_tipo_cc_fk'] != $antiguo['id_tipo_cc_fk'] or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Padre: '.$antiguo['id_tipo_cc_fk']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Padre: '.$nuevo['id_tipo_cc_fk']);
                }
                if ($nuevo['control_partida'] != $antiguo['control_partida'] or (in_array($value['operacion'], $operaciones))){
                    if($value['operacion'] == 'mod')
                        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$singleFila,'Controlar Partida: '.$antiguo['control_partida']);
                    $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$singleFila++,'Controlar Partida: '.$nuevo['control_partida']);
                }

                $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3,$fila,$value['desc_persona']);
                $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4,$fila,$arrayOperaciones[$value['operacion']]);

                $this->docexcel->getActiveSheet()->getStyle("A".($fila).":E".($singleFila-1))->applyFromArray($styleTitulos);

                    $fila = $singleFila;
            }else{
                $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0,$fila,'SIN BITACORA');
                $this->docexcel->setActiveSheetIndex(0)->mergeCells("A".($fila).":E".($fila));
                $this->docexcel->getActiveSheet()->getStyle("A".($fila).":E".($fila))->applyFromArray($styleArrayGroupCg);
                $fila++;
            }
            $primerData =false;
            $tmp_rec = $value;

            if($fi == count($datos)-1){
                $fila_fin = $fila;
                $this->docexcel->setActiveSheetIndex(0)->mergeCells("A".($fila_ini).":A".($fila_fin-1));
                $this->docexcel->setActiveSheetIndex(0)->mergeCells("D".($fila_ini).":D".($fila_fin-1));
                $this->docexcel->setActiveSheetIndex(0)->mergeCells("E".($fila_ini).":E".($fila_fin-1));
                if(!is_null($value['id_historico'])){
                    for ($row = $fila_ini; $row <= $fila_fin-1; ++$row) {
                        $this->docexcel->setActiveSheetIndex(0)->getRowDimension($row)->setOutlineLevel(1)->setVisible(false)->setCollapsed(true);
                    }
                }
            }
        }
        $this->docexcel->getActiveSheet()->getStyle('B1:B'.$this->docexcel->getActiveSheet()->getHighestRow())
            ->getAlignment()->setWrapText(true);

        $this->docexcel->getActiveSheet()->getStyle('C1:C'.$this->docexcel->getActiveSheet()->getHighestRow())
            ->getAlignment()->setWrapText(true);
    }

    function imprimeTitulo($sheet){
        $titulo = "HISTORIAL DE MOVIMIENTO";

        $sheet->getStyle('A3')->getFont()->applyFromArray(array('bold'=>true,
            'size'=>12,
            'name'=>'Arial'));

        $sheet->getStyle('A3')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $sheet->setCellValueByColumnAndRow(0,3,strtoupper($titulo));
        $sheet->mergeCells('A3:E3');

        $objDrawing = new PHPExcel_Worksheet_Drawing();
        $objDrawing->setName('Logo');
        $objDrawing->setDescription('Logo');
        $objDrawing->setPath(dirname(__FILE__).'/../../lib/imagenes/logos/logo.jpg');

        $objDrawing->setHeight(60);
        $objDrawing->setWorksheet($this->docexcel->setActiveSheetIndex(0));
    }



    function generarReporte(){


        $this->imprimeTitulo($this->docexcel->setActiveSheetIndex(0));
        $this->imprimeDatos();

        //echo $this->nombre_archivo; exit;
        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->docexcel->setActiveSheetIndex(0);
        $this->objWriter = PHPExcel_IOFactory::createWriter($this->docexcel, 'Excel5');
        $this->objWriter->save($this->url_archivo);


    }


}

?>