<?php
/**
*@package pXP
*@file gen-ACTTipoCc.php
*@author  (admin)
*@date 26-05-2017 10:10:19
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

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
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoCc','listarTipoCcAll');
		} else{
			$this->objFunc=$this->create('MODTipoCc');
			
			$this->res=$this->objFunc->listarTipoCcAll($this->objParam);
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
	





}

?>