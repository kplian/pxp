<?php
/**
*@package pXP
*@file gen-ACTArchivo.php
*@author  (admin)
*@date 05-12-2016 15:04:48
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTArchivo extends ACTbase{    
			
	function listarArchivo(){
		$this->objParam->defecto('ordenacion','id_archivo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODArchivo','listarArchivo');
		} else{
			$this->objFunc=$this->create('MODArchivo');
			
			$this->res=$this->objFunc->listarArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarArchivo(){
		$this->objFunc=$this->create('MODArchivo');	
		if($this->objParam->insertar('id_archivo')){
			$this->res=$this->objFunc->insertarArchivo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarArchivo(){
			$this->objFunc=$this->create('MODArchivo');	
		$this->res=$this->objFunc->eliminarArchivo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function eliminarArchivo2(){
			$this->objFunc=$this->create('MODArchivo');
		$this->res=$this->objFunc->eliminarArchivo2($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function subirArchivo(){
		$this->objFunc=$this->create('MODArchivo');
		$this->res=$this->objFunc->subirArchivo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function subirArchivoMultiple(){
		$this->objFunc=$this->create('MODArchivo');
		$this->res=$this->objFunc->subirArchivoMultiple($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarArchivoCodigo(){
		// tipar.tabla = 'ttipo_archivo' and (ar.id_tabla = 1 or ar.id_tabla is NULL )
		$this->objParam->addFiltro("tipar.tabla = ''".$this->objParam->getParametro('tabla')."'' ");
		$this->objParam->addFiltro("arch.id_archivo_fk is null ");
		$this->objParam->addFiltro(" (arch.id_tabla = ".$this->objParam->getParametro('id_tabla')." or arch.id_tabla is NULL )  ");


		$this->objFunc=$this->create('MODArchivo');
		$this->res=$this->objFunc->listarArchivoCodigo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarArchivoHistorico(){
		// tipar.tabla = 'ttipo_archivo' and (ar.id_tabla = 1 or ar.id_tabla is NULL )


		$this->objFunc=$this->create('MODArchivo');
		$this->res=$this->objFunc->listarArchivoHistorico($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}



    function listarArchivoTabla(){


        if($this->objParam->getParametro('filtros') != ''){

            $datos = json_decode($this->objParam->getParametro('filtros'));

            if(count($datos) >0){

                foreach ($datos as $key=> $dato) {


                    if($dato->tipo_filtro == 'igual'){
                        $this->objParam->addFiltro(" ".$dato->campo." = ''".$dato->valor."'' ");

                    }else if($dato->tipo_filtro == 'busqueda'){
                        $this->objParam->addFiltro(" upper(".$dato->campo.") LIKE  upper(''%".$dato->valor."%'') ");

                    }



                }

            }


        }


        $this->objFunc=$this->create('MODArchivo');
        $this->res=$this->objFunc->listarArchivoTabla($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

			
}

?>