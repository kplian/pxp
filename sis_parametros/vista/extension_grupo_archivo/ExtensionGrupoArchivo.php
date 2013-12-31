<?php
/**
*@package pXP
*@file gen-ExtensionGrupoArchivo.php
*@author  (admin)
*@date 23-12-2013 20:33:46
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ExtensionGrupoArchivo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ExtensionGrupoArchivo.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_extension_grupo_archivo'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				name: 'id_extension',
				fieldLabel: 'Extension',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/Extension/listarExtension',
					id: 'id_extension',
					root: 'datos',
					sortInfo: {
						field: 'extension',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_extension', 'extension', 'peso_max_upload_mb'],
					remoteSort: true,
					baseParams: {par_filtro: 'movtip.nombre#movtip.codigo'}
				}),
				valueField: 'id_extension',
				displayField: 'extension',
				gdisplayField: 'desc_extension',
				hiddenName: 'id_extension',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_extension']);
				}
		},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'movtip.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_grupo_archivo',
				fieldLabel: 'Grupo archivo',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/GrupoArchivo/listarGrupoArchivo',
					id: 'id_grupo_archivo',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_grupo_archivo', 'nombre', 'descripcion'],
					remoteSort: true,
					baseParams: {par_filtro: 'movtip.nombre#movtip.codigo'}
				}),
				valueField: 'id_grupo_archivo',
				displayField: 'nombre',
				gdisplayField: 'desc_grupo_archivo',
				hiddenName: 'id_grupo_archivo',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_grupo_archivo']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'movtip.nombre',type: 'string'},
			grid: true,
			form: true
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
				filters:{pfiltro:'ext_g_ar.estado_reg',type:'string'},
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
				filters:{pfiltro:'ext_g_ar.fecha_reg',type:'date'},
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'ext_g_ar.fecha_mod',type:'date'},
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
		}
	],
	tam_pag:50,	
	title:'Ext_g_ar',
	ActSave:'../../sis_parametros/control/ExtensionGrupoArchivo/insertarExtensionGrupoArchivo',
	ActDel:'../../sis_parametros/control/ExtensionGrupoArchivo/eliminarExtensionGrupoArchivo',
	ActList:'../../sis_parametros/control/ExtensionGrupoArchivo/listarExtensionGrupoArchivo',
	id_store:'id_extension_grupo_archivo',
	fields: [
		{name:'id_extension_grupo_archivo', type: 'numeric'},
		{name:'id_extension', type: 'numeric'},
		{name:'id_grupo_archivo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_extension', type: 'string'},
		{name:'desc_grupo_archivo', type: 'string'}
	],
	sortInfo:{
		field: 'id_extension_grupo_archivo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onReloadPage : function(m) {
		this.maestro = m;
  this.Atributos[1].valorInicial = this.maestro.id_extension;
  this.store.baseParams = {
                    id_extension : this.maestro.id_extension
                    };
                    this.load({
                    params : {
                        start : 0,
                        limit : 50
                    }
                })
  
  
	}
	}
)
</script>
		
		