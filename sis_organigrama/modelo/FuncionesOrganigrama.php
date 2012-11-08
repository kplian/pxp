<?php
class FuncionesOrganigrama
{
	function __construct()
	{
		foreach (glob('../../sis_organigrama/modelo/MOD*.php') as $archivo){
			include_once($archivo);
		}	
		
	}
		
	function listarParametroRhum(CTParametro $parametro){
		$parametro_rhum=new  MODParametroRhum($parametro);
		$res=$parametro_rhum->listarParametroRhum();
		return $res;
	}
	
	function insertarParametroRhum(CTParametro $parametro){
		$parametro_rhum=new  MODParametroRhum($parametro);
		$res=$parametro_rhum->insertarParametroRhum();
		return $res;
	}
	
	function modificarParametroRhum(CTParametro $parametro){
		$parametro_rhum=new  MODParametroRhum($parametro);
		$res=$parametro_rhum->modificarParametroRhum();
		return $res;
	}
	
	function eliminarParametroRhum(CTParametro $parametro){
		$parametro_rhum=new  MODParametroRhum($parametro);
		$res=$parametro_rhum->eliminarParametroRhum();
		return $res;
	}
	
	//----------------------FUNCIONARIO----------------//
	
	function listarFuncionario(CTParametro $parametro){
		$funcionario=new  MODFuncionario($parametro);
		$res=$funcionario->listarFuncionario();
		return $res;
	}
	
	function insertarFuncionario(CTParametro $parametro){
		$funcionario=new  MODFuncionario($parametro);
		$res=$funcionario->insertarFuncionario();
		return $res;
	}
	
	function modificarFuncionario(CTParametro $parametro){
		$funcionario=new  MODFuncionario($parametro);
		$res=$funcionario->modificarFuncionario();
		return $res;
	}
	
	function eliminarFuncionario(CTParametro $parametro){
		$funcionario=new  MODFuncionario($parametro);
		$res=$funcionario->eliminarFuncionario();
		return $res;
	}
	
	
	//----------------------TIPO COLUMNA----------------//
	
	function listarTipoColumna(CTParametro $parametro){
		$tipo_columna=new  MODTipoColumna($parametro);
		$res=$tipo_columna->listarTipoColumna();
		return $res;
	}
	
	function insertarTipoColumna(CTParametro $parametro){
		$tipo_columna=new  MODTipoColumna($parametro);
		$res=$tipo_columna->insertarTipoColumna();
		return $res;
	}
	
	function modificarTipoColumna(CTParametro $parametro){
		$tipo_columna=new  MODTipoColumna($parametro);
		$res=$tipo_columna->modificarTipoColumna();
		return $res;
	}
	
	function eliminarTipoColumna(CTParametro $parametro){
		$tipo_columna=new  MODTipoColumna($parametro);
		$res=$tipo_columna->eliminarTipoColumna();
		return $res;
	}
//----------------------TIPO OBLIGACION----------------//
	
	function listarTipoObligacion(CTParametro $parametro){
		$tipo_obligacion=new  MODTipoObligacion($parametro);
		$res=$tipo_obligacion->listarTipoObligacion();
		return $res;
	}
	
	function insertarTipoObligacion(CTParametro $parametro){
		$tipo_obligacion=new  MODTipoObligacion($parametro);
		$res=$tipo_obligacion->insertarTipoObligacion();
		return $res;
	}
	
	function modificarTipoObligacion(CTParametro $parametro){
		$tipo_obligacion=new  MODTipoObligacion($parametro);
		$res=$tipo_obligacion->modificarTipoObligacion();
		return $res;
	}
	
	function eliminarTipoObligacion(CTParametro $parametro){
		$tipo_obligacion=new  MODTipoObligacion($parametro);
		$res=$tipo_obligacion->eliminarTipoObligacion();
		return $res;
	}
	
