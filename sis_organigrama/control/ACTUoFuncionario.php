<?php
/***
 Nombre: ACTUoFuncionario.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tuo_funcionario 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTUoFuncionario extends ACTbase{    

	function listarUoFuncionario(){

		//el objeto objParam contiene todas la variables recibidad desde la interfaz
		
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','FUNCIO.desc_funcionario1');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam);
			$this->res=$this->objReporte->generarReporteListado('FuncionesRecursosHumanos','listarUoFuncionario');
		}
		else {
			$this->objFunSeguridad=new FuncionesRecursosHumanos();
			
			//obtiene el parametro nodo enviado por la vista
			$id_uo=$this->objParam->getParametro('id_uo');
			
		 
			
			$this->objParam->addParametro('id_uo',$id_uo);
		
	
		//$this->objParam->addParametro('id_subsistema',$id_subsistema);
			
			
			
			//ejecuta el metodo de lista funcionarios a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarUoFuncionario($this->objParam);
			
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
		
	}
	
	function guardarUoFuncionario(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesRecursosHumanos();
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_uo_funcionario')){

			//ejecuta el metodo de insertar de la clase MODFuncionario a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarUoFuncionario($this->objParam);			
		}
		else{	
			//ejecuta el metodo de modificar funcionario de la clase MODFuncionario a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarUoFuncionario($this->objParam);
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarUoFuncionario(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=new FuncionesRecursosHumanos();	
		$this->res=$this->objFunSeguridad->eliminarUoFuncionario($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());

	}

}

?>