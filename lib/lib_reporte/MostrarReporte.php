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
        }  else if ($fileExtension == 'sql') {
			header("Content-type: text/plain");
        } else {
            header("Content-type: text/html");
        }
        header('Content-Disposition: inline; filename="'.$fileName.'"');
        //NO CACHE HEADERS
        header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
        header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); 
        header("Cache-Control: no-store, no-cache, must-revalidate"); 
        header("Cache-Control: post-check=0, pre-check=0", false);
        header("Pragma: no-cache");
        
        readfile(dirname(__FILE__)."/../../../reportes_generados/".$fileName);
        //unlink(dirname(__FILE__)."/../../../reportes_generados/".$fileName);
        exit;
    }
        
}
?>