	/*Clase: MODEstructuraUo
	* Fecha: 2010
	* Autor: admin*/
	function listarEstructuraUo(CTParametro $parametro){
		$estructura_uo=new  MODEstructuraUo($parametro);
		$res=$estructura_uo->listarEstructuraUo();
		return $res;
	}
	
	function insertarEstructuraUo(CTParametro $parametro){
		$estructura_uo=new  MODEstructuraUo($parametro);
		$res=$estructura_uo->insertarEstructuraUo();
		return $res;
	}
	
	function modificarEstructuraUo(CTParametro $parametro){
		$estructura_uo=new  MODEstructuraUo($parametro);
		$res=$estructura_uo->modificarEstructuraUo();
		return $res;
	}
	
	function eliminarEstructuraUo(CTParametro $parametro){
		$estructura_uo=new  MODEstructuraUo($parametro);
		$res=$estructura_uo->eliminarEstructuraUo();
		return $res;
	}
	/*FinClase: MODEstructuraUo*/
	
	/*Clase: MODUoFuncionario
	* Fecha: 2010
	* Autor: admin*/
	function listarUoFuncionario(CTParametro $parametro){ 
		$uo_funcionario=new  MODUoFuncionario($parametro);
		$res=$uo_funcionario->listarUoFuncionario();
		return $res;
	}
	
	function insertarUoFuncionario(CTParametro $parametro){
		$uo_funcionario=new  MODUoFuncionario($parametro);
		$res=$uo_funcionario->insertarUoFuncionario();
		return $res;
	}
	
	function modificarUoFuncionario(CTParametro $parametro){
		$uo_funcionario=new  MODUoFuncionario($parametro);
		$res=$uo_funcionario->modificarUoFuncionario();
		return $res;
	}
	
	function eliminarUoFuncionario(CTParametro $parametro){
		$uo_funcionario=new  MODUoFuncionario($parametro);
		$res=$uo_funcionario->eliminarUoFuncionario();
		return $res;
	}
	/*FinClase: MODUoFuncionario*/
	
	/*Clase: MODUo
	* Fecha: 2010
	* Autor: admin*/
	function listarUo(CTParametro $parametro){ 
		$uo=new MODUo($parametro);
		$res=$uo->listarUo();
		return $res;
	}
	

	function listarUoFiltro(CTParametro $parametro){
		$uo=new MODUo($parametro);
		$res=$uo->listarUoFiltro();
		return $res;
	}
	
	/*FinClase: MODUo*/
	
	/*Clase: MODDepto
	* Fecha: 2011
	* Autor: mzm*/
	function ValidaDepto(CTParametro $parametro){
		$depto=new MODDepto($parametro);
		$res=$depto->ValidaDepto();
		return $res;
	}
	
	function listarDepto(CTParametro $parametro){
		$depto=new  MODDepto($parametro);
		$res=$depto->listarDepto();
		return $res;
	}
	
	function insertarDepto(CTParametro $parametro){
		$depto=new  MODDepto($parametro);
		$res=$depto->insertarDepto();
		return $res;
	}
	
	function modificarDepto(CTParametro $parametro){
		$depto=new  MODDepto($parametro);
		$res=$depto->modificarDepto();
		return $res;
	}
	
	function eliminarDepto(CTParametro $parametro){
		$depto=new  MODDepto($parametro);
		$res=$depto->eliminarDepto();
		return $res;
	}
	/*FinClase: MODDepto*/
	
	/*Clase: MODDeptoUo
	* Fecha: 19-10-2011 12:59:45
	* Autor: mzm*/
	function listarDeptoUo(CTParametro $parametro){
		$obj=new MODDeptoUo($parametro);
		$res=$obj->listarDeptoUo();
		return $res;
	}
			
	function insertarDeptoUo(CTParametro $parametro){
		$obj=new MODDeptoUo($parametro);
		$res=$obj->insertarDeptoUo();
		return $res;
	}
			
	function modificarDeptoUo(CTParametro $parametro){
		$obj=new MODDeptoUo($parametro);
		$res=$obj->modificarDeptoUo();
		return $res;
	}
			
