<?php
class MODValidacion
{
	var $res=array();
	var $equivalencias=array(	'integer' => 'integer',
								'varchar' => 'varchar',
								'char' => 'char',
								'text' => 'text',
								'boolean' => 'boolean',
								'numeric' => 'numeric',
								'email' => 'varchar',
								'url' => 'varchar',
								'ip' => 'varchar',
								'lista' => 'varchar',
	                            'date' => 'date',
	                            'time' => 'time',
								'otro' => 'varchar',
								'filtro_sql'=>'varchar',
								'smallint'=>'smallint',
								'int4'=>'int4',
								'int8'=>'int8',
								'consulta_select'=>'text',
								'codigo_html'=>'text',
								'json_text'=>'text' );
	
	function getTipo($tipo){
		//RAC 1/09/2011
		if(isset($this->equivalencias[$tipo]))
		  return $this->equivalencias[$tipo];	
		else 
		  return $tipo;	
	}
	
	function getRes(){
		return $this->res;
	}
	
	function validar($nombre,$valor,$tipo,$blank,$tamano,$opciones,$tipo_archivo){
		
		if($tipo=='integer' || $tipo=='smallint' || $tipo=='int4'|| $tipo=='int8'){
			
			$this->validarEntero($nombre,$valor,$blank,$tamano);
			
		}
		elseif ($tipo=='varchar'){
			
			$this->validarvarchar($nombre,$valor,$blank,$tamano);
		}
		elseif ($tipo=='text'){
            
            $this->validartext($nombre,$valor,$blank,$tamano);
        }
        elseif ($tipo=='boolean'){
            
            $this->validarBoolean($nombre,$valor,$blank,$tamano);
        }
        elseif ($tipo=='numeric'){
            
            $this->validarfloat($nombre,$valor,$blank,$tamano);
        }
		
		elseif ($tipo=='date'){
            
            //cambiar por un validador de fechas
            $this->validarvarchar($nombre,$valor,$blank,$tamano);
        }
        elseif ($tipo=='time'){
            
            $this->validarvarchar($nombre,$valor,$blank,$tamano);
        }
        elseif ($tipo=='bytea'){
            
            $this->validarBytea($nombre,$valor,$blank,$tamano,$opciones,$tipo_archivo);
            
        }
		elseif ($tipo=='consulta_select'){								
				$this->validarSelect($nombre,$valor,$blank,$tamano);				
			    $this->validartext($nombre,$valor,$blank,$tamano);
		}
		
		elseif ($tipo=='json_text'){								
				$this->validarJson($nombre,$valor,$blank,$tamano);
		}
		
		elseif ($tipo=='codigo_html'){                                
                $this->validarCodigoHtml($nombre,$valor,$blank,$tamano);
        }
		
		
		
		elseif ($tipo=='email'){
			
			$this->validaremail($nombre,$valor,$blank,$tamano);
		}
		elseif ($tipo=='url'){
			
			$this->validarurl($nombre,$valor,$blank,$tamano);
		}
		elseif ($tipo=='ip'){
			
			$this->validarip($nombre,$valor,$blank,$tamano);
		}
		elseif ($tipo=='lista'){
			
			$this->validarlista($nombre,$valor,$blank,$tamano,$opciones);
		}
		elseif ($tipo=='filtro_sql'){
			
			$this->validarfiltrosql($nombre,$valor);
		}
		
		else{
			//posiblemente se trata de un dato enum lo validamos como varchar
			$this->validarvarchar($nombre,$valor,$blank,$tamano);
			//array_push($this->res,"El tipo de dato $tipo no está especificado para el campo $nombre");
		}
		
		
	}
	
	///FUNCIONES DE VALIDACION
	
	function validarEntero($nombre,$valor,$blank,$tamano){
		
		if(trim($valor=='') || !isset($valor) || $valor==null){
			if($blank==false){
				
				array_push($this->res,'El campo '.$nombre." debe ser registrado");
			}
			
		}
		if(($tamano!='' && isset($tamano) && $tamano!=null)&&(strlen($valor)>$tamano))
		{
			array_push($this->res,'El tamaño en el campo '.$nombre." es mayor al máximo permitido");
		}
			
		/*if(!filter_var($valor, FILTER_VALIDATE_INT))
		{
			return 'El campo '.$nombre." debe ser un n�mero entero";
		}*/
					
		
	}
	
