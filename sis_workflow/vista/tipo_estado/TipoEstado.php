<?php
/**
*@package pXP
*@file gen-TipoEstado.php
*@author  (FRH)
*@date 21-02-2013 15:36:11
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoEstado=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoEstado.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_estado'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nombre_estado',
				fieldLabel: 'Nombre Estado',
				allowBlank: true,
				anchor: '70%',
				gwidth: 200,
				maxLength:150
			},
			type:'TextField',
			filters:{pfiltro:'tipes.nombre_estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'id_tipo_proceso',
				fieldLabel: 'Proceso',
				typeAhead: false,
				forceSelection: false,
				allowBlank: false,
				emptyText: 'Lista de Procesos...',
				store: new Ext.data.JsonStore({
					url: '../../sis_workflow/control/TipoProceso/listarTipoProceso',
					id: 'id_tipo_proceso',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_proceso', 'nombre', 'codigo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {par_filtro: 'tipproc.nombre#tipproc.codigo'}
				}),
				valueField: 'id_tipo_proceso',
				displayField: 'nombre',
				gdisplayField: 'desc_tipo_proceso',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				anchor: '80%',
				minChars: 2,
				gwidth: 200,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_tipo_proceso']);
				},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p>Codigo: <strong>{codigo}</strong> </div></tpl>'
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'tp.nombre',
				type: 'string'
			},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'inicio',
				fieldLabel: 'Inicio (raiz)?',
				allowBlank: true,
				anchor: '40%',
				gwidth: 50,
				maxLength:2,
				emptyText:'si/no...',       			
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    valueField: 'inicio',       		    
       		   // displayField: 'descestilo',
       		    store:['SI','NO']
			},
			type:'ComboBox',
			//filters:{pfiltro:'promac.inicio',type:'string'},
			id_grupo:1,
			filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['SI','NO'],	
	       		 	},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'disparador',
				fieldLabel: 'Disparador (bifurcación)?',
				allowBlank: true,
				anchor: '40%',
				gwidth: 50,
				maxLength:2,
				emptyText:'si/no...',       			
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    valueField: 'disparador',       		    
       		   // displayField: 'descestilo',
       		    store:['SI','NO']
			},
			type:'ComboBox',
			//filters:{pfiltro:'promac.inicio',type:'string'},
			id_grupo:1,
			filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['SI','NO'],	
	       		 	},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tipo_asignacion',
				fieldLabel: 'Tipo Asignación',
				allowBlank: true,
				anchor: '70%',
				gwidth: 150,
				maxLength:50,
				emptyText:'Tipo...',       			
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    valueField: 'tipo_asignacion',       		    
       		   // displayField: 'descestilo',
       		    store:['listado','todos','funcion_listado']
			},
			type:'ComboBox',
			//filters:{pfiltro:'promac.inicio',type:'string'},
			id_grupo:1,
			filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['listado','todos','funcion_listado'],	
	       		 	},
			grid:true,
			form:true
		}/*
		{
			config:{
				name: 'tipo_asignacion',
				fieldLabel: 'Tipo Asignación',
				allowBlank: true,
				anchor: '70%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'tipes.tipo_asignacion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		}*/,
		{
			config:{
				name: 'nombre_func_list',
				fieldLabel: 'Nombre Función de Listado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'tipes.nombre_func_list',type:'string'},
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
			filters:{pfiltro:'tipes.estado_reg',type:'string'},
			id_grupo:1,
			grid:false,
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
			filters:{pfiltro:'tipes.fecha_reg',type:'date'},
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'tipes.fecha_mod',type:'date'},
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
		}
	],
	
	title:'Tipo Estado',
	ActSave:'../../sis_workflow/control/TipoEstado/insertarTipoEstado',
	ActDel:'../../sis_workflow/control/TipoEstado/eliminarTipoEstado',
	ActList:'../../sis_workflow/control/TipoEstado/listarTipoEstado',
	id_store:'id_tipo_estado',
	fields: [
		{name:'id_tipo_estado', type: 'numeric'},
		{name:'nombre_estado', type: 'string'},
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'inicio', type: 'string'},
		{name:'disparador', type: 'string'},
		{name:'tipo_asignacion', type: 'string'},
		{name:'nombre_func_list', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_tipo_proceso', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_tipo_estado',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		