	function eliminarDeptoUo(CTParametro $parametro){
		$obj=new MODDeptoUo($parametro);
		$res=$obj->eliminarDeptoUo();
		return $res;
	}
	
	/*Clase: MODDeptoUsuario
	* Fecha: 24-11-2011 18:26:47
	* Autor: mzm*/
	function listarDeptoUsuario(CTParametro $parametro){
		$obj=new MODDeptoUsuario($parametro);
		$res=$obj->listarDeptoUsuario();
		return $res;
	}
			
	function insertarDeptoUsuario(CTParametro $parametro){
		$obj=new MODDeptoUsuario($parametro);
		$res=$obj->insertarDeptoUsuario();
		return $res;
	}
			
	function modificarDeptoUsuario(CTParametro $parametro){
		$obj=new MODDeptoUsuario($parametro);
		$res=$obj->modificarDeptoUsuario();
		return $res;
	}
			
	function eliminarDeptoUsuario(CTParametro $parametro){
		$obj=new MODDeptoUsuario($parametro);
		$res=$obj->eliminarDeptoUsuario();
		return $res;
	}
	/*FinClase: MODDeptoUsuario*/
	
	/*Clase: MODTipoHorario
	* Fecha: 17-08-2012 16:28:19
	* Autor: admin*/
	function listarTipoHorario(CTParametro $parametro){
		$obj=new MODTipoHorario($parametro);
		$res=$obj->listarTipoHorario();
		return $res;
	}
			
	function insertarTipoHorario(CTParametro $parametro){
		$obj=new MODTipoHorario($parametro);
		$res=$obj->insertarTipoHorario();
		return $res;
	}
			
	function modificarTipoHorario(CTParametro $parametro){
		$obj=new MODTipoHorario($parametro);
		$res=$obj->modificarTipoHorario();
		return $res;
	}
			
	function eliminarTipoHorario(CTParametro $parametro){
		$obj=new MODTipoHorario($parametro);
		$res=$obj->eliminarTipoHorario();
		return $res;
	}
	/*FinClase: MODTipoHorario*/
	
	/*Clase: MODEspecialidad
    * Fecha: 07-11-2012 18:26:47
    * Autor: Gonzalo Sarmiento Sejas*/
	function listarEspecialidad(CTParametro $parametro){
        $obj=new MODEspecialidad($parametro);
        $res=$obj->listarEspecialidad();
        return $res;
    }
            
    function insertarEspecialidad(CTParametro $parametro){
        $obj=new MODEspecialidad($parametro);
        $res=$obj->insertarEspecialidad();
        return $res;
    }
            
    function modificarEspecialidad(CTParametro $parametro){
        $obj=new MODEspecialidad($parametro);
        $res=$obj->modificarEspecialidad();
        return $res;
    }
            
    function eliminarEspecialidad(CTParametro $parametro){
        $obj=new MODEspecialidad($parametro);
        $res=$obj->eliminarEspecialidad();
        return $res;
    }
	
	/*Clase: MODEspecialidadNivel
	* Fecha: 26-08-2012 00:05:28
	* Autor: admin*/
	function listarEspecialidadNivel(CTParametro $parametro){
		$obj=new MODEspecialidadNivel($parametro);
		$res=$obj->listarEspecialidadNivel();
		return $res;
	}
			
	function insertarEspecialidadNivel(CTParametro $parametro){
		$obj=new MODEspecialidadNivel($parametro);
		$res=$obj->insertarEspecialidadNivel();
		return $res;
	}
			
	function modificarEspecialidadNivel(CTParametro $parametro){
		$obj=new MODEspecialidadNivel($parametro);
		$res=$obj->modificarEspecialidadNivel();
		return $res;
	}
			
	function eliminarEspecialidadNivel(CTParametro $parametro){
		$obj=new MODEspecialidadNivel($parametro);
		$res=$obj->eliminarEspecialidadNivel();
		return $res;
	}
	/*FinClase: MODEspecialidadNivel*/

}

?>