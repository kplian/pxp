<?php
/**
*@package pXP
*@file gen-ACTCertificadoPlanilla.php
*@author  (miguel.mamani)
*@date 24-07-2017 14:48:34
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
require_once(dirname(__FILE__).'/../reportes/RCertificadoPDF.php');
require_once(dirname(__FILE__).'/../reportes/RCertificadoDOC.php');

class ACTCertificadoPlanilla extends ACTbase{

	function listarCertificadoPlanilla(){
		$this->objParam->defecto('ordenacion','id_certificado_planilla');

        if ($this->objParam->getParametro('pes_estado') == 'borrador') {
            $this->objParam->addFiltro("planc.estado in (''borrador'')");
        }if ($this->objParam->getParametro('pes_estado') == 'emitido') {
            $this->objParam->addFiltro("planc.estado in (''emitido'')");
        }

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCertificadoPlanilla','listarCertificadoPlanilla');
		} else{
			$this->objFunc=$this->create('MODCertificadoPlanilla');
			
			$this->res=$this->objFunc->listarCertificadoPlanilla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCertificadoPlanilla(){

	    if($this->objParam->getParametro('tipo_certificado') == 'Con viáticos de los últimos tres meses') {

            $data = array("empleadoID" => $this->objParam->getParametro('id_funcionario'));
            $data_string = json_encode($data);
            $request = 'http://sms.obairlines.bo/BoAServiceItinerario/servServiceErp.svc/GetPromedioViaticos';
            $session = curl_init($request);
            curl_setopt($session, CURLOPT_CUSTOMREQUEST, "POST");
            curl_setopt($session, CURLOPT_POSTFIELDS, $data_string);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($session, CURLOPT_HTTPHEADER, array(
                    'Content-Type: application/json',
                    'Content-Length: ' . strlen($data_string))
            );
//
            $result = curl_exec($session);
            curl_close($session);
            $respuesta = json_decode($result);
            $resDatos = json_decode($respuesta->GetPromedioViaticosResult, true);
            //var_dump($resDatos["Codigo"]);exit;
            if ($resDatos["Codigo"] == 0) {
                throw new Exception('Error en servicio viaticos.');
            }
            $this->objParam->addParametro('importe_viatico', $resDatos["Resultado"]);
            $this->objFunc = $this->create('MODCertificadoPlanilla');

            if ($this->objParam->insertar('id_certificado_planilla')) {
                $this->res = $this->objFunc->insertarCertificadoPlanilla($this->objParam);
            } else {
                $this->res = $this->objFunc->modificarCertificadoPlanilla($this->objParam);
            }
            $this->res->imprimirRespuesta($this->res->generarJson());
        }else{
            $this->objFunc = $this->create('MODCertificadoPlanilla');

            if ($this->objParam->insertar('id_certificado_planilla')) {
                $this->res = $this->objFunc->insertarCertificadoPlanilla($this->objParam);
            } else {
                $this->res = $this->objFunc->modificarCertificadoPlanilla($this->objParam);
            }
            $this->res->imprimirRespuesta($this->res->generarJson());
        }
	}
						
	function eliminarCertificadoPlanilla(){
			$this->objFunc=$this->create('MODCertificadoPlanilla');	
		$this->res=$this->objFunc->eliminarCertificadoPlanilla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    function siguienteEstado()
    {
        $this->objFunc=$this->create('MODCertificadoPlanilla');
        $this->res=$this->objFunc->siguienteEstado($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function anteriorEstado()
    {
        $this->objFunc=$this->create('MODCertificadoPlanilla');
        $this->res=$this->objFunc->anteriorEstado($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function reporteCertificado(){


        $this->objFunc=$this->create('MODCertificadoPlanilla');
        $this->res=$this->objFunc->reporteCertificado($this->objParam);

        $nombreArchivo = uniqid(md5(session_id()).'[Reporte. Certificado]').'.pdf';
        $this->objParam->addParametro('orientacion','P');
        $this->objParam->addParametro('tamano','LETTER');
        $this->objParam->addParametro('nombre_archivo',$nombreArchivo);

        //llamar servicio recuperar viaticos


        $this->objReporte = new RCertificadoPDF($this->objParam);
        $this->objReporte->setDatos($this->res->datos);
        $this->objReporte->generarReporte();
        $this->objReporte->output($this->objReporte->url_archivo,'F');


        $this->mensajeExito=new Mensaje();
        $this->mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado','Se generó con éxito el reporte: '.$nombreArchivo,'control');
        $this->mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());
    }

    function reporteCertificadoDoc(){

        $this->objFunc=$this->create('MODCertificadoPlanilla');
        $dataSource = $this->objFunc->reporteCertificado();
        $this->dataSource=$dataSource->getDatos();
        $nombreArchivo = uniqid(md5(session_id()).'[Certificado-'.$this->dataSource[0]['nro_tramite'].']').'.docx';
        $reporte = new RCertificadoDOC($this->objParam);
        
        $reporte->datosHeader($dataSource->getDatos());
        $reporte->write(dirname(__FILE__).'/../../../reportes_generados/'.$nombreArchivo);
        //var_dump((dirname(__FILE__).'/../../reportes_generados/'));exit;
        $this->mensajeExito=new Mensaje();
        $this->mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado','Se generó con éxito el reporte: '.$nombreArchivo,'control');
        $this->mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());
    }

}

?>