<?php
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Ext.define('Phx.vista.Consultas', {
		extend: 'Ext.util.Observable',
		constructor: function(config){
			Ext.apply(this,config);
			this.callParent(arguments);
			this.panel = Ext.getCmp(this.idContenedor);
			this.drawLayout();
			this.panel.add(this.viewPort);
			this.panel.doLayout();
		},
		drawLayout: function(){
			//Creación de componentes del panel de parámetros
			this.fechaIni = new Ext.form.DateField({
				fieldLabel: 'Fecha Inicio'
			});
			this.fechaFin = new Ext.form.DateField({
				fieldLabel: 'Fecha Fin'
			});

			//Creación del panel de parámetros
			this.viewPort = new Ext.Panel({
				region: 'center',
				layout: 'border',
				items: [{
					region: 'west',
					title: 'Parámetros',
					width: '15%',
					layout: 'form',
					collapsible: true,
					split: true,
					items: [
						this.fechaIni,
						this.fechaFin
					]
				}, {
					region: 'center',
					title: 'Espacio'
				}]
			});
		}
	});
</script>