<?php
/***
 Nombre: ACTEstructuraUo.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla testructura_uo
 Autor:	Kplian
 Fecha:	24/05/2011
 */
class ACTEstructuraUo extends ACTbase {

	/*
	 * Listar estructura UO
	 *
	 * */
	function listarEstructuraUo() {
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		//$this->objFunSeguridad=$this->create('MODEstructuraUo');

		//obtiene el parametro nodo enviado por la vista
		$node = $this -> objParam -> getParametro('node');
		$id_uo = $this -> objParam -> getParametro('id_uo');

		if ($node == 'id' || !is_numeric($node)) {
			$this -> objParam -> addParametro('id_padre', '%');
		} else {
			$this -> objParam -> addParametro('id_padre', $id_uo);
		}

		if ($this -> objParam -> getParametro('filtro') == 'activo' && $node == 'id') {
			$count = 0;
			$pri = 1;
			$json = '';
			$count_temporal = 0;
			//$criterio_filtro = $this->objParam->getParametro('valor_filtro');

			if ($node == 'id') {
				$this -> objParam -> addParametro('id_padre', '%');
			} else {
				$this -> objParam -> addParametro('id_padre', $id_uo);
			}
			
			$this->objFunSeguridad=$this->create('MODUo');
			$this -> res = $this -> objFunSeguridad -> listarUoFiltro($this -> objParam);
			
			if ($this -> res) {
				
				foreach ($this->res->datos as $f) {
					//var_dump($f);
					if ($pri == 1) {
						//guardo el nivel
						$niveles[$count] = $f["niveles"];
						//suponemos que el nivel inicial no tiene hijos
						$hijos[$count] = 0;
						$pri = 0;
						//prepara nodo
						$json = '[{';
						$json = $json . $this -> asignar($json, $f);
					} else {
						//este nodo es hijo del anterior nodo??
						//$posicion = strpos($f["niveles"],$niveles[$count].'_');
						$posicion = strpos($f["niveles"], $niveles[$count]);
						//var_dump($posicion);
						//var_dump($f["niveles"]);
						if ($posicion !== false) {

							//echo "ENTRA";
							//var_dump($posicion);

							//pregunta mos si este el primer hijo del nivel padre
							if ($hijos[$count] == 0) {

								//si es el primero iniciamos las llaves
								$json = $json . ',children:[{';
							} else {
								//si no es el primero cerramos el hijo anterior y preparamos sllavez para el siguiente
								$json = $json . '},{';
							}
							//llenamos el nodo
							$json = $json . $this -> asignar($json, $f);

							//si el primer hijo incrementamos el nivel
							if ($hijos[$count] == 0) {

								//se incrementa el nivel
								$count++;
								//suponemos que este nuevo nivel no tiene hijos
								$hijos[$count] = 0;
							}
							//se incrementa un hijo en el anterior nivel
							$hijos[$count - 1]++;
							//almacena el identificador del actual nivel
							$niveles[$count] = $f["niveles"];
						} else {
							//si el nodo no es hijo del anterio nivel
							//buscamos mas arriba hasta encontrar un padre o la raiz
							//en el camino vamos cerrando llavez
							$sw_tmp = 0;
							// sw temporal
							$count_temporal = 0;
							while ($sw_tmp == 0) {

								$hijos[$count] = 0;
								$count--;

								$count_temporal++;
								if ($count_temporal == 1) {

									//$json =$json.' * ('.$count.')';

								} else {
									$json = $json . '}]';
								}

								//$posicion = strpos($f["niveles"],$niveles[$count].'_');
								$posicion = strpos($f["niveles"], $niveles[$count]);
								if ($posicion !== false) {

									$sw_tmp = 1;
								} else {

									//si revisamos el ultimo nivel
									if ($count <= -1) {
										$sw_tmp = 1;
									}
								}
							}
							$json = $json . '},{';
							$json = $json . $this -> asignar($json, $f);

							//se incrementa un hijo en el anterior nivel
							$hijos[$count]++;
							//almacena el identificador del actual nivel
							$count++;
							$niveles[$count] = $f["niveles"];

						}
					}
				}

				while ($count > 0) {

					$count--;
					$json = $json . '}]';

				}
				if ($pri == 0) {
					$json = $json . '}]';
				} else {
					$json = $json . '[]';

				}
				header("Content-Type:text/json; charset=" . $_SESSION["CODIFICACION_HEADER"]);
				//echo utf8_encode
				echo($json);
				exit ;

			}

			/////////////////////////
		} else {
			$this->objFunSeguridad=$this->create('MODEstructuraUo');
			$this -> res = $this -> objFunSeguridad -> listarEstructuraUo($this -> objParam);

			$this -> res -> setTipoRespuestaArbol();

			$arreglo = array();
			//array_push($arreglo,array('nombre'=>'id','valor'=>'id_gui'));
			array_push($arreglo, array('nombre' => 'id', 'valor' => 'id_uo'));
			array_push($arreglo, array('nombre' => 'codigo', 'valor' => 'codigo'));
			array_push($arreglo,array('nombre'=>'text','valores'=>'<b>(#codigo#)</b> - #nombre_unidad#'));
			array_push($arreglo, array('nombre' => 'desc', 'valor' => 'descripcion'));
			array_push($arreglo, array('nombre' => 'cargo', 'valor' => 'nombre_cargo'));

			array_push($arreglo, array('nombre' => 'presupuesta', 'valor' => 'presupuesta'));
			array_push($arreglo, array('nombre' => 'nodo_base', 'valor' => 'nodo_base'));
			array_push($arreglo, array('nombre' => 'estado_reg', 'valor' => 'estado_reg'));
			array_push($arreglo, array('nombre' => 'id_p', 'valor' => 'id_uo_padre'));

			/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
			 es importante que entre los resultados devueltos por la base exista la variable\
			 tipo_dato que tenga el valor en texto = 'carpeta' */

			$this -> res -> addNivelArbol('nodo_base', 'si', array('leaf' => false, 'allowDelete' => true, 'allowEdit' => true, 'cls' => 'folder', 'tipo' => 'si'), $arreglo);

			array_push($arreglo, array('nombre' => 'cls', 'valor' => 'descripcion'));

			/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
			 es importante que entre los resultados devueltos por la base exista la variable\
			 tipo_dato que tenga el valor en texto = 'hoja' */

			$this -> res -> addNivelArbol('nodo_base', 'no', array('leaf' => false, 'allowDelete' => true, 'allowEdit' => true, 'tipo' => 'no', 'icon' => '../../../lib/imagenes/a_form.png'), $arreglo);

			array_push($arreglo, array('nombre' => 'id_estructura_uo', 'valor' => 'id_estructura_uo'));



			//Se imprime el arbol en formato JSON
			$this -> res -> imprimirRespuesta($this -> res -> generarJson());

		}

	}

