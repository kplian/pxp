<?php
$data = array(	"credenciales"=>'{B6575E91-D2B3-48A3-B737-B66EDBD60AFA}{C0573161-B781-4B06-B4B7-C8D85DE86239}',
    "fecha"=>"09/01/2017",
    //"credenciales"=>"{ae7419a1-dbd2-4ea9-9335-2baa08ba78b4}{59331f3e-a518-4e1e-85ca-8df59d14a420}",
    "idioma"=>"ES",
    //"tkt"=>"9302400053068",
    //"pnr"=>"LOAKNP",
    //"apellido"=>"DFG",
    "ip"=>"127.0.0.1",
    "xmlJson"=>false);
$json_data = json_encode($data);


$s = curl_init();

curl_setopt($s, CURLOPT_URL, 'https://ef.boa.bo/Servicios/ServicioInterno.svc/DetalleDiario');
//curl_setopt($s, CURLOPT_URL, 'http://skbpruebas.cloudapp.net/ServicioINT/ServicioInterno.svc/TraerTkt');
//curl_setopt($s, CURLOPT_URL, 'https://ef.boa.bo/Servicios/ServicioInterno.svc/TraerReserva');

curl_setopt($s, CURLOPT_POST, true);
curl_setopt($s, CURLOPT_POSTFIELDS, $json_data);
curl_setopt($s, CURLOPT_RETURNTRANSFER, true);
curl_setopt($s, CURLOPT_HTTPHEADER, array(
        'Content-Type: application/json',
        'Content-Length: ' . strlen($json_data))
);
$_out = curl_exec($s);
echo $_out;
exit;

$status = curl_getinfo($s, CURLINFO_HTTP_CODE);
curl_close($s);


$_out = str_replace('\\','',$_out);
//$_out = substr($_out,23);
//$_out = substr($_out,0,-2);

$_out = substr($_out,19);
$_out = substr($_out,0,-2);



$res = json_decode($_out);
//$cadena = str_replace('"terminal_salida":{,},', '', $res->TraerTktResult);

//$res = json_decode($cadena);

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










