<?php
include_once(dirname(__FILE__)."/CTEncriptacionPrivada.php");
include_once(dirname(__FILE__)."/CTIntermediario.php");
include_once(dirname(__FILE__)."/CTParametro.php");
include_once(dirname(__FILE__)."/CTPostData.php");
include_once(dirname(__FILE__)."/../lib_modelo/conexion.php");
include_once(dirname(__FILE__)."/../lib_modelo/driver.php");
include_once(dirname(__FILE__)."/../lib_modelo/MODLogError.php");
include_once(dirname(__FILE__)."/../lib_modelo/MODValidacion.php");
include_once(dirname(__FILE__)."/../lib_general/Mensaje.php");
include_once(dirname(__FILE__)."/../lib_general/rss_php.php");
include_once(dirname(__FILE__)."/../cifrado/rsa.class.php");
include_once(dirname(__FILE__)."/../cifrado/feistel.php");
include_once(dirname(__FILE__).'/ACTbase.php');
include_once(dirname(__FILE__).'/../lib_modelo/MODbase.php');
include_once(dirname(__FILE__).'/../rest/PxpRestClient.php');

/*include_once(dirname(__FILE__).'/../../sis_seguridad/control/ACTbaseSeguridad.php');
include_once(dirname(__FILE__).'/../../sis_seguridad/modelo/MODbaseSeguridad.php');*/

include_once(dirname(__FILE__).'/../lib_reporte/Reporte.php');
include_once(dirname(__FILE__).'/../lib_reporte/ReportePDF.php');
include_once(dirname(__FILE__).'/../lib_reporte/ReporteXLS.php');
include_once(dirname(__FILE__).'/../lib_reporte/MostrarReporte.php');
//include_once(dirname(__FILE__).'/../../sis_generador/modelo/FuncionesGenerador.php');
include_once(dirname(__FILE__).'/../FirePHPCore-0.3.2/lib/FirePHPCore/FirePHP.class.php');
include_once(dirname(__FILE__).'/../../sis_seguridad/modelo/MODSesion.php');

//foreach (glob(dirname(__FILE__).'/../../../sis_*/modelo/Funciones*.php') as $archivo){
//	include_once($archivo);
//}

//require_once __DIR__ . "/../../../../vendor/autoload.php";
include_once(dirname(__FILE__).'/../textalk/vendor/autoload.php');

?>
