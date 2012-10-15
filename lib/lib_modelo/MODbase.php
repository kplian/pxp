<?php
//include '../lib_modelo/driver.php';
class MODbase extends driver
{
	protected $aParam;
	protected $arreglo;
	protected $arregloFiles;
	
	protected $arreglo_consultas;
	protected $validacion;
	protected $nombre_archivo;
	protected $objParam;
	


	//Constructor que obtiene los datos de parametros e inicializa el driver
	function __construct($pParam){
		
		$this->objParam=$pParam;
		$this->nombre_archivo='MODbase.php';
		parent::__construct();
		
		//Guarda los parametros en variable local
		$this->validacion=new MODValidacion();
		
		
		if($pParam==null){
			$this->esMatriz=false;
				
		}
		else{
				
			$this->aParam=$pParam;
			//recibe los parametros pasados desde la vista
			$this->arreglo=$this->aParam->getArregloParametros();
			
			$this->arregloFiles=$this->aParam->getArregloFiles();
			
		
			
			//oprine parametros de consulta como los filtros, etc
			$this->arreglo_consultas=$this->aParam->getParametrosConsulta();
			
			//RAC 25/10/2011: validacion de varialbes
			if(isset($this->arreglo_consultas['cont'])){
				if($this->arreglo_consultas['cont']=='false'){
					$this->count=false;
				}
			}
			//define el tipo de trasaccion
			if(isset($this->Tipo)){
			   $this->aParam->setTipotran($this->Tipo);
			}
			//son datos devueltos en formato matriz, ejem desde la grilla
			$this->esMatriz=$this->aParam->esMatriz();
			if(!$this->esMatriz){
				$this->setParametrosConsulta();
			}
			else{
				//si es matriz enumera todas lafilas
				$cont=0;
				array_push($this->variables,'_fila');
				array_push($this->tipos,'integer');
				foreach ($this->arreglo as $row){
						
					$this->validacion->validar('_fila',$row['_fila'],'integer',false,'',null,null);
					        
					
					$this->valores[$cont]['_fila']=$row['_fila'];
					$cont++;
				}
			}

		}


	}

	function armarConsulta(){

		if(count($this->validacion->getRes())==0){
			parent::armarConsulta();
		}
	}
	function ejecutarConsulta($res=null){
		if(count($this->validacion->getRes())==0){
			parent::ejecutarConsulta($res);
		}
		else{
			$this->generaRespuestaParametros();
		}

	}



	/**
	 * Nombre funcion:	parametro
	 * Proposito:		Anade una parametro que se coloca en el arreglo de 
	 *                  parametros a ser enviados a un procedimeinto
	 *                  se utiliza desde clases de modelo MD
	 * Fecha creacion:	12/04/2009
	 * @param $nombre El nombre del campo que se envia
	 * @param $nombre_parametro  Nombre del campo que se envia desde la vista
	 * @param $tipo Tipo del campoq ue se envia (todos los tipos de postges y otros definidos tb)
	 * @param $blank true o false si premite nulo o no)
	 * @param $tamano Tamaoo del campo definido si es nulo se aplica el amximo para el tipo de campo postgres sino hay moximo es ilimitado
	 */
	function setParametro($nombre,$valor,$tipo,$blank=true,$tamano='',$opciones=null,$tipo_archivo=null){
		//obtenemos el tipo de la base de datos
		//throw new exception('Desde donde llama pendejos');

		$tipo_base=$this->validacion->getTipo($tipo);

		//anadimos el nombre y el tipo a los arreglos correspondientes
		if($this->esMatriz || (!$this->esMatriz && (isset($this->arreglo_consultas[$valor])|| isset($this->arreglo[$valor])))){
			//rac 23092011 no define el tipo cuando es bytea en el array de definiciones
			if($tipo!='bytea'){
				array_push($this->variables,$nombre);
				array_push($this->tipos,$tipo_base);
			}else{
				
				$this->variablesFiles="'$nombre'";
				
			}
		}



		if($this->esMatriz){
				
			$valor2=array();
			$cont=0;
			foreach ($this->arreglo as $row){
				
				
				//rac 27/10/11 se escapa los valores entrantes para permitir almacenar comillas simples	
			    $row[$valor]=pg_escape_string(pg_escape_string($row[$valor]));
				$this->validacion->validar($nombre,$row[$valor],$tipo,$blank,$tamano,$opciones,$tipo_archivo);
				$this->valores[$cont][$nombre]=$row[$valor];
				$cont++;
			}
				
		}
		else{
			
			if($nombre=='filtro'||$nombre=='ordenacion'||$nombre=='dir_ordenacion'||$nombre=='puntero'||$nombre=='cantidad')
			{	if(isset($this->arreglo_consultas[$valor])){
					$this->validacion->validar($nombre,$this->arreglo_consultas[$valor],$tipo,$blank,$tamano,$opciones,$tipo_archivo);
					array_push($this->valores,$this->arreglo_consultas[$valor]);
				}
			}
			else{
				if(isset($this->arreglo[$valor])){
					
					
					//rac 22092011  verifica si es del tipo bytea 
					if($tipo=='bytea'){
						
						
						$this->validacion->validar($nombre,$this->arregloFiles[$valor],$tipo,$blank,$tamano,$opciones,$tipo_archivo);
						//echo "MODBase";
						
						$this->uploadFile=true;
						
						$data =  pg_escape_bytea(base64_encode(file_get_contents($this->arregloFiles[$valor]['tmp_name'])));

						$this->valoresFiles="'".$data."'";
					}
					else{
					
					  //rac 27/10/11 se escapa los valores entrantes para permitir almacenar comillas simples	
					  $this->arreglo[$valor]=pg_escape_string(pg_escape_string($this->arreglo[$valor]));
						
					  $this->validacion->validar($nombre,$this->arreglo[$valor],$tipo,$blank,$tamano,$opciones,$tipo_archivo);
					  array_push($this->valores,$this->arreglo[$valor]);
					}
				}elseif(isset($this->arregloFiles[$valor])){
					
					var_dump('PRUEBA............');
					
				}
				
				
			}
				
		}

	}
	
	
	


	function generaRespuestaParametros(){
		$cadena='';
		$this->respuesta=new Mensaje();
		$res_validacion=$this->validacion->getRes();
		foreach ($res_validacion as $data){
			$cadena.="$data|";
		}
		$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$cadena,'Error de validacion de datos por parte de Validacion.php','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,'');
	}

	/**
	 * Nombre funcion:	setParametrosConsulta
	 * Proposito:		inserta parametors de consulta y guarda los datos de cunsulta en las variables de clase
	 * para la seleccion
	 * Fecha creacion:	21/06/2009
	 *
	 * @param cadena $criterio_filtro
	 * @param cadena $ordenacion
	 * @param cadena $dir_ordenacion
	 * @param entero $puntero
	 * @param entero $cantidad
	 */
	function setParametrosConsulta(){
			
		$this->setParametro('filtro','filtro','filtro_sql');
		$this->setParametro('ordenacion','ordenacion','varchar');
		$this->setParametro('dir_ordenacion','dir_ordenacion','varchar');
		$this->setParametro('puntero','puntero','integer');
		$this->setParametro('cantidad','cantidad','integer');

	}

}
?>