	/*
	 * ELIMINAR GUI
	 *
	 *
	 * */

	function eliminarEstructuraUo() {
		//recupera lso datos recibidos desde la vista y los pone en  variables
		$tipo_dato = $this -> objParam -> getParametro('tipo_dato');
		//crea un objeto del tipo seguridad
		$this -> objFunSeguridad = $this -> create('MODEstructuraUo');

		if ($tipo_dato != 'procedimiento') {

			//Si es un nodo tipo interfaz eliminamos el GUI

			$this -> res = $this -> objFunSeguridad -> eliminarEstructuraUo($this -> objParam);
			$this -> res -> imprimirRespuesta($this -> res -> generarJson());

		} else {
			//si es un nodo tipo procedimiento,  eliminamos la relacion con el procedimiento

		}

	}

	/*
	 * GUARDAR Estructura UO (INSERTAR O MODIFICAR GUI)
	 * Inserta nueva uo en el arbol de uos
	 * rhum.tuo
	 * rhum.testructura_uo
	 *
	 *
	 * */

	function guardarEstructuraUo() {
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this -> objFunSeguridad = $this -> create('MODEstructuraUo');
		//recupera lso datos recibidos desde la vista y los pone en  variables
		$id_gui = $this -> objParam -> getParametro('id_uo');

		//$node=$this->objParam->getParametro('id_uo_padre');

		/*if($node=='id'){

		 }
		 */
		//preguntamos si se debe insertar o modificar
		if ($this -> objParam -> insertar('id_uo')) {

			//print_r($this->objParam); exit;

			//ejecuta el metodo de insertar de la clase MODPersona a travez
			//de la intefaz objetoFunSeguridad

			$this -> res = $this -> objFunSeguridad -> insertarEstructuraUo($this -> objParam);

		} else {
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez
			//de la intefaz objetoFunSeguridad
			$this -> res = $this -> objFunSeguridad -> modificarEstructuraUo($this -> objParam);
		}
		//imprime respuesta en formato JSON
		$this -> res -> imprimirRespuesta($this -> res -> generarJson());

	}

