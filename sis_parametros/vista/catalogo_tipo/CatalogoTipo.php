<?php
/**
*@package pXP
*@file gen-CatalogoTipo.php
*@author  (admin)
*@date 27-11-2012 23:32:44
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.CatalogoTipo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.CatalogoTipo.superclass.constructor.call(this,config);
		this.init();
		
		this.addButton('btnWizard',
            {
                text: 'Exportar Plantilla',
                iconCls: 'bchecklist',
                disabled: false,
                handler: this.expProceso,
                tooltip: '<b>Exportar</b><br/>Exporta a archivo SQL la plantilla'
            }
        );
		
		this.iniciarEventos();
		this.load({params:{start:0, limit:50}})
	},
	
	expProceso : function(resp){
			var data=this.sm.getSelected().data;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url: '../../sis_parametros/control/CatalogoTipo/exportarDatos',
				params: { 'id_catalogo_tipo' : data.id_catalogo_tipo },
				success: this.successExport,
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope: this
			});
			
	},
	
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_catalogo_tipo'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name:'id_subsistema',
				fieldLabel:'Subsistema',
				allowBlank:false,
				emptyText:'Subsistema...',
				store: new Ext.data.JsonStore({
					url: '../../sis_seguridad/control/Subsistema/listarSubsistema',
					id: 'id_subsistema',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_subsistema','nombre','codigo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_subsistema',
				displayField: 'codigo',
				gdisplayField:'desc_subsistema',
				hiddenName: 'id_subsistema',
				forceSelection:true,
				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2,
				minListWidth:'100%',
				renderer: function (value, p, record){
					return String.format('{0}', record.data['desc_subsistema']
					)}
			},
			type:'ComboBox',
			id_grupo:0,
			filters:{	
		        pfiltro:'subsis.nombre',
				type:'string'
			},
			
			grid:true,
			form:true
	},
	{
			config:{
				name: 'tabla',
				fieldLabel:'Tabla',
				allowBlank:false,
				emptyText:'Tabla...',
				store: new Ext.data.JsonStore({
					url: '../../sis_generador/control/Tabla/listarTablaCombo',
					id: 'oid_tabla',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['oid_tabla','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'c.relname'}
				}),
				valueField: 'nombre',
				displayField: 'nombre',
				gdisplayField:'tabla',
				//hiddenName: 'nombre',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2,
				minListWidth:'100%'
			},
			type:'ComboBox',
			id_grupo:0,
			filters:{	
		        pfiltro:'tabla.nombre',
				type:'string'
			},
			
			grid:true,
			form:true
	},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:100,
				gwidth: 220
			},
			type:'TextField',
			filters:{pfiltro:'pacati.nombre',type:'string'},
			id_grupo:1,
			grid:true,
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
			filters:{pfiltro:'pacati.estado_reg',type:'string'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'pacati.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
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
			grid:true,
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
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'pacati.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Tipo Catálogo',
	ActSave:'../../sis_parametros/control/CatalogoTipo/insertarCatalogoTipo',
	ActDel:'../../sis_parametros/control/CatalogoTipo/eliminarCatalogoTipo',
	ActList:'../../sis_parametros/control/CatalogoTipo/listarCatalogoTipo',
	id_store:'id_catalogo_tipo',
	fields: [
		{name:'id_catalogo_tipo', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'id_subsistema', type: 'numeric'},
		{name:'desc_subsistema', type: 'string'},
		{name:'tabla', type: 'string'}
	],
	sortInfo:{
		field: 'id_catalogo_tipo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	iniciarEventos:function(){
		var cmbTabla=this.getComponente('tabla');
		var txtNombre=this.getComponente('nombre');
		
		this.getComponente('id_subsistema').on('select',function(combo,record,index){
			cmbTabla.store.baseParams.esquema=record.data.codigo;
	        cmbTabla.reset();
	        cmbTabla.modificado = true;
	        txtNombre.setValue('');
		},this);
		this.getComponente('tabla').on('select',function(combo,record,index){
			txtNombre.setValue(cmbTabla.getValue());
		},this);
	}
})
</script>