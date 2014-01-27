<?php
/**
*@package pXP
*@file Actividad.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar el listado de bloqueos de usuario, IP, MAC, etc.
*/
include_once(dirname(__FILE__)."/CTSesion.php");
session_start();
include(dirname(__FILE__).'/../../../lib/DatosGenerales.php');
header("content-type: text/javascript; charset=UTF-8");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script>
Phx.vista.tabInicial=Ext.extend(Ext.util.Observable,{
constructor: function(config){}
})
</script>
</head>
<body  bgcolor="#FFFFFF">
<table width="100%" border="0" bgcolor="#FFFFFF"  height="100%" background="<?php  echo $_SESSION['_DIR_IMAGEN_INI']?>">  
  <!--
  <tr height="70%">
    <td colspan="2"><div align="center"><img src="../../../sis_seguridad/vista/inicio/logos/image001.gif" width="347" height="200" /></div></td>
  </tr>
  -->
  
    	<?php echo $_SESSION['_PLANTIILA'];?>
      
  <tr height="20%">
    <td colspan="2"><div align="center"><font color="white"><a  href="http://www.kplian.com/"   TARGET="_new" >Powered by KPLIAN LTDA</a></font></div></td>
  </tr>
</table>
</body>




