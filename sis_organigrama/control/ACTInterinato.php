<?php
//session_start();
/**
*@package pXP
*@file gen-ACTInterinato.php
*@author  (admin)
*@date 20-05-2014 20:01:24
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
class ACTInterinato extends ACTbase{
	        
	  
	function listarMisSuplentes(){
        $this->objParam->defecto('ordenacion','id_interinato');

        $this->objParam->defecto('dir_ordenacion','asc');
        
        //obtiene el cargo del usuario logueado de la variabl ede sesion
        if($_SESSION["ss_id_cargo"]==''){
            throw new Exception("Usted no tiene cargo asignado");     
        } 
        
        $this->objParam->addFiltro("int.id_cargo_titular = ".$_SESSION["ss_id_cargo"]);    
        
        
        if($this->objParam->getParametro('id_cargo_suplente')!=''){
            $this->objParam->addFiltro("int.id_cargo_suplente = ".$this->objParam->getParametro('id_cargo_suplente'));    
        }
        
        //if($this->objParam->getParametro('estado_reg')=='activo'){
                
            $this->objParam->addFiltro(" now()::Date BETWEEN  int.fecha_ini  and int.fecha_fin "); 
            $this->objParam->addFiltro(" now()::Date BETWEEN uoft.fecha_asignacion and COALESCE(uoft.fecha_finalizacion,now()::Date)");
			$this->objParam->addFiltro(" now()::Date BETWEEN uofs.fecha_asignacion and COALESCE(uofs.fecha_finalizacion,now()::Date)");
        //}
        
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODInterinato','listarInterinato');
        } else{
            $this->objFunc=$this->create('MODInterinato');
            
            $this->res=$this->objFunc->listarInterinato($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }      
			
	function listarInterinato(){
	     $this->objParam->defecto('ordenacion','id_interinato');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_cargo_suplente')!=''){
            $this->objParam->addFiltro("int.id_cargo_suplente = ".$this->objParam->getParametro('id_cargo_suplente'));    
        }
        
       // if($this->objParam->getParametro('estado_reg')=='activo'){
            $this->objParam->addFiltro(" now()::Date BETWEEN  int.fecha_ini  and int.fecha_fin ");    
            $this->objParam->addFiltro(" now()::Date BETWEEN uoft.fecha_asignacion and COALESCE(uoft.fecha_finalizacion,now()::Date)");   
			$this->objParam->addFiltro(" now()::Date BETWEEN uofs.fecha_asignacion and COALESCE(uofs.fecha_finalizacion,now()::Date)");
        
        //}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODInterinato','listarInterinato');
		} else{
			$this->objFunc=$this->create('MODInterinato');
			
			$this->res=$this->objFunc->listarInterinato($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarInterinato(){
		$this->objFunc=$this->create('MODInterinato');	
		if($this->objParam->insertar('id_interinato')){
			$this->res=$this->objFunc->insertarInterinato($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarInterinato($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
	
						
	function eliminarInterinato(){
			$this->objFunc=$this->create('MODInterinato');	
		$this->res=$this->objFunc->eliminarInterinato($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function asignarMiSuplente(){
	            
	   if($_SESSION["ss_id_cargo"]==''){
	        throw new Exception("Usted no tiene cargo asignado");     
	   }    
	    
	    //id_cargo_titular    
	   $this->objParam->addParametro('id_cargo_titular',$_SESSION["ss_id_cargo"]);    
	   
	   //var_dump($_SESSION["ss_id_cargo"]);
	   //exit;
	   
	   $this->objFunc=$this->create('MODInterinato');  
	   
       $this->res=$this->objFunc->insertarInterinato($this->objParam);         
      
       
       $this->res->imprimirRespuesta($this->res->generarJson());
    }
	
	function aplicarInterinato(){
        $this->objFunc=$this->create('MODInterinato');  
        $this->res=$this->objFunc->aplicarInterinato($this->objParam);
       
        if($this->res->getTipo()!='ERROR'){
                
            //si el cambio fue exitoso cambiamos los valores de neustras variables de session   
            $this->datos=$this->res->getDatos();           
            $_SESSION["autentificado"] = "SI";
            $_SESSION["ss_id_usuario_ai"] = $_SESSION["ss_id_usuario"];
            $_SESSION["_NOM_USUARIO_AI"] = $_SESSION["_NOM_USUARIO"];
            $_SESSION["ss_id_usuario"] = $this->datos['id_usuario'];
            $_SESSION["ss_id_funcionario"] = $this->datos['id_funcionario'];
            $_SESSION["ss_id_cargo"] = $this->datos['id_cargo'];
            $_SESSION["ss_id_persona"] = $this->datos['id_persona'];
            $_SESSION["_SESION"]->setIdUsuario($this->datos['id_usuario']);
            //cambia el estado del Objeto de sesion activa
            $_SESSION["_SESION"]->setEstado("activa");  
            
            $mres = new Mensaje();
            if($_SESSION["_OFUSCAR_ID"]=='si'){
                $id_usuario_ofus = $mres->ofuscar(($this->datos['id_usuario']));
                $id_funcionario_ofus = $mres->ofuscar(($this->datos['id_funcionario']));
            }
            else{
                $id_usuario_ofus = $this->datos['id_usuario'];
                $id_funcionario_ofus = $this->datos['id_funcionario'];
            }
            
            $_SESSION["_CONT_ALERTAS"] = $this->datos['cont_alertas'];
            $_SESSION["_CONT_INTERINO"] = $this->datos['cont_interino'];
            $_SESSION["_NOM_USUARIO"] = $this->datos['nombre']." ".$this->datos['apellido_paterno']." ".$this->datos['apellido_materno'];
            $_SESSION["_ID_USUARIO_OFUS"] = $id_usuario_ofus;
            $_SESSION["_ID_FUNCIOANRIO_OFUS"] = $id_funcionario_ofus;
            $_SESSION["_AUTENTIFICACION"] = $this->datos['autentificacion'];
            $_SESSION["_ESTILO_VISTA"] = $this->datos['estilo'];      
                
            
        }
        
        
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
			
}

?>