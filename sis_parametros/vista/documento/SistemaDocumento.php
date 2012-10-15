<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (fprudencio)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
//include_once("../../../../../sis_cobranza/vista/sistema_dist/SistemaDistAbs.php");
include_once("../../../sis_seguridad/vista/subsistema/Subsistema.php");
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.SistemaDocumento=Ext.extend(Phx.vista.Subsistema,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		
    	Phx.vista.SistemaDocumento.superclass.constructor.call(this,config);
		this.init();		
		this.store.baseParams={'estado_proceso':'en_requerimiento'};
		
	//this.addButton('fin_requerimiento',{text:'Finalizar',icon:'../../../lib/imagenes/book_next.png',disabled:false,handler:fin_requerimiento,tooltip: '<b>Finalizar'});
	function fin_requerimiento()
		{					
			var data=this.sm.getSelected().data.id_proceso_contrato;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				// form:this.form.getForm().getEl(),
				url:'../../sis_legal/control/ProcesoContrato/insertarProcesoContrato',
				params:{'id_proceso_contrato':data,'operacion':'fin_requerimiento'},
				success:this.successSinc,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});		
		}
		this.load({params:{start:0, limit:50}})
	},		
	
	successSinc:function(resp){
			
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if(!reg.ROOT.error){
				alert(reg.ROOT.detalle.mensaje)
				
			}else{
				
				alert('ocurrio un error durante el proceso')
			}
			this.reload();
			
	},
	onButtonNew:function(){
	    Phx.vista.ProcesoRequerimiento.superclass.onButtonNew.call(this);
	    this.ocultarGrupo(2);	
	},
	onReloadPage:function(m)
	{
		this.maestro=m;						
		this.store.baseParams={'estado_proceso':'en_requerimiento'};
		this.load({params:{start:0, limit:50}});			
	}	
	
	}
)