<?php
/***
 Nombre: MODFunBasicas.php
 Proposito: Contener todas las funcionalidades basicas del sistema que requieren acceso a la basede datos y
 * que puedan ser llamados desde el control o modelo
 Autor:	Kplian (JRR)
 Fecha:	13/03/2019
 */
 
class MODFunBasicas
{   
    /* Nombre : getVariableGlobal
	 * Descripcion: Obtiene una varibale global del sistema a partir del codigo. Lanzara una excepcion
	 * en caso de que la varibale global no exista
	 * Autor:	Kplian (JRR)
	 * Fecha:	13/03/2019
	 */
    public static function getVariableGlobal($codigo)
    {
        $cone=new conexion();
        $consulta = "select * from pxp.variable_global where variable = '" . $codigo . "'" ;
		$existe = 'no';
		$valor = '';
		
		$link=$cone->conectarSegu();
		if($res = pg_query($link,$consulta)){
		 	while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC))
			{
				$valor = $row['valor'];
				$existe = 'si';
			}
				
			//Libera la memoria
			pg_free_result($res);
			if ($existe == 'no') {
				throw new Exception("Variable global no existente en al tabla pxp.variable_global : $codigo",2);
			}
		}		
		return $valor;
    }
}