	function validarlista($nombre,$valor,$blank,$tamano,$opciones){
		$ban=0;
		foreach ($opciones as $opcion){
			if($opcion==$valor){
				$ban=1;
			}
		}
		if($ban!=1){
			array_push($this->res,"El campo $nombre debe tomar uno de los valores de la lista");
		}
			
	}
	
	function validarotro($nombre,$valor,$blank,$tamano,$opciones){
		
		if(trim($valor=='') || !isset($valor) || $valor==null){
			if($blank==false){
				return 'El campo '.$nombre." debe ser registrado";
			}
			else{
				return 'exito';
			}
		}
		if(($tamano!='' && isset($tamano) && $tamano!=null)&&(strlen($valor)>$tamano))
		{
			return 'El tamaño en el campo '.$nombre." es mayor al máximo permitido";
		}
		
		$res=$this->validarEspeciales($nombre,$valor);
		
		if($res!='exito'){
			return $res;
		}
		else{
			if(filter_var($valor, FILTER_VALIDATE_REGEXP,array('options' => array('regexp' => $opciones['expresion']))))
			{
				
				return 'exito';
			}
			else{
				return "El valor del campo $nombre no es aceptable";
			}
			
		}
			
		
	}
	
	function validarvarchar($nombre,$valor,$blank,$tamano){
		
		if(trim($valor=='') || !isset($valor) || $valor==null){
			if($blank==false){
				array_push($this->res,'El campo '.$nombre." debe ser registrado");
			}
			
		}
		if(($tamano!='' && isset($tamano) && $tamano!=null)&&(strlen($valor)>$tamano))
		{
			array_push($this->res,'El tamaño en el campo '.$nombre." es mayor al máximo permitido");
		}
		
		$this->validarEspeciales($nombre,$valor);
				
		
	}
	function validartext($nombre,$valor,$blank,$tamano){
		
		if(trim($valor=='') || !isset($valor) || $valor==null){
			if($blank==false){
				array_push($this->res,'El campo '.$nombre." debe ser registrado");
			}
			
		}
		$this->validarEspeciales($nombre,$valor);
				
		
	}
	
	
	function validarBoolean($nombre,$valor,$blank,$tamano){
		if(trim($valor=='') || !isset($valor) || $valor==null){
			if($blank==false){
				array_push($this->res,'El campo '.$nombre." debe ser registrado");
			}
		}
		
		//RAC 02/09/2011  modifica la validacion de datos  boleanos	
		if($valor!='false' && $valor!='true' && $valor!='f' && $valor!='t' && $valor!=false && $valor!=true) 
		{
			array_push($this->res,'El campo '.$nombre." debe ser de tipo boolean");
		}
				
	}
	
	function validarfloat($nombre,$valor,$blank,$tamano){
		
		if(trim($valor=='') || !isset($valor) || $valor==null){
			if($blank==false){
				array_push($this->res,'El campo '.$nombre." debe ser registrado");
			}
			
		}
		if(($tamano!='' && isset($tamano) && $tamano!=null)&&(strlen($valor)>$tamano))
		{
			array_push($this->res,'El tamaño en el campo '.$nombre." es mayor al máximo permitido");
		}
		
		
		
		if($valor!=0&&$valor!='' && !filter_var($valor, FILTER_VALIDATE_FLOAT))
		{
		   array_push($this->res,'El campo '.$nombre." debe ser un número decimal");
		}
		
			
		
	}
	
	function validarip($nombre,$valor,$blank,$tamano){
		
		if(trim($valor=='') || !isset($valor) || $valor==null){
			if($blank==false){
				array_push($this->res,'El campo '.$nombre." debe ser registrado");
			}
		}
				
		
		if(!filter_var($valor, FILTER_VALIDATE_IP))
		{
			array_push($this->res,'El campo '.$nombre." debe ser una dirección IP válida");
		}
		
			
		
	}
	function validarurl($nombre,$valor,$blank,$tamano){
		
		if(trim($valor=='') || !isset($valor) || $valor==null){
			if($blank==false){
				array_push($this->res,'El campo '.$nombre." debe ser registrado");
			}
			
		}
		
		if(($tamano!='' && isset($tamano) && $tamano!=null)&&(strlen($valor)>$tamano))
		{
			array_push($this->res,'El tamaño en el campo '.$nombre." es mayor al máximo permitido");
		}
		
		$this->validarEspeciales($nombre,$valor);
						
		if(!filter_var($valor, FILTER_VALIDATE_URL))
		{
			array_push($this->res,'El campo '.$nombre." debe ser una dirección url válida");
		}
				
	}
	
