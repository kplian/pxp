<?php
class ACTGenerador extends ACTbase{ 

	private $objCol;
	//variable que guarda los datos de las columnas de forma serializada
	private $gCol=array(); //arrays sin la llave primaria
	private $gLlave=array(); //array con la(s) colummna(s) llave primaria 
	private $gCamposBasicosInsert=array();//array que contiene los campos basicos (id_usuario_reg, fecha_reg)
	private $gCamposBasicosUpdate=array();//array que contiene los campos basicos (id_usuario_mod, fecha_mod)
	//variable que guarda los datos de la tabla de forma serializada
	private $gTabla;
	private $objFunc;
	private $oCols;
	private $ruta;
	private $aut='';
	
	function __construct($pParam){
		include('GENTabla.php');
		include('GENColumna.php');
		//$this->objFunc=$this->create('MODGenerador');
		parent::__construct($pParam);
		
		/*ob_start();
		$fb=FirePHP::getInstance(true);
		$fb->log(dirname(__FILE__),"direccion");*/
	}

	function generarCodigo(){
		//Obtiene los datos de la tabla
		$this->objParam->addParametroConsulta('ordenacion','id_tabla');
		$this->objParam->addParametroConsulta('dir_ordenacion','asc');
		$this->objParam->addParametroConsulta('puntero','0');
		$this->objParam->addParametroConsulta('cantidad','30');
		$this->objParam->addFiltro("id_tabla=".$this->objParam->getParametro('id_tabla'));

		$this->objFunc=$this->create('MODTabla');
		$res=$this->objFunc->listarTabla($this->objParam);
		
		$arreglo=$res->getDatos();
		
		$this->gTabla=new GENTabla($arreglo[0]);
		
		/*echo '<pre>';
		print_r($arreglo);
		echo '</pre>';
		exit;*/
		
		$this->objParam->addParametroConsulta('ordenacion','orden');
		$this->objParam->addParametroConsulta('dir_ordenacion','asc');
		$this->objParam->addParametroConsulta('puntero','0');
		$this->objParam->addParametroConsulta('cantidad','100');
	
		//Obtiene los datos de la columna
		$this->objFunc=$this->create('MODColumna');
		$res=$this->objFunc->listarColumna($this->objParam);
		
		$arreglo=$res->getDatos();
		
		/*echo '<pre>';
		print_r($arreglo);
		echo '</pre>';
		exit;*/

		foreach ($arreglo as $data){
			//Verifica si es llave para hacer push en el array de llave
			if($data['checks']=='PK'){
				array_push($this->gLlave,new GENColumna($data));
			} else{
				//Verifica si existen los campos basicos
				if($data['nombre']=='id_usuario_reg'||$data['nombre']=='fecha_reg'||$data['nombre']=='id_usuario_ai'||$data['nombre']=='usuario_ai'){
					array_push($this->gCamposBasicosInsert,new GENColumna($data));
				} elseif ($data['nombre']=='id_usuario_mod'||$data['nombre']=='fecha_mod'){
					array_push($this->gCamposBasicosUpdate,new GENColumna($data));
				} else{
					array_push($this->gCol,new GENColumna($data));
				}	
			}
		}
		
		//Crea los directorios generales
		$this->crearDirectorios();
		
		//Genera los archivos si los datos de las columnas existen
		if(count($arreglo)>0){
			//Crea el archivo de BD IME
			
			$this->crearBDIme();

			//Crea el archivo de BD SEL
			$this->crearBDSel();
			
			//Crea el archivo del Modelo MOD
			$this->crearMOD();

			//Crea el archivo Modelo Funciones
			//$this->crearMODFun();

			//Crea el archivo Control ACT
			$this->crearACT();

			//Crea el archivo Vista
			$this->crearVISTA1();
			
			//Mueve los archivos si corresponde
			//$this->moverArchivosGenerados();
			
			//Respuesta
			echo "{success:true,resp:'Archivos generados'}";
			exit;
			
		} else{
			throw new Exception('No existen datos sobre la tabla definida',1);
		}
		
	}
	
