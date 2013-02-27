<?php
/**
*@package pXP
*@file gen-TipoProceso.php
*@author  (FRH)
*@date 21-02-2013 15:52:52
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoProceso=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoProceso.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_proceso'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: true,
				anchor: '60%',
				gwidth: 100,
				maxLength:5
			},
			type:'TextField',
			filters:{pfiltro:'tipproc.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '60%',
				gwidth: 150,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'tipproc.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'id_proceso_macro',
				fieldLabel: 'Proceso',
				typeAhead: false,
				forceSelection: false,
				allowBlank: false,
				emptyText: 'Lista de Procesos...',
				store: new Ext.data.JsonStore({
					url: '../../sis_workflow/control/ProcesoMacro/listarProcesoMacro',
					id: 'id_proceso_macro',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_proceso_macro', 'nombre', 'codigo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {par_filtro: 'promac.nombre#promac.codigo'}
				}),
				valueField: 'id_proceso_macro',
				displayField: 'nombre',
				gdisplayField: 'desc_proceso_macro',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				anchor: '80%',
				minChars: 2,
				gwidth: 200,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_proceso_macro']);
				},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p>Codigo: <strong>{codigo}</strong> </div></tpl>'
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'pm.nombre',
				type: 'string'
			},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_tipo_estado',
				fieldLabel: 'Tipo Estado',
				typeAhead: false,
				forceSelection: false,
				allowBlank: true,
				emptyText: 'Lista de tipos estados...',
				store: new Ext.data.JsonStore({
					url: '../../sis_workflow/control/TipoEstado/listarTipoEstado',
					id: 'id_tipo_estado',
					root: 'datos',
					sortInfo: {
						field: 'nombre_estado',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_estado', 'nombre_estado', 'inicio'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {par_filtro: 'tipes.nombre_estado#tipes.inicio'}
				}),
				valueField: 'id_tipo_estado',
				displayField: 'nombre_estado',
				gdisplayField: 'desc_tipo_estado',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				anchor: '80%',
				minChars: 2,
				gwidth: 200,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_tipo_estado']);
				},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre_estado}</p>Inicio: <strong>{inicio}</strong> </div></tpl>'
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'te.nombre_estado',
				type: 'string'
			},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'tabla',
				fieldLabel: 'Tabla',
				allowBlank: true,
				anchor: '60%',
				gwidth: 150,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'tipproc.tabla',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'columna_llave',
				fieldLabel: 'Columna Llave',
				allowBlank: true,
				anchor: '60%',
				gwidth: 100,
				maxLength:150
			},
			type:'TextField',
			filters:{pfiltro:'tipproc.columna_llave',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
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
       		    store:['si','no']
			},
			type:'ComboBox',
			id_grupo:1,
			filters:{	pfiltro:'tipproc.inicio',
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['si','no'],	
	       		 	},
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
			filters:{pfiltro:'tipproc.estado_reg',type:'string'},
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
			filters:{pfiltro:'tipproc.fecha_reg',type:'date'},
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
			filters:{pfiltro:'tipproc.fecha_mod',type:'date'},
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
	
	title:'Tipo Proceso',
	ActSave:'../../sis_workflow/control/TipoProceso/insertarTipoProceso',
	ActDel:'../../sis_workflow/control/TipoProceso/eliminarTipoProceso',
	ActList:'../../sis_workflow/control/TipoProceso/listarTipoProceso',
	id_store:'id_tipo_proceso',
	fields: [
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'id_proceso_macro', type: 'numeric'},
		{name:'tabla', type: 'string'},
		{name:'columna_llave', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_tipo_estado', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_proceso_macro', type: 'string'},
		{name:'desc_tipo_estado', type: 'string'},'inicio'
		
	],
	sortInfo:{
		field: 'id_tipo_proceso',
		direction: 'ASC'
	},
	east:{
		  url:'../../../sis_workflow/vista/tipo_estado/TipoEstado.php',
		  title:'Estados', 
		  width:400,
		  cls:'TipoEstado'
		},
	bdel:true,
	bsave:true
	}
)
</script>
		
		