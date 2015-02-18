<?php
/**
*@package pXP
*@file gen-ProgramaProyectoActtividad.php
*@author  (admin)
*@date 06-02-2013 16:04:45
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ProgramaProyectoActtividad=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ProgramaProyectoActtividad.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_prog_pory_acti'
			},
			type:'Field',
			form:true 
		},
		{
	       			config:{
	       				name:'id_programa',
	       				fieldLabel:'Programa',
	       				allowBlank:false,
	       				emptyText:'Programa...',
	       				store: new Ext.data.JsonStore({

	    					url: '../../sis_parametros/control/Programa/ListarPrograma',
	    					id: 'id_programa',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'codigo_programa',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_programa','codigo_programa','nombre_programa'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'codigo_programa#nombre_programa'}
	    				}),
	       				valueField: 'id_programa',
	       				displayField: 'codigo_programa',
	       				gdisplayField:'desc_programa',//mapea al store del grid
	       				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo_programa}</p><p>{nombre_programa}</p> </div></tpl>',
	       				hiddenName: 'id_programa',
	       				forceSelection:true,
	       				typeAhead: true,
	           			triggerAction: 'all',
	           			lazyRender:true,
	       				mode:'remote',
	       				pageSize:10,
	       				queryDelay:1000,
	       				width:250,
	       				gwidth:280,
	       				minChars:2,
	       				renderer:function (value, p, record){return String.format('{0}', record.data['desc_programa']);}
	       			},
	       			type:'ComboBox',
	       			id_grupo:0,
	       			filters:{	
	       				        pfiltro:'codigo_programa',
	       						type:'string'
	       					},
	       		   
	       			grid:true,
	       			form:true
	       	},
		    {
	       			config:{
	       				name:'id_proyecto',
	       				fieldLabel:'Proyecto',
	       				allowBlank:false,
	       				emptyText:'Proyecto...',
	       				store: new Ext.data.JsonStore({

	    					url: '../../sis_parametros/control/Proyecto/ListarProyecto',
	    					id: 'id_proyecto',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'codigo_proyecto',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_proyecto','codigo_proyecto','nombre_proyecto'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'codigo_proyecto#nombre_proyecto'}
	    				}),
	       				valueField: 'id_proyecto',
	       				displayField: 'codigo_proyecto',
	       				gdisplayField:'desc_proyecto',//mapea al store del grid
	       				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo_proyecto}</p><p>{nombre_proyecto}</p> </div></tpl>',
	       				hiddenName: 'id_proyecto',
	       				forceSelection:true,
	       				typeAhead: true,
	           			triggerAction: 'all',
	           			lazyRender:true,
	       				mode:'remote',
	       				pageSize:10,
	       				queryDelay:1000,
	       				width:250,
	       				gwidth:280,
	       				minChars:2,
	       				renderer:function (value, p, record){return String.format('{0}', record.data['desc_proyecto']);}
	       			},
	       			type:'ComboBox',
	       			id_grupo:0,
	       			filters:{	
	       				        pfiltro:'codigo_proyecto',
	       						type:'string'
	       					},
	       		   
	       			grid:true,
	       			form:true
	       	},
		    {
	       			config:{
	       				name:'id_actividad',
	       				fieldLabel:'Actividad',
	       				allowBlank:false,
	       				emptyText:'Actividad...',
	       				store: new Ext.data.JsonStore({

	    					url: '../../sis_parametros/control/Actividad/ListarActividad',
	    					id: 'id_actividad',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'codigo_actividad',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_actividad','codigo_actividad','nombre_actividad'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'codigo_actividad#nombre_actividad'}
	    				}),
	       				valueField: 'id_actividad',
	       				displayField: 'codigo_actividad',
	       				gdisplayField:'desc_actividad',//mapea al store del grid
	       				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo_actividad}</p><p>{nombre_actividad}</p> </div></tpl>',
	       				hiddenName: 'id_actividad',
	       				forceSelection:true,
	       				typeAhead: true,
	           			triggerAction: 'all',
	           			lazyRender:true,
	       				mode:'remote',
	       				pageSize:10,
	       				queryDelay:1000,
	       				width:250,
	       				gwidth:280,
	       				minChars:2,
	       				renderer:function (value, p, record){return String.format('{0}', record.data['desc_actividad']);}
	       			},
	       			type:'ComboBox',
	       			id_grupo:0,
	       			filters:{	
	       				        pfiltro:'codigo_actividad',
	       						type:'string'
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
			filters:{pfiltro:'ppa.estado_reg',type:'string'},
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
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'ppa.fecha_reg',type:'date'},
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
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'ppa.fecha_mod',type:'date'},
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
	
	title:'Programa-Proyecto-Actividad',
	ActSave:'../../sis_parametros/control/ProgramaProyectoActtividad/insertarProgramaProyectoActtividad',
	ActDel:'../../sis_parametros/control/ProgramaProyectoActtividad/eliminarProgramaProyectoActtividad',
	ActList:'../../sis_parametros/control/ProgramaProyectoActtividad/listarProgramaProyectoActtividad',
	id_store:'id_prog_pory_acti',
	fields: [
		{name:'id_prog_pory_acti', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_proyecto', type: 'numeric'},
		{name:'id_actividad', type: 'numeric'},
		{name:'id_programa', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_programa','desc_proyecto','desc_actividad'
		
	],
	sortInfo:{
		field: 'id_prog_pory_acti',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		