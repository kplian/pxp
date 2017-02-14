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
Phx.vista.WidgetDash= {
    tipoDoc: 'venta',
	require: '../../../sis_parametros/vista/widget/Widget.php',
	requireclase: 'Phx.vista.Widget',
	title: 'Widget',
	nombreVista: 'Widget',
	bnew: false,
	bedit:false,
	bdel:false,
	bsave:false,
	
	constructor: function(config) {
	    
	    
	   
	         
	    Phx.vista.WidgetDash.superclass.constructor.call(this,config);	
	    
	    
	    
	       
	    this.addButton('addWidget', {
				text : 'Agregar',
				iconCls : 'bundo',
				disabled : false,
				handler : this.addWidget,
				tooltip : ' <b>Agregar Widget seleccionado</b>'
			});

   },
   
   addWidget:function(){
   	
   	  var rec = this.sm.getSelected(), me = this;
   	  console.log(1111)
   	  me.fireEvent('selectwidget', this, rec);
   	  console.log(2222)
   	
   	
   },
   
   preparaMenu: function (n) {
		Phx.vista.WidgetDash.superclass.preparaMenu.call(this, n);
		var data = this.getSelectedData();
		this.getBoton('addWidget').enable();
		
   },
   
   
   liberaMenu: function (n) {
		Phx.vista.WidgetDash.superclass.liberaMenu.call(this, n);
		this.getBoton('addWidget').disable();
		
	}
    
    
	
};
</script>