<?php
include_once(dirname(__FILE__).'/../../lib/PHPWord/src/PhpWord/Autoloader.php');
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
        $document->setValue('MONTO', $this->dataSource[0]['haber_basico']);
        $document->setValue('INICIALES', $this->dataSource[0]['iniciales']);
        $document->setValue('LITERAL', $this->dataSource[0]['haber_literal']);
        $document->setValue('FECHA_SOLICITUD', $this->fechaLiteral($this->dataSource[0]['fecha_solicitud']));
        if($this->dataSource[0]['tipo_certificado'] =='Con viáticos de los últimos tres meses'){
            $document->setValue('TRABAJADORA', $tra);
            $document->setValue('VIATICO', $this->dataSource[0]['importe_viatico']);
            $document->setValue('VIATICO_LITERAL', $this->dataSource[0]['literal_importe_viatico']);

        }

        $document->saveAs($fileName);


    }
    function fechaLiteral($va){
        setlocale(LC_ALL,"es_ES@euro","es_ES","esp");
        $fecha = strftime("%d de %B de %Y", strtotime($va));
        return $fecha;
    }


}

?>