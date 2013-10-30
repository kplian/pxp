<?php
class cls_archivos
{
    /*
    **********************************************************
    Nombre de la función:   copiar_archivo_servidor($archivo_temporal,$carpeta_destino)
    Propósito:              Se utiliza esta función para copiar
    srchivos al servidor
    Parámetros:             $archivo_temporal   --> Aquí se almacena el nombre del archivo temporal
    $carpeta_destino  --> Aquí se guarda el nombre de la carpeta destino
    Valores de Retorno:     $nombre_archivo     --> Retorna el nombre del archivo
    -1  --> Indica que se produjo un error y no se pudo subir el archivo al servidor
    **********************************************************
    */



    function carga_archivo ( $archivo, $directorio_destino )
    {
        // Revisa si el archivo es de mas de 5 megabytes.
        if ( $archivo['size'] < 5512000 )
        {
            $nombre_archivo = basename ( $archivo['name'] ) ;


            if ( file_exists ( $directorio_destino+$nombre_archivo ) )
            {
                $nombre_archivo = renombra_archivo ($nombre_archivo, $directorio_destino) ;
                echo "existe ya una copia de este archivo";
            }

            $archivo_destino = $directorio_destino . $nombre_archivo ;

            if ( move_uploaded_file ($archivo['tmp_name'], $archivo_destino) )
            {
                return $nombre_archivo ;
            }
            else
            {
                return -1 ;
            }
        }
        else
        {
            return -2 ;
        }
    }
    
    
        /*
    **********************************************************
    Nombre de la función:   copiar_archivo_servidor($archivo_temporal,$carpeta_destino)
    Propósito:              Se utiliza esta función para copiar
    srchivos al servidor
    Parámetros:             $archivo_temporal   --> Aquí se almacena el nombre del archivo temporal
    $carpeta_destino  --> Aquí se guarda el nombre de la carpeta destino
    Valores de Retorno:     $nombre_archivo     --> Retorna el nombre del archivo
    -1  --> Indica que se produjo un error y no se pudo subir el archivo al servidor
    **********************************************************
    */



    function carga_archivo_texto ( $archivo, $directorio_destino, $nombre_archivo )
    {
        // Revisa si el archivo es de mas de 50 megabytes.
        if ( $archivo['size'] <= 60000000)
        {
            //$nombre_archivo = basename ( $archivo['name'] ) ;


            if ( file_exists ( $directorio_destino+$nombre_archivo ) )
            {
                $nombre_archivo = renombra_archivo ($nombre_archivo, $directorio_destino) ;
                echo "existe ya una copia de este archivo";
            }

            $archivo_destino = $directorio_destino . $nombre_archivo ;

            if ( move_uploaded_file ($archivo['tmp_name'], $archivo_destino) )
            {
                return $nombre_archivo ;
            }
            else
            {
                return -1 ;
            }
        }
        else
        {
            return -2 ;
        }
    }
    
    
    
        /*
    **********************************************************
    Nombre de la función:   renombrar ( $archivo,$carpeta_archivo )
    Propósito:              Se utiliza esta función para copiar
    srchivos al servidor
    Parámetros:             $archivo    --> Aquí se almacena el nombre del archivo ha ser cambiado
    $carpeta_archivo  --> Aquí se guarda el nombre de la carpeta destino
    Valores de Retorno:     $nuevo_nombre   --> El nuevo nombre del archivo
    Observación:            -----
    Fecha de Creación:      16 - 05 - 05
    Versión:                1.0.0
    **********************************************************
    */
    function renombrar ( $archivo, $carpeta_archivo )
    {
        $ruta = pathinfo($archivo);
        $nombre_completo = $ruta["basename"];
        $extension = $ruta["extension"];

        if ( isset($extension) && !empty($extension))
        {
            $extension = "." . $extension;

            // obtener la posicion de la extension
            $position = strpos($nombre_completo, $extension);

            // sacar el nombre del archivo sin extension
            $nombre_sin_extension = substr($archivo, 0, $position);
        }
        else
        {
            $nombre_sin_extension = $nombre_completo;
        }

        $n = 0;
        $copia = "";

        while ( file_exists ( $carpeta_archivo . $nombre_sin_extension . $copia . $extension) )
        {
            if ($n<=9)
            $n = "00" . $n;

            if ($n<=99 && $n>=10)
            $n = "0" . $n;

            if ($n<=999 && $n>=100)
            $n = "" . $n;

            $copia = "_" . $n;
            $n++;
        }

        return $nombre_sin_extension . $copia . $extension;
    }
    
    
        /*
    **********************************************************
    Nombre de la función:   renombrar ( $archivo,$carpeta_archivo )
    Propósito:              Se utiliza esta función para copiar
    srchivos al servidor
    Parámetros:             $archivo    --> Aquí se almacena el nombre del archivo ha ser cambiado
    $carpeta_archivo  --> Aquí se guarda el nombre de la carpeta destino
    Valores de Retorno:     $nuevo_nombre   --> El nuevo nombre del archivo
    Observación:            -----
    Fecha de Creación:      16 - 05 - 05
    Versión:                1.0.0
    **********************************************************
    */
    function renombra_archivo ( $archivo, $carpeta_archivo )
    {
        $ruta = pathinfo($archivo);
        $nombre_completo = $ruta["basename"];
        $extension = $ruta["extension"];

        if ( isset($extension) && !empty($extension))
        {
            $extension = "." . $extension;

            // obtener la posicion de la extension
            $position = strpos($nombre_completo, $extension);

            // sacar el nombre del archivo sin extension
            $nombre_sin_extension = substr($archivo, 0, $position);
        }
        else
        {
            $nombre_sin_extension = $nombre_completo;
        }

        $n = 0;
        $copia = "";

        while ( file_exists ( $carpeta_archivo . $nombre_sin_extension . $copia . $extension) )
        {
            if ($n<=9)
            $n = "00" . $n;

            if ($n<=99 && $n>=10)
            $n = "0" . $n;

            if ($n<=999 && $n>=100)
            $n = "" . $n;

            $copia = "_" . $n;
            $n++;
        }

        return $nombre_sin_extension . $copia . $extension;
    }
    
    
    /*
    **********************************************************
    Nombre de la función:   PreguntaExtencion($archivo)
    Propósito:              separa la extencion de un archivo
    Parámetros:             $archivo    --> nombre del archivo

    Valores de Retorno:     $ext -->    la extención
    Observación:            -----
    Fecha de Creación:      16 - 05 - 05
    Versión:                1.0.0
    **********************************************************
    */

