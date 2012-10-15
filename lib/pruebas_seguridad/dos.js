function consultaDOS() {
	Ext.Ajax.request( {
	url : '../../sis_seguridad/control/Log/listarLog',
	method : 'POST',
	params : {"start":"0","limit":"50","sort":"logg.fecha_reg","dir":"DESC"},
	success : successConsultaDOS,
	failure : function() {
	  
	},
	timeout : 1000000000
	})
}

function successConsultaDOS(resp) {
	
		// se ejecuta recursivamente y nunca termina si la consulta tiene
		// exito
		consultaDOS()	
}

consultaDOS()