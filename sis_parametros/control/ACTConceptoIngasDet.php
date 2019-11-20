<?php
/**
*@package pXP
*@file gen-ACTConceptoIngasDet.php
*@author  (admin)
*@date 22-07-2019 14:37:28
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
  ISSUE			AUTHOR			FECHA				DESCRIPCION
 * #39 ETR		EGS				31/07/2019			Creacion
 * #61          Egs             12/09/2019          Bug con el puntero e columnas dinamicas
 * #71          EGS             17/10/2019          filtra los que no tienen tension
 */

class ACTConceptoIngasDet extends ACTbase{    
			
	function listarConceptoIngasDet(){
        $this->objParam->defecto('ordenacion','id_concepto_ingas_det');

        //guardamos las los parmetros originales de la consulta
        $ordenacion=$this->objParam->parametros_consulta['ordenacion'];
        $dir_ordenacion= $this->objParam->parametros_consulta['dir_ordenacion'];
        $puntero   = $this->objParam->parametros_consulta['puntero'];//#61
        $cantidad = $this->objParam->parametros_consulta['cantidad'];
        $filtro = $this->objParam->parametros_consulta['filtro'];
        //seteamos los parmetros para recuperar las columnas originales
        $this->objParam->parametros_consulta['ordenacion'] = 'nombre_columna';//#61
        $this->objParam->parametros_consulta['dir_ordenacion'] = 'ASC';//#61
        $this->objParam->parametros_consulta['puntero'] = '0';//#61
        $this->objParam->parametros_consulta['cantidad'] = '50';
        $this->objParam->parametros_consulta['filtro']= '0=0';
        $this->objFunc=$this->create('MODColumna');//#61
        $this->res=$this->objFunc->listarColumna($this->objParam);
        $datos = $this->res->datos;
        //añadimos las columnas dinamicas como un parametro
        $this->objParam->addParametro('columnas',$datos);
        //recuperamos los parametros originales de la consulta
        $this->objParam->parametros_consulta['ordenacion'] = $ordenacion;//#61
        $this->objParam->parametros_consulta['dir_ordenacion']=$dir_ordenacion;//#61
        $this->objParam->parametros_consulta['puntero'] = $puntero;//#61
        $this->objParam->parametros_consulta['cantidad'] = $cantidad;
        $this->objParam->parametros_consulta['filtro'] = $filtro;
        if($this->objParam->getParametro('id_concepto_ingas')!='' ){
            $this->objParam->addFiltro("coind.id_concepto_ingas = ".$this->objParam->getParametro('id_concepto_ingas'));
        }
        if($this->objParam->getParametro('agrupador') !='' ){
            $this->objParam->addFiltro("coind.agrupador = ''".$this->objParam->getParametro('agrupador')."''");
        }
        if($this->objParam->getParametro('tension_macro') !='' ){
            $this->objParam->addFiltro("coind.tension in (''".$this->objParam->getParametro('tension_macro')."'',''todas'','''')");//#71
        }
		$this->objParam->defecto('dir_ordenacion','asc');



        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODConceptoIngasDet','listarConceptoIngasDet');
		} else{
			$this->objFunc=$this->create('MODConceptoIngasDet');
			
			$this->res=$this->objFunc->listarConceptoIngasDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function insertarConceptoIngasDet(){


        $ordenacion=$this->objParam->parametros_consulta['ordenacion'];
        $dir_ordenacion= $this->objParam->parametros_consulta['dir_ordenacion'];
        $puntero   = $this->objParam->parametros_consulta['puntero'];//#61
        $cantidad = $this->objParam->parametros_consulta['cantidad'];
        //seteamos los parmetros para recuperar las columnas originales
        $this->objParam->parametros_consulta['ordenacion'] = 'nombre_columna';//#61
        $this->objParam->parametros_consulta['dir_ordenacion'] = 'ASC';//#61
        $this->objParam->parametros_consulta['puntero'] = '0';//#61
        $this->objParam->parametros_consulta['cantidad'] = '1000';//#61
        $this->objFunc=$this->create('MODColumna');//#61
        $this->res=$this->objFunc->listarColumna($this->objParam);
        $datos = $this->res->datos;
        //añadimos las columnas dinamicas como un parametro
        $this->objParam->addParametro('columnas',$datos);
        //recuperamos los parametros originales de la consulta
        $this->objParam->parametros_consulta['ordenacion'] = $ordenacion;//#61
        $this->objParam->parametros_consulta['dir_ordenacion']=$dir_ordenacion;//#61
        $this->objParam->parametros_consulta['puntero'] = $puntero;//#61
        $this->objParam->parametros_consulta['cantidad'] = $cantidad;//#61
        $this->objFunc=$this->create('MODConceptoIngasDet');
		if($this->objParam->insertar('id_concepto_ingas_det')){
			$this->res=$this->objFunc->insertarConceptoIngasDet($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarConceptoIngasDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarConceptoIngasDet()
    {
        $this->objFunc = $this->create('MODConceptoIngasDet');
        $this->res = $this->objFunc->eliminarConceptoIngasDet($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function listarConceptoIngasDetCombo(){
        $this->objParam->defecto('ordenacion','id_concepto_ingas_det');
        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('agrupador') !='' ){
            $this->objParam->addFiltro("coind.agrupador = ''".$this->objParam->getParametro('agrupador')."''");
        }
        if($this->objParam->getParametro('id_concepto_ingas')!='' ){
            $this->objParam->addFiltro("coind.id_concepto_ingas = ".$this->objParam->getParametro('id_concepto_ingas'));
        }
        $this->objFunc=$this->create('MODConceptoIngasDet');
        $this->res=$this->objFunc->listarConceptoIngasDetCombo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	
			
}

?>