	function crearBDIme(){
		//
		
		//Creacion de la funcion con parametros
		$this->strTexto = "CREATE OR REPLACE FUNCTION ".$this->gTabla->getNombreFuncionBDesquemaComillasIME()." (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
\$BODY$\n\n".
		
		//Agrega los comentarios
		$this->strTexto .= $this->Comentarios('BD',$this->gTabla->getNombreFuncionBDesquema().'_ime',$this->gTabla->getComentariosDefecto('bd_ime'))."
DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_".$this->gTabla->getId()."	integer;
			    
BEGIN

    v_nombre_funcion = '".$this->gTabla->getNombreFuncionBDesquema()."_ime';
    v_parametros = pxp.f_get_record(p_tabla);\n\n";
					
		//Agrega los comentarios por la transaccion
		$this->strTexto .= $this->Comentarios('BD',$this->gTabla->getNombreFuncionBDesquema().'_ime',$this->gTabla->getComentariosDefectoTrans('ins'),"'".$this->gTabla->getNombreTransaccion()."INS'")."
	if(p_transaccion='".$this->gTabla->getNombreTransaccion()."INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into ".$this->gTabla->getNombreTablaCompleto()."(";
		
							for($i=0;$i<count($this->gCol); $i++){
							//foreach($this->oCols as $col)
								//si no es el id y se tiene q guardar entra 
								//if($this->gCol[$i]->getColumna('nombre')!=$this->gTabla->getId() 
								if($this->gCol[$i]->getColumna('nombre')!=$this->gTabla->getId()
									&&	$this->gCol[$i]->getColumna('guardar')=='si'){
										$this->strTexto.= "\n\t\t\t".$this->gCol[$i]->getColumna('nombre').",";
									}
							}
							//Columnas basicas de insercion
							for($i=0;$i<count($this->gCamposBasicosInsert); $i++){
								
								$this->strTexto.= "\n\t\t\t".$this->gCamposBasicosInsert[$i]->getColumna('nombre').",";
							}
							//Columnas basicas de update (para asegurarse de que estara en nulo)
							for($i=0;$i<count($this->gCamposBasicosUpdate); $i++){
								
								$this->strTexto.= "\n\t\t\t".$this->gCamposBasicosUpdate[$i]->getColumna('nombre').",";
							}
							
							//Elimina la ultima coma
							$this->strTexto= substr($this->strTexto,0,strlen($this->strTexto)-1)."
          	) values(";
							
							//Valores de las Columnas
							for($i=0;$i<count($this->gCol); $i++){
								
							//foreach($this->oCols as $col){
								if($this->gCol[$i]->getColumna('nombre')!=$this->gTabla->getId() 
									&&	$this->gCol[$i]->getColumna('guardar')=='si'){
										if($this->gCol[$i]->getColumna('nombre')=='estado_reg'){
											$this->strTexto.= "\n\t\t\t'activo',";
										} else{
											$this->strTexto.= "\n\t\t\tv_parametros.".$this->gCol[$i]->getColumna('nombre').",";
										}
									}
							}
							
							//Valores de las columnas basicas insert
							for($i=0;$i<count($this->gCamposBasicosInsert); $i++){
								
								if($this->gCamposBasicosInsert[$i]->getColumna('nombre')=='id_usuario_reg'){
									$this->strTexto.= "\n\t\t\tp_id_usuario,";
								}
                                elseif($this->gCamposBasicosInsert[$i]->getColumna('nombre')=='id_usuario_ai'){
                                    $this->strTexto.= "\n\t\t\tv_parametros._id_usuario_ai,";
                                }
                                elseif($this->gCamposBasicosInsert[$i]->getColumna('nombre')=='usuario_ai'){
                                    $this->strTexto.= "\n\t\t\tv_parametros._nombre_usuario_ai,";
                                } 
								else{
									$this->strTexto.= "\n\t\t\tnow(),";	
								}
							}
							//Valores de las columnas basicas update
							for($i=0;$i<count($this->gCamposBasicosUpdate); $i++){
								
								$this->strTexto.= "\n\t\t\tnull,";	
							}
							
			                 if(!isset($this->gLlave[0])){
			                         
			                    throw new Exception('No existe la columna llave primaria, verifique la tabla y verifique la configuracion en el detalle del generador');
			                 }
			                   
			
							$this->strTexto= substr($this->strTexto,0,strlen($this->strTexto)-1)."
							
			
			
			)RETURNING ".$this->gLlave[0]->getColumna('nombre')." into v_".$this->gLlave[0]->getColumna('nombre').";
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','".$this->gTabla->getTitulo()." almacenado(a) con exito (".$this->gTabla->getId()."'||v_".$this->gTabla->getId()."||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'".$this->gLlave[0]->getColumna('nombre')."',v_".$this->gLlave[0]->getColumna('nombre')."::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;\n\n".
				
		//Agrega los comentarios por la transaccion
		$this->Comentarios('BD',$this->gTabla->getNombreFuncionBDesquema().'_ime',$this->gTabla->getComentariosDefectoTrans('mod'),"'".$this->gTabla->getNombreTransaccion()."MOD'")."
	elsif(p_transaccion='".$this->gTabla->getNombreTransaccion()."MOD')then

		begin
			--Sentencia de la modificacion
			update ".$this->gTabla->getNombreTablaCompleto()." set";
          					
          					for($i=0;$i<count($this->gCol); $i++){
          						if($this->gCol[$i]->getColumna('nombre')!=$this->gTabla->getId() 
									&&	$this->gCol[$i]->getColumna('guardar')=='si'){
									    
										if($this->gCol[$i]->getColumna('nombre')!='estado_reg'){
											$this->strTexto.= "\n\t\t\t".$this->gCol[$i]->getColumna('nombre')." = v_parametros.".$this->gCol[$i]->getColumna('nombre').",";		
										}
										
									
								}
							}
							//Columnas basicas de update
							for($i=0;$i<count($this->gCamposBasicosUpdate); $i++){
								if($this->gCamposBasicosUpdate[$i]->getColumna('nombre')=='id_usuario_mod'){
									$this->strTexto.= "\n\t\t\tid_usuario_mod = p_id_usuario,";
								} 
								else{
									$this->strTexto.= "\n\t\t\t".$this->gCamposBasicosUpdate[$i]->getColumna('nombre')." = now(),";	
								}
							}
							
							
							//RAC agrega datos de usuario ai
							$this->strTexto.= "\n\t\t\tid_usuario_ai = v_parametros._id_usuario_ai,";
                            $this->strTexto.= "\n\t\t\tusuario_ai = v_parametros._nombre_usuario_ai,";
                            
							
							
							$this->strTexto= substr($this->strTexto,0,strlen($this->strTexto)-1)."
			where ".$this->gLlave[0]->getColumna('nombre')."=v_parametros.".$this->gLlave[0]->getColumna('nombre').";
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','".$this->gTabla->getTitulo()." modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'".$this->gTabla->getId()."',v_parametros.".$this->gTabla->getId()."::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;\n\n".
							
		//Agrega los comentarios por la transaccion
		$this->Comentarios('BD',$this->gTabla->getNombreFuncionBDesquema().'_ime',$this->gTabla->getComentariosDefectoTrans('del'),"'".$this->gTabla->getNombreTransaccion()."ELI'")."
	elsif(p_transaccion='".$this->gTabla->getNombreTransaccion()."ELI')then

		begin
			--Sentencia de la eliminacion
			delete from ".$this->gTabla->getNombreTablaCompleto()."
            where ".$this->gTabla->getId()."=v_parametros.".$this->gLlave[0]->getColumna('nombre').";
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','".$this->gTabla->getTitulo()." eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'".$this->gTabla->getId()."',v_parametros.".$this->gTabla->getId()."::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
\$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION ".$this->gTabla->getNombreFuncionBDesquemaComillasIME()."(integer, integer, character varying, character varying) OWNER TO postgres;
";

		//Almacenamiento de los datos en el archivo
		$this->guardarArchivo($this->ruta.'/base/funciones/'.$this->gTabla->getNombreArchivo('bd_ime'),$this->strTexto);

		
	}
	
	function crearBDSel(){
		//Creacion de la funcion con parametros
		$this->strTexto = "CREATE OR REPLACE FUNCTION ".$this->gTabla->getNombreFuncionBDesquemaComillasSEL()."(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
\$BODY$\n";
		
		//Agrega los comentarios
		$this->strTexto .= $this->Comentarios('BD',$this->gTabla->getNombreFuncionBDesquema().'_sel',$this->gTabla->getComentariosDefecto('bd_sel'))."
DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = '".$this->gTabla->getNombreFuncionBDesquema()."_sel';
    v_parametros = pxp.f_get_record(p_tabla);\n\n".
		
		//Agrega los comentarios por la transaccion
		$this->Comentarios('BD',$this->gTabla->getNombreFuncionBDesquema().'_sel',$this->gTabla->getComentariosDefectoTrans('sel'),"'".$this->gTabla->getNombreTransaccion()."SEL'")."
	if(p_transaccion='".$this->gTabla->getNombreTransaccion()."SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select";
		
							for($i=0;$i<count($this->gLlave); $i++){
								$this->strTexto.= "\n\t\t\t\t\t\t".$this->gTabla->getAliasLower().'.'.$this->gLlave[$i]->getColumna('nombre').",";
							}
							//Columnas
							for($i=0;$i<count($this->gCol); $i++){
								$this->strTexto.= "\n\t\t\t\t\t\t".$this->gTabla->getAliasLower().'.'.$this->gCol[$i]->getColumna('nombre').",";
							}
							//Columnas basicas de insercion
							for($i=0;$i<count($this->gCamposBasicosInsert); $i++){
								$this->strTexto.= "\n\t\t\t\t\t\t".$this->gTabla->getAliasLower().'.'.$this->gCamposBasicosInsert[$i]->getColumna('nombre').",";
							}
							//Columnas basicas de update
							for($i=0;$i<count($this->gCamposBasicosUpdate); $i++){
								$this->strTexto.= "\n\t\t\t\t\t\t".$this->gTabla->getAliasLower().'.'.$this->gCamposBasicosUpdate[$i]->getColumna('nombre').",";
							}
							$this->strTexto= substr($this->strTexto,0,strlen($this->strTexto)-1).",
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from ".$this->gTabla->getNombreTablaCompleto()." ".$this->gTabla->getAliasLower()."
						inner join segu.tusuario usu1 on usu1.id_usuario = ".$this->gTabla->getAliasLower().".id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ".$this->gTabla->getAliasLower().".id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;\n\n".
		//Agrega los comentarios por la transaccion
		$this->Comentarios('BD',$this->gTabla->getNombreFuncionBDesquema().'_sel',$this->gTabla->getComentariosDefectoTrans('cont'),"'".$this->gTabla->getNombreTransaccion()."CONT'")."
	elsif(p_transaccion='".$this->gTabla->getNombreTransaccion()."CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(".$this->gLlave[0]->getColumna('nombre').")
					    from ".$this->gTabla->getNombreTablaCompleto().' ' .$this->gTabla->getAliasLower()."
					    inner join segu.tusuario usu1 on usu1.id_usuario = ".$this->gTabla->getAliasLower().".id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ".$this->gTabla->getAliasLower().".id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
	end if;
					
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
\$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION ".$this->gTabla->getNombreFuncionBDesquemaComillasSEL()."(integer, integer, character varying, character varying) OWNER TO postgres;
";
				            
				            
		//Almacenamiento de los datos en el archivo
		$this->guardarArchivo($this->ruta.'/base/funciones/'.$this->gTabla->getNombreArchivo('bd_sel'),$this->strTexto);

		
	}
	
	function crearMOD(){
		//Creacion de la funcion con parametros
		$this->strTexto = "<?php\n";
		//Agrega los comentarios
		$this->strTexto .= $this->Comentarios('php',$this->gTabla->getNombreArchivo('modelo'),$this->gTabla->getComentariosDefecto('modelo'))."
class ".$this->gTabla->getNombreFuncion('modelo')." extends MODbase{
	
	function __construct(CTParametro \$pParam){
		parent::__construct(\$pParam);
	}
			
	function listar".$this->gTabla->getSujetoTablaJava()."(){
		//Definicion de variables para ejecucion del procedimientp
		\$this->procedimiento='".$this->gTabla->getNombreFuncion('bd_sel')."';
		\$this->transaccion='".$this->gTabla->getNombreTransaccion()."SEL';
		\$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query\n";
				for($i=0;$i<count($this->gLlave); $i++){
					$this->strTexto.="\t\t\$this->captura('".$this->gLlave[$i]->getColumna('nombre')."','".$this->gLlave[$i]->getColumna('tipo_dato')."');\n";
				}
				//Columnas
				for($i=0;$i<count($this->gCol); $i++){
					$this->strTexto.="\t\t\$this->captura('".$this->gCol[$i]->getColumna('nombre')."','".$this->gCol[$i]->getColumna('tipo_dato')."');\n";
				}
				//Columnas basicas insercion
				for($i=0;$i<count($this->gCamposBasicosInsert); $i++){
					$this->strTexto.="\t\t\$this->captura('".$this->gCamposBasicosInsert[$i]->getColumna('nombre')."','".$this->gCamposBasicosInsert[$i]->getColumna('tipo_dato')."');\n";
				}
				//Columnas basicas insercion
				for($i=0;$i<count($this->gCamposBasicosUpdate); $i++){
					$this->strTexto.="\t\t\$this->captura('".$this->gCamposBasicosUpdate[$i]->getColumna('nombre')."','".$this->gCamposBasicosUpdate[$i]->getColumna('tipo_dato')."');\n";
				}
			
				$this->strTexto.="\t\t\$this->captura('usr_reg','varchar');
		\$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		\$this->armarConsulta();
		\$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return \$this->respuesta;
	}
			
	function insertar".$this->gTabla->getSujetoTablaJava()."(){
		//Definicion de variables para ejecucion del procedimiento
		\$this->procedimiento='".$this->gTabla->getNombreFuncion('bd_ime')."';
		\$this->transaccion='".$this->gTabla->getNombreTransaccion()."INS';
		\$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion\n";
				
				for($i=0;$i<count($this->gCol); $i++){
					$this->strTexto.="\t\t\$this->setParametro('".$this->gCol[$i]->getColumna('nombre')."','".$this->gCol[$i]->getColumna('nombre')."','".$this->gCol[$i]->getColumna('tipo_dato')."');\n";
				}
			
				$this->strTexto.="
		//Ejecuta la instruccion
		\$this->armarConsulta();
		\$this->ejecutarConsulta();

		//Devuelve la respuesta
		return \$this->respuesta;
	}
			
	function modificar".$this->gTabla->getSujetoTablaJava()."(){
		//Definicion de variables para ejecucion del procedimiento
		\$this->procedimiento='".$this->gTabla->getNombreFuncion('bd_ime')."';
		\$this->transaccion='".$this->gTabla->getNombreTransaccion()."MOD';
		\$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion\n";
				for($i=0;$i<count($this->gLlave); $i++){
					$this->strTexto.="\t\t\$this->setParametro('".$this->gLlave[$i]->getColumna('nombre')."','".$this->gLlave[$i]->getColumna('nombre')."','".$this->gLlave[$i]->getColumna('tipo_dato')."');\n";
				}
				
				for($i=0;$i<count($this->gCol); $i++){
					$this->strTexto.="\t\t\$this->setParametro('".$this->gCol[$i]->getColumna('nombre')."','".$this->gCol[$i]->getColumna('nombre')."','".$this->gCol[$i]->getColumna('tipo_dato')."');\n";
				}
			
				$this->strTexto.="
		//Ejecuta la instruccion
		\$this->armarConsulta();
		\$this->ejecutarConsulta();

		//Devuelve la respuesta
		return \$this->respuesta;
	}
			
	function eliminar".$this->gTabla->getSujetoTablaJava()."(){
		//Definicion de variables para ejecucion del procedimiento
		\$this->procedimiento='".$this->gTabla->getNombreFuncion('bd_ime')."';
		\$this->transaccion='".$this->gTabla->getNombreTransaccion()."ELI';
		\$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion\n";
				
				for($i=0;$i<count($this->gLlave); $i++){
					$this->strTexto.="\t\t\$this->setParametro('".$this->gLlave[$i]->getColumna('nombre')."','".$this->gLlave[$i]->getColumna('nombre')."','".$this->gLlave[$i]->getColumna('tipo_dato')."');\n";
				}
			
				$this->strTexto .= "
		//Ejecuta la instruccion
		\$this->armarConsulta();
		\$this->ejecutarConsulta();

		//Devuelve la respuesta
		return \$this->respuesta;
	}
			
}
?>";
				
		//Almacenamiento de los datos en el archivo
		$this->guardarArchivo($this->ruta.'/modelo/'.$this->gTabla->getNombreArchivo('modelo'),$this->strTexto);
		
	}
	
	function crearMODFun(){
		//Obtiene la ruta del sistema del que se genera el codigo
		$aux='../../sis_'.$this->gTabla->getCarpetaSistema().'/modelo/';

		//Creacion de la funcion con parametros
		$this->strTexto = "<?php\n";
		//Agrega los comentarios
		$this->strTexto .= $this->Comentarios('php',$this->gTabla->getNombreArchivo('custom'),$this->gTabla->getComentariosDefecto('custom'))."
class ".$this->gTabla->getNombreFuncion('custom')."{
		
	function __construct(){
		foreach (glob('".$aux."MOD*.php') as \$archivo){
			include_once(\$archivo);
		}
	}

	".$this->llamadasCustom()."
			
}//marca_generador
?>";
		
		//Almacenamiento de los datos en el archivo
		$this->guardarArchivo($this->ruta.'/modelo/'.$this->gTabla->getNombreArchivo('custom'),$this->strTexto);
	}
	
	function crearACT(){
		
		//Abre el archivo en modo rw

		//Creacion de la funcion con parametros
		$this->strTexto = "<?php\n";
		//Agrega los comentarios
		$this->strTexto .= $this->Comentarios('php',$this->gTabla->getNombreArchivo('control'),$this->gTabla->getComentariosDefecto('control'))."
class ".$this->gTabla->getNombreFuncion('control')." extends ACTbase{    
			
	function listar".$this->gTabla->getSujetoTablaJava()."(){\n";

		for($i=0;$i<count($this->gLlave); $i++){
			$this->strTexto.="\t\t\$this->objParam->defecto('ordenacion','".$this->gLlave[$i]->getColumna('nombre')."');\n";
		}
		$this->strTexto.= "
		\$this->objParam->defecto('dir_ordenacion','asc');\n";
		
		$this->strTexto.= "\t\tif(\$this->objParam->getParametro('tipoReporte')=='excel_grid' || \$this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			\$this->objReporte = new Reporte(\$this->objParam,\$this);
			\$this->res = \$this->objReporte->generarReporteListado('".$this->gTabla->getNombreFuncion('modelo')."','listar".$this->gTabla->getSujetoTablaJava()."');
		} else{
		\t\$this->objFunc=\$this->create('".$this->gTabla->getNombreFuncion('modelo')."');
			
		\t\$this->res=\$this->objFunc->listar".$this->gTabla->getSujetoTablaJava()."(\$this->objParam);
		}
		\$this->res->imprimirRespuesta(\$this->res->generarJson());
	}
				
	function insertar".$this->gTabla->getSujetoTablaJava()."(){
		\$this->objFunc=\$this->create('".$this->gTabla->getNombreFuncion('modelo')."');	
		if(\$this->objParam->insertar('".$this->gLlave[0]->getColumna('nombre')."')){
			\$this->res=\$this->objFunc->insertar".$this->gTabla->getSujetoTablaJava()."(\$this->objParam);			
		} else{			
			\$this->res=\$this->objFunc->modificar".$this->gTabla->getSujetoTablaJava()."(\$this->objParam);
		}
		\$this->res->imprimirRespuesta(\$this->res->generarJson());
	}
						
	function eliminar".$this->gTabla->getSujetoTablaJava()."(){
		\t\$this->objFunc=\$this->create('".$this->gTabla->getNombreFuncion('modelo')."');	
		\$this->res=\$this->objFunc->eliminar".$this->gTabla->getSujetoTablaJava()."(\$this->objParam);
		\$this->res->imprimirRespuesta(\$this->res->generarJson());
	}
			
}

?>";
		
		//Almacenamiento de los datos en el archivo
		$this->guardarArchivo($this->ruta.'/control/'.$this->gTabla->getNombreArchivo('control'),$this->strTexto);
		
	}
	
	function crearVISTA(){
		//Creacion de la funcion con parametros
		$this->strTexto = "<?php\n";
		//Agrega los comentarios
		$this->strTexto .= $this->Comentarios('js',$this->gTabla->getNombreArchivo('vista'),$this->gTabla->getComentariosDefecto('vista'))."
		header(\"content-type: text/javascript; charset=UTF-8\");
			?>
			<script>
			Phx.vista.".$this->gTabla->getNombreFuncion('vista')."=function(config){
			
			var FormatoVista=function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			
				this.Atributos=[
				{
					//configuracion del componente
					config:{
						labelSeparator:'',
						inputType:'hidden',
						name: '".$this->gLlave[0]->getColumna('nombre')."'
			
					},
					type:'Field',
					form:true 
					
				},";
		
		//Columnas
		for($i=0;$i<count($this->gCol); $i++){
			$this->strTexto.="
				{
					config:{
						fieldLabel: '".$this->gCol[$i]->getColumna('nombre')."',
						gwidth: 100,
						name: '".$this->gCol[$i]->getColumna('nombre')."',
						allowBlank:false,	
						minLength:1,/*aumentar el minimo*/
						anchor:'80%'
						
					},
					type:'TextField',
					filters:{type:'string'},
					id_grupo:0,
					grid:true,
					form:true
				},
			
			";
		}
		
		//Columnas basicas insert
		for($i=0;$i<count($this->gCamposBasicosInsert); $i++){
			$this->strTexto.="
				{
					config:{
						fieldLabel: '".$this->gCamposBasicosInsert[$i]->getColumna('nombre')."',
						gwidth: 100,
						name: '".$this->gCamposBasicosInsert[$i]->getColumna('nombre')."',
						allowBlank:false,	
						minLength:1,/*aumentar el minimo*/
						anchor:'80%'
						
					},
					type:'TextField',
					filters:{type:'string'},
					id_grupo:0,
					grid:true,
					form:false
				},
			
			";
		}
		//Columnas basicas update
		for($i=0;$i<count($this->gCamposBasicosUpdate); $i++){
			$this->strTexto.="
				{
					config:{
						fieldLabel: '".$this->gCamposBasicosUpdate[$i]->getColumna('nombre')."',
						gwidth: 100,
						name: '".$this->gCamposBasicosUpdate[$i]->getColumna('nombre')."',
						allowBlank:false,	
						minLength:1,/*aumentar el minimo*/
						anchor:'80%'
						
					},
					type:'TextField',
					filters:{type:'string'},
					id_grupo:0,
					grid:true,
					form:false
				},
			
			";
		}
		
		$this->strTexto.="
		
				];
			
				Phx.vista.".$this->gTabla->getNombreTablaVista().".superclass.constructor.call(this,config);
				this.init();
				
				this.load({params:{start:0, limit:50}})
			
			}
			
			Ext.extend(Phx.vista.".$this->gTabla->getNombreTabla().",Phx.gridInterfaz,{
				title:'".$this->gTabla->getTitulo()."',
				ActSave:'../../".$this->gTabla->getCarpetaSistema()."/control/".$this->gTabla->getNombreTablaJava()."/insertar".$this->gTabla->getNombreTablaJava()."',
				ActDel:'../../".$this->gTabla->getCarpetaSistema()."/control/".$this->gTabla->getNombreTablaJava()."/eliminar".$this->gTabla->getNombreTablaJava()."',
				ActList:'../../".$this->gTabla->getCarpetaSistema()."/control/".$this->gTabla->getNombreTablaJava()."/listar".$this->gTabla->getNombreTablaJava()."',
				id_store:'".$this->gLlave[0]->getColumna('nombre')."',
				fields: [";
		
				//Llaves
				for($i=0;$i<count($this->gLlave); $i++){
					$this->strTexto.="{name:'".$this->gLlave[$i]->getColumna('nombre')."', type: '".$this->tipoDato($this->gLlave[$i]->getColumna('tipo_dato'))."'},\n";
				}
				//Columnas
				for($i=0;$i<count($this->gCol); $i++){
					$this->strTexto.="{name:'".$this->gCol[$i]->getColumna('nombre')."', type: '".$this->tipoDato($this->gCol[$i]->getColumna('tipo_dato'))."'},\n";
				}
				//Columnas basicas insert
				for($i=0;$i<count($this->gCamposBasicosInsert); $i++){
					$this->strTexto.="{name:'".$this->gCamposBasicosInsert[$i]->getColumna('nombre')."', type: '".$this->tipoDato($this->gCamposBasicosInsert[$i]->getColumna('tipo_dato'))."'},\n";
				}
				//Columnas basicas update
				for($i=0;$i<count($this->gCamposBasicosUpdate); $i++){
					$this->strTexto.="{name:'".$this->gCamposBasicosUpdate[$i]->getColumna('nombre')."', type: '".$this->tipoDato($this->gCamposBasicosUpdate[$i]->getColumna('tipo_dato'))."'},\n";
				}
				$this->strTexto= substr($this->strTexto,0,strlen($this->strTexto)-1)."
					],
				sortInfo:{
					field: '".$this->gLlave[0]->getColumna('nombre')."',
					direction: 'ASC'
				},
				bdel:true,//boton para eliminar
				bsave:false,//boton para eliminar
			
			}
			</script>
		
		";
		
		//Almacenamiento de los datos en el archivo
		$this->guardarArchivo($this->ruta.'/vista/'.$this->gTabla->getNombreArchivo('vista'),$this->strTexto);
		
	}
	
	function crearVISTA1(){
		//Vista extendiendo de inicio al grid interfaz
		$this->strTexto = "<?php\n";
		//Agrega los comentarios
		$this->strTexto .= $this->Comentarios('js',$this->gTabla->getNombreArchivo('vista'),$this->gTabla->getComentariosDefecto('vista'))."
header(\"content-type: text/javascript; charset=UTF-8\");
?>
<script>
Phx.vista.".$this->gTabla->getNombreFuncion('vista')."=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.".$this->gTabla->getNombreFuncion('vista').".superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: '".$this->gLlave[0]->getColumna('nombre')."'
			},
			type:'Field',
			form:true 
		},";
		//Columnas
		$this->strTexto.= $this->definicionColumnas($this->gCol);
		$this->strTexto.= $this->definicionColumnas($this->gCamposBasicosInsert);
		$this->strTexto.= $this->definicionColumnas($this->gCamposBasicosUpdate);
		$this->strTexto= substr($this->strTexto,0,strlen($this->strTexto)-1);
		
		$this->strTexto.="
	],
	tam_pag:50,	
	title:'".$this->gTabla->getTitulo()."',
	ActSave:'../../sis_".$this->gTabla->getCarpetaSistema()."/control/".$this->gTabla->getSujetoTablaJava()."/insertar".$this->gTabla->getSujetoTablaJava()."',
	ActDel:'../../sis_".$this->gTabla->getCarpetaSistema()."/control/".$this->gTabla->getSujetoTablaJava()."/eliminar".$this->gTabla->getSujetoTablaJava()."',
	ActList:'../../sis_".$this->gTabla->getCarpetaSistema()."/control/".$this->gTabla->getSujetoTablaJava()."/listar".$this->gTabla->getSujetoTablaJava()."',
	id_store:'".$this->gLlave[0]->getColumna('nombre')."',
	fields: [\n";
		
				//Llaves
				for($i=0;$i<count($this->gLlave); $i++){
					//$this->strTexto.="\t\t{name:'".$this->gLlave[$i]->getColumna('nombre')."', type: '".$this->tipoDato($this->gLlave[$i]->getColumna('tipo_dato'))."'},\n";
					$this->strTexto.=$this->mapeoColumnas($this->gLlave[$i]);
				}
				//Columnas
				for($i=0;$i<count($this->gCol); $i++){
					//$this->strTexto.="\t\t{name:'".$this->gCol[$i]->getColumna('nombre')."', type: '".$this->tipoDato($this->gCol[$i]->getColumna('tipo_dato'))."'},\n";
					$this->strTexto.=$this->mapeoColumnas($this->gCol[$i]);
				}
				//Columnas basicas insert
				for($i=0;$i<count($this->gCamposBasicosInsert); $i++){
					//$this->strTexto.="\t\t{name:'".$this->gCamposBasicosInsert[$i]->getColumna('nombre')."', type: '".$this->tipoDato($this->gCamposBasicosInsert[$i]->getColumna('tipo_dato'))."'},\n";
					$this->strTexto.=$this->mapeoColumnas($this->gCamposBasicosInsert[$i]);
				}
				//Columnas basicas update
				for($i=0;$i<count($this->gCamposBasicosUpdate); $i++){
					//$this->strTexto.="\t\t{name:'".$this->gCamposBasicosUpdate[$i]->getColumna('nombre')."', type: '".$this->tipoDato($this->gCamposBasicosUpdate[$i]->getColumna('tipo_dato'))."'},\n";
					$this->strTexto.=$this->mapeoColumnas($this->gCamposBasicosUpdate[$i]);
				}
				
				//Aumenta los usuarios de registro y de modificacion
				$this->strTexto.="\t\t{name:'usr_reg', type: 'string'},\n";
				$this->strTexto.="\t\t{name:'usr_mod', type: 'string'},\n";
				
				$this->strTexto= substr($this->strTexto,0,strlen($this->strTexto)-1)."
		
	],
	sortInfo:{
		field: '".$this->gLlave[0]->getColumna('nombre')."',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true";
				//////
				
				//Creacion de los grupos
				if($this->gTabla->getCantGrupos()>1){
					$this->strTexto.=",
	Grupos:[{ 
		layout: 'column',
		items:[";
					for($i=0;$i<$this->gTabla->getCantGrupos();$i++){
						$this->strTexto.="
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Grupo ".$i."',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: '.5',
                items:[],
		        id_grupo:".$i.",
			},";
					}
					
					$this->strTexto= substr($this->strTexto,0,strlen($this->strTexto)-1);
					
					$this->strTexto.="
			]
		}]";
					
				}
				
			$this->strTexto.="
	}
)
</script>
		
		";
		
		//Almacenamiento de los datos en el archivo
		$this->guardarArchivo($this->ruta.'/vista/'.$this->gTabla->getSujetoTabla().'/'.$this->gTabla->getNombreArchivo('vista'),$this->strTexto);
		
	}
	
