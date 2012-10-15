<?php
class ACTGenerador extends ACTbase{ 

	private $objTabla;
	private $objCol;
	private $aTabla; //array que contiene los datos de la Tabla
	private $aCol; //array que contiene los datos de las columnas
	private $strDirec; //Dirección para guardar los archivos
	private $strTexto;
	
	//Nombres para funciones, archivos, etc.
	private $strBDprefijo;//ej: SEG
	private $strBDalias;//ej: REGION
	
	private $strPHPalias;//ej: Regional
	private $strMOD;//ej: MODRegional
	
	private $strMODlistar;//ej: listarRegional
	private $strMODinsertar;//ej: insertarRegional
	private $strMODmodificar;//ej: modificarRegional
	private $strMODeliminar;//ej: eliminarRegional
	
	private $strACT;//ej:ACTRegional
	private $strVIS;//ej:ACTRegional
	
	private $strMODarchivo;//ej: MODRegional
	private $strACTarchivo;//ej:ACTRegional
	private $strVISarchivo;//ej:ACTRegional
	
	private $strBDime;//ej: gen.ft_tabla_ime
	private $strBDsel;//ej: gen.ft_tabla_sel
	private $strBDpins;//pins=proceso insercion ej: SEG_REGION_INS
	private $strBDpmod;//ej: SEG_REGION_UPD
	private $strBDpeli;//ej: SEG_REGION_ELI
	private $strBDpsel;//ej: SEG_REGION_SEL
	private $strBDpcont;//ej: SEG_REGION_CONT
	
	private $strTablaEsq;//nombre de la tabla con el esquema incluido
	private $strTabla;//nombre de la tabla sin el esquema
	private $strPK; //llave primaria
	
	private $strPHPlistar;
	private $strPHPinsertar;
	private $strPHPmodificar;
	private $strPHPeliminar;
	private $strMODfun;
	
	function __construct($pParam){
		//echo 'fuck';exit;
		parent::__construct($pParam);
		$this->aTabla=$this->listarDatosTabla();
		$this->aCol=$this->listarColumnas();
		$this->defineNombres();
	}
	
	function defineNombres(){
		
		//Llave primaria
		
		//nombre tabla
		$this->strTabla=$this->aTabla['nombre'];
		//nombre tabla mas esquema
		$this->strTablaEsq=$this->aTabla['esquema'].'.'.$this->aTabla['nombre'];
		//NOmbre orefijo subsistema mas alias
		$this->strBDalias=$this->aTabla['prefijo'].'_'.$this->aTabla['alias'];
		//Nombre BD funcion IME
		$this->strBDime=strtolower($this->aTabla['esquema'].'.ft_'.substr($this->strTabla,2).'ime');
		//Nombre BD funcion SEL
		$this->strBDime=strtolower($this->aTabla['esquema'].'.ft_'.substr($this->strTabla,2).'sel');
		//Nombres procedimientos
		$this->strBDpins=strtoupper($this->strBDalias.'_INS');
		$this->strBDpmod=strtoupper($this->strBDalias.'_MOD');
		$this->strBDpeli=strtoupper($this->strBDalias.'_ELI');
		$this->strBDpsel=strtoupper($this->strBDalias.'_SEL');
		$this->strBDpcont=strtoupper($this->strBDalias.'_CONT');
		
		$this->strPHPalias=$this->aTabla['alias'];
		//Nombre clase control
		$this->strACT='ACT'.$this->aTabla['alias'];
		//Nombre clase modelo
		$this->strMOD='MOD'.$this->aTabla['alias'];
		$this->strPHPlistar='listar'.$this->strPHPalias;
		$this->strPHPinsertar='insertar'.$this->strPHPalias;
		$this->strPHPmodificar='modificar'.$this->strPHPalias;
		$this->strPHPeliminar='eliminar'.$this->strPHPalias;
		//Nombre clase vista
		$this->strVIS=strtolower($this->aTabla['alias']);
		//Nombre archivo control
		$this->strACTarchivo=$this->strACT.'php';
		//Nombre archivo modelo
		$this->strMODarchivo=$this->strMOD.'php';
		//Nombre archivo vista
		$this->strVISarchivo=$this->strVIS.'js';
		//Nombre funciones modelo
		$this->strMODfun='Funciones'.$this->strPHPalias;
	}
	

