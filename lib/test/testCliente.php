<?php
	
include 'ClientSiga.php';

//Generamos el documento con REST

$ClienteSiga = ClienteSiga::connect('siga.congregacao.org.br', '');


$respuesta =  $ClienteSiga->doGet('index.aspx',
    array(
        "f_login"=>"S", 
        "f_usuario"=>"rensi.coparia", 
        "f_senha"=>"Mesu161182=!\"%$"

    ));


if (strpos($respuesta, '/SIS/SIS99908.aspx') !== false) {
    //echo '<BR>Logueado con exito';
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
        "f_estabelecimento"=>"24584",
        "f_competencia"=>"07A60453-FE49-45F4-A8A2-313EF60D44E9",
        "__jqSubmit__"=>"S"

    ),'multipart');
	
	//echo '<BR>'.$respuesta;	
	/*
curl 'https://siga.congregacao.org.br/SIS/SIS99906.aspx' 

-H 'Content-Length: 720' 
-H 'Content-Type: multipart/form-data; boundary=---------------------------20099257512804' 
-H 'Cookie: ai_user=EZF1c|2017-08-27T15:41:51.925Z; _ga=GA1.3.7789039.1503848515; _gid=GA1.3.864123469.1504298979; ASP.NET_SessionId=klokewicjmf5yof5pwzbfbot; ai_session=GYQJL|1504313507584|1504314212706.645' 
-H 'DNT: 1' -H 'Host: siga.congregacao.org.br' 
-H 'Referer: https://siga.congregacao.org.br/SIS/SIS99908.aspx' 
-H 'User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0' 
-H 'x-ms-request-id: EEFMb' 
-H 'x-ms-request-root-id: 0JVQ'*/

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

    ), 'json');
	
echo $respuesta;	
	



exit;