	function tipoDato($p_tipoDato,$p_resp='tipo_dato'){
		//Valores por defecto
		$tipoDato='string';
		$tipoComp='TextField';
		
		//Evaluacion del tipo de dato
		if($p_tipoDato=='varchar'){
			$tipoDato='string';
		} elseif ($p_tipoDato=='integer'||$p_tipoDato=='int4'||$p_tipoDato=='numeric') {
			$tipoDato='numeric';
			$tipoComp='NumberField';
		} elseif($p_tipoDato=='timestamp'){
			$tipoDato='timestamp';
			$tipoComp='DateField';
		} 
		elseif($p_tipoDato=='date'){
			$tipoDato='date';
			$tipoComp='DateField';
		}elseif($p_tipoDato=='bool'){
			$tipoDato='boolean';
			$tipoComp='Checkbox';
		}

		//Respuesta
		if($p_resp=='tipo_dato'){
			return $tipoDato;			
		} else{
			return $tipoComp;
		}
	}
	
	function crearDirectorios(){
	//echo $this->gTabla->getSujetoTabla();exit;
	
		/*ob_start();
		$fb=FirePHP::getInstance(true);
		$fb->log($this->gTabla->getSujetoTabla(),"direccion");*/
		
		//$this->ruta=dirname(__FILE__)."/../archivos/sis_".$this->objParam->getParametro('nombre_carpeta');
		$this->ruta=dirname(__FILE__).'/../../../sis_'.$this->gTabla->getCarpetaSistema();
		
		

		if(!file_exists($this->ruta)){
			mkdir($this->ruta);
		}
		if(!file_exists("$this->ruta/base")){
			mkdir("$this->ruta/base");
		}
		if(!file_exists("$this->ruta/base/funciones")){
			mkdir("$this->ruta/base/funciones");
		}
		if(!file_exists("$this->ruta/modelo")){
			mkdir("$this->ruta/modelo");
		}
		if(!file_exists("$this->ruta/control")){
			mkdir("$this->ruta/control");
		}
		if(!file_exists("$this->ruta/vista")){
			mkdir("$this->ruta/vista");
		}
		//echo 'ruta2:'."$this->ruta/vista/".$this->gTabla->getSujetoTabla(); exit;
		if(!file_exists("$this->ruta/vista/".$this->gTabla->getSujetoTabla())){
			mkdir("$this->ruta/vista/".$this->gTabla->getSujetoTabla());
		}
	}
	
