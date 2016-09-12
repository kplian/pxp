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
Phx.vista.WidgetConfig= {
    tipoDoc: 'venta',
	require: '../../../sis_parametros/vista/widget/Widget.php',
	requireclase: 'Phx.vista.Widget',
	title: 'Widget',
	nombreVista: 'WidgetConfig',
	
	constructor: function(config) {
	    Phx.vista.WidgetConfig.superclass.constructor.call(this,config);
	    
	    this.addButton('addPlantilla', {
				text : 'Imagen',
				iconCls : 'bundo',
				disabled : false,
				handler : this.addPlantilla,
				tooltip : ' <b>Subir imagen</b>'
			});
			
	    
   },
   addPlantilla : function() {


			var rec = this.sm.getSelected();
			Phx.CP.loadWindows('../../../sis_parametros/vista/widget/subirImagen.php', 'Subir', {
				modal : true,
				width : 500,
				height : 250
			}, rec.data, this.idContenedor, 'subirImagen')

			

	},
	
	preparaMenu: function (n) {
		Phx.vista.WidgetConfig.superclass.preparaMenu.call(this, n);
		var data = this.getSelectedData();
		this.getBoton('addPlantilla').enable();
	},
	liberaMenu: function (n) {
		Phx.vista.WidgetConfig.superclass.liberaMenu.call(this, n);
		this.getBoton('addPlantilla').disable();
		
		
		
	}
	
	
    
    
	
   
	
	
};
</script>