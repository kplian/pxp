<?php
//include_once '../../../lib/lib_control/session_secure.inc.php';
//session_secure();  
include('../../../lib/lib_control/CTSesion.php');
session_start();
include(dirname(__FILE__).'/../../../lib/DatosGenerales.php');
if($_SESSION["_FORSSL"]==="SI"){
	session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,true ,false);
}
else{
	session_set_cookie_params (0,$_SESSION["_FOLDER"], '' ,false ,false);
}
//iniciamos las variables para la DOS
$_SESSION["_IN_PILA"]=1;
$_SESSION["_PILA"][1]='';
if ($_SESSION["_FORSSL"]==="SI" &&  $_SERVER['SERVER_PORT']!='443') { 
	// Fuerza SSL en esta página 
	header("Location:https://".$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF']); 
}
if(!isset($_SESSION["_SESION"])){
       $_SESSION["_SESION"]= new CTSesion();
	   $nueva_sesion=true; 
	   $estado_sesion='inactiva';
}else{
	 $estado_sesion=$_SESSION["_SESION"]->getEstado();
	 $nueva_sesion=false;
	
}
?>
<html lang="es">
<head>
 <title>KPLIAN - WEB</title>
	<meta http-equiv="Content-Type" content="charset=UTF-8;text/html; " />	
	<meta name="language" content="es"/>
	<meta name="author" content="Rensi Arteaga Copari" />
	<meta name="subject" content="rensi4rn@gmail.com" />
<meta name="application-name" content="TI Capacitación - Diplomado: Fundamentos de HTML5"/>
<meta name="msapplication-window" content="width=1024;height=768"/>
<link rel="icon" type="image/x-icon" href="/favicon.ico" />

	  <!-- overrides to base library  -->
 <link rel="stylesheet" type="text/css" href="../../../lib/ux/statusbar/css/statusbar.css" />
 <!-- componentes extendidos  -->	   
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/gridfilters/css/GridFilters.css" />
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/gridfilters/css/RangeMenu.css" />

   <link rel="stylesheet" type="text/css" href="../../../lib/ux/statusbar/css/statusbar.css" />
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/AwesomeCombo/static/css/Ext.ux.AwesomeCombo.css" />
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/fileuploadfield/css/fileuploadfield.css" />
    
   <link rel="stylesheet" type="text/css" href="resources/docs.css"></link>
   <link rel="stylesheet" type="text/css" href="resources/style.css"></link>

   <link rel="stylesheet" type="text/css" href="../../../lib/ext3/resources/css/ext-all.css"/>
   <link rel="stylesheet" type="text/css" href="../../../lib/imagenes/<?php echo $_SESSION['_ESTILO_MENU'];?>/menus.css"/>


	<!-- GC -->
</head>
<body scroll="no" id="docs">
 
<div id="loading-mask" style=""></div>
  <div id="loading">
    <div class="loading-indicator"><img src="../../../lib/images/bigrotation2.gif" width="32" height="32" style="margin-right:8px;" align="absmiddle"/>Cargando...</div>
  </div>

  
    <!-- include everything after the loading indicator -->
    <script type="text/javascript" charset="UTF-8" src="../../../lib/ext3/adapter/ext/ext-base-debug.js"></script>
    <!--
    <script type="text/javascript" charset="UTF-8" src="../../../lib/ext3/ext-debug.js"></script>
    <script type="text/javascript" charset="UTF-8" src="../../../lib/ext3/builds/ext-core.js"></script>
    -->
    <script type="text/javascript" charset="UTF-8" src="../../../lib/ext3/ext-all-debug.js"></script>
    
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
     
     <!--   <script type="text/javascript" src="resources/TaskBar.js"></script> -->
     <script language="JavaScript" src="../../../lib/cifrado/rsa_test/BigInt.js"></script>
	 <script language="JavaScript" src="../../../lib/cifrado/rsa_test/Barrett.js"></script>
	   <script type="text/javascript" src="../../../lib/cifrado/EncriptacionPrivada.js"></script>
     <!-- status bar -->
      <script type="text/javascript" src="../../../lib/ux/statusbar/StatusBar.js"></script>
	
    
     <!-- para filtro en grillas -->
     
    <script type="text/javascript" src="../../../lib/ux/gridfilters/menu/ListMenu.js"></script>
	<script type="text/javascript" src="../../../lib/ux/gridfilters/menu/RangeMenu.js"></script>
	
	<script type="text/javascript" src="../../../lib/ux/gridfilters/GridFilters.js"></script>
	
	<script type="text/javascript" src="../../../lib/ux/gridfilters/filter/Filter.js"></script>
	<script type="text/javascript" src="../../../lib/ux/gridfilters/filter/StringFilter.js"></script>
	<script type="text/javascript" src="../../../lib/ux/gridfilters/filter/DateFilter.js"></script>
	<script type="text/javascript" src="../../../lib/ux/gridfilters/filter/ListFilter.js"></script>
	<script type="text/javascript" src="../../../lib/ux/gridfilters/filter/NumericFilter.js"></script>
	<script type="text/javascript" src="../../../lib/ux/gridfilters/filter/BooleanFilter.js"></script>
	<script type="text/javascript" src="../../../lib/ux/RowEditor.js"></script>
	<!--
	<script type="text/javascript" src="../../../lib/ux/treegrid/TreeGridSorter.js"></script>
    <script type="text/javascript" src="../../../lib/ux/treegrid/TreeGridColumnResizer.js"></script>
    <script type="text/javascript" src="../../../lib/ux/treegrid/TreeGridNodeUI.js"></script>
    <script type="text/javascript" src="../../../lib/ux/treegrid/TreeGridLoader.js"></script>
    <script type="text/javascript" src="../../../lib/ux/treegrid/TreeGridColumns.js"></script>
    <script type="text/javascript" src="../../../lib/ux/treegrid/TreeGrid.js"></script>
    
   -->
    <script type="text/javascript" src="../../../lib/ux/GMapPanel.js"></script>
    <!-- componentes extendidos  -->	  
    <script type="text/javascript" src="../../../lib/ux/AwesomeCombo/static/js/Ext.ux.PagingMemoryProxy.js"></script>
	<script type="text/javascript" src="../../../lib/ux/AwesomeCombo/static/js/Ext.ux.AwesomeCombo.js"></script>
	<script type="text/javascript" src="../../../lib/ux/fileuploadfield/FileUploadField.js"></script>
	 <!-- componentes extendidos propios -->	  
	<script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/addcmp/TrigguerCombo.js'></script>    
	<script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/addcmp/ComboRec.js'></script>   
    <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/addcmp/ComboMultiple.js'></script>  
    <script type="text/javascript" src="../../../lib/ext3/TabCloseMenu.js"></script>
    <script type="text/javascript" charset="UTF-8" src="resources/Phx.CP.js"></script>
    <?php
     echo "<script type=\"text/javascript\" charset=\"UTF-8\" src=\"resources/Phx.CP.main.php?nueva_sesion=false&estado_sesion=".$estado_sesion."\"></script>";  
	?>
	 <!-- tipo de interfaces -->
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/baseInterfaz.js'></script>
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/gridInterfaz.js'></script>
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/arbInterfaz.js'></script>
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/frmInterfaz.js'></script>
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/gmapInterfaz.js'></script>
     
  <!--  <script src="http://maps.google.com/maps?file=api&amp;v=3&amp;sensor=false&amp;key=ABQIAAAAl-hZOf33Gms5pu2iwFTemxTHJbrJ9LYRs0WMg05wOxvXuMe0hhQLWPMv9ORdFvvZKSR3tbliwK4dMA" type="text/javascript"></script>-->
    <div id="header">
	<img src="../../../lib/images/extjs.gif" style="float:right;margin-right:0px;margin-top:0px;"/>
   <img src="../../../lib/images/postgres.gif"  style="margin-left:0px;margin-top:2px;"/>	
   </div>

   
  <div id="classes"></div>
  <div id="main"></div>
  <div id="x-tab">
  <div id="x-tab-panel"></div>
  <div class="x-clear"></div>
	
	
</div>
<!-- div para cargar interfaces requeridas para herencia-->
<div id="4rn"></div>

  


  </body>
</html>