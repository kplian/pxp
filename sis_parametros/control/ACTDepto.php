<?php
/***
 Nombre: ACTDepartamento.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tdepartamento 
 Autor:	Kplian
 Fecha:	04/06/2011
 */
class ACTDepto extends ACTbase{    

	function listarDepto(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','depto');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if( $this->objParam->getParametro('modulo') != '' ) {
			$this->objParam->addFiltro("DEPPTO.modulo = ''".$this->objParam->getParametro('modulo')."''");
		}

        if( $this->objParam->getParametro('prioridad') != '' ) {
            $this->objParam->addFiltro("DEPPTO.prioridad = ".$this->objParam->getParametro('prioridad'));
        }
		
		if( $this->objParam->getParametro('id_depto_origen') != '' ) {
			$this->objParam->addFiltro("deppto.id_depto in (select dd.id_depto_destino  from param.tdepto_depto dd where dd.id_depto_origen  = ".$this->objParam->getParametro('id_depto_origen').")");
		}
		
		
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODDepto','listarDepto');
		}
		else {
			$this->objFunSeguridad=$this->create('MODDepto');
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarDepto($this->objParam);
			
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function listarDeptoFiltradoDeptoUsuario(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','depto');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if( $this->objParam->getParametro('id_lugar') != '' ) {
			$this->objParam->addFiltro( '('.$this->objParam->getParametro('id_lugar')."::integer =ANY(DEPPTO.id_lugares)  or prioridad = 0)");
		}
		
		if( $this->objParam->getParametro('modulo') != '' ) {
			$this->objParam->addFiltro("DEPPTO.modulo = ''".$this->objParam->getParametro('modulo')."''");
		}
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODDepto','listarDeptoCombo');
		}
		else {
			$this->objFunSeguridad=$this->create('MODDepto');
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarDeptoFiltradoDeptoUsuario($this->objParam);
			
		}
		
		if($this->objParam->getParametro('_adicionar')!=''){
		    
			$respuesta = $this->res->getDatos();
			
										
		    array_unshift ( $respuesta, array(  'id_depto'=>'0',
		                                'codigo'=>'Todos',
									    'nombre'=>'Todos',
										'nombre_corto'=>'Todos',
										'id_subsistema'=>'Todos',
										'estado_reg'=>'Todos',
										'desc_subsistema'=>'Todos'));
			$this->res->setDatos($respuesta);
		}		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarDeptoFiltradoXUsuario(){

        // parametros de ordenacion por defecto
        $this->objParam->defecto('ordenacion','depto');
        $this->objParam->defecto('dir_ordenacion','asc');
        
        if( $this->objParam->getParametro('id_lugar') != '' ) {
			$this->objParam->addFiltro( '('.$this->objParam->getParametro('id_lugar')."::integer =ANY(DEPPTO.id_lugares)  or prioridad = 0)");
		}
		
		if( $this->objParam->getParametro('modulo') != '' ) {
			$this->objParam->addFiltro("DEPPTO.modulo = ''".$this->objParam->getParametro('modulo')."''");
		}
		
		
        if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte=new Reporte($this->objParam, $this);
            $this->res=$this->objReporte->generarReporteListado('MODDepto','listarDeptoFiltradoXUsuario');
        }
        else {
            $this->objFunSeguridad=$this->create('MODDepto');
            //ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
            $this->res=$this->objFunSeguridad->listarDeptoFiltradoXUsuario($this->objParam);
            
        }
        
        $this->res->imprimirRespuesta($this->res->generarJson());
        
        
    }

	function listarDeptoFiltradoXUO(){
		
	}
    
	
	
	
	function insertarDepto(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODDepto');
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_depto')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarDepto($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarDepto($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarDepto(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODDepto');	
		$this->res=$this->objFunSeguridad->eliminarDepto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	
	
	
	

}

?>