	protected function asignar($json, $f) {

		//para ofuscar identificadores

		$mres = new Mensaje();
		if ($_SESSION["_OFUSCAR_ID"] == 'si') {

			$id_uo = $mres -> ofuscar($f["id_uo"]);
			$id_uo_padre = $mres -> ofuscar($f["id_uo_padre"]);
		} else {
			$id_uo = $f["id_uo"];
			$id_uo_padre = $f["id_uo_padre"];
		}

		//$json='id:'.$f["id_unidad_organizacional"];
		if ($f["resaltar"] == 'si') {

			$text = $f["nombre_unidad"] . '  <FONT SIZE="+1"><b>*</b></FONT>';
			$expanded = 'true';
		} else {

			$text = $f["nombre_unidad"];
			$expanded = 'true';
		}

		$json = 'text:\'' . $text . '\',
			 id:\'' . $id_uo . '\',
			 id_p:\'' . $id_uo_padre . '\',
			 cls:\'folder\',
			 id_uo:\'' . $id_uo . '\',
             leaf:false,
			 allowDelete:true,
			 allowEdit:true,
			 allowDrag:true,
			 allowDrop:true,
			 expanded:' . $expanded . ',
			 nombre_unidad:\'' . $f["nombre_unidad"] . '\',
			 nombre_cargo:\'' . $f["nombre_cargo"] . '\',
			 cargo_individual:\'' . $f["cargo_individual"] . '\',
			 descripcion:\'' . $f["descripcion"] . '\',
			 codigo:\'' . $f["codigo"] . '\',
			 nodo_base:\'' . $f["nodo_base"] . '\',
			 gerencia:\'' . $f["gerencia"] . '\',               
			 id_estructura_uo:' . $f["id_estructura_uo"] . ',
			 correspondencia:\'' . $f["correspondencia"] . '\',
			 presupuesta:\'' . $f["presupuesta"] . '\',
			 estado_reg:\'' . $f["estado_reg"] . '\',';

		$json = $json . 'icon:\'../../../lib/imagenes/a_form.png\',';
		$json = $json . 'qtip:\'Funcionario: ' . $f['funcionarios'] . ' <br \/>Cargo: ' . $f["nombre_cargo"] . '\',
			              qtipTitle:\'' . $f["nombre_unidad"] . '\' ';

		$json = str_replace(chr(13), '', $json);
		$json = str_replace(chr(9), '', $json);
		$json = str_replace(chr(10), '', $json);

		return $json;
	}

