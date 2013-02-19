<?php
/**
*@package pXP
*@file Ep.php
*@author  Gonzalo Sarmiento Sejas
*@date 06-02-2013 19:20:32
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
				name: 'ep',
				fieldLabel: 'Codigo EP',
				allowBlank: true,
				anchor: '80%',
				gwidth: 150,
				maxLength:4
			},
			type:'Field',
			filters:{pfiltro:'ep',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
       			config:{
       				name:'id_financiador',
       				fieldLabel:'Financiador',
       				allowBlank:false,
       				emptyText:'Financiador...',
       				store: new Ext.data.JsonStore({

    					url: '../../sis_parametros/control/Financiador/ListarFinanciador',
    					id: 'id_financiador',
    					root: 'datos',
    					sortInfo:{
    						field: 'codigo_financiador',
    						direction: 'ASC'
    					},
    					totalProperty: 'total',
    					fields: ['id_financiador','codigo_financiador','nombre_financiador'],
    					// turn on remote sorting
    					remoteSort: true,
    					baseParams:{par_filtro:'codigo_financiador#nombre_financiador'}
    				}),
       				valueField: 'id_financiador',
       				displayField: 'codigo_financiador',
       				gdisplayField:'codigo_financiador',//mapea al store del grid
       				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo_financiador}</p><p>{nombre_financiador}</p> </div></tpl>',
       				hiddenName: 'id_financiador',
       				forceSelection:true,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				width:250,
       				gwidth:280,
       				listWidth:'280',
       				minChars:2,
       				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_financiador']);}
       			},
       			type:'ComboBox',
       			id_grupo:0,
       			filters:{	
       				        pfiltro:'nombre_financiador',
       						type:'string'
       					},
       		   
       			grid:true,
       			form:true
       	},
       	{
       			config:{
       				name:'id_regional',
       				fieldLabel:'Regional',
       				allowBlank:false,
       				emptyText:'Regional...',
       				store: new Ext.data.JsonStore({

    					url: '../../sis_parametros/control/Regional/ListarRegional',
    					id: 'id_regional',
    					root: 'datos',
    					sortInfo:{
    						field: 'codigo_regional',
    						direction: 'ASC'
    					},
    					totalProperty: 'total',
    					fields: ['id_regional','codigo_regional','nombre_regional'],
    					// turn on remote sorting
    					remoteSort: true,
    					baseParams:{par_filtro:'codigo_regional#nombre_regional'}
    				}),
       				valueField: 'id_regional',
       				displayField: 'codigo_regional',
       				gdisplayField:'codigo_regional',//mapea al store del grid
       				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo_regional}</p><p>{nombre_regional}</p> </div></tpl>',
       				hiddenName: 'id_regional',
       				forceSelection:true,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				width:250,
       				gwidth:280,
       				listWidth:'280',
       				minChars:2,
       				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_regional']);}
       			},
       			type:'ComboBox',
       			id_grupo:0,
       			filters:{	
       				        pfiltro:'nombre_regional',
       						type:'string'
       					},
       		    grid:true,
       			form:true
       	},
		{
       			config:{
       				name:'id_prog_pory_acti',
       				fieldLabel:'Prog. Proy. Act.',
       				allowBlank:false,
       				emptyText:'Prog. Proy. Act....',
       				store: new Ext.data.JsonStore({

    					url: '../../sis_parametros/control/ProgramaProyectoActtividad/ListarProgramaProyectoActtividad',
    					id: 'prog_pory_acti',
    					root: 'datos',
    					sortInfo:{
    						field: 'id_prog_pory_acti',
    						direction: 'ASC'
    					},
    					totalProperty: 'total',
    					fields: ['id_prog_pory_acti','desc_programa','desc_proyecto','desc_actividad','codigo_ppa'],
    					// turn on remote sorting
    					remoteSort: true,
    					baseParams:{par_filtro:'codigo_programa#codigo_actividad#codigo_proyecto#nombre_programa#nombre_proyecto#nombre_actividad'}
    				}),
       				valueField: 'id_prog_pory_acti',
       				displayField: 'codigo_ppa',
       				gdisplayField:'desc_ppa',//mapea al store del grid
       				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{desc_programa}</p><p>{desc_proyecto}</p> <p>{desc_actividad}</p></div></tpl>',
       				hiddenName: 'id_regional',
       				forceSelection:true,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				listWidth:'280',
       				width:250,
       				gwidth:280,
       				minChars:2,
       				renderer:function (value, p, record){return String.format('{0}', record.data['desc_ppa']);}
       			},
       			type:'ComboBox',
       			id_grupo:0,
       	        filters:{pfiltro:'desc_ppa',type:'string'},
					id_grupo:1,
					grid:true,
					form:true
		}/*,
		{
			config:{
				name: 'sw_presto',
				fieldLabel: 'Sw Presto',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'frpp.sw_presto',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:false
		}*/,
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
			filters:{pfiltro:'estado_reg',type:'string'},
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
			filters:{pfiltro:'fecha_reg',type:'date'},
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
			filters:{pfiltro:'usr_reg',type:'string'},
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
			filters:{pfiltro:'fecha_mod',type:'date'},
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
			type:'Field',
			filters:{pfiltro:'usr_mod',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'EP',
	ActSave:'../../sis_parametros/control/Ep/insertarEp',
	ActDel:'../../sis_parametros/control/Ep/eliminarEp',
	ActList:'../../sis_parametros/control/Ep/listarEp',
	id_store:'id_ep',
	fields: [
		{name:'id_ep', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_financiador', type: 'numeric'},
		{name:'id_prog_pory_acti', type: 'numeric'},
		{name:'id_regional', type: 'numeric'},
		{name:'sw_presto', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'codigo_regional','codigo_financiador','desc_ppa','ep',
		'nombre_regional',
		'nombre_financiador'
		
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
		
		