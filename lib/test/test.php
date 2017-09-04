<?php

include 'ClientSiga.php';

$ClienteSiga = ClienteSiga::connect('siga.congregacao.org.br', '');


$ClienteSiga->addHeader('Host:	siga.congregacao.org.br');
$ClienteSiga->addHeader('Referer: https://siga.congregacao.org.br/TES/TES00401.aspx?f_inicio=S');
$ClienteSiga->addHeader('X-Requested-With:	XMLHttpRequest');
//$ClienteSiga->addHeader('x-ms-request-id:	QBXas');
//$ClienteSiga->addHeader('x-ms-request-root-id:	23Osi');
$ClienteSiga->addHeader('Content-Type:	application/json; charset=UTF-8');


$respuesta =  $ClienteSiga->doPost('TES/TES00401.asmx/Selecionar',
    array(
        "config"=>array(
        		"iDisplayLength"=>10,
        		"iDisplayStart"=>0, 
        		"iSortCol"=>0, 
        		"sEcho"=>1, 
        		"sSearch"=>"",  
        		"sSortDir"=>"asc"), 
        "data1"=>"2017-08-01", 
        "data2"=>"2017-08-31"

    ));
	
echo '<BR>'.$respuesta;	
	



exit;




?>
