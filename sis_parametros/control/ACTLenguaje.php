<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTLenguaje.php
*@author  (admin)
*@date 21-04-2020 01:50:14
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                21-04-2020 01:50:14    admin             Creacion    
  #133              27/05/2020             rac               setLanguage
*****************************************************************************************/

class ACTLenguaje extends ACTbase{    
    
    //#133
    function setLanguage(){
        if( $this->objParam->getParametro('language') != '') {
            $_SESSION["ss_lenguaje_usu"] = strtoupper($this->objParam->getParametro('language')); 
        } else {
            $_SESSION["ss_lenguaje_usu"] = 'EN';
        }
        header("HTTP/1.1 200 ok");
        header('Content-type: application/json; charset=utf-8'); 
        echo "{success:true}";
    }

    function listarLenguaje(){
		$this->objParam->defecto('ordenacion','id_lenguaje');
        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODLenguaje','listarLenguaje');
        } else{
        	$this->objFunc=$this->create('MODLenguaje');
            
        	$this->res=$this->objFunc->listarLenguaje($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarLenguaje(){
        $this->objFunc=$this->create('MODLenguaje');    
        if($this->objParam->insertar('id_lenguaje')){
            $this->res=$this->objFunc->insertarLenguaje($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarLenguaje($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarLenguaje(){
        $this->objFunc=$this->create('MODLenguaje');    
        $this->res=$this->objFunc->eliminarLenguaje($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function generarArchivoV2(){
		$this->objParam->defecto('ordenacion','id_lenguaje');
        $this->objParam->defecto('dir_ordenacion','asc');

        $this->objFunc=$this->create('MODLenguaje');            
        $this->res=$this->objFunc->obtenerTraducciones($this->objParam);

		
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function generarArchivo() {
		$this->objFun=$this->create('MODLenguaje');	
		$this->res = $this->objFun->obtenerTraducciones();
		
		if($this->res->getTipo()=='ERROR'){
			$this->res->imprimirRespuesta($this->res->generarJson());
			exit;
		}
		
		$nombreArchivo = $this->crearArchivoExportacion($this->res);
		
		$this->mensajeExito=new Mensaje();
		$this->mensajeExito->setMensaje('EXITO','Reporte.php','Se genero con exito el archivo JSON '.$nombreArchivo,
										'Se genero con exito el archivo JSON '.$nombreArchivo,'control');
		$this->mensajeExito->setArchivoGenerado($nombreArchivo);
		
		$this->res->imprimirRespuesta($this->mensajeExito->generarJson());

    }
    
    function crearArchivoExportacion($res) {	
	    $fileName = $this->objParam->getParametro('codigo_lenguaje').'.translation.json';
        $data = $res -> getDatos();		
		//create file
		$file = fopen("../../../reportes_generados/$fileName", 'w');
		fwrite ($file,  $data["resp_json"]);
		fclose($file);
		return $fileName;
    }
    
    function generarVariosArchivo() {
		$this->objFun=$this->create('MODGrupoIdioma');	
		$this->res = $this->objFun->listarGrupoIdiomaComun();
		
		if($this->res->getTipo()=='ERROR'){
			$this->res->imprimirRespuesta($this->res->generarJson());
			exit;
        }
        
        $dataGrupo = $this->res->getDatos();

        foreach ($dataGrupo as $row) {
            $this->objParam->addParametro('codigo_grupo',$row['codigo']);    
            //Obtiene los datos de la columna
            $this->objFunc=$this->create('MODLenguaje');
            $resGrupo = $this->objFunc->obtenerTraduccionesGrupo($this->objParam);
            $data = $resGrupo -> getDatos();
            //create file
            $this->createFile( $this->objParam->getParametro('codigo_lenguaje'), $row['codigo'], $data["resp_json"]);
        }
		
		$this->mensajeExito=new Mensaje();
        $this->mensajeExito->setMensaje('EXITO','Reporte.php','Se genero con exito el archivo LCV',
                                                'Se genero con exito los archivos en la carpeta de traducciones','control');
		$this->mensajeExito->setArchivoGenerado($nombreArchivo);		
		$this->res->imprimirRespuesta($this->mensajeExito->generarJson());

    }

    function createFile($codigo_lenguaje, $grupo, $contenido) {
        
        //Creamos la carpeta bascia si no existe
        $ruta=dirname(__FILE__).'/../../../locale/';
        if(!file_exists($ruta)){
            mkdir($ruta);
        }

        $ruta=dirname(__FILE__).'/../../../locale/'.strtolower($codigo_lenguaje);
        if(!file_exists($ruta)){
            mkdir($ruta);
        }
        $file = fopen("../../../locale/".strtolower($codigo_lenguaje)."/".strtolower($grupo).".json", 'w');
		fwrite ($file,  $contenido);
		fclose($file);
		return $fileName;
    }

    
            
}

?>