<?php
	//$srt= mb_convert_encoding('!"·$%&/()=1234567890','UTF-8');
	
	include 'PxpRestClient.php';	
	
	//phpinfo();
	$prefix = uniqid('pxp');
	$pass = md5('123');
	$_pass = fnEncrypt($prefix . '$$' . $pass, $pass);
	
	$pxpRestClient = PxpRestClient::connect('127.0.0.1','kerp/pxp/lib/rest/')->setCredentialsPxp('jrivera','jrivera');
	
					//->setCredentialsPxp('admin','123');
	//echo $pxpRestClient->doGet('libre/tesoreria/CuentaDocumentadaEndesis/listarFondoAvance2',array("limit"=>'10'));
	//echo $pxpRestClient->doGet('tesoreria/CuentaDocumentadaEndesis/listarFondoAvance',array("limit"=>'10'));
	//echo $pxpRestClient->doGet('seguridad/Usuario/listarUsuario',array());
	/*echo $pxpRestClient->doPost('organigrama/Interinato/asignarMiSuplente',
	    array(	"id_interinato"=>'',"id_cargo_suplente"=>16,"fecha_ini"=>"01/07/2014",
	    		"fecha_fin"=>"01/08/2014", "descripcion"=>"" ));*/
	    		
	echo $pxpRestClient->doPost('adquisiciones/Solicitud/reporteSolicitud',
	    array("id_proceso_wf"=>'4032'));
				
				
			/*	kerp_capacitacion/pxp/lib/rest/organigrama/Funcionario/listarFuncionarioCargo
	echo $pxpRestClient->doGet('organigrama/Interinato/listarMisSuplentes',
	    array(	"sort"=>'id_interinato',"start"=>0,"limit"=>50,
	    		"dir"=>'ASC'));*/
	
	/*
	echo $pxpRestClient->doGet('organigrama/Funcionario/listarFuncionarioCargo',
        array(  "sort"=>'descripcion_cargo',"start"=>0,"limit"=>50,"dir"=>'ASC'
                ));*/
                
  /*echo $pxpRestClient->doGet('organigrama/Funcionario/listarFuncionarioCargo',
        array(  "start"=>0,"limit"=>50
                )); */
	
	/*echo $pxpRestClient->doPost('seguridad/Auten/verificarCredenciales',
        array(  "usuario"=>"jrivera","contrasena"=>$_pass
                ));*/
      
      
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
	


