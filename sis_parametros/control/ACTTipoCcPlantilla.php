<?php
/**
*@package pXP
*@file gen-ACTTipoCc.php
*@author  (admin)
*@date 26-05-2017 10:10:19
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoCcPlantilla extends ACTbase{

		function listarTipoCcPlantilla(){
			$this->objParam->defecto('ordenacion','id_tipo_cc_plantilla');
			$this->objParam->defecto('dir_ordenacion','asc');

            if($this->objParam->getParametro('solo_raices')=='si'){
                $this->objParam->addFiltro("tccp.id_tipo_cc_fk is null");
            }

			if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
				$this->objReporte = new Reporte($this->objParam,$this);
				$this->res = $this->objReporte->generarReporteListado('MODTipoCcPlantilla','listarTipoCcPlantilla');
			} else{
				$this->objFunc=$this->create('MODTipoCcPlantilla');

				$this->res=$this->objFunc->listarTipoCcPlantilla($this->objParam);
			}
			$this->res->imprimirRespuesta($this->res->generarJson());
		}


	function listarTipoCcArbPlantilla(){

        //obtiene el parametro nodo enviado por la vista
        $node=$this->objParam->getParametro('node');

        $id_cuenta=$this->objParam->getParametro('id_tipo_cc_plantilla');
        $tipo_nodo=$this->objParam->getParametro('tipo_nodo');


        if($node=='id'){
            $this->objParam->addParametro('id_padre','%');
        }
        else {
            $this->objParam->addParametro('id_padre',$id_tipo_cc_plantilla);
        }

		$this->objFunc=$this->create('MODTipoCcPlantilla');
        $this->res=$this->objFunc->listarTipoCcArbPlantilla();

        $this->res->setTipoRespuestaArbol();

        $arreglo=array();

        array_push($arreglo,array('nombre'=>'id','valor'=>'id_tipo_cc_plantilla'));
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

   function insertarTipoCcArbPlantilla(){
		$this->objFunc=$this->create('MODTipoCcPlantilla');
		if($this->objParam->insertar('id_tipo_cc_plantilla')){
			$this->res=$this->objFunc->insertarTipoCcArbPlantilla($this->objParam);
		} else{
			$this->res=$this->objFunc->modificarTipoCcArbPlantilla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}


	function eliminarTipoCcArbPlantilla(){
		$this->objFunc=$this->create('MODTipoCcPlantilla');
		$this->res=$this->objFunc->eliminarTipoCcArbPlantilla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarTipoCcArbPlantillaPadre(){
		$this->objFunc=$this->create('MODTipoCcPlantilla');
		$this->res=$this->objFunc->listarTipoCcArbPlantillaPadre();
		$this->res->imprimirRespuesta($this->res->generarJson());

		}

	}

?>