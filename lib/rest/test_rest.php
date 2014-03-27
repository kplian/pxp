<?php

	include 'PxpRestClient.php';
	
	//phpinfo();
	/*$pxpRestClient = PxpRestClient::connect('192.168.56.101','kerp-boa/pxp/lib/rest/')
					->setCredentialsPxp('admin','admin');
	
	echo $pxpRestClient->doGet('seguridad/Usuario/listarUsuario',array('start'=>'0','limit'=>'3'));*/
	//echo '................';
	/*echo $pxpRestClient->doPost('seguridad/UsuarioRol/guardarUsuarioRol',array("id_usuario"=>"20","id_rol"=>"1"));
	echo '................';
	echo $pxpRestClient->doPost('seguridad/UsuarioRol/eliminarUsuarioRol',array("_tipo"=>"matriz","row"=>"{\"0\":{\"id_usuario_rol\":\"15\",\"_fila\":1}}"));
	
	*/
	/*$prefix = uniqid('pxp');
	echo $pxpRestClient->doPost('seguridad/Auten/verificarCredenciales',array("usuario"=>"admin","contrasena"=>fnEncrypt($prefix . '$$' .md5('admin'),md5('admin'))));
	
	*/
	$pass = md5('admin');
	echo fnEncrypt($pass,$pass);
	echo "<br>";
	echo fnEncrypt2('admin','admin');
	
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
	
	function fnEncrypt2($sValue, $sSecretKey)
	{
	    
	      return 
	      	base64_encode( 
	            mcrypt_encrypt(
	                MCRYPT_RIJNDAEL_256,
	                $sSecretKey, $sValue, 
	                MCRYPT_MODE_ECB
	                
	                
	            ));
	}