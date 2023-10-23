<?php
/**
 *@package pXP
 *@file utilidades.php
 *@author  rac
 *@date 22-10-2023
 *@description   utilidades para funciones comunes ulizdas en el control y modelo del WF
 */

function getNombreSesion( $prefijo, $objParam, $aux=null ){
    //$prefijo   coudl be _wf_ins_ or _wf
    if ($aux === null) {
        $id_tabla = $objParam->getParametro('id_tabla');
        if (isset($id_tabla) && $id_tabla !== null) {
            $nombre = $prefijo . $objParam->getParametro('tipo_proceso') . '_'. $id_tabla . '_' . $objParam->getParametro('tipo_estado');
        } else{
            $nombre = $prefijo . $objParam->getParametro('tipo_proceso') . '_' . $objParam->getParametro('tipo_estado');
        }

    } else {
        $id_tabla = $aux['id_tabla'];
        if (isset($id_tabla) && $id_tabla !== null) {
            $nombre = $prefijo . $aux['tipo_proceso'] . '_' . $id_tabla . '_' . $aux['tipo_estado'];
        } else {
            $nombre = $prefijo . $aux['tipo_proceso'] . '_' . $aux['tipo_estado'];
        }

    }
    return $nombre;
}



?>