	function validaremail($nombre,$valor,$blank,$tamano){
		
		if(trim($valor=='') || !isset($valor) || $valor==null){
			if($blank==false){
				array_push($this->res,'El campo '.$nombre." debe ser registrado");
			}
			
		}
		if(($tamano!='' && isset($tamano) && $tamano!=null)&&(strlen($valor)>$tamano))
		{
			array_push($this->res,'El tama�o en el campo '.$nombre." es mayor al máximo permitido");
		}
		
		$this->validarEspeciales($nombre,$valor);
		
				
		if(!filter_var($valor, FILTER_VALIDATE_EMAIL))
		{
			array_push($this->res,'El campo '.$nombre." debe ser un correo electrónico válido");
		}
				
		
	}
	
	function validarfiltrosql($nombre,$valor){
		
		//echo $valor;exit;
		
		//validar sql injection
		//rac 07022012 modifica expresion regular por que no permitia filtrar el numero 23 to do mejorar exprecion regular para esta validacion
		//if(filter_var($valor, FILTER_VALIDATE_REGEXP,array('options' => array('regexp' => "/(\%27)|(\-\-)|(\%23)/"))))//otra cadena para probar "/\w*((\%27)|(\'))((\%6F)|o|(\%4F))((\%72)|r|(\%52))/ix "
		if(filter_var($valor, FILTER_VALIDATE_REGEXP,array('options' => array('regexp' => "/(\-\-)/"))))
		{
			
			throw new Exception("Error en validacion de caracteres en los filtros del grid, posible sql inyection (elimine los caracteres especiales). Este evento sera reportado");
		}
		//valida cross site scripting
		if(filter_var($valor, FILTER_VALIDATE_REGEXP,array('options' => array('regexp' => "/((\%3C)|<)((\%2F)|\/)*[a-z0-9\%]+((\%3E)|>)/"))))
		{
			
			throw new Exception("Error en validacion de caracteres en los filtros del grid, posible cross site scripting (elimine los caracteres especiales). Este evento sera reportado");
		}
		//validar uso de comodines en el filtro	

	    if(filter_var($valor, FILTER_VALIDATE_REGEXP,array('options' => array('regexp' => "/plainto_tsquery\(''spanish'',''*_*_*_*''\)/"))))
		{
			//array_push($this->res,'El campo '.$nombre." contiene caracteres no permitidos '$valor'");
			array_push($this->res,'El campo '.$nombre." contiene demasiados comodines tipo _ ");
		}
		//ejemplo de cadena en filtro
		/*
		0 = 0 AND to_tsvector(consulta) 
		@@ plainto_tsquery(''spanish'',''_[r/a)_ _(r/b)_ _(r-d)_'') 
		AND to_tsvector(procedimientos) 
		
		@@ plainto_tsquery(''spanish'',''_[r/a)_ _(r/b)_ _(r-d)_'')*/
		
				
		
	}
	
	function validarEspeciales($nombre,$valor){
		//validar sql injection
		//if(preg_match('@/\*(.*)\*/@Us', $valor))//otra cadena para probar "/\w*((\%27)|(\'))((\%6F)|o|(\%4F))((\%72)|r|(\%52))/ix "
		

		//rac 27/10/11 se comenta esta validacion por un problema para permitir comillas simples
		//que ahoran son escapadas en la ModBase
		//if(filter_var($valor, FILTER_VALIDATE_REGEXP,array('options' => array('regexp' => "/(\%27)|(\')|(\-\-)|(\%23)/"))) || (preg_match('@/\*(.*)\*/@Us', $valor)))//otra cadena para probar "/\w*((\%27)|(\'))((\%6F)|o|(\%4F))((\%72)|r|(\%52))/ix "
		
		if(filter_var($valor, FILTER_VALIDATE_REGEXP,array('options' => array('regexp' => "/(\-\-)|(\%23)/"))) || (preg_match('@/\*(.*)\*/@Us', $valor)))//otra cadena para probar "/\w*((\%27)|(\'))((\%6F)|o|(\%4F))((\%72)|r|(\%52))/ix "
		
		{
			
			throw new Exception("Error en validacion de caracteres en el campo $nombre, posible sql inyection (elimine los caracteres especiales). Este evento sera reportado");
		}
		
		//valida cross site scripting
		if(filter_var($valor, FILTER_VALIDATE_REGEXP,array('options' => array('regexp' => "/((\%3C)|<)((\%2F)|\/)*[a-z0-9\%]+((\%3E)|>)/"))))
		{
			
			throw new Exception("Error en validacion de caracteres en el campo $nombre, posible cross site scripting (elimine los caracteres especiales). Este evento sera reportado");
		}
		
		if(strpos($valor, "'") != false)
		{
			
			throw new Exception("Error en validacion de caracteres en el campo $nombre, no está permitido el caracter '");
		}
				
	}
	
