<?php
/***
 Nombre: ACTUo.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tuo 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTUo extends ACTbase{    

	function listarUo(){
		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','FUNCIO.desc_funcionario1');
		$this->objParam->defecto('dir_ordenacion','asc');
		if ($this->objParam->getParametro('correspondencia') != '') {
			$this->objParam->addFiltro("UO.correspondencia = ''".$this->objParam->getParametro('correspondencia')."''");  
		}
		if ($this->objParam->getParametro('id_funcionario_uo_presupuesta') != '') {
			$this->objParam->addFiltro("UO.id_uo = orga.f_get_uo_presupuesta(NULL, ". $this->objParam->getParametro('id_funcionario_uo_presupuesta') .",''" . $this->objParam->getParametro('fecha') . "'')"); 
		}
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('FuncionesRecursosHumanos','listarUo');
		}
		else {
			$this->objFunc=$this->create('MODUo');
			//ejecuta el metodo de lista funcionarios a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunc->listarUo();
			
		}
		
		//imprime respuesta en formato JSON para enviar lo a la interface (vista)
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
}

?>