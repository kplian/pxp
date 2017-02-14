<?php
/**
 *@package pXP
 *@file gen-Depto.php
 *@author  )
 *@date 24-11-2011 15:52:20
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Ext.define('Phx.vista.widget.widget6',{		
	extend: 'Ext.util.Observable',
	constructor: function(config){
		   console.log('config', config)
		   
		   Ext.apply(this, config)
		
		   this.callParent(arguments);
		   this.panel = Ext.getCmp(this.idContenedor);
		    
		  
		    this.panel.add({
		    	           autoHeight: true,
				           autoScroll : true,
		                   html : 	'<iframe src="../../../sis_seguridad/widgets/seis/index.html"  scrolling="no" width = "100%" align="center" frameborder="0" onload="resizeIframe(this)"></iframe>'
            
		                });
		    
		  
		
	},
	init:function() {
		  this.panel.doLayout();
	}       

});
</script>
