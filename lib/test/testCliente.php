<?php
	
include '../rest/ClientSiga.php';

//Generamos el documento con REST

$ClienteSiga = ClienteSiga::connect('siga.congregacao.org.br', '');


$respuesta =  $ClienteSiga->doGet('index.aspx',
    array(
        "f_login"=>"S", 
        "f_usuario"=>"", 
        "f_senha"=>""

    ));


if (strpos($respuesta, '/SIS/SIS99908.aspx') !== false) {
    echo '<BR>Logueado con exito';
}
else{
	echo '<BR>'.$out;
}





//SELECCIONAR LOCALIDAD  DE TRABAJO .......
/*
$ClienteSiga->clearHeader();
/*
$ClienteSiga->addHeader('Accept-Encoding:	gzip, deflate, br');
$ClienteSiga->addHeader('Accept-Language:	es-ES,es;q=0.8,en-US;q=0.5,en;q=0.3');
$ClienteSiga->addHeader('Accept-Encoding:	gzip, deflate, br');*/

$ClienteSiga->addHeader('Accept:  */*');
$ClienteSiga->addHeader('Connection: keep-alive');
$ClienteSiga->addHeader('Host:	siga.congregacao.org.br');
$ClienteSiga->addHeader('Referer: https://siga.congregacao.org.br/SIS/SIS99908.aspx?f_inicio=S');
$ClienteSiga->addHeader('X-Requested-With:	XMLHttpRequest');
//$ClienteSiga->addHeader('Content-Length: 720');

$ClienteSiga->addHeader('User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0');



$respuesta =  $ClienteSiga->doPost('SIS/SIS99906.aspx', 
    array(
        "gravar"=>"S", 
        "f_usuario"=>"RENSI ARTEAGA COPARIA", 
        "f_empresa"=>"954",  
        "f_estabelecimento"=>"24584",  //casa de oracion
        "f_competencia"=>"07A60453-FE49-45F4-A8A2-313EF60D44E9", //mes de trabajo 
        "__jqSubmit__"=>"S"

    ),'multipart');
	
	echo '<BR>'.$respuesta;	
	

///////////////////////
//consulta de prueba
////////////////////////

$ClienteSiga->clearHeader();

$ClienteSiga->addHeader('Host:	siga.congregacao.org.br');
$ClienteSiga->addHeader('Referer: https://siga.congregacao.org.br/TES/TES00401.aspx?f_inicio=S');
$ClienteSiga->addHeader('X-Requested-With:	XMLHttpRequest');
//$ClienteSiga->addHeader('x-ms-request-id:	QBXas');
//$ClienteSiga->addHeader('x-ms-request-root-id:	23Osi');
$ClienteSiga->addHeader('Content-Type:	application/json; charset=UTF-8');


$respuesta =  $ClienteSiga->doPost('CTB/CTB00301.asmx/Selecionar', 
    array(
        "config"=>array(
        		"iDisplayLength"=>300,
        		"iDisplayStart"=>0, 
        		"iSortCol"=>0, 
        		"sEcho"=>2, 
        		"sSearch"=>"",  
        		"sSortDir"=>"asc"), 
        "codigoEstabelecimento"=>"24150", 
        "indice"=>"", 
        "ativo"=>"True"

    ), 'json');
    

	
echo $respuesta;	


