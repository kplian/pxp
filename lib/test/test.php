<?php


const HTTP_OK = 200;
const HTTP_CREATED = 201;
const HTTP_ACEPTED = 202;
const POST   = 'POST';
const GET    = 'GET';
const DELETE = 'DELETE';
const PUT    = 'PUT';
const HTTP  = 'http';
const HTTPS = 'https';

echo  "inicia... ";

$s = curl_init();

echo  "<br>curl_init... ";


$_headers = array();
//array_push($this->_headers,$header);

$url='https://siga.congregacao.org.br/index.aspx';
$params = array("f_login"=>"S", "f_usuario"=>"xxxx", "f_senha"=>"xxxx");


echo  "<br>URL... ".$url;

curl_setopt($s, CURLOPT_URL, $url . '?' . http_build_query($params));
//curl_setopt($s, CURLOPT_CUSTOMREQUEST, self::DELETE);


curl_setopt($s, CURLOPT_RETURNTRANSFER, true);
//curl_setopt($s, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'Content-Length: ' . strlen(json_encode($params))));



$_out = curl_exec($s);


if (strpos($_out, '/SIS/SIS99908.aspx') !== false) {
    echo '<BR>Logueado con exito';
}
else{
	echo '<BR>'.$out;
}





$status = curl_getinfo($s, CURLINFO_HTTP_CODE);
echo  "status ".$status;


$information = curl_getinfo($s);

curl_close($s);




?>
