<?php
/**
*@package pXP
*@file CentroCosto.php
*@author  Gonzalo Sarmiento Sejas
*@date 18-02-2013 14:08:14
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.CentroCosto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.CentroCosto.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_centro_costo'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'tipo_pres',
				fieldLabel: 'Tipo Presupuesto',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'ccost.tipo_pres',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_fuente_financiammiento',
				fieldLabel: 'Id Fuente Financiammiento',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'ccost.id_fuente_financiammiento',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_parametro',
				fieldLabel: 'Id Parametro',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'ccost.id_parametro',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_uo',
				fieldLabel: 'Id Unidad Organizacional',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'ccost.id_uo',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'ccost.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cod_prg',
				fieldLabel: 'Cod Prg',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'ccost.cod_prg',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'ccost.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_concepto_colectivo',
				fieldLabel: 'Id Concepto Colectivo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'ccost.id_concepto_colectivo',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cod_fin',
				fieldLabel: 'Cod Fin',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'ccost.cod_fin',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Codigo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'ccost.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		/*
		{
			config:{
				name: 'id_ep',
				fieldLabel: 'Id Ep',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'ccost.id_ep',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},*/
		{
	       			config:{
	       				name:'id_ep',
	       				fieldLabel:'Ep',
	       				allowBlank:true,
	       				emptyText:'Ep...',
	       				store: new Ext.data.JsonStore({

	    					url: '../../sis_parametros/control/Ep/listarEp',
	    					id: 'id_ep',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'id_ep',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_ep'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'frpp.id_ep'}
	    				}),
	       				valueField: 'id_ep',
	       				displayField: 'id_ep',
	       				gdisplayField: 'id_ep',
	       				hiddenName: 'id_ep',
	       				forceSelection:true,
	       				typeAhead: true,
	           triggerAction: 'all',
	           lazyRender:true,
	       				mode:'remote',
	       				pageSize:10,
	       				queryDelay:1000,
	       				width:250,
	       				minChars:2,
	       			
	       				renderer:function(value, p, record){return String.format('{0}', record.data['id_ep']);}

	       			},
	       			type:'ComboBox',
	       			id_grupo:0,
	       			filters:{   pfiltro:'frpp.id_ep',
	       						type:'string'
	       					},
	       			grid:true,
	       			form:true
	       },
		{
			config:{
				name: 'id_categoria_prog',
				fieldLabel: 'Id Categoria Prog',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'ccost.id_categoria_prog',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_agrupador',
				fieldLabel: 'Nombre Agrupador',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:150
			},
			type:'TextField',
			filters:{pfiltro:'ccost.nombre_agrupador',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cod_pry',
				fieldLabel: 'Cod Pry',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'ccost.cod_pry',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cod_act',
				fieldLabel: 'Cod Act',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'ccost.cod_act',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_gestion',
				fieldLabel: 'Id Gestion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'ccost.id_gestion',type:'numeric'},
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
			filters:{pfiltro:'ccost.estado_reg',type:'string'},
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
			filters:{pfiltro:'ccost.fecha_reg',type:'date'},
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
			filters:{pfiltro:'ccost.fecha_mod',type:'date'},
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
	
	title:'Centro de Costo',
	ActSave:'../../sis_parametros/control/CentroCosto/insertarCentroCosto',
	ActDel:'../../sis_parametros/control/CentroCosto/eliminarCentroCosto',
	ActList:'../../sis_parametros/control/CentroCosto/listarCentroCosto',
	id_store:'id_centro_costo',
	fields: [
		{name:'id_centro_costo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'tipo_pres', type: 'string'},
		{name:'id_fuente_financiammiento', type: 'numeric'},
		{name:'id_parametro', type: 'numeric'},
		{name:'id_uo', type: 'numeric'},
		{name:'estado', type: 'string'},
		{name:'cod_prg', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'id_concepto_colectivo', type: 'numeric'},
		{name:'cod_fin', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'id_ep', type: 'numeric'},
		{name:'id_categoria_prog', type: 'numeric'},
		{name:'nombre_agrupador', type: 'string'},
		{name:'cod_pry', type: 'string'},
		{name:'cod_act', type: 'string'},
		{name:'id_gestion', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_centro_costo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		