	function listarEstructuraUoCheck() {
		//obtiene el parametro nodo enviado por la vista
		$node = $this -> objParam -> getParametro('node');
		$id_uo = $this -> objParam -> getParametro('id_uo');

		if ($node == 'id') {
			$this -> objParam -> addParametro('id_padre', '%');
		} else {
			$this -> objParam -> addParametro('id_padre', $id_uo);
		}

		if ($this -> objParam -> getParametro('filtro') == 'activo' && $node == 'id') {
			$count = 0;
			$pri = 1;
			$json = '';
			$count_temporal = 0;

			if ($node == 'id') {
				$this -> objParam -> addParametro('id_padre', '%');
			} else {
				$this -> objParam -> addParametro('id_padre', $id_uo);
			}
			
			$this->objFunSeguridad=$this->create('MODUo');
			$this -> res = $this -> objFunSeguridad -> listarUoFiltro($this -> objParam);

			if ($this -> res) {
				foreach ($this->res->datos as $f) {
					//var_dump($f);
					if ($pri == 1) {
						//guardo el nivel
						$niveles[$count] = $f["niveles"];
						//suponemos que el nivel inicial no tiene hijos
						$hijos[$count] = 0;
						$pri = 0;
						//prepara nodo
						$json = '[{';
						$json = $json . $this -> asignar($json, $f);
					} else {
						//este nodo es hijo del anterior nodo??
						//$posicion = strpos($f["niveles"],$niveles[$count].'_');
						$posicion = strpos($f["niveles"], $niveles[$count]);
						//var_dump($posicion);
						//var_dump($f["niveles"]);
						if ($posicion !== false) {

							//echo "ENTRA";
							//var_dump($posicion);

							//pregunta mos si este el primer hijo del nivel padre
							if ($hijos[$count] == 0) {

								//si es el primero iniciamos las llaves
								$json = $json . ',children:[{';
							} else {
								//si no es el primero cerramos el hijo anterior y preparamos sllavez para el siguiente
								$json = $json . '},{';
							}
							//llenamos el nodo
							$json = $json . $this -> asignar($json, $f);

							//si el primer hijo incrementamos el nivel
							if ($hijos[$count] == 0) {

								//se incrementa el nivel
								$count++;
								//suponemos que este nuevo nivel no tiene hijos
								$hijos[$count] = 0;
							}
							//se incrementa un hijo en el anterior nivel
							$hijos[$count - 1]++;
							//almacena el identificador del actual nivel
							$niveles[$count] = $f["niveles"];
						} else {
							//si el nodo no es hijo del anterio nivel
							//buscamos mas arriba hasta encontrar un padre o la raiz
							//en el camino vamos cerrando llavez
							$sw_tmp = 0;
							// sw temporal
							$count_temporal = 0;
							while ($sw_tmp == 0) {

								$hijos[$count] = 0;
								$count--;

								$count_temporal++;
								if ($count_temporal == 1) {

									//$json =$json.' * ('.$count.')';

								} else {
									$json = $json . '}]';
								}

								//$posicion = strpos($f["niveles"],$niveles[$count].'_');
								$posicion = strpos($f["niveles"], $niveles[$count]);
								if ($posicion !== false) {

									$sw_tmp = 1;
								} else {

									//si revisamos el ultimo nivel
									if ($count <= -1) {
										$sw_tmp = 1;
									}
								}
							}
							$json = $json . '},{';
							$json = $json . $this -> asignar($json, $f);

							//se incrementa un hijo en el anterior nivel
							$hijos[$count]++;
							//almacena el identificador del actual nivel
							$count++;
							$niveles[$count] = $f["niveles"];

						}
					}
				}

				while ($count > 0) {

					$count--;
					$json = $json . '}]';

				}
				if ($pri == 0) {
					$json = $json . '}]';
				} else {
					$json = $json . '[]';

				}
				header("Content-Type:text/json; charset=" . $_SESSION["CODIFICACION_HEADER"]);
				//echo utf8_encode
				echo($json);
				exit ;

			}

			/////////////////////////
		} else {
			$this->objFunSeguridad=$this->create('MODEstructuraUo');
			$this -> res = $this -> objFunSeguridad -> listarEstructuraUo($this -> objParam);

			$this -> res -> setTipoRespuestaArbol();

			$arreglo = array();
			$arreglo_valores=array();
			
			//para cambiar un valor por otro en una variable
			array_push($arreglo_valores,array('variable'=>'checked','val_ant'=>'true','val_nue'=>true));
			array_push($arreglo_valores,array('variable'=>'checked','val_ant'=>'false','val_nue'=>false));
			$this->res->setValores($arreglo_valores);
			
			//array_push($arreglo,array('nombre'=>'id','valor'=>'id_gui'));
			array_push($arreglo, array('nombre' => 'id', 'valor' => 'id_uo'));
			array_push($arreglo, array('nombre' => 'codigo', 'valor' => 'codigo'));
			array_push($arreglo, array('nombre' => 'text', 'valor' => 'nombre_unidad'));
			array_push($arreglo, array('nombre' => 'desc', 'valor' => 'descripcion'));
			array_push($arreglo, array('nombre' => 'cargo', 'valor' => 'nombre_cargo'));

			array_push($arreglo, array('nombre' => 'presupuesta', 'valor' => 'presupuesta'));
			array_push($arreglo, array('nombre' => 'nodo_base', 'valor' => 'nodo_base'));
			array_push($arreglo, array('nombre' => 'estado_reg', 'valor' => 'estado_reg'));
			array_push($arreglo, array('nombre' => 'id_p', 'valor' => 'id_uo_padre'));

			/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
			 es importante que entre los resultados devueltos por la base exista la variable\
			 tipo_dato que tenga el valor en texto = 'carpeta' */

			$this -> res -> addNivelArbol('nodo_base', 'si', array('leaf' => false, 'allowDelete' => true, 'allowEdit' => true, 'cls' => 'folder', 'tipo' => 'si'), $arreglo,$arreglo_valores);

			array_push($arreglo, array('nombre' => 'cls', 'valor' => 'descripcion'));

			/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
			 es importante que entre los resultados devueltos por la base exista la variable\
			 tipo_dato que tenga el valor en texto = 'hoja' */

			$this -> res -> addNivelArbol('nodo_base', 'no', array('leaf' => false, 'allowDelete' => true, 'allowEdit' => true, 'tipo' => 'no', 'icon' => '../../../lib/imagenes/a_form.png'), $arreglo,$arreglo_valores);

			array_push($arreglo, array('nombre' => 'id_estructura_uo', 'valor' => 'id_estructura_uo'));

			//Se imprime el arbol en formato JSON
            
			$this -> res -> imprimirRespuesta($this -> res -> generarJson());

		}

	}

}
?>