	function listarDatosTabla(){

		$objTabla=new FuncionesGenerador();
		$this->objParam->defecto('ordenacion','id_tabla');
		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->defecto('puntero','0');
		$this->objParam->defecto('cantidad','30');
		
		$this->res=$objTabla->listarTabla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

		
	}
	
	function listarColumnas(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','a.attnum');
		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->defecto('puntero','0');
		$this->objParam->defecto('cantidad','30');
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunGenerador=new FuncionesGenerador();	
		
		//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
		$this->res=$this->objFunGenerador->listarColumna($this->objParam);
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
	}
	
	function generarCodigo(){
		
		$this->objTabla = new ACTTabla();
		$this->objCol= new ACTColumna();
		
		$this->objParam->defecto('ordenacion','id_tabla');
		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->defecto('puntero','0');
		$this->objParam->defecto('cantidad','30');
		//Obtiene los datos de la tabla
		$this->aTabla=$this->objTabla->listarTabla();
		
		$this->objParam->defecto('ordenacion','a.attnum');
		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->defecto('puntero','0');
		$this->objParam->defecto('cantidad','30');
	
		//Obtiene los datos de la columna
		$this->aCol=$this->objCol->listarDatosColumna();
		
		//Genera los archivos si los datos de las columnas existen
		if(1){
			
			//Crea el archivo de BD IME
			$this->crearBDIme();
			
			//Crea el archivo de BD SEL
			$this->crearBDSel();
			
			//Crea el archivo del Modelo MOD
			$this->crearMOD();
			
			//Crea el archivo Modelo Funciones
			$this->crearMODFun();
			
			//Crea el archivo Control ACT
			$this->crearACT();
			
			//Crea el archivo Vista
			$this->crearVISTA();
			
		} else{
			throw new Exception('No existen datos sobre la tabla definida',1);
		}
		
		
		
		//Respuesta
		
		
	}
	
