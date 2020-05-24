<?php
/****************************************************************************************
*@package pXP
*@file gen-MODGrupoIdioma.php
*@author  (admin)
*@date 21-04-2020 02:29:46
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                21-04-2020 02:29:46    admin             Creacion    
  #
*****************************************************************************************/

class MODGrupoIdioma extends MODbase{
    
    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }
            
    function listarGrupoIdioma(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_grupo_idioma_sel';
        $this->transaccion='PM_GRI_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->captura('id_grupo_idioma','int4');
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('tipo','varchar');
        $this->captura('estado_reg','varchar');
        $this->captura('nombre_tabla','varchar');
        $this->captura('id_usuario_ai','int4');
        $this->captura('id_usuario_reg','int4');
        $this->captura('usuario_ai','varchar');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');        
        $this->captura('columna_llave','varchar');  
        $this->captura('columna_texto_defecto','varchar');  
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function insertarGrupoIdioma(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_grupo_idioma_ime';
        $this->transaccion='PM_GRI_INS';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('tipo','tipo','varchar');
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('nombre_tabla','nombre_tabla','varchar');
        $this->setParametro('columna_llave','columna_llave','varchar');
        $this->setParametro('columna_texto_defecto','columna_texto_defecto','varchar');
 

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function modificarGrupoIdioma(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_grupo_idioma_ime';
        $this->transaccion='PM_GRI_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_grupo_idioma','id_grupo_idioma','int4');
        $this->setParametro('codigo','codigo','varchar');
        $this->setParametro('nombre','nombre','varchar');
        $this->setParametro('tipo','tipo','varchar');
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('nombre_tabla','nombre_tabla','varchar');
        $this->setParametro('columna_llave','columna_llave','varchar');
        $this->setParametro('columna_texto_defecto','columna_texto_defecto','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
    function eliminarGrupoIdioma(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_grupo_idioma_ime';
        $this->transaccion='PM_GRI_ELI';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_grupo_idioma','id_grupo_idioma','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function exportarDatosGrupo() {
        
        $this->procedimiento='param.ft_grupo_idioma_sel';
        $this->transaccion='PM_EXPGRUPIDI_SEL';
        $this->tipo_procedimiento='SEL';
        $this->setCount(false);        
        $this->setParametro('id_grupo_idioma','id_grupo_idioma','integer');  //todas llas llamadas comparten el mismo parametros
        
        $this->captura('tipo_reg','varchar');            
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('tipo','varchar');
        $this->captura('estado_reg','varchar');
        $this->captura('nombre_tabla','varchar'); 
        $this->captura('columna_llave','varchar');  
        $this->captura('columna_texto_defecto','varchar');   


        $this->armarConsulta();   
        $this->ejecutarConsulta();          
        ////////////////////////////
        
        
        if($this->respuesta->getTipo()=='ERROR'){
            return $this->respuesta;
        }
        else {
            $this->procedimiento='param.ft_palabra_clave_sel';
            $this->transaccion='PM_EXPPLC_SEL';
            $this->tipo_procedimiento='SEL';
            $this->setCount(false);
            $this->resetCaptura();
            $this->addConsulta();        
            
            $this->captura('tipo_reg','varchar'); 
            $this->captura('estado_reg','varchar');
            $this->captura('codigo','varchar');
            $this->captura('default_text','varchar');            
            $this->captura('codigo_grupo_idioma','varchar');

                                 

            $this->armarConsulta();
            $consulta=$this->getConsulta();            
      
            $this->ejecutarConsulta($this->respuesta);
        }

        if($this->respuesta->getTipo()=='ERROR'){
            return $this->respuesta;
        }
        else {
            $this->procedimiento='param.ft_traduccion_sel';
            $this->transaccion='PM_EXPTRA_SEL';
            $this->tipo_procedimiento='SEL';
            $this->setCount(false);
            $this->resetCaptura();
            $this->addConsulta();        

            $this->captura('tipo_reg','varchar');  
		    $this->captura('texto','varchar');
		    $this->captura('estado_reg','varchar');
            $this->captura('codigo_lenguaje','varchar');
            $this->captura('codigo_palabra_clave','varchar');
            $this->captura('codigo_grupo','varchar');

            $this->armarConsulta();
            $consulta=$this->getConsulta();            
              
            $this->ejecutarConsulta($this->respuesta);
        }
        
        
       return $this->respuesta;        
    
    }

    function listarGrupoIdiomaComun(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='param.ft_grupo_idioma_sel';
        $this->transaccion='PM_GRICMN_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setCount(false);
                
        //Definicion de la lista del resultado del query
        $this->captura('id_grupo_idioma','int4');
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('tipo','varchar');       
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }

    function generarLlaves(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_grupo_idioma_ime';
        $this->transaccion='PM_GENKEYS_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_grupo_idioma','id_grupo_idioma','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
            
}
?>