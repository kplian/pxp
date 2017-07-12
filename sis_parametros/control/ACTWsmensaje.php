<?php
/**
*@package pXP
*@file gen-ACTWsmensaje.php
*@author  (favio.figueroa)
*@date 16-06-2017 21:47:08
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTWsmensaje extends ACTbase{    
			
	function listarWsmensaje(){
		$this->objParam->defecto('ordenacion','id_wsmensaje');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODWsmensaje','listarWsmensaje');
		} else{
			$this->objFunc=$this->create('MODWsmensaje');
			
			$this->res=$this->objFunc->listarWsmensaje($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarWsmensaje(){
		/*$this->objFunc=$this->create('MODWsmensaje');
		if($this->objParam->insertar('id_wsmensaje')){
			$this->res=$this->objFunc->insertarWsmensaje($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarWsmensaje($this->objParam);
		}*/

		$evento = "enviarMensajeUsuario";
		if($this->objParam->getParametro('tipo') == "alert" || $this->objParam->getParametro('tipo') == "notificacion"){
            $evento = "enviarMensajeUsuario";
        }else{
            $evento = "actualizarVistaUsuario";
        }
		//mandamos datos al websocket
        $data = array(
            "mensaje" => $this->objParam->getParametro('mensaje'),
            "tipo_mensaje" => $this->objParam->getParametro('tipo'),
            "titulo" => $this->objParam->getParametro('titulo'),
            "id_usuario" => $this->objParam->getParametro('id_usuario'),
            "destino" => $this->objParam->getParametro('destino'),
            "evento" => $evento
        );

        $send = array(
            "tipo" => "enviarMensajeUsuario",
            "data" => $data
        );

        $usuarios_socket = $this->dispararEventoWS($send);

        $usuarios_socket =json_decode($usuarios_socket, true);

        //var_dump($usuarios_socket);



		//$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarWsmensaje(){
			$this->objFunc=$this->create('MODWsmensaje');	
		$this->res=$this->objFunc->eliminarWsmensaje($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>