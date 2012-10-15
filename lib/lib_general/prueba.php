<?php
include_once('Validacion.php');

//$this->mensaje_parametro=validaParametro($nombre,$valor,$tipo,$blank,$tamano);
$a=new Validacion();
$x=$a->validar('campo666',"<strong>",'text',$blank,$tamano);
echo $x;



?>