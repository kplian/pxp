<?php
/***
 Nombre: ACTFuncion.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tfuncion 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTFuncion extends ACTbase{
	var $notas = ''; 
	var $relaciones = array();   

	function listarFuncion(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','codigo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODFuncion','listarFuncion');
		}
		else {
			$this->objFunSeguridad=$this->create('MODFuncion');
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarFuncion($this->objParam);
			
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarFuncion(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODFuncion');
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_funcion')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarFuncion($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarFuncion($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarFuncion(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODFuncion');	
		$this->res=$this->objFunSeguridad->eliminarFuncion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	
	function sincFuncion(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODFuncion');	
		$this->res=$this->objFunSeguridad->sincFunciones($this->objParam);
		if($this->res->getTipo() == "ERROR") {
		    $this->res->imprimirRespuesta($this->res->generarJson());
            exit();
		}
		$this->objParam->setTipoTran('SEL');
		//despues de sincronizar las funciones obtiene un listado de los metaprocesos que se muestran en el arbol
		$this->objFunSeguridad=$this->create('MODGui');
		
		$this->res=$this->objFunSeguridad->listarGuiSincronizacion();
		
		//se llama a lafuncion relacionaGui el cual relacionara la vistas con sus vistas dependientes y con los proce
		//dimientos respectivos 
		$guis = $this->res->getDatos();
		
		foreach($guis as $gui) {
			$this->relaciones = array();
			$this->relacionaGui($gui);
		}
				
		$this->mensajeExito=new Mensaje();
		if ($this-> notas != '') {
			$this->mensajeExito->setMensaje('ERROR','Funcion.php','Se tuvieron los siguientes problemas al hacer la sincronizacion: '. $this->notas,
										'Se tuvieron los siguientes problemas al hacer la sincronizacion: '. $this->notas,'control');
		} else {
			$this->mensajeExito->setMensaje('EXITO','Funcion.php','Se genero con exito la sincronizacion de los objetos de seguridad',
										'Se genero con exito la sincronizacion de los objetos de seguridad','control');
		}
		$this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());
		
		
	}
	
	function relacionaGui ($data) {
		//si no hay datos en data quiere decir que todos los metaprocesos estan relacionados	
		$gui = $data;
		$relaciones = $this -> insertaRelaciones($gui);
		$this->insertaProcedimientos($gui);
		foreach($relaciones as $rel) {
			$this->relacionaGui($rel);
		}		
	}
	
	function insertaRelaciones ($gui) {
		
		$relaciones = array();	
		$filename = '../../../' . trim(str_replace(array("\n", "\r"), '', $gui['ruta_archivo']));
		//se abre el archivo
		if (file_exists($filename) && is_readable ($filename)) {
			
			$lines = file($filename);
			$cadenaLoad = '';
			$cadenaMD = ''; //para maestro detalle
			$comentado = 0;
			$turl = '';
			$ttitle = '';
			$tclass = '';
			$definicion_atributo = 0;
			foreach ($lines as $line_num => & $line) {
								
				if (strpos($line, "/*")!== FALSE) {
					$comentado = 1;
				}
				//Para el caso de combo rec
				if (strpos(str_replace(' ', '', $line),'config:') !== FALSE && strpos($line, '//') === FALSE && $comentado == 0 && $definicion_atributo == 0) {
					$definicion_atributo = 1;
				} else if ($definicion_atributo == 1 && strpos(str_replace(' ', '', $line),'origen:') !== FALSE) {
					$tempString = str_replace('"', "'", $line);
					$tempArr = explode("'",$tempString);
					$linesParent = $this->getComboRec($tempArr[1]);
					
					foreach ($linesParent as $lineParent) {
						array_push($lines, $lineParent);
					}
					
				} else if ($definicion_atributo == 1 && strpos($line, '}') !== FALSE) {
					$definicion_atributo = 0;
				}
				if (strpos(str_replace(' ', '', $line),'require:') !== FALSE && strpos($line, '//') === FALSE && $comentado == 0) {
					$tempString = str_replace('"', "'", $line);
					$tempArr = explode("'",$tempString);
					
					$linesParent = file($tempArr[1]);
					
					foreach ($linesParent as $lineParent) {
						array_push($lines, $lineParent);
					}
					
				}
				if ((strpos(str_replace(' ', '', $line),'turl:') !== FALSE || strpos(str_replace(' ', '', $line),'tcls:') !== FALSE || strpos(str_replace(' ', '', $line),'ttitle:')!==FALSE) && strpos($line, '//') === FALSE && $comentado == 0) {
					$tempString = str_replace('"', "'", $line);
					$tempArr = explode("'",$tempString);
					
					if (strpos($line,'turl') !== FALSE) 
						$turl = $tempArr[1];
					elseif (strpos($line,'tcls') !== FALSE) 
						$tclass = $tempArr[1];
					else
						$ttitle = $tempArr[1];
				}
				
				if ($turl != '' && $ttitle != '' && $tclass != '') {					
					$newGui = array('ruta_archivo' => str_replace('../', '', $turl) , 'nombre'=> $ttitle, 'descripcion'=>$ttitle,'clase_vista'=>$tclass, 'combo_trigger'=>'si');
					
					
					if (!$this->existe($gui['ruta_archivo'], $newGui['ruta_archivo'])) {
						$newGui = $this->saveGui($newGui, $gui['id_gui']);
						if ($newGui['id_gui'] != $gui['id_gui']) {
							array_push($relaciones, $newGui);
						}
					}				
					
					$turl = '';
					$ttitle = '';
					$tclass = '';					
				}										
				//Para el caso de Phx.CP.loadWindows
			    if (strpos($line, 'Phx.CP.loadWindows')!== FALSE && (strpos($line, '//') === FALSE || strpos(trim($line), '//') !== 0 ) && $comentado == 0) {
			    	$cadenaLoad = $line;
			    } else if (strpos($line, ')')!== FALSE && $cadenaLoad != '') {
			    	$cadenaLoad .= $line; 
					$newGui = $this->getRelacion($cadenaLoad);
					//guardar datos de newgui y actualizar el id de newgui
					
					//poner newgui en el arreglo de relaciones
					$cadenaLoad = '';
					if (!$this->existe($gui['ruta_archivo'], $newGui['ruta_archivo'])) {
						$newGui = $this->saveGui($newGui, $gui['id_gui']);
						if ($newGui['id_gui'] != $gui['id_gui']) {
							array_push($relaciones, $newGui);
						}
					}
					
			    } else if ($cadenaLoad != '') {
			    	$cadenaLoad .= $line; 
			    }
				
				//Para el caso de maestro detalle east,west,south
			    if ((strpos($line, 'east')!== FALSE || strpos($line, 'west')!== FALSE || strpos($line, 'south')!== FALSE || 
			    	strpos($line, 'xeast')!== FALSE || strpos($line, 'xwest')!== FALSE || strpos($line, 'xsouth')!== FALSE ||
					strpos($line, 'tabeast')!== FALSE || strpos($line, 'tabwest')!== FALSE || strpos($line, 'tabsouth')!== FALSE)
			    	&& (strpos($line, '//') === FALSE || strpos(trim($line), '//') !== 0 ) && $comentado == 0) {
			    	if (strpos($line, 'tab')!== FALSE) {
						$booltab = 1;			    		
			    	} else {
			    		$booltab = 0;
			    	}
			    	$cadenaMD = $line;
			    } else if (strpos($line, '}')!== FALSE && $cadenaMD != '') {
                    
			    	$cadenaMD .= $line;
					$newGui = $this->getRelacion($cadenaMD);
					if ($booltab == 1) {
						$cadenaMD = 'tab';
					} else {
						$cadenaMD = '';
					}
                    if (strpos($line, ']')!== FALSE){
                        $cadenaMD = '';
                    }
					
					if (!$this->existe($gui['ruta_archivo'], $newGui['ruta_archivo'])) {
						//guardar datos de newgui y actualizar el id de newgui
						$newGui = $this->saveGui($newGui, $gui['id_gui']);
						if ($newGui['id_gui'] != $gui['id_gui']) {
							array_push($relaciones, $newGui);
						}
					}
					
			    }else if (strpos($line, ']')!== FALSE && $cadenaMD != '') {
			    	$cadenaMD = '';
			    	
			    } else if ($cadenaMD != '') {
			    	$cadenaMD .= $line; 
			    }
				
				if (strpos($line, "*/")!== FALSE) {
					$comentado = 0;
				}
			}
		} else {
			$this->notas .= 'No se encontro el archivo de vista'. $filename . "<BR>";
		}
		return $relaciones;		
	}

	function existe($ruta_padre, $ruta_hijo) {
		$existe = false;
		foreach ($this->relaciones as $data) {
			if ($data['ruta_padre'] == $ruta_padre && $data['ruta_hijo'] == $ruta_hijo) {
				
				$existe = true;
			}
		}
		if (!$existe) {
							
			array_push($this->relaciones,array('ruta_padre'=>$ruta_padre,'ruta_hijo'=>$ruta_hijo));
			
		}
		return $existe;
	}
	function getComboRec($opcion) {
		$filename = '../../../pxp/lib/lib_vista/addcmp/ComboRec.js';
		$res = array();
		//se abre el archivo
		if (file_exists($filename) && is_readable ($filename)) {
			$lines = file($filename);
			$comentado = 0;
			$encontrado = 0;
			foreach ($lines as $line_num => & $line) {
				if (strpos($line, "/*")!== FALSE) {
					$comentado = 1;
				}
				$line_sq = str_replace(' ', '', $line);
				if (strpos(str_replace(' ', '', $line_sq),"if(config.origen=='" . $opcion . "')") !== FALSE && strpos($line_sq, '//') === FALSE && $comentado == 0 && $encontrado == 0) {
					$encontrado = 1;			
				} else if (strpos(str_replace(' ', '', $line_sq),"if(config.origen==") !== FALSE && $comentado == 0 && $encontrado == 1 && strpos($line_sq, '//')=== FALSE) {
					$encontrado = 0;
				} else if ($encontrado == 1){
					array_push($res, $line);
				}
				
				if (strpos($line, "*/")!== FALSE) {
					$comentado = 0;
				}
			} 
			
		} else {
			$this->notas .= 'No se encontro el archivo de definicion de Combo Recs'. $filename . "<BR>";
		}
		return $res;
	}
	function getRelacion ($str) {
		$m = array();
		//echo $str;
		if (preg_match_all('/"([^"]+)"/', $str, $m)) {
    		 
		} else if (preg_match_all('/\'([^\']+)\'/', $str, $m) ) {
			
		}
		
		if(count($m) > 0) {
			return array('ruta_archivo'=>str_replace('../', '', $m[1][0]) , 'nombre'=> $m[1][1], 'descripcion'=>$m[1][1],'clase_vista'=>$m[1][2]);
		} else {
			return array();
		}
		
	}
	
	function saveGui($gui, $fk) {
		
		$retorna = $gui;
		$this->objParam->setTipoTran('IME');
		$this->objParam->iniciaParametro();
		
		$this->objParam->addParametro('ruta_archivo', $gui['ruta_archivo']);
		$this->objParam->addParametro('nombre', $gui['nombre']);
		$this->objParam->addParametro('descripcion', $gui['descripcion']);
		$this->objParam->addParametro('clase_vista', $gui['clase_vista']);
		if ($gui['combo_trigger'] == 'si')
			$this->objParam->addParametro('combo_trigger', $gui['combo_trigger']);
		else 
			$this->objParam->addParametro('combo_trigger', 'no');	
		
		//el id del padre
		$this->objParam->addParametro('id_gui_padre', $fk);
		
		
		$this->objFunSeguridad=$this->create('MODGui');
		
		$this->res=$this->objFunSeguridad->guardarGuiSincronizacion();
		$datos = $this->res->getDatos();
		$retorna['id_gui'] = $datos ['id_gui'];
		return $retorna;
				
	}
	
	function insertaProcedimientos($gui) {

		$filename = '../../../' . $gui['ruta_archivo'];
		//var_dump($filename);
		//se abre el archivo
		if (file_exists($filename) && is_readable ($filename)) {
			
			$lines = file($filename);
			$comentado = 0;
			$procedimientos = array();
			$definicion_atributo = 0;
			foreach ($lines as $line_num => & $line) {
				
				if (strpos($line, "/*")!== FALSE) {
					$comentado = 1;
				}
				//Para el caso de combo rec
				if (strpos(str_replace(' ', '', $line),'config:') !== FALSE && strpos($line, '//') === FALSE && $comentado == 0 && $definicion_atributo == 0) {
					$definicion_atributo = 1;
				} else if ($definicion_atributo == 1 && strpos(str_replace(' ', '', $line),'origen:') !== FALSE) {
					$tempString = str_replace('"', "'", $line);
					$tempArr = explode("'",$tempString);
					$linesParent = $this -> getComboRec($tempArr[1]);
					
					foreach ($linesParent as $lineParent) {
						array_push($lines, $lineParent);
					}
					
				} else if ($definicion_atributo == 1 && strpos($line, '}') !== FALSE) {
					$definicion_atributo = 0;
				}
				
				if (strpos(str_replace(' ', '', $line),'require:') !== FALSE && strpos($line, '//') === FALSE && $comentado == 0) {
					$tempString = str_replace('"', "'", $line);
					$tempArr = explode("'",$tempString);
					
					$linesParent = file($tempArr[1]);
					
					
					foreach ($linesParent as $lineParent) {
						array_push($lines, $lineParent);
					}
					
					
				}
				if (strpos($line, '/control/')!== FALSE && strpos($line, 'img src') === FALSE && (strpos($line, '//') === FALSE || strpos(trim($line), '//') !== 0 ) && $comentado == 0) {
					
					if (preg_match_all('/\'([^\']+)\'/', $line, $m)) {
						
						$procedimientos = $this->getProcedimientos($m[1], $gui['id_gui']);
						
						if (count($procedimientos) > 0) {
							$this->saveProcedimientos($procedimientos, $gui['id_gui']);
						}
					}
					if (preg_match_all('/"([^"]+)"/', $line, $m)) {
						$procedimientos = $this->getProcedimientos($m[1], $gui['id_gui']);
						if (count($procedimientos) > 0) {
							$this->saveProcedimientos($procedimientos, $gui['id_gui']);
						}
					}
					
				}
				if (strpos($line, "*/")!== FALSE) {
					$comentado = 0;
				}
			}
		} else {
			$this->notas .= "No existe el arhcivo de vista : ".$filename . "<BR>";;
		}
	}
	function getProcedimientos($cadenas, $id_gui) {

		$procedimientos = array();
		//primero buscamos la cadena que tiene la palabra control
		foreach($cadenas as $cadena) {
			if (strpos($cadena, '/control/')!== FALSE) {
				//se arma el nombre del archivo
				$arrayUrl = explode('/', $cadena);
				$arrayUrl[4] = 'ACT' . $arrayUrl[4];
				$controlFile = '../' . $arrayUrl[0] . '/' . $arrayUrl[1] . '/' . $arrayUrl[2] . '/' . $arrayUrl[3] . '/' . $arrayUrl[4] . '.php';
				$controlFunction = $arrayUrl[5];
				
				$arrayModelos = $this->getModelosFunciones($controlFile, $controlFunction);
				
				foreach ($arrayModelos as $modelo) {
					array_push ($procedimientos, $this->getFuncionProcedimiento ($modelo, $arrayUrl[2]));
				}
			}
		}
		
		
		return $procedimientos;
	}
	
	function getModelosFunciones($archivo, $funcion) {
		
		$funcionesModelo = array();
		if (file_exists($archivo) && is_readable ($archivo)) {
				
			$lines = file($archivo);
			$comentado = 0;
			$llaves = 0;
			$codigoFuncion = '';
			$modelos = array();
			
			foreach ($lines as $line_num => $line) {
				if (strpos(trim($line), "/*")=== 0) {
					$comentado = 1;
					
				}
				
				//Para el caso de Phx.CP.loadWindows
			    if (stripos($line, 'function ' . $funcion)!== FALSE && (strpos($line, '//') === FALSE || strpos(trim($line), '//') !== 0 ) && $comentado == 0 && $codigoFuncion == '') {
			    	
			    	$codigoFuncion = $line;	
			    	if (strpos($line, '{') !== FALSE) {
						$llaves++;
					}
			    } else if ($codigoFuncion != '' && (strpos($line, '//') === FALSE || strpos(trim($line), '//') !== 0 ) && $comentado == 0) {
			    	$codigoFuncion .= $line;
			    	if (strpos($line, '{') !== FALSE) {
						$llaves++;
					}
					
					if (strpos($line, '}') !== FALSE) {
						$llaves--;
					}
					if (strpos(str_replace(' ','',$line), '$this->create(') !== FALSE) {
							
						$arrtemp = explode('=', $line);
						$varName = trim($arrtemp[0]);
						//si el modelo esta envuelto por comillas simples
						if(strpos($line, "'") !== FALSE)
							$arrtemp = explode("'", $arrtemp[1]);
						else if(strpos($line, "'") !== FALSE)
							$arrtemp = explode('"', $arrtemp[1]);
						$modelo = $arrtemp[1];
						$varName = str_replace(' ','',$varName);
						
												
					} else if (strpos(str_replace(' ','',$line), $varName.'->') !== FALSE && $varName != '') {
						
						$tempArray = explode($varName.'->', str_replace(' ','',$line));
      $tempArray = explode('(', $tempArray[1]);
						$funcionModelo = trim($tempArray[0]);
						array_push($funcionesModelo, array('modelo' => $modelo, 'funcion' => $funcionModelo));
						} else if(preg_match('/\$this ?-> ?[a-zA-Z0-9_-]*\(.*\);/', $line)) {
						$funcionControl = trim($this->get_string_between($line, '->', '('));
						
						if ($funcionControl != $funcion) {
							$tempArray = $this->getModelosFunciones($archivo, $funcionControl);
							foreach($tempArray as $temp) {
								array_push($funcionesModelo, $temp);
							}
						}
					}
					if ($llaves == 0) {
						$codigoFuncion = '';
					}
			    }
								
				if (strpos($line, "*/")!== FALSE) {
					$comentado = 0;
					
				}
				
				
			}
		} else {
			$this->notas = "No existe el archivo de control: ". htmlentities($archivo) . " <BR>";
		}
			
		return $funcionesModelo;
	}

	
	function getFuncionProcedimiento($modelo, $subsistema) {
		$myArray = explode("/", $modelo['modelo']);
		$transacciones = array();
		
		if (sizeof($myArray) == 1) {			
			$archivo = "../../../" . $subsistema . "/modelo/" . $myArray [0] . '.php';			
			
		} else if (sizeof($myArray) == 2) {			
			$archivo = "../../../" . $myArray [0] . "/modelo/" . $myArray [1] . '.php';				
			
		}
		if (file_exists($archivo) && is_readable ($archivo)) {
			
			$lines = file($archivo);
			$comentado = 0;
			$llaves = 0;
			$procedimiento = '';
			$transaccion = '';
			$codigoFuncion = '';
			foreach ($lines as $line_num => $line) {
				if (strpos($line, "/*")!== FALSE) {
					$comentado = 1;
				}
				
				//Para el caso de Phx.CP.loadWindows
			    if (strpos($line, $modelo['funcion'])!== FALSE && (strpos($line, '//') === FALSE || strpos(trim($line), '//') !== 0 ) && $comentado == 0  && $codigoFuncion == '') {
			    	$codigoFuncion = $line;	
			    	if (strpos($line, '{') !== FALSE) {
						$llaves++;
					}
			    } else if ($codigoFuncion != '' && (strpos($line, '//') === FALSE || strpos(trim($line), '//') !== 0 ) && $comentado == 0) {
			    	$codigoFuncion .= $line;
			    	if (strpos($line, '{') !== FALSE) {
						$llaves++;
					}
					
					if (strpos($line, '}') !== FALSE) {
						$llaves--;
					}
					if (strpos($line, '$this->procedimiento') !== FALSE) {
						$arrtemp = explode('=', $line);
						if (strpos($line, '"'))
							$arrtemp = explode('"', $arrtemp[1]);
						else if (strpos($line, "'"))
							$arrtemp = explode("'", $arrtemp[1]);
						$procedimiento = $arrtemp[1];						
					}
					
					if (strpos($line, '$this->transaccion') !== FALSE) {
						$arrtemp = explode('=', $line);
						if (strpos($line, '"'))
							$arrtemp = explode('"', $arrtemp[1]);
						else if (strpos($line, "'"))
							$arrtemp = explode("'", $arrtemp[1]);
						$transaccion = $arrtemp[1];
						$arrtemp = array('procedimiento'=>$procedimiento, 'transaccion'=>$transaccion);
						array_push($transacciones, $arrtemp);
											
					}
					
					if ($llaves == 0) {
						$codigoFuncion = '';
					}
			    }
								
				if (strpos($line, "*/")!== FALSE) {
					$comentado = 0;
				}
			}
			
				
		} else {
			$this->notas = "No existe el archivo de modelo: " . htmlentities($archivo) . "<BR>";
		}
	return $transacciones;
		
	}

	function saveProcedimientos($procedimientos, $id_gui) {
		
		foreach($procedimientos as $procedimiento) {
			foreach($procedimiento as $transaccion) {				
				$this->objParam->setTipoTran('IME');
				$this->objParam->iniciaParametro();
				$this->objParam->addParametro('transaccion', $transaccion['transaccion']);
				$this->objParam->addParametro('procedimiento', $transaccion['procedimiento']);
				
				//el id del padre
				$this->objParam->addParametro('id_gui', $id_gui);
				
				$this->objFunSeguridad=$this->create('MODProcedimientoGui');
				
				$this->res=$this->objFunSeguridad->guardarProcedimientoGuiSincronizacion();
				
			}	
		}
						
	}

	function get_string_between($string, $start, $end){
	    $string = " ".$string;
	    $ini = strpos($string,$start);
	    if ($ini == 0) return "";
	    $ini += strlen($start);
	    $len = strpos($string,$end,$ini) - $ini;
	    return substr($string,$ini,$len);
	}

}

?>