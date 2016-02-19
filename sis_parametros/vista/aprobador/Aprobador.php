<?php
/**
*@package pXP
*@file gen-Aprobador.php
*@author  (admin)
*@date 09-01-2013 23:03:33
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Aprobador=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Aprobador.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_aprobador'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_subsistema',
				origen:'SUBSISTEMA',
	   			tinit:false,
				fieldLabel: 'Sistema',
				gdisplayField:'desc_subsistema',//mapea al store del grid
				allowBlank: false,
				gwidth: 200,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_subsistema']);}
			},
			type:'ComboRec',
			filters:{pfiltro:'sub.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
        {
            config: {
                name: 'id_proceso_macro',
                fieldLabel: 'Proceso',
                typeAhead: false,
                forceSelection: false,
                 hiddenName: 'id_proceso_macro',
                allowBlank: true,
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
                listWidth:280,
                minChars: 2,
                gwidth: 170,
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
            config:{
                    name:'id_uo_cargo',
                    origen:'UO',
                    fieldLabel:'Cargo',
                    emptyText:'Cargo Aprobador...',
                    displayField: 'nombre_cargo',
                    allowBlank:true,
                    gdisplayField:'desc_uo_cargo',//mapea al store del grid
                    gwidth:200,
                    baseParams:{presupuesta:'si'},
                    tpl:'<tpl for="."><div class="x-combo-list-item">{codigo}<p>{nombre_cargo}</p> </div></tpl>',
                    renderer:function (value, p, record){return String.format('{0}', record.data['desc_uo_cargo']);}
                },
            type:'ComboRec',
            id_grupo:0,
            filters:{pfiltro:'uoc.nombre_unidad',type:'string'},
            grid:true,
            form:true
       }
        
        ,
		{
		   			config:{
		       		    name:'id_funcionario',
		   				origen:'FUNCIONARIO',
		   				fieldLabel:'Funcionario',
		   				allowBlank:true,
		                gwidth:200,
		   				valueField: 'id_funcionario',
		   			    gdisplayField: 'desc_funcionario',
		      			renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario']);}
		       	     },
		   			type:'ComboRec',//ComboRec
		   			id_grupo:0,
		   			filters:{pfiltro:'fun.desc_funcionario1',type:'string'},
		   		    grid:true,
		   			form:true
		 } ,
         {
            config:{
                    name:'id_uo',
                    origen:'UO',
                    fieldLabel:'Unidad',
                    allowBlank:true,
                    gdisplayField:'desc_uo',//mapea al store del grid
                    gwidth:200,
                    baseParams:{presupuesta:'si'},
                    renderer:function (value, p, record){return String.format('{0}', record.data['desc_uo']);}
                },
            type:'ComboRec',
            id_grupo:0,
            filters:{pfiltro:'uo.nombre_unidad',type:'string'},
            grid:true,
            form:true
       },
	    {
	   		config:{
	   				name:'id_ep',
	   				origen:'EP',
	   				fieldLabel:'EP',
	   				allowBlank:true,
	   				valueField: 'id_ep',
	   				gdisplayField:'desc_ep',//mapea al store del grid
	   			    gwidth:200,
	   			    renderer:function (value, p, record){return String.format('{0}', record.data['desc_ep']);}
	      		},
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'ep.ep',type:'string'},
   		    grid:true,
   			form:true
	    },
			{
			config:{
				name: 'id_centro_costo',
				origen:'CENTROCOSTO',
	   			tinit:false,
				fieldLabel: 'Centro de Costos',
				gdisplayField:'desc_cc',//mapea al store del grid
				allowBlank: true,
				gwidth: 200,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_cc']);}
			},
			type:'ComboRec',
			filters:{pfiltro:'cc.codigo_cc',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'monto_min',
				currencyChar:'Bs',
				fieldLabel: 'Monto Min.',
				allowBlank: false,
				gwidth: 100,
				renderer:bolFormatter
		      		
			},
			type:'MoneyField',
			filters:{pfiltro:'apro.monto_min',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'monto_max',
				currencyChar:'Bs',
				fieldLabel: 'Monto Max.',
				allowBlank: true,
				gwidth: 100,
				renderer:bolFormatter
			},
			type:'MoneyField',
			filters:{pfiltro:'apro.monto_max',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_ini',
				fieldLabel: 'Fecha Inicio',
				allowBlank: false,
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'apro.fecha_ini',type:'date'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_fin',
				fieldLabel: 'Fecha Fin',
				allowBlank: true,
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'apro.fecha_fin',type:'date'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'obs',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:255
			},
			type:'TextArea',
			filters:{pfiltro:'apro.obs',type:'string'},
			id_grupo:0,
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
			filters:{pfiltro:'apro.estado_reg',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		}
		,
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
			filters:{pfiltro:'apro.fecha_reg',type:'date'},
			id_grupo:0,
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
			id_grupo:0,
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
			filters:{pfiltro:'apro.fecha_mod',type:'date'},
			id_grupo:0,
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
			id_grupo:0,
			grid:true,
			form:false
		}
	],
	
	title:'Aprobador',
	ActSave:'../../sis_parametros/control/Aprobador/insertarAprobador',
	ActDel:'../../sis_parametros/control/Aprobador/eliminarAprobador',
	ActList:'../../sis_parametros/control/Aprobador/listarAprobador',
	id_store:'id_aprobador',
	fields: [
		{name:'id_aprobador', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_centro_costo', type: 'numeric'},
		{name:'monto_min', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'obs', type: 'string'},
		{name:'id_uo', type: 'numeric'},
		{name:'fecha_ini', type: 'date',dateFormat:'Y-m-d'},
		{name:'monto_max', type: 'numeric'},
		{name:'fecha_fin', type: 'date',dateFormat:'Y-m-d'},
		{name:'id_subsistema', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'id_ep', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'desc_uo','desc_ep',
		'desc_funcionario','desc_cc',
		'desc_subsistema','id_uo_cargo',
		'desc_uo_cargo','id_proceso_macro',
		'desc_proceso_macro'
		
	],
	sortInfo:{
		field: 'id_aprobador',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		
