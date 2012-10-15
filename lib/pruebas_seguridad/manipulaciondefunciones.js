function EliminarProyecto() {
	Ext.Ajax.request( {
	url : '../../sis_seguridad/control/Proyecto/eliminarProyecto',
	method : 'POST',
	params : {"_tipo":"matriz","row":"{\"0\":{\"id_proyecto\":\"9322270 5067861 \",\"_fila\":5}}"},
	success : function successPrueba(resp) {
		
	},
	failure : function(resp) {
	  
	},
	timeout : 1000000000
	})
}
EliminarProyecto()	

	