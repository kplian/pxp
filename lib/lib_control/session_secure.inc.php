<?php
/***
 Nombre: session_secure.inc.php
 Proposito: Para generacion de numeros aleatorios para la sesion
 a peticion del usuario
 Autor:	Kplian (RAC)
 Fecha:	01/07/2010
 */
function session_secure(){
    // wrapped for the php entry....
    $alph =array('A','a','B','b','C','c','D','d','E',
    'e','F','f','G','g','H','h','I','i','J','K','k',
    'L','l','M','m','N','n','O','o','P','p','Q','q',
    'R','r','S','s','T','t','U','u','V','v','W','w',
    'X','x','Y','y','Z','z');
    for($i=0;$i<rand(10,20);$i++){
        $tmp[] =$alph[rand(0,count($alph))];
        $tmp[] =rand(0,9);
    }
    return implode("",shuffle($tmp));
}
?>