	private function guardarArchivo($pNombreArchivo, $pTexto){
		$arch=fopen($pNombreArchivo,"w+");
		fwrite($arch,$pTexto);
		fclose($arch);
	}
	
	private function moverArchivosGenerados(){
	//echo 'fuck:'.$this->gTabla->getReemplazar();exit;
		//if($this->gTabla->getReemplazar()=='si'){
			$this->ruta=dirname(__FILE__).'/../../sis_'.$this->gTabla->getCarpetaSistema();
			//modelo: $this->ruta.'/modelo/MOD'.$this->gTabla->getNombreTablaJava().".php"
			
			//Verifica si la carpeta del sistema existe, caso contrario lo crea
			if(!file_exists($aux)){
				mkdir($aux);
			}
			//Verifica si existe la carpeta de control, caso contrario lo crea
			if(!file_exists("$aux/control")){
				mkdir("$aux/control");
			}
			//Verifica si existe la carpeta de modelo, caso contrario lo crea
			if(!file_exists("$aux/modelo")){
				mkdir("$aux/modelo");
			}
			//Verifica si existe la carpeta de vista, caso contrario lo crea
			if(!file_exists("$aux/vista")){
				mkdir("$aux/vista");
			}
			if(!file_exists("$aux/vista/".$this->gTabla->getSujetoTabla())){
				mkdir("$aux/vista/".$this->gTabla->getSujetoTabla());
			}
			
			//Copia el modelo
			copy($this->ruta.'/modelo/'.$this->gTabla->getNombreArchivo('modelo'),$aux.'/modelo/'.$this->gTabla->getNombreArchivo('modelo'));
			
			//Verifica la existencia del custom
			if(file_exists($aux.'/modelo/'.$this->gTabla->getNombreArchivo('custom_anx'))){
				//Existe, anexa al final del documento las funciones de la entidad creada
				//$this->anexarCustom($aux.'/modelo/'.$this->gTabla->getNombreArchivo('custom_anx'));//,$aux.'/modelo/'.$this->gTabla->getNombreArchivo('custom'));
				$this->anexarCustom($aux.'/modelo/'.$this->gTabla->getNombreArchivo('custom_anx'),$aux.'/modelo/'.$this->gTabla->getNombreArchivo('custom'));
				//copy($this->ruta.'/modelo/'.$this->gTabla->getNombreArchivo('custom'),$aux.'/modelo/'.$this->gTabla->getNombreArchivo('custom'));
			} else{
				//No existe, copia el archivo
				copy($this->ruta.'/modelo/'.$this->gTabla->getNombreArchivo('custom'),$aux.'/modelo/'.$this->gTabla->getNombreArchivo('custom'));
			}
			
			//control: $this->ruta.'/control/ACT'.$this->gTabla->getNombreTablaJava().".php"
			copy($this->ruta.'/control/'.$this->gTabla->getNombreArchivo('control'),$aux.'/control/'.$this->gTabla->getNombreArchivo('control'));
			//vista: $this->ruta.'/vista/'.$this->gTabla->getNombreTablaVista().".js"
			copy($this->ruta.'/vista/'.$this->gTabla->getSujetoTabla().'/'.$this->gTabla->getNombreArchivo('vista'),$aux.'/vista/'.$this->gTabla->getSujetoTabla().'/'.$this->gTabla->getNombreArchivo('vista'));
			
		//}
	}
	
	
	private function anexarCustom($pArchivoOrig,$pArchivoGen){
		ob_start();
		$fb=FirePHP::getInstance(true);
		$fb->log($pArchivoOrig.', '.$pArchivoGen,"direccion");
		//Definici�n de variables
		$sw_exist_clase=0;
		$sw_escribir=1;
		$sw_salir=0;
		//Inicializaci�n de variables
		$lineaIni='/*Clase: '.$this->gTabla->getNombreFuncion('modelo');
		$lineaFin='/*FinClase: '.$this->gTabla->getNombreFuncion('modelo').'*/';
		
		//echo $pArchivoGen.'vec';exit;
		
		//Abrir archivos
		$archOrig=fopen($pArchivoOrig,'r');
		$archTmp=fopen($pArchivoGen,'w+');
		
		//Recorrer 'Funciones' original
		while(!feof($archOrig)&&!$sw_salir){
			//Recupera la linea del puntero
			$linea=fgets($archOrig);
			//Verifica si es el comienzo de la clase de la generaci�n de c�digo de la tabla actual
			if(trim($linea)==$lineaIni){
				//Enciende la bandera para terminar el bucle por haber encontrado la clase
				$sw_exist_clase=1;
				//Copia todas las l�neas del archivo generado al archivo temporal
				fwrite($archTmp,"\t".$this->llamadasCustom());
				//Apaga la bandera para no copiar la llave en el archivo temporal
				$sw_escribir=0;
			} elseif(strpos($linea,'//marca_generador')){
				//Verifica si ya encontr� la clase en lo recorrido hasta ahora
				if($sw_exist_clase){
					//Enciende la bandera de escritura
					$sw_escribir=1;
				} else{
					//Apaga la bandera porque no se encontr� la clase en el archivo original
					$sw_exist_clase=0;
					//Enciende la bandera de salir para salir del bucle
					$sw_salir=1;
					//Apaga la bandera de escritura
					$sw_escribir=0;
				}
			}
			//Verifica la bandera de escritura para copiar la l�nea al archivo temporal
			if($sw_escribir){
				fwrite($archTmp,$linea);
			}
			//Verifica si encuentra la finalizaci�n de la l�nea y habilita la bandera de escritura para la siguiente vuelta
			if(!$sw_escribir&&trim($linea)==$lineaFin){
				//Enciende la bandera para copiar la linea al archivo temporal
				$sw_escribir=1;
			} 
		}
		//Verifica si se encontr� la clase en el archivo original
		if(!$sw_exist_clase){
			//Como no lo encontr�, escribe las llamadas del custom en el archivo temporal
			fwrite($archTmp,"\t".$this->llamadasCustom());
			//Escribe los caracteres para cerrar el php
			fwrite($archTmp,"\n\n}//marca_generador\n?>");
		}
		
		fclose($archOrig);
		fclose($archTmp);
		
	}
	
