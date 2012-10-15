<?php
class FuncionesGenerador
{
	function __construct()
	{
		foreach (glob("../../sis_generador/modelo/MOD*.php") as $archivo){
			include_once($archivo) ;
		}
	}
	
	/**
	 * ***para tablas
	 */
	function listarTabla(CTParametro $parametro){
		$tb=new  MODTabla($parametro);
		$res=$tb->listarTabla();
		return $res;
	}
	function listarTablaCombo(CTParametro $parametro){
		
		$tb=new  MODTabla($parametro);
		$res=$tb->listarTablaCombo();
		return $res;
	}
	
	function insertarTabla(CTParametro $parametro){
		$tb=new  MODTabla($parametro);
		$res=$tb->insertarTabla();
		return $res;
	}
	
	function modificarTabla(CTParametro $parametro){
		$tb=new  MODTabla($parametro);
		$res=$tb->modificarTabla();
		return $res;
	}
	
	function eliminarTabla(CTParametro $parametro){
		$tb=new  MODTabla($parametro);
		$res=$tb->eliminarTabla();
		return $res;
	}
	
	/**
	 * ***para columnas
	 */
	function listarColumna(CTParametro $parametro){
		$tb=new  MODColumna($parametro);
		$res=$tb->listarColumna();
		return $res;
	}
	
	function insertarColumna(CTParametro $parametro){
		$tb=new  MODColumna($parametro);
		$res=$tb->insertarColumna();
		return $res;
	}
	
	function modificarColumna(CTParametro $parametro){
		$tb=new  MODColumna($parametro);
		$res=$tb->modificarColumna();
		return $res;
	}
	
	function eliminarColumna(CTParametro $parametro){
		$tb=new  MODColumna($parametro);
		$res=$tb->eliminarColumna();
		return $res;
	}
	
	function listarDatosColumna(CTParametro $parametro){
		$tb=new  MODColumna($parametro);
		$res=$tb->listarDatosColumna();
		return $res;
	}
	/**
	 * ***para esquema
	 */
	function listarEsquema(CTParametro $parametro){
		$tb=new  MODEsquema($esquema);
		$res=$tb->listarEsquema();
		return $res;
	}
	
}

?>