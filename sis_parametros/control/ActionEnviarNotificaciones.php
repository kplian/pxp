<?php
/***
 * Nombre: ActionEnviarNotificaciones.php
 * Proposito:  Enviar Notificaciones para telefenos moviles
 * Autor:    valvarado
 * Fecha:    09/04/2020
 */
include_once(dirname(__FILE__) . "/../../lib/lib_control/CTSesion.php");
session_start();
$session = new CTSesion();
$session->setIdUsuario(1);
$_SESSION["_SESION"] = $session;
$_SESSION["ss_id_usuario"] = 1;
include(dirname(__FILE__) . '/../../lib/DatosGenerales.php');
include_once(dirname(__FILE__) . '/../../lib/lib_general/Errores.php');
ob_start();
$_SESSION["_CANTIDAD_ERRORES"] = 0;

include_once(dirname(__FILE__) . '/../../lib/lib_control/CTincludes.php');
include_once(dirname(__FILE__) . '/../../lib/Fcm.php');
include_once(dirname(__FILE__) . '/../../sis_parametros/modelo/MODNotificaciones.php');

$objPostData = new CTPostData();
$arr_unlink = array();
$aPostData = $objPostData->getData();

$_SESSION["_PETICION"] = serialize($aPostData);
function send_notificacion($token, $title, $message, $data = array())
{
    $fcm = new Fcm();
    $fcm->setTo($token);
    $fcm->setTitle($title);
    $fcm->setBody($message);
    $fcm->setData($data);
    $p = $fcm->send();
    return $p;
}

$objParam = new CTParametro($aPostData['p'], null, $aPostFiles);
$objParam->defecto('ordenacion', 'fecha_reg');
$objParam->defecto('dir_ordenacion', 'desc');
$objParam->addParametro('id_usuario', 1);
$objParam->parametros_consulta['filtro'] = ' 0 = 0 ';
$objParam->addFiltro(" noti.enviado = ''no'' ");
$objFunc = new MODNotificaciones($objParam);
$res = $objFunc->listar();
if ($res->getTipo() == 'ERROR') {
    echo 'Se ha producido un error-> Mensaje Técnico:' . $res->getMensajeTec();
    exit;
}
$notification = [];
foreach ($res->datos as $dato) {
    $rs = send_notificacion($dato['token'], $dato['title'], $dato['body'], array(
        "id" => $dato['id_registro'],
        "id_estado_wf" => $dato['id_estado_wf'],
        "id_proceso_wf" => $dato['id_proceso_wf'],
        "modulo" => $dato['modulo'],
        "esquema" => $dato['esquema'],
        "nombre_vista" => $dato['nombre_vista']));
    $result = json_decode($rs, true);
    if ($result['success'] === 1) {
        $notification [] = array(
            'id' => (string)$dato['id'],
            'enviado' => 'si'
        );
    }
}
$objParam = new CTParametro($aPostData['p'], null, $aPostFiles);
$json = json_encode($notification);
$objParam->addParametro('notificaciones', $json);
$objParam->addParametro('id_usuario', 1);

$objFunc = new MODNotificaciones($objParam);
$res2 = $objFunc->modificar();
if ($res2->getTipo() == 'ERROR') {
    echo 'Se ha producido un error-> Mensaje Técnico:' . $res2->getMensajeTec();
    exit;
}

$res2->imprimirRespuesta($res2->generarJson());
?>