	//RAC 29/09/2011
	//para validacion de archivos
	function validarBytea($nombre,$valor,$blank,$tamano,$isimage,$tipo_archivo){
		
		$filesize = $valor['size'];
		$filename = $valor['name'];
		$filetemp = $valor['tmp_name'];
		//$filetype = mime_content_type($filetemp);
		$fileexte = substr($filename, strrpos($filename, '.')+1);
		$allowed = array("image/bmp","image/gif","image/jpeg","image/pjpeg","image/png","image/x-png");
		$blocked = array("php","PHP","phtml","PHTML","php3","PHP3","php4","PHP4","js","JS","shtml","SHTML","pl","PL","py","PY","html","HTML");
		/*$atext = array("txt","TXT");
		$aPdf = array("pdf","PDF");
		$aExcel = array("cvs","CVS");*/
		
		if(trim($valor=='') || !isset($valor) || $valor==null){
			if($blank==false){
				array_push($this->res,'El campo '.$nombre." debe ser registrado");
			}
			
		}elseif (is_uploaded_file($filetemp)){
			$filetype = mime_content_type($filetemp);
			// check if file valid
			if ($filename == "") {
				throw new Exception("El archivo no puede estar vacio");
			}
			
						
			// check max size
			if ($tamano != 0) {
				if ($filesize > $tamano*1024) {
					throw new Exception("El archivo es muy gande, maximo permitido de $tamano KB");
				}
			}
			// check if image
			if ($isimage) {
				// check dimensions
				if (!getimagesize($filetemp)) {
					throw new Exception("Archivo de imagen invalido");	
				}
				// check content type
				if (!in_array($filetype, $allowed)) {
					throw new Exception("Tipo de archivo no permitido");	
				}
			}
			else{
				//si no es imagen segun el tipo verifica extenciones
				
				if (!in_array($fileexte, $tipo_archivo)) {
					throw new Exception("Tipo de archivo no permitido");	
				}
				 
				
			}
			// check if file is allowed
			if (in_array($fileexte, $blocked)) {
				throw new Exception("Tipo de archivo bloqueado por politica -".$fileexte);	
				
			}
			// check if file is allowed
			if (in_array($fileexte, $blocked)) {
				throw new Exception("Tipo de archivo no permitido -".$fileexte);	
				
			}
			
					
			
		} else {
			
			throw new Exception("El archivo no se pudo subir, por favor intentelo de nuevo");
		}
		

	}
	
	function validarSelect($nombre,$valor,$blank,$tamano){		
			
			if($blank==false){
				array_push($this->res,'El campo '.$nombre." debe ser registrado");
			}
			else{
				$needle = array("insert", "update", "delete", "create","alter","drop","into", "values", 
				"trigger", "view", "rule","CREATEDB","CREATEROLE","CREATEUSER","EXECUTE","EXEC");
				$words = explode(' ', $valor);				
				foreach ($words as $word) {				
						foreach ($needle as $keyword) {
								if(strpos($word,$keyword)!==false){
									if(strpos($word,$keyword)==0){
												array_push($this->res,'El campo '.$nombre.'contiene ordenes no permitidas');
											 throw new Exception("El campo contiene la orden no permitida ".strtoupper($word));
									}
								}							
						}	
				}								 
			}					
	}
	
	function validarCodigoHtml($nombre,$valor,$blank,$tamano){		
		 if($blank==false){
                array_push($this->res,'El campo '.$nombre." debe ser registrado");
        }							
	}
	
	function validarJson($nombre,$valor,$blank,$tamano) {
        if($blank==false){
           array_push($this->res,'El campo '.$nombre." debe ser registrado");
        }            
        json_decode($valor);
        if(json_last_error() != JSON_ERROR_NONE  ){
           throw new Exception("Error en archvi JSON: ".json_last_error_msg());
        }
    }
}