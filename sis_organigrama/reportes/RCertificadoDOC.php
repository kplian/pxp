<?php
include_once(dirname(__FILE__).'/../../lib/PHPWord/src/PhpWord/Autoloader.php');
require_once(dirname(__FILE__) . '/../../lib/tcpdf/tcpdf_barcodes_2d.php');
\PhpOffice\PhpWord\Autoloader::register();
Class RCertificadoDOC {

    private $dataSource;

    public function datosHeader( $dataSource) {
        $this->dataSource = $dataSource;

    }

    function write($fileName) {
        if ($this->dataSource[0]['genero'] == 'Sr'){
            $tipo = 'del interesado';
            $gen = 'el';
            $tipol = 'al interesado';
            $tra = 'trabajor';
        }else{
            $gen = 'la';
            $tipo = 'de la interesada';
            $tipol = 'de la interesada';
            $tra = 'trabajadora';
        }
        $phpWord = new \PhpOffice\PhpWord\PhpWord();
        if($this->dataSource[0]['tipo_certificado'] =='Con viáticos de los últimos tres meses'){
            $document = $phpWord->loadTemplate(dirname(__FILE__).'/cer_viatico.docx');

        }else{
            $document = $phpWord->loadTemplate(dirname(__FILE__).'/cer_general.docx');

        }


        setlocale(LC_ALL,"es_ES@euro","es_ES","esp");
        $document->setValue('JEFA_RECURSOS', $this->dataSource[0]['jefa_recursos']);
        $document->setValue('INTERESADO', $tipo);
        $document->setValue('LA', $gen);
        $document->setValue('INTERESADA', $tipol);
        $document->setValue('GENERO', $this->dataSource[0]['genero']);
        $document->setValue('NOMBRE_FUNCIONARIO', $this->dataSource[0]['nombre_funcionario']);
        $document->setValue('CI', $this->dataSource[0]['ci']);
        $document->setValue('EXPEDIDO', $this->dataSource[0]['expedicion']);
        $document->setValue('FECHA_CONTRATO', $this->fechaLiteral($this->dataSource[0]['fecha_contrato']));
        $document->setValue('NOMBRE_CARGO', $this->dataSource[0]['nombre_cargo']);
        $document->setValue('GERENCIA', $this->dataSource[0]['nombre_unidad']);
        $document->setValue('MONTO', number_format($this->dataSource[0]['haber_basico'],2,",","."));
        $document->setValue('INICIALES', $this->dataSource[0]['iniciales']);
        $document->setValue('LITERAL', $this->dataSource[0]['haber_literal']);
        $document->setValue('FECHA_SOLICITUD', $this->fechaLiteral($this->dataSource[0]['fecha_solicitud']));
        if($this->dataSource[0]['tipo_certificado'] =='Con viáticos de los últimos tres meses'){
            $document->setValue('TRABAJADORA', $tra);
            $document->setValue('VIATICO', number_format($this->dataSource[0]['importe_viatico'],2,",","."));
            $document->setValue('VIATICO_LITERAL', $this->dataSource[0]['literal_importe_viatico']);

        }
        //$document->setImageValue($this->codigoQr('hola','imagen'), 'my_image.jpg');

       // $document->setImg('IMGD#1',array('src' => $this->codigoQr('hola','imagen'),'swh'=>'250'));
        $document->saveAs($fileName);

    }

    function fechaLiteral($va){
        setlocale(LC_ALL,"es_ES@euro","es_ES","esp");
        $fecha = strftime("%d de %B de %Y", strtotime($va));
        return $fecha;
    }
    /*function codigoQr ($cadena,$ruta){
        $barcodeobj = new TCPDF2DBarcode($cadena, 'QRCODE,M');
        $png = $barcodeobj->getBarcodePngData($w = 8, $h = 8, $color = array(0, 0, 0));
        $im = imagecreatefromstring($png);
        if ($im !== false) {
            header('Content-Type: image/png');
            imagepng($im, dirname(__FILE__) . "/../../../reportes_generados/".$ruta.".png");
            imagedestroy($im);
        } else {
            echo 'An error occurred.';
        }
        $url =  dirname(__FILE__) . "/../../../reportes_generados/".$ruta.".png";
        return $url;
    }

    public function __construct($documentTemplate)
    {
//add to this function

        $this->_countRels=100; //start id for relationship between image and document.xml
    }

    public function save()
    {
//add to this function after $this->zipClass->addFromString('word/document.xml', $this->tempDocumentMainPart);

        if($this->_rels!="")
        {
            $this->zipClass->addFromString('word/_rels/document.xml.rels', $this->_rels);
        }
        if($this->_types!="")
        {
            $this->zipClass->addFromString('[Content_Types].xml', $this->_types);
        }
    }

//add function

    public function setImg( $strKey, $img){
        $strKey = '${'.$strKey.'}';
        $relationTmpl = '<Relationship Id="RID" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/IMG"/>';

        $imgTmpl = '<w:pict><v:shape type="#_x0000_t75" style="width:WIDpx;height:HEIpx"><v:imagedata r:id="RID" o:title=""/></v:shape></w:pict>';

        $toAdd = $toAddImg = $toAddType = '';
        $aSearch = array('RID', 'IMG');
        $aSearchType = array('IMG', 'EXT');
        $countrels=$this->_countRels++;
        //I'm work for jpg files, if you are working with other images types -> Write conditions here
        $imgExt = 'jpg';
        $imgName = 'img' . $countrels . '.' . $imgExt;

        $this->zipClass->deleteName('word/media/' . $imgName);
        $this->zipClass->addFile($img['src'], 'word/media/' . $imgName);

        $typeTmpl = '<Override PartName="/word/media/'.$imgName.'" ContentType="image/EXT"/>';


        $rid = 'rId' . $countrels;
        $countrels++;
        list($w,$h) = getimagesize($img['src']);

        if(isset($img['swh'])) //Image proportionally larger side
        {
            if($w<=$h)
            {
                $ht=(int)$img['swh'];
                $ot=$w/$h;
                $wh=(int)$img['swh']*$ot;
                $wh=round($wh);
            }
            if($w>=$h)
            {
                $wh=(int)$img['swh'];
                $ot=$h/$w;
                $ht=(int)$img['swh']*$ot;
                $ht=round($ht);
            }
            $w=$wh;
            $h=$ht;
        }

        if(isset($img['size']))
        {
            $w = $img['size'][0];
            $h = $img['size'][1];
        }


        $toAddImg .= str_replace(array('RID', 'WID', 'HEI'), array($rid, $w, $h), $imgTmpl) ;
        if(isset($img['dataImg']))
        {
            $toAddImg.='<w:br/><w:t>'.$this->limpiarString($img['dataImg']).'</w:t><w:br/>';
        }

        $aReplace = array($imgName, $imgExt);
        $toAddType .= str_replace($aSearchType, $aReplace, $typeTmpl) ;

        $aReplace = array($rid, $imgName);
        $toAdd .= str_replace($aSearch, $aReplace, $relationTmpl);


        $this->tempDocumentMainPart=str_replace('<w:t>' . $strKey . '</w:t>', $toAddImg, $this->tempDocumentMainPart);
        //print $this->tempDocumentMainPart;



        if($this->_rels=="")
        {
            $this->_rels=$this->zipClass->getFromName('word/_rels/document.xml.rels');
            $this->_types=$this->zipClass->getFromName('[Content_Types].xml');
        }

        $this->_types       = str_replace('</Types>', $toAddType, $this->_types) . '</Types>';
        $this->_rels        = str_replace('</Relationships>', $toAdd, $this->_rels) . '</Relationships>';
    }
    function limpiarString($str) {
        return str_replace(
            array('&', '<', '>', "\n"),
            array('&amp;', '&lt;', '&gt;', "\n" . '<w:br/>'),
            $str
        );
    }*/


}

?>