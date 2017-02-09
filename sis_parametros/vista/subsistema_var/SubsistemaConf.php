<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (fprudencio)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite 
*dar el visto a solicitudes de compra
*
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.SubsistemaConf = {
    bedit: false,
    bnew: false,
    bsave: false,
    bdel: true,
	require: '../../../sis_seguridad/vista/subsistema/Subsistema.php',
	requireclase: 'Phx.vista.Subsistema',
	title: 'Libro Diario',
	nombreVista: 'SubsistemaConf',
	
	constructor: function(config) {
	    Phx.vista.SubsistemaConf.superclass.constructor.call(this,config);
	   
    
    },
    
    tabeast:[
		{
		  url:'../../../sis_seguridad/vista/funcion/Funcion.php',
		  title:'Funcion', 
		  width:400,
		  cls:'funcion'
		 },
         {
			  url: '../../../sis_parametros/vista/subsistema_var/SubsistemaVar.php',
			  title: 'Variables', 
			  height: '50%',	//altura de la ventana hijo
			  cls: 'SubsistemaVar'
		}
      ]
};
</script>
