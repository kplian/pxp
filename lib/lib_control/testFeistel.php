<?php
include('../../../lib/lib_control/CTSesion.php');
session_start();
include_once(dirname(__FILE__)."/../cifrado/feistel.php");

$iFeis=new feistel();


echo $_SESSION['key_k']."<br>"; ;
echo $_SESSION['key_p_inv']."<br>"; 
echo $_SESSION['key_p']."<br>";

$texto = 'hola que tal ....    Esta es una prueba 123456.';


$respue=$iFeis->encriptar($texto,$_SESSION['key_p'],$_SESSION['key_k'],1);
   
echo $respue."<br>";

$ido=$iFeis->encriptar($respue,$_SESSION['key_p_inv'],$_SESSION['key_k'],2);
  
echo $ido."<br>"; 



  
  


                     

?>