    function PreguntaExtencion($archivo)
    {
        $ext = '';

        $vari= explode(".",$archivo) ;
        $ext = $vari[1];
        return $ext;
    }
    
    
    /*
    **********************************************************
    Nombre de la función:   AjustaTamaño($origen,$archivo,$ancho,$altura)
    Propósito:              Se utiliza para delmitar el tamño de una foto


    Parámetros:             $source --> directorio origen
    $dest  --> directorio destino
    $archivo  --> nombre del archivo
    Valores de Retorno:     1   --> 1
    0   --> error el archivo no es jpg, gif, bmp o png
    Autor                   Rensi Arteaga Copari rensi@pi.umsa.bo
    **********************************************************
    */


    function AjustaTamaño($origen,$archivo,$ancho,$altura)
    {

        
        
        $source="$origen/$archivo"; // archivo de origen
        $width_d=$ancho; // ancho de salida maximo
        $height_d=$altura; // alto de salida maximo
        $resultados = array();
        list($width_s, $height_s, $type, $attr) = getimagesize($source, $info2); // obtengo información del archivo
        ////////////////////////////////redimencion
        $wr = 0;
        $hr = 0;
        for($i=1;$i>0;$i=$i - 0.02)
        {   $wr = $width_s * $i;
        $hr = $height_s * $i;
        if($wr <= $width_d && $hr <= $height_d)
        {
            $i = 0;
        }
        }
        ///////////////////////////////redimencion
        $resultados[0]=$wr;
        $resultados[1]=$hr;
        return $resultados;
    }
    
    
        /*
    **********************************************************
    Nombre de la función:   CreaThumb($source,$des,$archivo)
    Propósito:              Se utiliza para crear thumb de imagenes jpg gif y png
    (los thumb son copias de las  imagenes originas reducidas)

    Parámetros:             $source --> directorio origen
    $dest  --> directorio destino
    $archivo  --> nombre del archivo
    Valores de Retorno:     1   --> 1
    0   --> error el archivo no es jpg, gif, bmp o png
    Autor                   Rensi Arteaga Copari rensi@pi.umsa.bo
    **********************************************************
    */
    
        function CreaThumb($origen,$destino,$archivo)
    {

        $source="$origen/$archivo"; // archivo de origen
        $dest="$destino/$archivo"; // archivo de destino
        $width_d=150; // ancho de salida maximo
        $height_d=150; // alto de salida maximo
        list($width_s, $height_s, $type, $attr) = getimagesize($source, $info2); // obtengo información del archivo

        
        
        $ext = $this -> PreguntaExtencion($archivo);

        $sw=0;
        if($ext == "jpg" || $ext == "JPG")
        {
            $gd_s = imagecreatefromjpeg($source); // crea el recurso gd para el origen
            $sw = 1;
        }
        if($ext == "gif" || $ext == "GIF")
        {
            $gd_s = imagecreatefromgif($source); // crea el recurso gd para el origen
            $sw = 1;
        }
        if($ext == "png" || $ext == "PNG")
        {
            $gd_s = imagecreatefrompng($source); // crea el recurso gd para el origen
            $sw = 1;
        }
        if($ext == ".bmp" || $ext == "BMP")
        {
            $gd_s = imagecreatefromwbmp($source); // crea el recurso gd para el origen
            $sw = 1;
        }

        if($sw==1)
        {
            ////////////////////////////////redimencion
            $wr = 0;
            $hr = 0;
            for($i=0.5;$i>0;$i=$i - 0.02)
            {   $wr = $width_s * $i;
            $hr = $height_s * $i;
            if($wr <= $width_d && $hr <= $height_d)
            {
                $i = 0;
            }
            }
            ///////////////////////////////redimencion

            $gd_d = imagecreatetruecolor($wr, $hr); // crea el recurso gd para la salida
            // desactivo el procesamiento automatico de alpha
            imagealphablending($gd_d, false);
            // hago que el alpha original se grabe en el archivo destino
            imagesavealpha($gd_d, true);


            imagecopyresampled($gd_d, $gd_s, 0, 0, 0, 0, $wr, $hr, $width_s, $height_s); // redimensiona
            imagepng($gd_d, $dest); // graba
            // Se liberan recursos
            imagedestroy($gd_s);
            imagedestroy($gd_d);
            return 1;
        }
        else
        {
            return 0;
        }

    }

	/*
	 * AUtor: RCM
	 * Fecha: 18/09/2013
	 * Descripción: Crea un archivo con el texto enviado en la ruta indicada
	 */
	public function crearArchivo($pTexto,$pNombreArchivo,$pRuta){
		file_put_contents($pRuta.'/'.$pNombreArchivo, $pTexto);
	}
    
}
?>
