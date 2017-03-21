<?php
$data = array(	"credenciales"=>"{B6575E91-D2B3-48A3-B737-B66EDBD60AFA}{C0573161-B781-4B06-B4B7-C8D85DE86239}",
    "idioma"=>"ES",
    //"fecha"=>"01/30/2017",
    "tkt"=>"9306545094074",
    "ip"=>"127.0.0.1",
    "xmlJson"=>false);
$json_data = json_encode($data);

$s = curl_init();
//curl_setopt($s, CURLOPT_URL, 'https://ef.boa.bo/Servicios/ServicioInterno.svc/DetalleDiario');
curl_setopt($s, CURLOPT_URL, 'https://ef.boa.bo/Servicios/ServicioInterno.svc/TraerTkt');

curl_setopt($s, CURLOPT_POST, true);
curl_setopt($s, CURLOPT_POSTFIELDS, $json_data);
curl_setopt($s, CURLOPT_RETURNTRANSFER, true);
curl_setopt($s, CURLOPT_HTTPHEADER, array(
        'Content-Type: application/json',
        'Content-Length: ' . strlen($json_data))
);
$_out = curl_exec($s);
$status = curl_getinfo($s, CURLINFO_HTTP_CODE);
curl_close($s);
//echo $_out;
//exit;
//$_out = substr($_out,109);
//$_out = substr($_out,0,-4);

//$_out = str_replace('\\','',$_out);


$cadena = str_replace('"terminal_salida":{,},', '', $res->TraerTktResult);
$res = json_decode($_out);

echo "<pre>";
print_r($res);
echo "</pre>";
//var_dump($obj);




/*
 * CASH
 * 
 * [forma_pago] => stdClass Object
                (
                    [#text] => CASH,/BOB172/+TKT,CASH
                )
 * 
 * VISA
 * 
 * 
 * 
 * MASTERCARD
 * 
 * [forma_pago] => stdClass Object
                (
                    [#text] => CA,1000096014079908/1020/N600430/BOB644
                )
 * 
 * */










