<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTGrupoIdioma.php
*@author  (admin)
*@date 21-04-2020 02:29:46
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                21-04-2020 02:29:46    admin             Creacion    
  #
*****************************************************************************************/

class ACTGrupoIdioma extends ACTbase{    
            
    function listarGrupoIdioma(){
        $this->objParam->defecto('ordenacion','id_grupo_idioma');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODGrupoIdioma','listarGrupoIdioma');
        } else{
            $this->objFunc=$this->create('MODGrupoIdioma');
            
            $this->res=$this->objFunc->listarGrupoIdioma($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarGrupoIdioma(){
        $this->objFunc=$this->create('MODGrupoIdioma');    
        if($this->objParam->insertar('id_grupo_idioma')){
            $this->res=$this->objFunc->insertarGrupoIdioma($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarGrupoIdioma($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarGrupoIdioma(){
        $this->objFunc=$this->create('MODGrupoIdioma');    
        $this->res=$this->objFunc->eliminarGrupoIdioma($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function exportarDatosGrupo(){
        
        //crea el objetoFunProcesoMacro que contiene todos los metodos del sistema de workflow
        $this->objFunProcesoMacro=$this->create('MODGrupoIdioma');        
        
        $this->res = $this->objFunProcesoMacro->exportarDatosGrupo();
        
        if($this->res->getTipo()=='ERROR'){
            $this->res->imprimirRespuesta($this->res->generarJson());
            exit;
        }
        
        $nombreArchivo = $this->crearArchivoExportacion($this->res);
        
        $this->mensajeExito=new Mensaje();
        $this->mensajeExito->setMensaje('EXITO','Reporte.php','Se genero con exito el sql'.$nombreArchivo,
                                        'Se genero con exito el sql'.$nombreArchivo,'control');
        $this->mensajeExito->setArchivoGenerado($nombreArchivo);
        
        $this->res->imprimirRespuesta($this->mensajeExito->generarJson());

    }
    function crearArchivoExportacion($res) {
        $data = $res -> getDatos();
        $fileName = uniqid(md5(session_id()).'ExportDataGrupoTraduccion').'.sql';
        //create file
        $file = fopen("../../../reportes_generados/$fileName", 'w');
        
        $sw_gui = 0;
        $sw_funciones=0;
        $sw_procedimiento=0;
        $sw_rol=0; 
        $sw_rol_pro=0;
        fwrite ($file,"----------------------------------\r\n".
                          "--COPY LINES TO SUBSYSTEM data.sql FILE  \r\n".
                          "---------------------------------\r\n".
                          "\r\n" );
        //var_dump($data);   
        //exit;

        foreach ($data as $row) {            
            if ($row['tipo_reg'] == 'grupo_idioma' ) {
                
                    fwrite ($file, 
                     "select param.f_import_tgrupo_idioma ('insert','".
                             $row['codigo']."', '" . 
                             $row['nombre']."', '" . 
                             $row['tipo']."'," . 
                             $row['estado_reg']."'," . 
                             (is_null($row['nombre_tabla'])?'NULL,':"'".$row['nombre_tabla']."',").
                             (is_null($row['columna_llave'])?'NULL,':"'".$row['columna_llave']."',").
                             (is_null($row['columna_texto_defecto'])?'NULL':"'".$row['columna_texto_defecto']."'").");\r\n");    
                          
            } else if ($row['tipo_reg'] == 'palabra_clave' ) {
                 
                
                    fwrite ($file, 
                     "select wf.f_import_tpalabra_clave ('insert','".
                                $row['estado_reg']."', '" .  
                                $row['codigo']."', '" .  
                                $row['default_text']."', '" .                             
                                $row['codigo_grupo_idioma']."');\r\n"); 
                             
            } else if ($row['tipo_reg'] == 'traduccion') {                    
                    
                    fwrite ($file, 
                     "select wf.f_import_ttraduccion ('insert',".
                             (is_null($row['texto'])?'NULL,':"'".$row['texto']."'") ."," .
                             (is_null($row['estado_reg'])?'NULL,':"'".$row['estado_reg']."'") ."," .
                             (is_null($row['codigo_lenguaje'])?'NULL,':"'".$row['codigo_lenguaje']."'") ."," .
                             (is_null($row['codigo_palabra_clave'])?'NULL,':"'".$row['codigo_palabra_clave']."'") ."," .                             
                             (is_null($row['codigo_grupo'])?'NULL':"'".$row['codigo_grupo']."'") .");\r\n");         
                
            }

        }
        
        return $fileName;
    }
            
}

?>