<?php
/**
 *@package pXP
 *@file gen-MODArchivo.php
 *@author  (admin)
 *@date 05-12-2016 15:04:48
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODImagenFirma extends MODbase{

    function __construct(CTParametro $pParam){
        parent::__construct($pParam);

        $this->cone = new conexion();
        $this->link = $this->cone->conectarpdo(); //conexion a pxp(postgres)

    }



    function descargarImagenFirmaBoa()
    {


        try {


            // Configuration settings
            $im    = ImageCreateFromPNG('../../../uploaded_files/sis_organigrama/ImageFirma/firmaboa.png');
            $string     = 'hola fasdasd';


            imagesavealpha($im, true);
            imagealphablending($im, false);
# important part two
            $white = imagecolorallocatealpha($im, 255, 255, 255, 127);

            //$orange = imagecolorallocate($im, 0, 0, 0);
            $orange = imagefill($im,0,0,0x7fff0000);

            $px     = (imagesx($im) - 7.5 * strlen($string)) / 2;

            imagestring($im, 3, 300, 12, $string, $orange);
            imagestring($im, 3, 300, 25, $string, $orange);
            imagepng($im,'/var/www/html/kerp_capacitacion/uploaded_files/sis_organigrama/ImageFirma/2.png');
            imagedestroy($im);




            $obj = (object) array('nombre_archivo' => 'favio.png');

            $this->respuesta=new Mensaje();
            $this->respuesta->setMensaje('tipo_respuesta','nombre_archivo','mensaje','mensaje_tec','base','procedimiento','transaccion','procedimiento','consulta');
            $this->respuesta->setDatos($obj);



        }catch (Exception $e) {

            $this->respuesta=new Mensaje();

            throw new Exception($e->getMessage(), 2);


        }
        return $this->respuesta;



    }



    




}
?>