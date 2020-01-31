<?php
/***
Nombre: ACTReporte.php
Proposito: Clase de Control para recibir los parametros enviados por los archivos
de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tsubsistema
Autor:	Kplian
Fecha:	01/07/2010
 * 	ISSUE			AUTHOR				FECHA					DESCRIPCION
 */
require_once(dirname(__FILE__).'/../reportes/RReporteIssuesXLS.php');
class ACTReporte extends ACTbase{

    function ReporteIssues(){
        $this->objFunc = $this->create('MODReporte');
        $this->res = $this->objFunc->reporteGitHub($this->objParam);
        $titulo = 'Reporte';
        $nombreArchivo = uniqid(md5(session_id()) . $titulo);
        $nombreArchivo .= '.xls';
        $this->objParam->addParametro('nombre_archivo', $nombreArchivo);
        $this->objParam->addParametro('datos', $this->res->datos);
        $this->objReporteFormato = new RReporteIssuesXLS($this->objParam);
        $this->objReporteFormato->generarDatos();
        $this->objReporteFormato->generarReporte();
        $this->mensajeExito = new Mensaje();
        $this->mensajeExito->setMensaje('EXITO', 'Reporte.php', 'Reporte generado','Se generó con éxito el reporte: ' . $nombreArchivo, 'control');
        $this->mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());
    }
    function getData($org,$repo){
        $request = 'https://api.github.com/repos/'.$org.'/'.$repo.'/issues?state=all';
        $session = curl_init($request);
        curl_setopt($session, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($session, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'User-Agent: request')
        );
        $result = curl_exec($session);
        curl_close($session);
        $respuesta = json_decode($result);
        $array_issues = array();
        foreach ($respuesta as $value){
            $data = json_decode(json_encode($value), true);
            $array_issues[] = array(
                "url" => (string)$data['url'],
                "repository_url" => (string)$data['repository_url'],
                "comments_url" => (string)$data['comments_url'],
                "number" => (string)$data['number'] ,
                "title" => (string)$data['title'],
                "user" =>  array(
                    "login" => $data['user']['login'],
                    "url" => $data['user']['url']
                ),
                "state"=> (string)$data['state'],
                "created_at"=> (string)$data['created_at'],
                "updated_at"=> (string)$data['updated_at']
            );
        }

        $commits = $this->onCommits($org,$repo);
        // var_dump($commits);exit;
        $data = array();
        $data[] = array(
            'issues' => $array_issues,
            'commits'=> $commits,
        );
        return $data;
    }
    function onCommits($org,$repo){
        $request = 'https://api.github.com/repos/'.$org.'/'.$repo.'/commits';
        $session = curl_init($request);
        curl_setopt($session, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($session, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'User-Agent: request')
        );
        $result = curl_exec($session);
        curl_close($session);
        $respuesta = json_decode($result);
        // var_dump($request);exit;
        $array_commits= array();
        foreach ($respuesta as $value){
            $data = json_decode(json_encode($value), true);
            $array = explode(" ", $data["commit"]["message"]);
            $int = 0;
            if (count($array)>0){
                foreach ($array as $value){
                    if (strpos($value, '#') !== false) {
                        $int = (int) filter_var($value, FILTER_SANITIZE_NUMBER_INT);
                        break;
                    }
                }
            } else {
                throw new Exception("No no.. Error", 3);
            }
            $array_commits[] = array(
                'name' => $data["commit"]["author"]['name'],
                'email'=> $data["commit"]["author"]['email'],
                'date' => $data["commit"]["author"]['date'],
                'message'=> $data["commit"]["message"],
                'number'=> $int
            );
        }
        return $array_commits;
    }
    function listarRepositorio($org){
        $request = 'https://api.github.com/users/'.$org.'/repos';
        $session = curl_init($request);
        curl_setopt($session, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($session, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'User-Agent: request')
        );
        $result = curl_exec($session);
        curl_close($session);
        $respuesta = json_decode($result);
        $array_repos = array();
        foreach ($respuesta as $value){
            $data = json_decode(json_encode($value), true);
            $array_repos []= array(
                "id" => (string)$data['id'],
                "name" => (string)$data['name'],
                "full_name" => (string)$data['full_name'],
                "created_at" => (string)$data['created_at'],
                "default_branch" => (string)$data['default_branch']
            );
        }
        return $array_repos;
    }
    function listarRepo(){
        $this->objParam->defecto('ordenacion','id_subsistema');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objFunc=$this->create('MODReporte');
        $this->res=$this->objFunc->listarRepo($this->objParam);
        if($this->objParam->getParametro('_adicionar')!=''){
            $respuesta = $this->res->getDatos();
            array_unshift ( $respuesta, array(
                'id_subsistema'=>'0',
                'nombre'=>'Todos',
                'organizacion_git'=>'Todos'));
            $this->res->setDatos($respuesta);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function listarBranch(){
        $this->objParam->defecto('ordenacion','id_branches');
        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('id_subsistema') != '') {
            $this->objParam->addFiltro("id_subsistema=".$this->objParam->getParametro('id_subsistema'));
        }
        $this->objFunc=$this->create('MODReporte');
        $this->res=$this->objFunc->listarBranch($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
}

?>

