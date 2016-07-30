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
 <title><?php echo $_SESSION['_NOMBRE_SIS']; ?></title>
	<meta http-equiv="Content-Type" content="charset=UTF-8;text/html; " />	
	<meta name="language" content="es"/>
	<meta name="author" content="Rensi Arteaga Copari" />
	<meta name="subject" content="rensi@kplian.com" />
	<meta name="application-name" content="KERP - KPLIAN"/>
<link rel="icon" type="image/x-icon" href="<?php echo $_SESSION['_DIR_FAV_ICON'] ?>" />

	  <!-- overrides to base library  -->
 <link rel="stylesheet" type="text/css" href="../../../lib/ux/statusbar/css/statusbar.css" />
 <!-- componentes extendidos  -->	   
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/gridfilters/css/GridFilters.css" />
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/gridfilters/css/RangeMenu.css" />

   <link rel="stylesheet" type="text/css" href="../../../lib/ux/statusbar/css/statusbar.css" />
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/AwesomeCombo/static/css/Ext.ux.AwesomeCombo.css" />
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/fileuploadfield/css/fileuploadfield.css" />
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/css/ColumnHeaderGroup.css" />
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/css/GroupSummary.css" />
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/css/gridsummary.css"/>
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/css/RowEditor.css" />
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/treegrid/treegrid.css" />
   

    
   <link rel="stylesheet" type="text/css" href="resources/docs.css"></link>
   <link rel="stylesheet" type="text/css" href="resources/style.css"></link>
   <link rel="stylesheet" type="text/css" href="../../../lib/ux/css/Portal.css" />

   <link rel="stylesheet" type="text/css" href="../../../lib/ext3/resources/css/ext-all.css"/>
  
   <link rel="stylesheet" type="text/css" href="../../../lib/imagenes/<?php echo $_SESSION['_ESTILO_MENU'];?>/menus.css"/>
   <style type="text/css" media="screen">
		    html, body{
		        margin:0px;
		        padding:0px;
		        height:100%;
		        overflow:hidden;
		    }   
    </style>
    
    <link rel="stylesheet" type="text/css" href="../../../lib/imagenes/font-awesome-4.2.0/css/font-awesome.css"/>


	<!-- GC -->
