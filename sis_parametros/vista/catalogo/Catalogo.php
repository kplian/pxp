<?php
/**
*@package   pXP
*@file      Catalogo.php
*@author    (admin)
*@date      16-11-2012 17:01:40a
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Catalogo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Catalogo.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_catalogo'
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
			filters:{pfiltro:'cat.estado_reg',type:'string'},
			id_grupo:1,
			grid:false,
			form:false
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
                    baseParams:{par_filtro:'nombre#codigo'}
                }),
                valueField: 'id_subsistema',
                displayField: 'nombre',
                gdisplayField: 'desc_subsistema',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:270,
                minChars:2,
                enableMultiSelect:true,
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_subsistema']);},
                gwidth:200

            },
            type:'ComboBox',
            id_grupo:0,
            filters:{
                   pfiltro:'nombre',
                   type:'string'
            },
            grid:true,
            form:true
        },
		{
			config: {
				typeAhead: false,
				forceSelection: false,
				name: 'id_catalogo_tipo',
				fieldLabel: 'Tipo Catálogo',
				allowBlank: false,
				emptyText: 'Tipo Catálogo',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/CatalogoTipo/listarCatalogoTipo',
					id: 'id_catalogo_tipo',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_catalogo_tipo', 'nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {
						par_filtro: 'nombre'
					}
				}),
				valueField: 'id_catalogo_tipo',
				displayField: 'nombre',
				gdisplayField: 'desc_catalogo_tipo',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 10,
				queryDelay: 200,
				width: 250,
				minChars: 2,
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p></div></tpl>',
				renderer:function(value, p, record){return String.format('{0}', record.data['desc_catalogo_tipo']);},
				gwidth:130
			},
			type: 'ComboBox',
			id_grupo: 1,
			filters: {
				pfiltro: 'nombre',
				type: 'string'
			},
			grid: true,
			form: true
		},
		
		{
            config:{
                name: 'codigo',
                fieldLabel: 'Codigo',
                allowBlank: true,
                anchor: '50%',
                gwidth: 100,
                maxLength:20
            },
            type:'TextField',
            filters:{pfiltro:'cat.codigo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '100%',
				gwidth: 220,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'cat.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'cat.fecha_reg',type:'date'},
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
			filters:{pfiltro:'cat.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Catalogo',
	ActSave:'../../sis_parametros/control/Catalogo/insertarCatalogo',
	ActDel:'../../sis_parametros/control/Catalogo/eliminarCatalogo',
	ActList:'../../sis_parametros/control/Catalogo/listarCatalogo',
	id_store:'id_catalogo',
	fields: [
		{name:'id_catalogo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_catalogo_tipo', type: 'numeric'},
		{name:'id_subsistema', type: 'numeric'},
		{name:'desc_subsistema',type:'string'},
		{name:'descripcion', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_catalogo_tipo', type: 'string'}
	],
	sortInfo:{
		field: 'id_catalogo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	iniciarEventos:function(){
		var cmbSubsis=this.getComponente('id_subsistema');
		var cmbCatTipo=this.getComponente('id_catalogo_tipo');
		
		this.getComponente('id_subsistema').on('select',function(combo,record,index){
			cmbCatTipo.store.baseParams.id_subsistema=record.data.id_subsistema;
	        cmbCatTipo.reset();
	        cmbCatTipo.modificado = true;
		},this);
	}
})
</script>
		
		