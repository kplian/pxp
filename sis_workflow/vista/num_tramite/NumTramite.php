<?php
/**
*@package pXP
*@file gen-NumTramite.php
*@author  (FRH)
*@date 19-02-2013 13:51:54
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.NumTramite=Ext.extend(Phx.gridInterfaz,{	
	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.NumTramite.superclass.constructor.call(this,config);
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		this.init();
		//this.load({params:{start:0, limit:50}})
	},			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_num_tramite'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				labelSeparator:'',
				name: 'id_proceso_macro',
				inputType:'hidden'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'numtram.estado_reg',type:'string'},
			id_grupo:1,
			grid:false,
			form:false
		},
		{
			config:{
				name: 'id_gestion',
				origen:'GESTION',
	   			tinit:true,
				fieldLabel: 'Gestion',
				gdisplayField:'desc_gestion',//mapea al store del grid
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_gestion']);}
			},
			type:'ComboRec',
			filters:{pfiltro:'ges.gestion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'num_siguiente',
				fieldLabel: 'Número Siguiente',
				allowBlank: true,
				anchor: '80%',
				gwidth: 150,
				maxLength:8,
				disabled:true			
			},
			type:'TextField',
			filters:{pfiltro:'numtram.num_siguiente',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codificacion_siguiente',
				fieldLabel: 'Codificación Siguiente',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:10,
				disabled:true
			},
			type:'TextField',
			filters:{pfiltro:'prom.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'numtram.fecha_reg',type:'date'},
			id_grupo:1,
			grid:false,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:false,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:false,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'numtram.fecha_mod',type:'date'},
			id_grupo:1,
			grid:false,
			form:false
		}
	],
	
	title:'Numero de Tramite',
	ActSave:'../../sis_workflow/control/NumTramite/insertarNumTramite',
	ActDel:'../../sis_workflow/control/NumTramite/eliminarNumTramite',
	ActList:'../../sis_workflow/control/NumTramite/listarNumTramite',
	id_store:'id_num_tramite',
	loadValoresIniciales:function()
	{
		Phx.vista.NumTramite.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_proceso_macro').setValue(this.maestro.id_proceso_macro);		
	},
	
	onReloadPage:function(m)
	{
		this.maestro=m;						
		this.store.baseParams={id_proceso_macro:this.maestro.id_proceso_macro, num_siguiente:null};
		this.load({params:{start:0, limit:50}});			
	},
	fields: [
		{name:'id_num_tramite', type: 'numeric'},
		{name:'id_proceso_macro', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_gestion', type: 'numeric'},
		{name:'num_siguiente', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_gestion', type: 'string'},
		{name:'codificacion_siguiente', type: 'string'}
	],
	sortInfo:{
		field: 'id_num_tramite',
		direction: 'ASC'
	},
	bedit: false,
	bdel:false,
	bnew:false,
	bsave:false
	}
)
</script>
		
		