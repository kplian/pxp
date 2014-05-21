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
		this.bloquearMenus();
		
		this.addButton('btnPlaMen',
            {
                text: 'Plantilla de Correo',
                iconCls: 'bchecklist',
                disabled: true,
                handler: this.formPlantilleMensaje,
                tooltip: '<b>Plantilla de Correo</b><br/>Personaliza los correos enviados en alertas en tipo de estado seleccionado.'
            }
        ); 
		
		
		
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
			config: {
				name: 'id_tipo_proceso',
				inputType:'hidden',
				},
			type: 'Field',
			form: true
		},
        {
            config:{
                name: 'codigo_estado',
                fieldLabel: 'Código Estado',
                allowBlank: false,
                anchor: '70%',
                gwidth: 100,
                maxLength:150
            },
            type:'TextField',
            filters:{pfiltro:'tipes.codigo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'nombre_estado',
				fieldLabel: 'Nombre Estado',
				allowBlank: false,
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
			config:{
				name: 'inicio',
				fieldLabel: 'Inicio (raiz)?',
				allowBlank: false,
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
			//filters:{pfiltro:'promac.inicio',type:'string'},
			id_grupo:1,
			filters:{	
	       		         type: 'list',
	       				 pfiltro:'tipes.inicio',
	       				 options: ['si','no'],	
	       		 	},
			grid:true,
			form:true
		},
        {
            config:{
                name:'fin',
                fieldLabel:'Fin ?',
                allowBlank: false,
                anchor:'40%',
                gwidth:50,
                maxLength:2,
                emptyText:'si/no...',                   
                typeAhead:true,
                triggerAction:'all',
                lazyRender:true,
                mode:'local',
                valueField:'inicio',                   
               // displayField: 'descestilo',
                store:['si','no']
            },
            type:'ComboBox',
            //filters:{pfiltro:'promac.inicio',type:'string'},
            id_grupo:1,
            filters:{type: 'list',
                     pfiltro:'tipes.fin',
                     options: ['si','no']
                    },
            grid:true,
            form:true
        },
		{
			config:{
				name: 'disparador',
				fieldLabel: 'Disparador (bifurcación)?',
				allowBlank: false,
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
       		    store:['si','no']
			},
			type:'ComboBox',
			//filters:{pfiltro:'promac.inicio',type:'string'},
			id_grupo:1,
			filters:{	
	       		         type: 'list',
	       				 pfiltro:'tipes.disparador',
	       				 options: ['si','no'],	
	       		 	},
			grid:true,
			form:true
		},
        {
            config:{
                name: 'alerta',
                fieldLabel: 'Alertar',
                allowBlank: false,
                anchor: '40%',
                gwidth: 50,
                maxLength:2,
                emptyText:'si/no...',                   
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                valueField: 'alerta',                   
               // displayField: 'descestilo',
                store:['si','no']
            },
            type:'ComboBox',
            //filters:{pfiltro:'promac.inicio',type:'string'},
            id_grupo:1,
            filters:{   
                         type: 'list',
                         pfiltro:'tipes.alerta',
                         options: ['si','no'],  
                    },
            grid:true,
            form:true
        },
        {
            config:{
                name: 'pedir_obs',
                fieldLabel: 'Pedir Instrucciones?',
                allowBlank: false,
                anchor: '40%',
                gwidth: 50,
                maxLength:2,
                emptyText:'si/no...',                   
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                valueField: 'pedir_obs',                   
               // displayField: 'descestilo',
                store:['si','no']
            },
            type:'ComboBox',
            //filters:{pfiltro:'promac.inicio',type:'string'},
            id_grupo:1,
            filters:{   
                         type: 'list',
                         pfiltro:'tipes.pedir_obs',
                         options: ['si','no'],  
                    },
            grid:true,
            form:true
        },
		{
			config:{
				name: 'tipo_asignacion',
				fieldLabel: 'Tipo Asignación',
				allowBlank: false,
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
       		    store:['ninguno','anterior','listado','todos','funcion_listado']
			},
			type:'ComboBox',
			//filters:{pfiltro:'promac.inicio',type:'string'},
			id_grupo:1,
			filters:{	
	       		         type: 'list',
	       				 pfiltro:'tipes.tipo_asignacion',
	       				 options: ['ninguno','anterior','listado','todos','funcion_listado'],	
	       		 	},
			grid:true,
			form:true
		},
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
                name: 'depto_asignacion',
                fieldLabel: 'Depto Asignación',
                allowBlank: false,
                anchor: '70%',
                gwidth: 150,
                maxLength:50,
                emptyText:'Tipo...',                
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                valueField: 'depto_asignacion',                  
               // displayField: 'descestilo',
                store:['ninguno','anterior','depto_listado','depto_func_list']
            },
            type:'ComboBox',
            //filters:{pfiltro:'promac.inicio',type:'string'},
            id_grupo:1,
            filters:{   
                         type: 'list',
                         pfiltro:'tipes.depto_asignacion',
                         options: ['ninguno','anterior','depto_listado','depto_func_list'],   
                    },
            grid:true,
            form:true
        },
        {
            config:{
                name: 'nombre_depto_func_list',
                fieldLabel: 'Nombre Función de Listado',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'tipes.nombre_depto_func_list',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                    name:'cargo_depto',
                    fieldLabel:'Cargo',
                    qtip:'En este campo se defines los  cargos que reciben alerta,  si no se marca niguno se los manda a todos',
                    tinit:false,
                    resizable:true,
                    tasignacion:false,
                    allowBlank:true,
                    store: new Ext.data.JsonStore({
                            url: '../../sis_parametros/control/Catalogo/listarCatalogoCombo',
                            id: 'id_catalogo',
                            root: 'datos',
                            sortInfo:{
                                field: 'descripcion',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_catalogo','codigo','descripcion'],
                            // turn on remote sorting
                            remoteSort: true,
                            baseParams: {par_filtro:'descripcion',
                                         cod_subsistema : 'PARAM',
                                         catalogo_tipo : 'tdepto_usuario_cargo'}
                        }),
                    
                    valueField: 'descripcion',
                    displayField: 'descripcion',
                    gdisplayField: 'cargo_depto',
                    hiddenName: 'catalogo',
                    forceSelection:true,
                    typeAhead: false,
                    triggerAction: 'all',
                    lazyRender:true,
                    mode:'remote',
                    pageSize:10,
                    queryDelay:1000,
                    width:250,
                    enableMultiSelect:true,
                    minChars:2
                },
                type:'AwesomeCombo',
                id_grupo:0,
                grid:true,
                form:true
        },
        
        
        {
            config:{
                name: 'obs',
                fieldLabel: 'Obs(config adicional)',
                allowBlank: true,
                anchor: '70%',
                gwidth: 200,
                maxLength:150
            },
            type:'TextArea',
            filters:{pfiltro:'tipes.obs',type:'string'},
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
		'alerta','pedir_obs', 'codigo_estado','obs','depto_asignacion','fin','nombre_depto_func_list',
		'plantilla_mensaje_asunto','plantilla_mensaje','cargo_depto'
		
	],
	sortInfo:{
		field: 'id_tipo_estado',
		direction: 'ASC'
	},
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_tipo_proceso:this.maestro.id_tipo_proceso};
		this.load({params:{start:0, limit:50}})
		
	},
	loadValoresIniciales:function()
	{
		Phx.vista.TipoEstado.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_tipo_proceso').setValue(this.maestro.id_tipo_proceso);		
	},
	tabsouth:[
	     {
          url:'../../../sis_workflow/vista/estructura_estado/EstructuraEstadoHijo.php',
          title:'Hijos', 
          height:'50%',
          cls:'EstructuraEstadoHijo'
         },
	      {
		   url:'../../../sis_workflow/vista/estructura_estado/EstructuraEstadoPadre.php',
		   title:'Padres', 
		   //width:'50%',
		   height:'50%',
		   cls:'EstructuraEstadoPadre'
		 },
		 {
          url:'../../../sis_workflow/vista/funcionario_tipo_estado/FuncionarioTipoEstado.php',
          title:'Funcionarios', 
          height:'50%',
          cls:'FuncionarioTipoEstado'
         }
	
	   ],
	
	formPlantilleMensaje:function(wizard,resp){
            var rec=this.sm.getSelected();
            Phx.CP.loadWindows('../../../sis_workflow/vista/tipo_estado/PlantillaMensaje.php',
            'Estado de Wf',
            {
                modal:true,
                width:'80%',
                height:400
            }, {data:rec.data}, 
               this.idContenedor,
               'PlantillaMensaje'
            )
         
    },
    
    preparaMenu:function(n){
      Phx.vista.TipoEstado.superclass.preparaMenu.call(this,n); 
      this.getBoton('btnPlaMen').enable();
      return this.tbar;
    },
    
    liberaMenu:function(){
        var tb = Phx.vista.TipoEstado.superclass.liberaMenu.call(this);
        if(tb){
             this.getBoton('btnPlaMen').disable();
        }
        return tb
    },
    
    bdel:true,
	bsave:false
	}
)
</script>
		
		