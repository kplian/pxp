<?php
	
include 'ClientSiga.php';

//Generamos el documento con REST

$ClienteSiga = ClienteSiga::connect('siga.congregacao.org.br', '');


$respuesta =  $ClienteSiga->doGet('index.aspx',
    array(
        "f_login"=>"S", 
        "f_usuario"=>"rensi.coparia", 
        "f_senha"=>"xxxxxx"

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

/*
$ClienteSiga->addHeader('Host:	siga.congregacao.org.br');
$ClienteSiga->addHeader('Referer: https://siga.congregacao.org.br/TES/TES00401.aspx?f_inicio=S');
$ClienteSiga->addHeader('X-Requested-With:	XMLHttpRequest');
$ClienteSiga->addHeader('Content-Type: multipart/form-data;boundary=---------------------------32642708628732');
*/

/*

$respuesta =  $ClienteSiga->doPost('/SIS/SIS99906.aspx',
    array(
        "gravar"=>"S", 
        "f_usuario"=>"RENSI ARTEAGA COPARIA", 
        "f_empresa"=>"954",
        "f_estabelecimento"=>"24584",
        "f_competencia"=>"07A60453-FE49-45F4-A8A2-313EF60D44E9",
        "f-mudarpadrao"=>"S",
        "__jqSubmit__"=>"S"

    ));*/


///////////////////////
//consulta de prueba
////////////////////////

//$ClienteSiga->clearHeader();

$ClienteSiga->addHeader('Host:	siga.congregacao.org.br');
$ClienteSiga->addHeader('Referer: https://siga.congregacao.org.br/TES/TES00401.aspx?f_inicio=S');
$ClienteSiga->addHeader('X-Requested-With:	XMLHttpRequest');
//$ClienteSiga->addHeader('x-ms-request-id:	QBXas');
//$ClienteSiga->addHeader('x-ms-request-root-id:	23Osi');
$ClienteSiga->addHeader('Content-Type:	application/json; charset=UTF-8');


$respuesta =  $ClienteSiga->doPost('/TES/TES00401.asmx/Selecionar',
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