	//Funcion que hace un append al Custom que ya existia con las lineas de las funciones de la entidad creada
	private function anexarCustom1111($pArchivo){
		/*ob_start();
		$fb=FirePHP::getInstance(true);
		$fb->log($pArchivo,"direccion");*/
		//Variables para comparacion
		$lineaIni='/*Clase: '.$this->gTabla->getNombreFuncion('modelo');
		$lineaFin='/*FinClase: '.$this->gTabla->getNombreFuncion('modelo').'*/';
		$cont=0;
		$sw=0;
		$sw1=1; //bandera que define si esta en 1 quiere decir que no se encontro a la clase en el modelo
		$escribir=1;
		$pie=0;
		$contFin=0;
		$nombreArchivo=$pArchivo;
		
		//Se abre el archivo de Funciones original en modo lectura en el cual se anexaran lineas
		$arch=fopen($pArchivo,'r');
		
		//Se abre  y escritura y otro para guardar el nuevo archivo
		$archNuevo=fopen($nombreArchivo.'tmp',"w+");
		
		//Recorre el archivo 
		while(!feof($arch)&&!$sw){
			//Recupera la linea del puntero
			$linea=fgets($arch);
			//Compara si la linea corresponde al comparador de inicio
			if(trim($linea)==$lineaIni){
				//Apaga la bandera para que ya no se escriba en el archivo nuevo
				$escribir=0;
				$sw1=0;	
			} elseif(!$escribir&&trim($linea)==$lineaFin){
				//Enciende la bandera indicando que existen mas llamadas despues del ya encontrado, obtiene la fila numero y termina el while
				$pie=1;
				$contFin=$cont;
				$sw=1;
				$sw1=0;
			} elseif(strpos($linea,'//marca_generador')){
				$escribir=0;
			}
			
			//Escribe en el archivo si la bandera esta encendida
			if($escribir){
				//Escribe en el nuevo archivo
				fwrite($archNuevo,$linea);
			}
			//Incrementa el contador
			$cont++;
		}
		
		//Cierra los archivos
		//fclose($arch);
		fclose($archNuevo);
		
		//Verifica si encontro el comparador de inicio
		if($sw||$sw1){
			//Abre el archivo en modo escritura (append)
			$archNuevo=fopen($nombreArchivo,"a+");
			//Escribe las nuevas llamadas al custom
			fwrite($archNuevo,"\t".$this->llamadasCustom());
			//Cierra archivo
			fclose($archNuevo);
		}
		
		//Verifica el 'pie' para completar el nuevo archivo
		$archNuevo=fopen($nombreArchivo,"a+");
		if($pie){
			//Copia las llamadas siguientes al nuevo archivo
			while(!feof($arch)){
				$linea=fgets($arch);
				fwrite($archNuevo,$linea);
			}
			
		} else{
			//Escribe los caracteres para cerrar el php
			fwrite($archNuevo,"\n\n}//marca_generador\n?>");
		}
		
		//Cierra los archivos
		fclose($arch);
		fclose($archNuevo);
		
	}
	
