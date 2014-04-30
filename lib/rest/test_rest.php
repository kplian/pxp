<?php
	//$srt= mb_convert_encoding('!"·$%&/()=1234567890','UTF-8');
	
	/*include 'PxpRestClient.php';	
	//phpinfo();
	$pxpRestClient = PxpRestClient::connect('172.17.45.229','kerp_capacitacion/pxp/lib/rest/')
					->setCredentialsPxp('jrivera','jrivera');
	//echo $pxpRestClient->doGet('libre/tesoreria/CuentaDocumentadaEndesis/listarFondoAvance2',array("limit"=>'10'));
	echo $pxpRestClient->doGet('tesoreria/CuentaDocumentadaEndesis/listarFondoAvance',array("limit"=>'10'));
	//echo $pxpRestClient->doGet('seguridad/Usuario/listarUsuario',array());
	//echo $pxpRestClient->doPost('tesoreria/CuentaDocumentadaEndesis/aprobarFondoAvance',array("id_cuenta_documentada"=>'356',"accion"=>"cancelar"));
	
*/

$pass = 'jrivera';

$prefix = uniqid('pxp');

$md5 = md5($pass);
echo $md5;



echo "<BR>";

$pass = fnEncrypt($prefix . '$$' . $md5, $md5);

echo $pass; //Se envia esto



echo "<BR>";

$desenc = fnDecrypt('SKscQ7TLte66lRZZxyf0+KsBWJyuHGmyR+ZgOz24pHoy1lqn0urBhV+DtxtMgM7S3r9l0b5XiH79zVJAzB6TmQ==', $md5);

echo $desenc;
exit;

function fnEncrypt($sValue, $sSecretKey)
	{
	    return rtrim(
	        base64_encode(
	            mcrypt_encrypt(
	                MCRYPT_RIJNDAEL_256,
	                $sSecretKey, $sValue, 
	                MCRYPT_MODE_ECB, 
	                mcrypt_create_iv(
	                    mcrypt_get_iv_size(
	                        MCRYPT_RIJNDAEL_256, 
	                        MCRYPT_MODE_ECB
	                    ), 
	                    MCRYPT_RAND)
	                )
	            ), "\0"
	        );
	}
	
	
function fnDecrypt($sValue, $sSecretKey)
	{
	    return rtrim(
	        mcrypt_decrypt(
	            MCRYPT_RIJNDAEL_256, 
	            $sSecretKey, 
	            base64_decode($sValue), 
	            MCRYPT_MODE_ECB,
	            mcrypt_create_iv(
	                mcrypt_get_iv_size(
	                    MCRYPT_RIJNDAEL_256,
	                    MCRYPT_MODE_ECB
	                ), 
	                MCRYPT_RAND
	            )
	        ), "\0"
	    );
	}
	