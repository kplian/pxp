<?php
/**
*@package pXP
*@file gen-ProcesoMacro.php
*@author  (FRH)
*@date 19-02-2013 13:51:29
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ProcesoMacro=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ProcesoMacro.superclass.constructor.call(this,config);
		this.init();
		
		this.addButton('exp_menu',{text:'Exportar Proceso Macro',iconCls: 'blist',disabled:true,tooltip: '<b>Permite exportar los datos del proceso macro</b>',
                		menu:{
                   				items: [
                   				{
                   					text: 'Exportar Cambios Realizados', handler: this.expProceso, scope: this, argument : {todo:'no'}
                   				},{
                   					text: 'Exportar Todos los datos del Proceso', handler: this.expProceso, scope: this, argument : {todo : 'si'}
                   				}
                   				]
                   			}
                   		});
		this.load({params:{start:0, limit:50}})
	},
	
	expProceso : function(resp){
			var data=this.sm.getSelected().data.id_proceso_macro;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url:'../../sis_workflow/control/ProcesoMacro/exportarDatosWf',
				params:{'id_proceso_macro' : data, 'todo' : resp.argument.todo},
				success:this.successExport,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
			
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_proceso_macro'
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
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_subsistema']);}
			},
			type:'ComboRec',
			filters:{pfiltro:'subs.nombre',type:'string'},
			bottom_filter: true,
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
				gwidth: 200,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'promac.nombre',type:'string'},
			bottom_filter: true,
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: true,
				anchor: '40%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'promac.codigo',type:'string'},
			bottom_filter: true,
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'inicio',
				fieldLabel: 'Inicio del proceso (Nodo inicial)',
				allowBlank: true,
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
			//filters:{pfiltro:'promac.inicio',type:'string'},
			id_grupo:1,
			filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['si','no'],	
	       		 	},
			grid:true,
			form:true
		},
		
		{
            config:{
                name: 'grupo_doc',
                fieldLabel:  'Agrupadores Doc',
                qtip:  'Aca se configura que pestañas aparecen el la interface de coumentos, (se intorduce código javascript), no usar comilla simple',
                allowBlank:  true,
                anchor:  '70%',
                gwidth:  200,
                maxLength:  1000
            },
            type: 'TextArea',
            filters: { pfiltro: 'tipes.obs', type: 'string' },
            id_grupo: 1,
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
			filters:{pfiltro:'promac.estado_reg',type:'string'},
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
			filters:{pfiltro:'promac.fecha_reg',type:'date'},
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
			filters:{pfiltro:'promac.fecha_mod',type:'date'},
			id_grupo:1,
			grid:false,
			form:false
		}
	],
	
	title:'Proceso Macro',
	ActSave:'../../sis_workflow/control/ProcesoMacro/insertarProcesoMacro',
	ActDel:'../../sis_workflow/control/ProcesoMacro/eliminarProcesoMacro',
	ActList:'../../sis_workflow/control/ProcesoMacro/listarProcesoMacro',
	id_store:'id_proceso_macro',
	fields: [
		{name:'id_proceso_macro', type: 'numeric'},
		{name:'id_subsistema', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'inicio', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_subsistema', type: 'string'},'grupo_doc'
		
	],
	sortInfo:{
		field: 'id_proceso_macro',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	tabsouth:[{
		  url:'../../../sis_workflow/vista/num_tramite/NumTramite.php',
		  title:'Numero de tramite', 
		  height:'35%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'NumTramite'
		}		
	],
	preparaMenu:function(tb){
			
			this.getBoton('exp_menu').enable();
			Phx.vista.ProcesoMacro.superclass.preparaMenu.call(this,tb)
			return tb
		},
	 
	 liberaMenu:function(tb){
		
			this.getBoton('exp_menu').disable();
			Phx.vista.ProcesoMacro.superclass.liberaMenu.call(this,tb)
			return tb
		}
}
)
</script>
		
		