	//Verifica si es necesario definir el tama�o m�ximo en funci�n del tipo de dato
	private function maximaLongitud($p_Col){
		//Verifica el tipo de dato
		$aux=$this->tipoDato($p_Col->getColumna('tipo_dato'),'tipo_comp');
		if($aux=='TextField'||$aux=='TextArea'||$aux=='NumberField'){
			return true;
		} else{
			return false;
		}
	}
	
	private function definicionColumnas($p_Columnas,$pColBasicas='columnas'){
		$cadena='';
		ob_start();
		$fb=FirePHP::getInstance(true);

		for($i=0;$i<count($p_Columnas); $i++){
			
			//Verifica si se trata de las columnas basicas de insert y de updte para por defecto no mostrar en el formulario
			if($p_Columnas[$i]->getColumna('nombre')=='id_usuario_reg'||
				$p_Columnas[$i]->getColumna('nombre')=='id_usuario_mod'||
				$p_Columnas[$i]->getColumna('nombre')=='id_usuario_ai'||
				$p_Columnas[$i]->getColumna('nombre')=='usuario_ai'||
				$p_Columnas[$i]->getColumna('nombre')=='fecha_reg'||
				$p_Columnas[$i]->getColumna('nombre')=='fecha_mod'||
				$p_Columnas[$i]->getColumna('nombre')=='estado_reg'
			){
    				$form='false';
    				$name=$p_Columnas[$i]->getColumna('nombre');
    				$tipodato=$this->tipoDato($p_Columnas[$i]->getColumna('tipo_dato'));
    				$alias=$this->gTabla->getAliasLower().".".$p_Columnas[$i]->getColumna('nombre');
    				$grid='true';
    				
    				if($p_Columnas[$i]->getColumna('nombre')=='id_usuario_ai'){
    				    $grid='false';
    				}
    				
    				//Define los label por defecto
    				if($p_Columnas[$i]->getColumna('nombre')=='id_usuario_reg'){
    					$label='Creado por';
    					$name='usr_reg';
    					$tipodato='string';
    					$alias='usu1.cuenta';
    				} elseif($p_Columnas[$i]->getColumna('nombre')=='id_usuario_mod'){
    					$label='Modificado por';
    					$name='usr_mod';
    					$tipodato='string';
    					$alias='usu2.cuenta';
    				} 
    				elseif($p_Columnas[$i]->getColumna('nombre')=='usuario_ai'){
                        $label='Funcionaro AI';
                        $name='usuario_ai';
                        $tipodato='string';
                        $alias=$this->gTabla->getAliasLower()."."."usuario_ai";
                    }
    				
    				elseif($p_Columnas[$i]->getColumna('nombre')=='fecha_reg'){
    					$label='Fecha creación';
    				} elseif($p_Columnas[$i]->getColumna('nombre')=='fecha_mod'){
    					$label='Fecha Modif.';
    				} elseif($p_Columnas[$i]->getColumna('nombre')=='estado_reg'){
    					$label='Estado Reg.';
    				}
			} else{
    				//Verifica si el campo debe ser  desplegado en el formulario
    				if($p_Columnas[$i]->getColumna('guardar')=='si'){
    					$form='true';
    				} else{
    					$form='false';
    				}
    				//Verificacion de despliegue en el grid
    				if($p_Columnas[$i]->getColumna('grid_mostrar')=='no'){
    					$grid='false';
    				} else{
    					$grid='true';
    				}
    				
    				$label=$p_Columnas[$i]->getColumna('etiqueta');
    				$name=$p_Columnas[$i]->getColumna('nombre');
    				$tipodato=$this->tipoDato($p_Columnas[$i]->getColumna('tipo_dato'));
    				$alias=$this->gTabla->getAliasLower().".".$p_Columnas[$i]->getColumna('nombre');
			}
			
			//echo $p_Columnas[$i]->getColumna('nombre').' --- '.substr($p_Columnas[$i]->getColumna('nombre'),0,3).'::';
			
			/*if($p_Columnas[$i]->getColumna('nombre')=='id_cuenta'){
				echo $p_Columnas[$i]->getColumna('nombre').' --- '.substr($p_Columnas[$i]->getColumna('nombre'),0,3).'::';
				echo 'AAA;;'.$this->gLlave[0]->getColumna('nombre');
			}*/
			
			//Verifica si es un campo llave foranea para crear el combo
			if($p_Columnas[$i]->getColumna('nombre')!=$this->gLlave[0]->getColumna('nombre')&&$p_Columnas[$i]->getColumna('nombre')!='id_usuario_ai'&&$p_Columnas[$i]->getColumna('nombre')!='id_usuario_reg'&&$p_Columnas[$i]->getColumna('nombre')!='id_usuario_mod'&&substr($p_Columnas[$i]->getColumna('nombre'),0,3)=='id_'){
				//echo 'entra';
				//Combo
				$cadena.="
		{
			config: {
				name: '".$name."',
				fieldLabel: '".$label."',
				allowBlank: ".$this->nulo($p_Columnas[$i]->getColumna('nulo')).",
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_/control/Clase/Metodo',
					id: 'id_',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_', 'nombre', 'codigo'],
					remoteSort: true,
					baseParams: {par_filtro: 'movtip.nombre#movtip.codigo'}
				}),
				valueField: 'id_',
				displayField: 'nombre',
				gdisplayField: 'desc_',
				hiddenName: '".$name."',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'movtip.nombre',type: 'string'},
			grid: ".$grid.",
			form: ".$grid."
		},";
					
			} else{
				//Define la cadena de la columna
				$cadena.="
		{
			config:{
				name: '".$name."',
				fieldLabel: '".$label."',
				allowBlank: ".$this->nulo($p_Columnas[$i]->getColumna('nulo')).",
				anchor: '".$p_Columnas[$i]->getColumna('form_ancho_porcen')."%',
				gwidth: ".$p_Columnas[$i]->getColumna('grid_ancho').",";
				
				//Verifica si es campo fecha para aumentar el renderer
				if($tipodato=='date'){
					$cadena.="
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},";
				 }
				
			      if($tipodato=='timestamp'){
							$cadena.="
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''},";
				}

				//Verifica si es necesario definir limite maximo en funcion del componente
				$sw=0;
				if($this->maximaLongitud($p_Columnas[$i])>0){
					$sw=1;
					$cadena.="\n\t\t\t\tmaxLength:".$p_Columnas[$i]->getColumna('longitud').",";
				}
				
				//Quita la ultima coma
				$cadena= substr($cadena,0,strlen($cadena)-1);
				
				if($tipodato=='timestamp'){
					$tipodato = 'date';
				}
				
				$tipo_componente = $this->tipoDato($p_Columnas[$i]->getColumna('tipo_dato'),'tipo_comp');
				
				if($p_Columnas[$i]->getColumna('nombre')=='id_usuario_reg'||$p_Columnas[$i]->getColumna('nombre')=='id_usuario_mod'||$p_Columnas[$i]->getColumna('nombre')=='id_usuario_ai'){
                
                   $tipo_componente = 'Field';
                }
				
				
				
				$cadena.="\n\t\t\t},
				type:'".$tipo_componente."',
				filters:{pfiltro:'".$alias."',type:'".$tipodato."'},
				id_grupo:".$p_Columnas[$i]->getColumna('grupo').",
				grid:".$grid.",
				form:".$form.",";
				$cadena= substr($cadena,0,strlen($cadena)-1);
				$cadena.="\n\t\t},";
				
				//$fb->log($p_Columnas[$i],"columnas");
						
			}
			
		}
		
		return $cadena;
	}
	
	private function nulo($pNulo){
		if($pNulo=='si'){
			return 'true';
		} else{
			return 'false';
		}
	}
	
	private function formBasicas($pColBasicas){
		if($pColBasicas=='columnas'){
			return 'true';
		} else{
			return 'false';
		}
	}
	
	private function nvl($pDato,$defecto){
		if($dato==''){
			return $defecto;
		} else{
			return $pDato;	
		}
	}
	
	private function Comentarios($pTipo,$pNombre,$pDescripcion,$pTrans=''){
		$comentario='';
		
		//Verifica el tipo de archivo
		if($pTipo=='BD'){
			//Verifica si es cabecera o transaccion
			if($pTrans==''){
				//Cabecera
				$comentario=
'/**************************************************************************
 SISTEMA:		'.$this->gTabla->getSubsistema().'
 FUNCION: 		'.$pNombre.'
 DESCRIPCION:   '.$pDescripcion.'
 AUTOR: 		'.$this->aut.' ('.$_SESSION["_LOGIN"].')
 FECHA:	        '.date("d-m-Y H:i:s").'
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				'.date("d-m-Y H:i:s").'				'.$this->aut.'				'.$pDescripcion.'	
 #
 ***************************************************************************/
';
			} else{
				//transaccion
				$comentario=
'	/*********************************    
 	#TRANSACCION:  '.$pTrans.'
 	#DESCRIPCION:	'.$pDescripcion.'
 	#AUTOR:		'.$_SESSION["_LOGIN"].'	
 	#FECHA:		'.date("d-m-Y H:i:s").'
	***********************************/
';
			}
			
			
		} elseif($pTipo=='php'){
			$comentario=
'/**
*@package pXP
*@file '.$pNombre.'
*@author '.$this->aut.' ('.$_SESSION["_LOGIN"].')
*@date '.date("d-m-Y H:i:s").'
*@description '.$pDescripcion.'
*/
';
			
		} elseif($pTipo=='js'){
			$comentario=
'/**
*@package pXP
*@file '.$pNombre.'
*@author '.$this->aut.' ('.$_SESSION["_LOGIN"].')
*@date '.date("d-m-Y H:i:s").'
*@description '.$pDescripcion.'
*/
';
		}
		return $comentario;
	}
	
	function llamadasCustom(){
		$aux="/*Clase: ".$this->gTabla->getNombreFuncion('modelo')."
	* Fecha: ".date("d-m-Y H:i:s")."
	* Autor: ".$_SESSION["_LOGIN"]."*/
	function listar".$this->gTabla->getSujetoTablaJava()."(CTParametro \$parametro){
		\$obj=new ".$this->gTabla->getNombreFuncion('modelo')."(\$parametro);
		\$res=\$obj->listar".$this->gTabla->getSujetoTablaJava()."();
		return \$res;
	}
			
	function insertar".$this->gTabla->getSujetoTablaJava()."(CTParametro \$parametro){
		\$obj=new ".$this->gTabla->getNombreFuncion('modelo')."(\$parametro);
		\$res=\$obj->insertar".$this->gTabla->getSujetoTablaJava()."();
		return \$res;
	}
			
	function modificar".$this->gTabla->getSujetoTablaJava()."(CTParametro \$parametro){
		\$obj=new ".$this->gTabla->getNombreFuncion('modelo')."(\$parametro);
		\$res=\$obj->modificar".$this->gTabla->getSujetoTablaJava()."();
		return \$res;
	}
			
	function eliminar".$this->gTabla->getSujetoTablaJava()."(CTParametro \$parametro){
		\$obj=new ".$this->gTabla->getNombreFuncion('modelo')."(\$parametro);
		\$res=\$obj->eliminar".$this->gTabla->getSujetoTablaJava()."();
		return \$res;
	}
	/*FinClase: ".$this->gTabla->getNombreFuncion('modelo')."*/\n";
		
		return $aux;
	}
	
	//Funcion que devuelve por columna el mapeo para el data store
	function mapeoColumnas($p_Columnas){
		//Define la cadena del mapeo
		$tip = $this->tipoDato($p_Columnas->getColumna('tipo_dato'));
		
		if($tip=='timestamp'){
			$tip='date';
			
		}
		
		$col="\t\t{name:'".$p_Columnas->getColumna('nombre')."', type: '".$tip;
		
		//Verifica si es campo Date para aumentar el formato de fecha
		
		if($this->tipoDato($p_Columnas->getColumna('tipo_dato'))=='timestamp'){
			$col.="',dateFormat:'Y-m-d H:i:s.u'},\n";
			
		}
		elseif($this->tipoDato($p_Columnas->getColumna('tipo_dato'))=='date'){
			
			
			var_dump($p_Columnas);
			$col.="',dateFormat:'Y-m-d'},\n";
		} else{
			$col.="'},\n";
		}
		return $col;
	}
	
		
}

?>