</head>
<body  style="background:#ffffff url('<?php echo $_SESSION['_DIR_BACKGROUND_LOGIN']?>') no-repeat center center;">
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
    <!--   
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
     
     	
     	
     	<script type="text/javascript" src="resources/TaskBar.js"></script> -->
     
     <script language="JavaScript" src="../../../lib/cifrado/rsa_test/BigInt.js"></script>
	 <script language="JavaScript" src="../../../lib/cifrado/rsa_test/Barrett.js"></script>
	 <script type="text/javascript" src="../../../lib/AES/js-mcrypt/md5.js"></script>
	 <script type="text/javascript" src="../../../lib/cifrado/EncriptacionPrivada.js"></script>
     <!-- status bar -->
      <script type="text/javascript" src="../../../lib/ux/statusbar/StatusBar.js"></script>
      <script type="text/javascript" src="../../../lib/ux/SearchField.js"></script>
	
    
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
	<script type="text/javascript" src="../../../lib/ux/RowExpander.js"></script>
	<script type="text/javascript" src="../../../lib/ux/GridSummary.js"></script>
	<script type="text/javascript" src="../../../lib/ux/GroupSummary.js"></script>
	
	<script type="text/javascript" src="../../../lib/ux/Portal.js"></script>
    <script type="text/javascript" src="../../../lib/ux/PortalColumn.js"></script>
    <script type="text/javascript" src="../../../lib/ux/Portlet.js"></script>
    	
	<script type="text/javascript" src="../../../lib/ux/treegrid/TreeGridSorter.js"></script>
    <script type="text/javascript" src="../../../lib/ux/treegrid/TreeGridColumnResizer.js"></script>
    <script type="text/javascript" src="../../../lib/ux/treegrid/TreeGridNodeUI.js"></script>
    <script type="text/javascript" src="../../../lib/ux/treegrid/TreeGridLoader.js"></script>
    <script type="text/javascript" src="../../../lib/ux/treegrid/TreeGridColumns.js"></script>
    <script type="text/javascript" src="../../../lib/ux/treegrid/TreeGrid.js"></script>
    
   
    <script type="text/javascript" src="../../../lib/ux/GMapPanel.js"></script>
    <!-- componentes extendidos  -->	  
    <script type="text/javascript" src="../../../lib/ux/AwesomeCombo/static/js/Ext.ux.PagingMemoryProxy.js"></script>
	<script type="text/javascript" src="../../../lib/ux/AwesomeCombo/static/js/Ext.ux.AwesomeCombo.js"></script>
	<script type="text/javascript" src="../../../lib/ux/Ext.util.Format.CurrencyFactory.js"></script>
	
	
	<script type="text/javascript" src="../../../lib/ux/MoneyField.js"></script>
	<script type="text/javascript" src="../../../lib/ux/fileuploadfield/FileUploadField.js"></script>
	 <!-- componentes extendidos propios -->	  
	<script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/addcmp/TrigguerCombo.js'></script>    
	<script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/addcmp/ComboRec.js'></script>   
    <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/addcmp/ComboMultiple.js'></script>  
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/addcmp/RadioGroupField.js'></script>   
   
    <script type="text/javascript" src="../../../lib/ext3/TabCloseMenu.js"></script>
    <script type="text/javascript" charset="UTF-8" src="resources/Phx.CP.js"></script>
    <?php
     echo "<script type=\"text/javascript\" charset=\"UTF-8\" src=\"resources/Phx.CP.main.php?nueva_sesion=false&estado_sesion=".$estado_sesion."\"></script>";  
	?>
	 
	 
	 <!-- tipo de interfaces -->
	 <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/baseInterfaz.js'></script>
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/gridInterfaz.js'></script>
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/grafInterfaz.js'></script>
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/arbInterfaz.js'></script>
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/arbGridInterfaz.js'></script>
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/frmInterfaz.js'></script>
     <script type='text/javascript' charset="UTF-8" src='../../../lib/lib_vista/gmapInterfaz.js'></script>
      
     
     
     <script type="text/javascript" src="../../../lib/ux/ColumnHeaderGroup.js"></script>
      
      
    <script type="text/javascript" charset="UTF-8" src="../../../lib/ext3/ext-lang-es.js"></script>
    
 	<?php 		
 		$dir = scandir(dirname(__FILE__) . "/../../../../");
		
		foreach($dir as $file) {
			
		   	if(is_dir(dirname(__FILE__) . "/../../../../" . $file) && ($file!='..' && $file!='.') && strpos($file, 'sis_') === 0) {
		   								   		
		    	if (file_exists(dirname(__FILE__) . "/../../../../" . $file . '/vista/_comborec/comborec.js')){
		    		
		    		echo "<script type=\"text/javascript\" charset=\"UTF-8\" src=\"../../../" . $file . "/vista/_comborec/comborec.js\"></script>";
		    	}
		   	}
		}
 	?>

  <!--  <script src="http://maps.google.com/maps?file=api&amp;v=3&amp;sensor=false&amp;key=ABQIAAAAl-hZOf33Gms5pu2iwFTemxTHJbrJ9LYRs0WMg05wOxvXuMe0hhQLWPMv9ORdFvvZKSR3tbliwK4dMA" type="text/javascript"></script>-->
  

  <div id="classes"></div>
  <div id="main"></div>
  <div id="x-tab">
  <div id="x-tab-panel"></div>
  <div class="x-clear"></div>
  
	
	
</div>
<!-- div para cargar interfaces requeridas para herencia-->
<div id="4rn"></div>
<div id="5rn"></div>
<div id="6rn"></div>
<div id="3rn"></div>
	<!-- form para uso de history-->
 	<form id="history-form" class="x-hidden">
    	<input type="hidden" id="x-history-field" value="tab1:subtab1">
    	<iframe id="x-history-frame"></iframe>
	</form>
  </body>
</html>