	function crearBDIme(){
		
		//Abre el archivo en modo rw

		//Creación de la función con parámetros
		$this->strTexto = "
		
			CREATE OR REPLACE FUNCTION \"".$this->strBDime." (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
			RETURNS character varying AS
			\$BODY$

			DECLARE

			    v_nro_requerimiento    	integer;
			    v_parametros           	record;
			    v_id_requerimiento     	integer;
			    v_resp		            varchar;
			    v_nombre_funcion        text;
			    v_mensaje_error         text;
			    v_".$this->strPK."	integer;
			    
			    BEGIN

     				v_nombre_funcion = '".$this->strBDime."';
     				v_parametros = f_get_record(p_tabla);

     				if(p_transaccion='".$this->strBDpins."')then

          				BEGIN
          					insert into ".$this->strTablaEsq."(\n
          					";
		
							for($i=1;$i<=$this->numCampos-2; $i++){
								$this->strTexto.= "\t\t".$this->aCol['nombre'].",\n";
							}
							$this->strTexto.= "\t\t".$this->aCol['nombre']
							
							."
          					) values(";
							
							for($i=1;$i<=$this->numCampos-2; $i++){
								$this->strTexto.= "\t\t v_parametros.".$this->aCol['nombre'].",\n";
							}
							$this->strTexto.= "\t\t v_parametros.".$this->aCol['nombre']
							
          					.")RETURNING ".$this->strPK." into v_".$this->strPK.";
               
							v_resp = f_agrega_clave(v_resp,'mensaje','".$this->strPK." almacenado(a) con éxito (".$this->llavePrimaria()."'||v_".$this->strPK."||')'); 
               				v_resp = f_agrega_clave(v_resp,'".$this->strPK."',v_".$this->strPK."::varchar);

               				return v_resp;

         				END;

     				elsif(p_transaccion='".$this->strBDpmod."')then

          				BEGIN

               				update ".$this->strTablaEsq." set";
          					
          					for($i=1;$i<=$this->numCampos-2; $i++){
								$this->strTexto.= "\t\t".$this->aCol['nombre']."= v_parametros.".$this->aCol['nombre'] ."\n";
							}
							$this->strTexto.= "\t\t".$this->aCol['nombre']."= v_parametros.".$this->aCol['nombre']
          					
          					
               				."where ".$this->strPK."=v_parametros.".$this->strPK.";
               
               				v_resp = f_agrega_clave(v_resp,'mensaje','".$this->strPK." modificado(a)'); 
               				v_resp = f_agrega_clave(v_resp,'".$this->strPK."',v_parametros.".$this->strPK."::varchar);
               
               				return v_resp;
          				END;

    				elsif(p_transaccion='".$this->strBDpeli."')then

          				BEGIN

               				delete from ".$this->strTablaEsq."
               				where ".$this->strPK."=v_parametros.".$this->strPK.";
               
               				v_resp = f_agrega_clave(v_resp,'mensaje','".$this->strPK." eliminado(a)'); 
               				v_resp = f_agrega_clave(v_resp,'".$this->strPK."',v_parametros.".$this->strPK."::varchar);
              
               				return v_resp;
         				END;
         
     				else
     
         				raise exception 'Transacción inexistente: %',p_transaccion;

     				end if;

				EXCEPTION
				
					WHEN OTHERS THEN
				    	v_resp='';
						v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
				    	v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
				  		v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
						raise exception '%',v_resp;
				        
				END;
				\$BODY$
				  LANGUAGE 'plpgsql' VOLATILE
				  COST 100;
				ALTER FUNCTION ".$this->strBDime."(integer, integer, character varying, character varying) OWNER TO postgres;

			
			";
		
		//Almacenamiento de los datos en el archivo
		
		
	}
	
	function crearBDSel(){
		
		//Abre el archivo en modo rw

		//Creación de la función con parámetros
		$this->strTexto = "
		
			CREATE OR REPLACE FUNCTION \"".$this->strBDsel." (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
			RETURNS character varying AS
			\$BODY$

			DECLARE

			    v_consulta    		varchar;
				v_parametros  		record;
				v_nombre_funcion   	text;
			    v_resp				varchar;
			    
			    BEGIN

     				v_nombre_funcion = '".$this->strBDsel."';
     				v_parametros = f_get_record(p_tabla);

     				if(p_transaccion='".$this->strBDpsel."')then
     				
     					begin
				        	v_consulta:='select";
		
							for($i=0;$i<=$this->numCampos-2; $i++){
								$this->strTexto.= "\t\t".$this->aCol['nombre'].",\n";
							}
							$this->strTexto.= "\t\t".$this->aCol['nombre']
		
				            ."			from ".$this->aTabla['esquema'].".".$this->aTabla['nombre']."
				                        where  ';
				            v_consulta:=v_consulta||v_parametros.filtro;
				            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
				            return v_consulta;
						end;
						
						elsif(p_transaccion='".$this->strBDpcont."')then

					        begin
					        
					        	v_consulta:='select count(".$this->strPK.")
					            			from ".$this->strTablaEsq."
					                        where ';
					            v_consulta:=v_consulta||v_parametros.filtro;
					            
					            return v_consulta;
					        end;
					
					     else
					     
					         raise exception 'Transaccion inexistente';
					         
					     end if;
					
					EXCEPTION
					
						WHEN OTHERS THEN
					    	v_resp='';
							v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
					    	v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
					  		v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
							raise exception '%',v_resp;
					END;
					\$BODY$
					  LANGUAGE 'plpgsql' VOLATILE
					  COST 100;
					ALTER FUNCTION ".$this->strBDsel."(integer, integer, character varying, character varying) OWNER TO postgres;
					
			";

		
	}
	
	function crearMOD(){
		
		//Abre el archivo en modo rw

		//Creación de la función con parámetros
		$this->strTexto = "
		
		<?php
		class ".$this->strMOD." extends MODbase{
	
			function __construct(CTParametro \$pParam){
				parent::__construct(\$pParam);
			}
			
			function ".$this->strPHPlistar."(){
				//Definicion de variables para ejecucion del procedimientp
				\$this->procedimiento='".$this->strBDsel."';// nombre procedimiento almacenado
				\$this->transaccion='".$this->strBDpsel."';//nombre de la transaccion
				\$this->tipo_procedimiento='SEL';//tipo de transaccion
			
				//Definicion de la lista del resultado del query";
		
				for($i=0;$i<=$this->numCampos-1; $i++){
					$this->strTexto.="\$this->captura('".$this->aCol['columna']."','".$this->aCol['tipo_dato']."');\n";
				}
			
				$this->strTexto.="
				
				//Ejecuta la funcion
				\$this->armarConsulta();
				\$this->ejecutarConsulta();
		
				return \$this->respuesta;
			}
			
			function ".$this->strPHPinsertar."(){
				//Definicion de variables para ejecucion del procedimiento
				\$this->procedimiento='".$this->strBDime."';
				\$this->transaccion='".$this->strBDpins."';
				\$this->tipo_procedimiento='IME';
				
				//Define los parametros para la funcion	";
				
				for($i=0;$i<=$this->numCampos-1; $i++){
					$this->strTexto.="\$this->setParametro('".$this->aCol['columna']."','".$this->aCol['columna']."','".$this->aCol['tipo_dato']."');\n";
				}
			
				$this->strTexto.="
				
				//Ejecuta la instruccion
				\$this->armarConsulta();
				\$this->ejecutarConsulta();
				
				return \$this->respuesta;
			}
			
			function ".$this->strPHPmodificar."(){
				//Definicion de variables para ejecucion del procedimiento
				\$this->procedimiento='".$this->strBDime."';
				\$this->transaccion='".$this->strBDpmod."';
				\$this->tipo_procedimiento='IME';
				
				//Define los parametros para la funcion	";
				
				for($i=0;$i<=$this->numCampos-1; $i++){
					$this->strTexto.="\$this->setParametro('".$this->aCol['columna']."','".$this->aCol['columna']."','".$this->aCol['tipo_dato']."');\n";
				}
			
				$this->strTexto.="
				
				//Ejecuta la instruccion
				\$this->armarConsulta();
				\$this->ejecutarConsulta();
				
				return \$this->respuesta;
			}
			
			function ".$this->strPHPeliminar."(){
				//Definicion de variables para ejecucion del procedimiento
				\$this->procedimiento='".$this->strBDime."';
				\$this->transaccion='".$this->strBDpeli."';
				\$this->tipo_procedimiento='IME';
				
				//Define los parametros para la funcion
				
				\$this->setParametro('".$this->strPK."','".$this->strPK."','integer');\n
			
			
				//Ejecuta la instruccion
				\$this->armarConsulta();
				\$this->ejecutarConsulta();
				
				return \$this->respuesta;
			}
			
		}
		?>
		
		";
				
		//Guarda archivo
		
	}
	
	function crearMODFun(){
		
		//Abre el archivo en modo rw

		//Creación de la función con parámetros
		$this->strTexto = "	
	
		
		<?php
		class ".$this->strMODfun."{
		
			function __construct(){
				include_once('".$this->strMODarchivo."');
			}
			
			function ".$this->strMODlistar."(CTParametro \$parametro){
				\$obj=new ".$this->strMOD."(\$parametro);
				\$res=\$obj->".$this->strMODlistar."();
				return \$res;
			}
			
			function ".$this->strMODinsertar."(CTParametro \$parametro){
				\$obj=new ".$this->strMOD."(\$parametro);
				\$res=\$obj->".$this->strMODinsertar."();
				return \$res;
			}
			
			function ".$this->strMODmodificar."(CTParametro \$parametro){
				\$obj=new ".$this->strMOD."(\$parametro);
				\$res=\$obj->".$this->strMODmodificar."();
				return \$res;
			}
			
			function ".$this->strMODeliminar."(CTParametro \$parametro){
				\$obj=new ".$this->strMOD."(\$parametro);
				\$res=\$obj->".$this->strMODeliminar."();
				return \$res;
			}
			
		}
		?>";
		
		//Guarda archivo
	}
	
	function crearACT(){
		
		//Abre el archivo en modo rw

		//Creación de la función con parámetros
		$this->strTexto = "	
		
		<?php
			class ".$this->strACT." extends ACTbase{    
			
				function ".$this->strPHPlistar."(){		
					\$this->objParam->defecto('ordenacion','".$this->strPK."');
					\$this->objParam->defecto('dir_ordenacion','asc');
					
					\$this->objFunc=new ".$this->strMODfun."();	
					\$this->res=\$this->objFunc->".$this->strPHPlistar."(\$this->objParam);
					\$this->res->imprimirRespuesta(\$this->res->generarJson());
				}
				
				function ".$this->strPHPinsertar."(){
					\$this->objFunc=new ".$this->strMODfun."();	
					if(\$this->objParam->insertar('".$this->strPK."')){
						\$this->res=\$this->objFunc->".$this->strPHPinsertar."(\$this->objParam);			
					}
					else{			
						\$this->res=\$this->objFunc->".$this->strPHPmodificar."(\$this->objParam);
					}
					\$this->res->imprimirRespuesta(\$this->res->generarJson());
				}
						
				function ".$this->strPHPeliminar."(){
					\$this->objFunc=new ".$this->strMODfun."();	
					\$this->res=\$this->objFunc->".$this->strPHPeliminar."(\$this->objParam);
					\$this->res->imprimirRespuesta(\$this->res->generarJson());
				}
			
			}
			
		?>
		
		";
		
		//Guarda archivo
		
	}
	
	function crearVISTA(){
		
		//Abre el archivo en modo rw

		//Creación de la función con parámetros
		$this->strTexto = "	
		
		/*
			* Ext JS Library 2.0.2
			* Copyright(c) 2006-2008, Ext JS, LLC.
			* licensing@extjs.com
			* http://extjs.com/license
			*/
			<script>
			Phx.vista.".$this->strVIS."=function(config){
			
			var FormatoVista=function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			
				this.Atributos=[
				{
					//configuracion del componente
					config:{
						labelSeparator:'',
						inputType:'hidden',
						name: '".$this->strPK."'
			
					},
					type:'Field',
					form:true 
					
				},";
		
		for($i=0;$i<=$this->numCampos-1; $i++){
			$this->strTexto.="
				{
					config:{
						fieldLabel: '".$this->aCol['nombre']."',
						gwidth: 100,
						name: '".$this->aCol['nombre']."',
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
		
		$this->strTexto.="
		
				];
			
				Phx.vista.".$this->strVIS.".superclass.constructor.call(this,config);
				this.init();
				
				this.load({params:{start:0, limit:50}})
			
			}
			
			Ext.extend(Phx.vista.".$this->strVIS.",Phx.gridInterfaz,{
				title:'".$this->strPHPalias."',
				ActSave:'../../".$this->aTabla['subsistema']."/control/".$this->strPHPalias."/".$this->strPHPinsertar."',
				ActDel:'../../".$this->aTabla['subsistema']."/control/".$this->strPHPalias."/".$this->strPHPeliminar."',
				ActList:'../../".$this->aTabla['subsistema']."/control/".$this->strPHPalias."/".$this->strPHPlistar."',
				id_store:'".$this->strPK."',
				fields: [";
		
				for($i=0;$i<=$this->numCampos-1; $i++){
					$this->strTexto.="{name:'".$this->aCol['nombre']."', type: '".$this->tipoDato($this->aCol['tipo_dato'])."'}\n,";
				}
		
		
				$this->strTexto.="
					],
				sortInfo:{
					field: '".$this->strPK."',
					direction: 'ASC'
				},
				bdel:true,//boton para eliminar
				bsave:false,//boton para eliminar
			
			}
			</script>
		
		";
		
		//Guarda archivo
		
	}
	
	function tipoDato($p_tipoDato){
		$resp='indefinido';
		if($p_tipoDato=='varchar'){
			$resp='string';
		} elseif ($p_tipoDato=='integer') {
			$resp='numeric';
		}
		return $resp;
	}
	
		
}

?>