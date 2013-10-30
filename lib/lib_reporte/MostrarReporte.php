<?php
class MostrarReporte
{
    
    function __construct($fileName){
        $fileExtension = substr(strrchr($fileName,'.'),1);
        if ($fileExtension == 'pdf') {
            header('Content-type: application/pdf');
        } else if($fileExtension == 'xls'){
        	header("Content-type: application/xls");
		} else if ($fileExtension == 'png') {
			header("Content-type: image/png");
        } else {
            header("Content-type: text/html");
        }
        header('Content-Disposition: inline; filename="'.$fileName.'"');
        readfile(dirname(__FILE__)."/../../../reportes_generados/".$fileName);
        unlink(dirname(__FILE__)."/../../../reportes_generados/".$fileName);
        exit;
    }
        
}
?>