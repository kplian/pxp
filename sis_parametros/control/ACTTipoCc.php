<?php
/**
*@package pXP
*@file gen-ACTTipoCc.php
*@author  (admin)
*@date 26-05-2017 10:10:19
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
* ISSUE			FECHA			AUTHOR			DESCRIPCION
  #2			07/12/2018		EGS				Funcion para listar centros de costo de tipo transsaccionale del arbol Tipo CC por gestion
 #155           14/08/2020      YMR             Bitacora exportable en PDF Y CSV
 */

require_once(dirname(__FILE__) . '/../reportes/RTipoCcXls.php');
require_once(dirname(__FILE__).'/../reportes/RTipoCcPdf.php');

class ACTTipoCc extends ACTbase{

	function listarTipoCc(){
		$this->objParam->defecto('ordenacion','id_tipo_cc');

		$this->objParam->defecto('dir_ordenacion','asc');

		if($this->objParam->getParametro('gestion')!=''){
            $this->objParam->addFiltro("( tcc.gestion_ini <= ".$this->objParam->getParametro('gestion').' and '.$this->objParam->getParametro('gestion').' <= COALESCE(tcc.gestion_fin,'.$this->objParam->getParametro('gestion').'))');

        }


		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoCc','listarTipoCc');
		} else{
			$this->objFunc=$this->create('MODTipoCc');

			$this->res=$this->objFunc->listarTipoCc($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

   function listarTipoCcAll(){
		$this->objParam->defecto('ordenacion','id_tipo_cc');

		$this->objParam->defecto('dir_ordenacion','asc');


		if($this->objParam->getParametro('movimiento')!=''){
            $this->objParam->addFiltro(" tcc.movimiento = ''".$this->objParam->getParametro('movimiento')."'' ");

        }

        if($this->objParam->getParametro('control_techo')!=''){
            $this->objParam->addFiltro(" tcc.control_techo = ''".$this->objParam->getParametro('control_techo')."'' ");

        }

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoCc','listarTipoCcAll');
		} else{
			$this->objFunc=$this->create('MODTipoCc');

			$this->res=$this->objFunc->listarTipoCcAll($this->objParam);
		}


		if($this->objParam->getParametro('_adicionar')!=''){

			$respuesta = $this->res->getDatos();
			array_unshift ( $respuesta, array(  'id_tipo_cc'=>'0',
		                                'descripcion'=>'Todos',
		                                'codigo'=>'Todos',
									    'tipo'=>'Todos'));
		    //var_dump($respuesta);
			$this->res->setDatos($respuesta);
		}

		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarTipoCcArb(){

        //obtiene el parametro nodo enviado por la vista
        $node=$this->objParam->getParametro('node');

        $id_cuenta=$this->objParam->getParametro('id_tipo_cc');
        $tipo_nodo=$this->objParam->getParametro('tipo_nodo');


        if($node=='id'){
            $this->objParam->addParametro('id_padre','%');
        }
        else {
            $this->objParam->addParametro('id_padre',$id_tipo_cc);
        }

		$this->objFunc=$this->create('MODTipoCc');
        $this->res=$this->objFunc->listarTipoCcArb();

        $this->res->setTipoRespuestaArbol();

        $arreglo=array();

        array_push($arreglo,array('nombre'=>'id','valor'=>'id_tipo_cc'));
        array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_tipo_cc_fk'));


        array_push($arreglo,array('nombre'=>'text','valores'=>'<b> #nro_cuenta# - #nombre_cuenta#</b>'));
        array_push($arreglo,array('nombre'=>'cls','valor'=>'nombre_cuenta'));
        array_push($arreglo,array('nombre'=>'qtip','valores'=>'<b> #nro_cuenta#</b><br/><b> #nombre_cuenta#</b><br> #desc_cuenta#'));


        $this->res->addNivelArbol('tipo_nodo','raiz',array('leaf'=>false,
                                                        'allowDelete'=>true,
                                                        'allowEdit'=>true,
                                                        'cls'=>'folder',
                                                        'tipo_nodo'=>'raiz',
                                                        'icon'=>'../../../lib/imagenes/a_form.png'),
                                                        $arreglo);

        /*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
          es importante que entre los resultados devueltos por la base exista la variable\
          tipo_dato que tenga el valor en texto = 'hoja' */


         $this->res->addNivelArbol('tipo_nodo','hijo',array(
                                                        'leaf'=>false,
                                                        'allowDelete'=>true,
                                                        'allowEdit'=>true,
                                                        'tipo_nodo'=>'hijo',
                                                        'icon'=>'../../../lib/imagenes/a_form.png'),
                                                        $arreglo);


		$this->res->addNivelArbol('tipo_nodo','hoja',array(
                                                        'leaf'=>true,
                                                        'allowDelete'=>true,
                                                        'allowEdit'=>true,
                                                        'tipo_nodo'=>'hoja',
                                                        'icon'=>'../../../lib/imagenes/a_table_gear.png'),
                                                        $arreglo);


        $this->res->imprimirRespuesta($this->res->generarJson());

   }

   function insertarTipoCcArb(){
		$this->objFunc=$this->create('MODTipoCc');
		if($this->objParam->insertar('id_tipo_cc')){
			$this->res=$this->objFunc->insertarTipoCcArb($this->objParam);
		} else{
			$this->res=$this->objFunc->modificarTipoCcArb($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}


	function eliminarTipoCcArb(){
		$this->objFunc=$this->create('MODTipoCc');
		$this->res=$this->objFunc->eliminarTipoCcArb($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	/////EGS-I-16/08/2018//////////////
	function  agregarPlantilla(){
		$this->objFunc=$this->create('MODTipoCc');	
	    $this->res=$this->objFunc->agregarPlantilla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function asignarAutorizacion(){

		$this->objFunc=$this->create('MODTipoCc');
	    $this->res=$this->objFunc->asignarAutorizacion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			//#1				07/12/2018		EGS	
	 function listarTipoCcArbHijos(){
		$this->objParam->defecto('ordenacion','id_tipo_cc');

		$this->objParam->defecto('dir_ordenacion','asc');
 		
		//var_dump($this->objParam);
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoCc','listarTipoCcArbHijos');
		} else{
			$this->objFunc=$this->create('MODTipoCc');

			$this->res=$this->objFunc->listarTipoCcArbHijos($this->objParam);
		}

    	$this->res->imprimirRespuesta($this->res->generarJson());
	}
	//#1				07/12/2018		EGS	

    function recuperarEntrega()
    {
        $this->objFunc = $this->create('MODTipoCc');
        $cbteHeader = $this->objFunc->recuperarTipoCc($this->objParam);
        if ($cbteHeader->getTipo() == 'EXITO') {
            return $cbteHeader;
        } else {
            $cbteHeader->imprimirRespuesta($cbteHeader->generarJson());
            exit;
        }
    }

    function reporteTipoCc()
    {
        if($this->objParam->getParametro('formato_reporte')=='pdf'){
            $nombreArchivo = uniqid(md5(session_id()).'Bitacora') . '.pdf';
        }
        else{
            $nombreArchivo = uniqid(md5(session_id()) . 'Bitacora') . '.xls';
        }

        $dataSource = $this->recuperarEntrega();

        //parametros basicos
        $tamano = 'LETTER';
        $orientacion = 'L';
        $titulo = 'Bitacora';

        $this->objParam->addParametro('orientacion', $orientacion);
        $this->objParam->addParametro('tamano', $tamano);
        $this->objParam->addParametro('titulo_archivo', $titulo);
        $this->objParam->addParametro('nombre_archivo', $nombreArchivo);


        //Instancia la clase de pdf
        if($this->objParam->getParametro('formato_reporte')=='pdf'){
            $reporte = new RTipoCcPdf($this->objParam);
            $reporte->datosHeader($dataSource->getDatos());
            $reporte->generarReporte();
            $reporte->output($reporte->url_archivo,'F');
        }
        else{
            $reporte = new REntregaXls($this->objParam);
            $reporte->datosHeader($dataSource->getDatos(), $this->objParam->getParametro('id_tipo_cc'));
            $reporte->generarReporte();
        }

        $this->mensajeExito = new Mensaje();
        $this->mensajeExito->setMensaje('EXITO', 'Reporte.php', 'Reporte generado', 'Se generó con éxito el reporte: ' . $nombreArchivo, 'control');
        $this->mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());

    }
}

?>