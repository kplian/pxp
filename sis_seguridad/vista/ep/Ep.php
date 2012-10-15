<?php
/**
*@package pXP
*@file gen-Ep.php
*@author  (w)
*@date 18-10-2011 02:09:50
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Ep=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Ep.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_ep'
			},
			type:'Field',
			form:true 
		},
		{
	       	config:{
	       		name: 'id_programa',
				fieldLabel: 'Programa',
				allowBlank: false,
				anchor: '70%',
				gwidth:80,
	       		store: new Ext.data.JsonStore({

	    				url: '../../sis_seguridad/control/Programa/listarPrograma',
	    				id: 'id_programa',
	    				root: 'datos',
	    				sortInfo:{
	    					field: 'id_programa',
	    					direction: 'ASC'
	    				},
	    				totalProperty: 'total',
	    				fields: ['id_programa','nombre'],
	    				// turn on remote sorting
	    				remoteSort: true,
	    				baseParams:{par_filtro:'progra.nombre#progra.codigo',estado_reg:'activo'}
	    			}),
	       		valueField: 'id_programa',
	       		displayField: 'nombre',
	       		gdisplayField: 'nombre_programa',
	       		hiddenName: 'id_programa',
	       		forceSelection:true,
	       		typeAhead: false,
	        	triggerAction: 'all',
	        	lazyRender:true,
	       		mode:'remote',
	       		pageSize:20,
	       		queryDelay:1000,
	       		minChars:3,
	       		renderer:function(value, p, record){return String.format('{0}', record.data['nombre_programa']);}
   			},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{   pfiltro:'ep.nombre_programa',
   						type:'string'
   					},
   			grid:true,
   			form:true
       	},
		
			
		{
	       	config:{
	       		name: 'id_proyecto',
				fieldLabel: 'Proyecto',
				allowBlank: false,
				anchor: '70%',
				gwidth:80,
	       		store: new Ext.data.JsonStore({

	    				url: '../../sis_seguridad/control/Proyecto/listarProyecto',
	    				id: 'id_proyecto',
	    				root: 'datos',
	    				sortInfo:{
	    					field: 'id_proyecto',
	    					direction: 'ASC'
	    				},
	    				totalProperty: 'total',
	    				fields: ['id_proyecto','nombre'],
	    				// turn on remote sorting
	    				remoteSort: true,
	    				baseParams:{par_filtro:'proy.nombre#proy.codigo',estado_reg:'activo'}
	    			}),
	       		valueField: 'id_proyecto',
	       		displayField: 'nombre',
	       		gdisplayField: 'nombre_proyecto',
	       		hiddenName: 'id_proyecto',
	       		forceSelection:true,
	       		typeAhead: false,
	        	triggerAction: 'all',
	        	lazyRender:true,
	       		mode:'remote',
	       		pageSize:20,
	       		queryDelay:1000,
	       		minChars:3,
	       		renderer:function(value, p, record){return String.format('{0}', record.data['nombre_proyecto']);}
   			},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{   pfiltro:'ep.nombre_proyecto',
   						type:'string'
   					},
   			grid:true,
   			form:true
       	},
		
		
		{
	       	config:{
	       		name: 'id_actividad',
				fieldLabel: 'Actividad',
				allowBlank: false,
				anchor: '70%',
				gwidth:80,
	       		store: new Ext.data.JsonStore({

	    				url: '../../sis_seguridad/control/Actividad/listarActividad',
	    				id: 'id_actividad',
	    				root: 'datos',
	    				sortInfo:{
	    					field: 'id_actividad',
	    					direction: 'ASC'
	    				},
	    				totalProperty: 'total',
	    				fields: ['id_actividad','nombre'],
	    				// turn on remote sorting
	    				remoteSort: true,
	    				baseParams:{par_filtro:'act.nombre#act.codigo',estado_reg:'activo'}
	    			}),
	       		valueField: 'id_actividad',
	       		displayField: 'nombre',
	       		gdisplayField: 'nombre_actividad',
	       		hiddenName: 'id_actividad',
	       		forceSelection:true,
	       		typeAhead: false,
	        	triggerAction: 'all',
	        	lazyRender:true,
	       		mode:'remote',
	       		pageSize:20,
	       		queryDelay:1000,
	       		minChars:3,
	       		renderer:function(value, p, record){return String.format('{0}', record.data['nombre_actividad']);}
   			},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{   pfiltro:'ep.nombre_actividad',
   						type:'string'
   					},
   			grid:true,
   			form:true
       	},
		
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'esp.estado_reg',type:'string'},
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
			filters:{pfiltro:'esp.fecha_reg',type:'date'},
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
			type:'TextField',
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'esp.fecha_mod',type:'date'},
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
			type:'TextField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Estructura Programatica',
	ActSave:'../../sis_seguridad/control/Ep/insertarEp',
	ActDel:'../../sis_seguridad/control/Ep/eliminarEp',
	ActList:'../../sis_seguridad/control/Ep/listarEp',
	id_store:'id_ep',
	fields: [
		{name:'id_ep', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_actividad', type: 'numeric'},
		{name:'nombre_actividad', type: 'string'},
		{name:'id_programa', type: 'numeric'},
		{name:'nombre_programa', type: 'string'},
		{name:'id_proyecto', type: 'numeric'},
		{name:'nombre_proyecto', type: 'string'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_ep',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		