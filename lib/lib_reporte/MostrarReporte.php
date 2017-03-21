<?php
class MostrarReporte
{
    
    function __construct($fileName){
        $fileExtension = substr(strrchr($fileName,'.'),1);

        if (file_exists(dirname(__FILE__)."/../../../reportes_generados/".$fileName)) {
            if ($fileExtension == 'pdf' || $fileExtension == 'PDF') {
                header('Content-type: application/pdf');
            } else if($fileExtension == 'xls'){
                header("Content-type: application/xls");
            } else if($fileExtension == 'docx'){
                header("Content-type: application/docx");
            }else if ($fileExtension == 'png') {
                header("Content-type: image/png");
            }  else if ($fileExtension == 'sql') {
                header("Content-type: text/plain");
            } else {
                header("Content-type: text/html");
            }
			header('Content-Description: File Transfer');
			header('Content-Transfer-Encoding: binary');
            header('Content-Disposition: inline; filename="'.$fileName.'"');
			header('Accept-Ranges: bytes');
			
            //NO CACHE HEADERS
            /*header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); 
            header("Cache-Control: no-store, no-cache, must-revalidate"); 
            header("Cache-Control: post-check=0, pre-check=0", false);
            header("Pragma: no-cache");  */  
            
            readfile(dirname(__FILE__)."/../../../reportes_generados/".$fileName);
            unlink(dirname(__FILE__)."/../../../reportes_generados/".$fileName);
        }
        else{
             header("Content-type: text/html");
             echo '<H1><B>El archivo a sido  eliminado</B></H1>';    
            
        }
        exit;
    }
        
}
?>