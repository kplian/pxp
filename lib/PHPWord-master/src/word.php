<?php
require_once 'PhpWord/Autoloader.php';
\PhpOffice\PhpWord\Autoloader::register();


$templateProcessor = new \PhpOffice\PhpWord\TemplateProcessor('footer_ejemplo.docx');

//static zone


//variant 1
//dynamic zone


//var_dump($templateProcessor);

$headers = $templateProcessor;


//$templateProcessor->setValueHeader('imgh',htmlspecialchars('cabezera ajajaj'));


//$templateProcessor->setImgHeader('imgHeader',array('src' => '1.jpg','swh'=>'250'));

$templateProcessor->setImgFooter('imgFooter',array('src' => '1.jpg','swh'=>'250'));

$templateProcessor->setValue('titulo', htmlspecialchars('Loremausto'));

//$templateProcessor->setImg('img1',array('src' => 'jpeg.jpg','swh'=>'250'));

//$templateProcessor->setImg('imgf',array('src' => 'jpeg.jpg','swh'=>'250'));




$templateProcessor->saveAs('resheader11.docx');