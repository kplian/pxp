<?php
/**
*@package pXP
*@file gen-ACTTabla.php
*@author  (admin)
*@date 07-05-2014 21:39:40
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
    ISSUE            FECHA            AUTHOR                     DESCRIPCION
 * #145             08/06/2020      EGS                     Se agrego comillas simples al nombre del array por que php 7 da conflictos si no especificas con comillas
 * #ISE-1           22/10/2023      RAC                     se agega utilitarios getNombreSesion para manejar detalle-modal
*/
include_once __DIR__ . '/../modelo/utilidades.php';
class ACTTabla extends ACTbase{


    function listarTablaCombo(){
        $nombreSess =  getNombreSesion('_wf_ins_',$this->objParam);
        //obtiene la posicion de la tabla instanciada
        $_SESSION[$nombreSess] = $this->obtenerTablaInstancia();
        $id_maestro = $_SESSION[$nombreSess]['atributos']['vista_campo_maestro'];
        $codigo_tabla = $_SESSION[$nombreSess]['atributos']['bd_codigo_tabla'];
        
        //si existe como parametro el id del maestro se anade el filtro
        if ($this->objParam->getParametro($id_maestro) != '') {            
            $this->objParam->addFiltro($codigo_tabla . "." . $id_maestro  . " = ". $this->objParam->getParametro($id_maestro));
        }
        
        if ($this->objParam->getParametro('filtro_directo') != '') {            
            $this->objParam->addFiltro($this->objParam->getParametro('filtro_directo'));
        }
        
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTabla','listarTablaCombo');
        } else{
            $this->objFunc=$this->create('MODTabla');            
            $this->res=$this->objFunc->listarTablaCombo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }    
            
    function listarTablaInstancia(){
        $nombreSess =      getNombreSesion('_wf_ins_',$this->objParam);

        //var_dump($_SESSION);
        //print_r($_SESSION);
        //exit();
        //obtiene la posicion de la tabla instanciada
        $_SESSION[$nombreSess] = $this->obtenerTablaInstancia();
        $id_maestro = $_SESSION[$nombreSess]['atributos']['vista_campo_maestro'];
        $codigo_tabla = $_SESSION[$nombreSess]['atributos']['bd_codigo_tabla'];
        
        //si existe como parametro el id del maestro se anade el filtro
        if ($this->objParam->getParametro($id_maestro) != '') {            
            $this->objParam->addFiltro($codigo_tabla . "." . $id_maestro  . " = ". $this->objParam->getParametro($id_maestro));
        }
        
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTabla','listarTablaInstancia');
        } else{
            $this->objFunc=$this->create('MODTabla');            
            $this->res=$this->objFunc->listarTablaInstancia($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function insertarTablaInstancia(){
        $nombreSess =      getNombreSesion('_wf_ins_',$this->objParam);
        $this->objFunc=$this->create('MODTabla');    
        //obtiene la posicion de la tabla instanciada
        $_SESSION[$nombreSess] = $this->obtenerTablaInstancia();
        
        if($this->objParam->insertar('id_' . $_SESSION[$nombreSess]['atributos']['bd_nombre_tabla'])){
            $this->res=$this->objFunc->insertarTablaInstancia($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarTablaInstancia($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function eliminarTablaInstancia(){
        $this->objFunc=$this->create('MODTabla');
        $aux = $this->objParam->getParametro('0');
        $nombreSess = getNombreSesion('_wf_ins_',$this->objParam,$aux);
        $_SESSION[$nombreSess] = $this->obtenerTablaInstancia();


        $this->res=$this->objFunc->eliminarTablaInstancia($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function listarTabla(){
        $this->objParam->defecto('ordenacion','id_tabla');

        $this->objParam->defecto('dir_ordenacion','asc');
        if ($this->objParam->getParametro('id_tipo_proceso') != '') {
            $this->objParam->addFiltro("TABLA.id_tipo_proceso = ". $this->objParam->getParametro('id_tipo_proceso'));
        }
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTabla','listarTabla');
        } else{
            $this->objFunc=$this->create('MODTabla');
            
            $this->res=$this->objFunc->listarTabla($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarTabla(){
        $this->objFunc=$this->create('MODTabla');    
        if($this->objParam->insertar('id_tabla')){
            $this->res=$this->objFunc->insertarTabla($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarTabla($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function ejecutarScriptTabla(){
        $this->objFunc=$this->create('MODTabla');    
                
        $this->res=$this->objFunc->ejecutarScriptTabla($this->objParam);
        
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarTabla(){
        $this->objFunc=$this->create('MODTabla');    
        $this->res=$this->objFunc->eliminarTabla($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function cargarDatosTablaProceso(){

        $nombreSess =      getNombreSesion('_wf_',$this->objParam);
        $this->objParam->defecto('ordenacion','id_tabla');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objParam->addFiltro("tp.codigo = ''". $this->objParam->getParametro('tipo_proceso')."''");
        $this->objParam->addFiltro("TABLA.vista_id_tabla_maestro is null");
        
        
        $this->objFunc=$this->create('MODTabla');
            
        $this->res=$this->objFunc->cargarDatosTablaProceso();
        //var_dump($this->res->getDatos());exit;
        $_SESSION[$nombreSess] = $this->res->getDatos();
        
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    //RAC 2023
    function cargarDatosTablaDetalleProceso(){
        $nombreSess =  getNombreSesion('_wf_',$this->objParam);
        $this->objParam->defecto('ordenacion','id_tabla');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objParam->addFiltro("tp.codigo = ''". $this->objParam->getParametro('tipo_proceso')."''");
        $this->objParam->addFiltro("TABLA.id_tabla = ".$this->objParam->getParametro('id_tabla'));


        $this->objFunc=$this->create('MODTabla');

        $this->res=$this->objFunc->cargarDatosTablaProceso();
        //var_dump($this->res->getDatos());exit;
        $_SESSION[$nombreSess] = $this->res->getDatos();

        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function obtenerTablaInstancia ($prof=array()) {
        if ($this->objParam->esMatriz()) {
            $aux = $this->objParam->getParametro('0');
            $nombreSess =  getNombreSesion('_wf_',$this->objParam,$aux);
            $cadena = '$_SESSION["'.$nombreSess.'"][0]';
            $id_tabla = $aux['id_tabla'];
        } else {
            $nombreSess =  getNombreSesion('_wf_',$this->objParam);
            $cadena = '$_SESSION["'.$nombreSess.'"][0]';
            $id_tabla = $this->objParam->getParametro('id_tabla');
        }
        
        $res = 0 ;

        foreach ($prof as $value) {
            $cadena .=  "['detalles'][$value]"; //#145
        }
        eval('$variable = '. $cadena . ';');        
                        
        if ($variable['atributos']['id_tabla'] == $id_tabla) {
            return $variable;
        } else {
            if (is_array($variable['detalles'])) { //RAC 2023, valida si es array
                for ($i = 0; $i < count($variable['detalles']); $i++) {
                    array_push($prof, $i);
                    $res = $this->obtenerTablaInstancia($prof);
                    if ($res != 0) {
                        return $res;
                    }
                }
            }
            return 0;
        }
    }            
}

?>