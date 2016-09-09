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
        
        this.addButton('btnPlanCorreo',
            {
                iconCls: 'bemail',
                text: 'Correos extra',
                disabled: true,
                handler: this.gridPlantillaCorreo,
                tooltip: '<b>Conf. Envio de Correos</b><br/>Personaliza los correos enviados a otras personas fuera del flujo en el tipo de estado seleccionado. (Es independiente de que las alertas esten activada o no)'
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
				maxLength: 150,
				renderer: function(val){if (val != ''){return '<div class="gridmultiline">'+val+'</div>';}}
			},
			type:'TextField',
			filters: { pfiltro: 'tipes.nombre_estado', type: 'string'},
			id_grupo: 1,
			grid: true,
			form: true
		},
		{
			config:{
				name: 'etapa',
				fieldLabel: 'Etapa',
				qtip: 'Sirve para clasificar los estados,  se muestra en el diagrama gantt, la finalidad es reducir la complejidad de los nombre de estado',
				allowBlank: false,
				anchor: '70%',
				gwidth: 200,
				maxLength: 150
			},
			type:'TextField',
			filters: { pfiltro: 'tipes.estapa', type: 'string'},
			id_grupo: 1,
			grid: true,
			form: true
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
                name: 'admite_obs',
                fieldLabel: 'Admite Observaciones',
                qtip: 'permite el registros de observaciones en el estado',
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
                store:['si','no']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{   
                         type: 'list',
                         pfiltro:'tipes.admite_obs',
                         options: ['si','no'],  
                    },
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
				name: 'tipo_asignacion',
				fieldLabel: 'Tipo Asignación',
				qtip: 'define la forma de obtener el funcionario responsable, <br/> funcion_listadi: lo obtiene de lo funcionarios asignados al estado <br/>funcion_listado: funcion customizada ',
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
       		    store:['ninguno','anterior','listado','todos','funcion_listado','segun_depto']
			},
			type:'ComboBox',
			//filters:{pfiltro:'promac.inicio',type:'string'},
			id_grupo:1,
			filters:{	
	       		         type: 'list',
	       				 pfiltro:'tipes.tipo_asignacion',
	       				 options: ['ninguno','anterior','listado','todos','funcion_listado','segun_depto'],	
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
                name: 'mobile',
                fieldLabel: 'Mobile',
                qtip:'este estado es accesible desde la interface de visto bueno mobile?, si es asi posiblemente tambien necesite indicar la funcion de inicio y retroceso',
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
                store:['si','no']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{   
                         type: 'list',
                         pfiltro:'tipes.mobile',
                         options: ['si','no'],  
                    },
            grid:true,
            form:true
        },
        {
            config:{
                name: 'funcion_inicial',
                fieldLabel: 'Funcion Inicial',
                qtip:'Esta funcion se ejecuta cuando llega a este estado en flujo normal, solo corre en interface mobile o interface Visto bueno WF (generica) ejemplo tes.tes.f_fun_inicio_plan_pago_wf( p_id_usuario, v_parametros._id_usuario_ai, v_parametros._nombre_usuario_ai, v_parametros.id_estado_wf_act, v_parametros.id_proceso_wf_act, v_codigo_estado_siguiente)',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'tipes.funcion_inicial',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'funcion_regreso',
                fieldLabel: 'Funcion Regreso',
                qtip:'Esta funcion se ejecuta cuando en el flujo retrocede a este estado, solo corre en interface mobile o interface Visto bueno WF (generica) ejemplo tes.tes.f_fun_regeso_plan_pago_wf( p_id_usuario, v_parametros._id_usuario_ai, v_parametros._nombre_usuario_ai, v_parametros.id_estado_wf_act, v_parametros.id_proceso_wf_act, v_codigo_estado_siguiente)',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'tipes.funcion_regreso',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'acceso_directo_alerta',
                fieldLabel: 'Acceso Directo',
                qtip:'En el caso de tener alerta este es la direccion de la interface',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'tipes.acceso_directo_alerta',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'nombre_clase_alerta',
                fieldLabel: 'Nmbre Cls AD',
                qtip:'Nombre de clase de la interface indicada en el acceso directo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'tipes.nombre_clase_alerta',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'tipo_noti',
                fieldLabel: 'Tipo de alerta',
                qtip:'Tipo de alerta, porde fecto notificacion',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'tipes.tipo_noti',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'titulo_alerta',
                fieldLabel: 'Titulo alerta',
                qtip:'Titulo de alerta',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'tipes.tipo_titulo_alertaoti',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        
        
        {
            config:{
                name: 'parametros_ad',
                fieldLabel: 'Nombre Parametros AD',
                qtip:'Nombre de la columna que se usa como  filtro en el acceso directo, ejm plapa.id_proceso_wf',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'tipes.titulo_alerta',type:'string'},
            id_grupo:1,
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
       				name:'id_roles',
       				fieldLabel:'Roles',
       				allowBlank:true,
       				emptyText:'Roles...',
       				store: new Ext.data.JsonStore({
              			url: '../../sis_seguridad/control/Rol/listarRol',
       					id: 'id_rol',
       					root: 'datos',
       					sortInfo:{
       						field: 'rol',
       						direction: 'ASC'
       					},
       					totalProperty: 'total',
       					fields: ['id_rol','rol','descripcion'],
       					// turn on remote sorting
       					remoteSort: true,
       					baseParams:{par_filtro:'rol'}
       					
       				}),
       				valueField: 'id_rol',
       				displayField: 'rol',
       				forceSelection:true,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				width:250,
       				minChars:2,
	       			enableMultiSelect:true,
       			
       				//renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}

       			},
       			type:'AwesomeCombo',
       			id_grupo:0,
       			grid:false,
       			form:true
       	},
       	{
			config: {
				name: 'id_tipo_estado_anterior',
				fieldLabel: 'Estado Anterior',
				typeAhead: false,
				forceSelection: false,
				allowBlank: true,
				emptyText: 'Estado Anterior...',
				store: new Ext.data.JsonStore({
					url: '../../sis_workflow/control/TipoEstado/listarTipoEstado',
					id: 'id_tipo_estado',
					root: 'datos',
					sortInfo: {
						field: 'tipes.codigo',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_estado', 'nombre_estado', 'inicio','codigo_estado','disparador','fin','desc_tipo_proceso'],
                    // turn on remote sorting
					remoteSort: true,
					baseParams: {par_filtro: 'tipes.nombre_estado'}
				}),
				valueField: 'id_tipo_estado',
				displayField: 'nombre_estado',
				gdisplayField: 'desc_tipo_estado_anterior',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				anchor: '100%',
				minChars: 2,
				gwidth: 200,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_tipo_estado_anterior']);
				},
			    tpl: '<tpl for="."><div class="x-combo-list-item"><p>({codigo_estado})- {nombre_estado}</p>Inicio: <strong>{inicio}</strong>, Fin: <strong>{fin} <p>Tipo Proceso: {desc_tipo_proceso}</p></strong> </div></tpl>'
            },
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'tea.nombre_estado',
				type: 'string'
			},
			grid: true,
			form: true
		},

        {
            config:{
                name: 'icono',
                fieldLabel: 'Icono',
                allowBlank: true,
                anchor: '100%',
                gwidth: 100,
                maxLength:150,
                qtip:  'Las imagenes deben estar en pxp/lib/imagenes/'
            },
            type:'TextField',
            filters:{pfiltro:'tipes.icono',type:'string'},
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
			filters:{pfiltro:'tipes.fecha_reg',type:'date'},
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
			filters:{pfiltro:'tipes.fecha_mod',type:'date'},
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
	
	title:'Tipo Estado',
	ActSave:'../../sis_workflow/control/TipoEstado/insertarTipoEstado',
	ActDel:'../../sis_workflow/control/TipoEstado/eliminarTipoEstado',
	ActList:'../../sis_workflow/control/TipoEstado/listarTipoEstado',
	id_store:'id_tipo_estado',
	fields: [
		{name:'id_tipo_estado', type: 'numeric'},
		{name:'nombre_estado', type: 'string'},
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'id_tipo_estado_anterior', type: 'numeric'},
		{name:'desc_tipo_estado_anterior', type: 'string'},
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
		'plantilla_mensaje_asunto','plantilla_mensaje','cargo_depto','funcion_inicial','funcion_regreso',
		'mobile','acceso_directo_alerta', 'nombre_clase_alerta', 'tipo_noti', 
        'titulo_alerta', 'parametros_ad','id_roles','admite_obs','etapa','grupo_doc','icono'
		
	],
	sortInfo:{
		field: 'id_tipo_estado',
		direction: 'ASC'
	},
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_tipo_proceso:this.maestro.id_tipo_proceso};
		this.Cmp.id_tipo_estado_anterior.store.baseParams={id_tipo_proceso:this.maestro.id_tipo_proceso};
		this.load({params:{start:0, limit:50}})
		
	},
	loadValoresIniciales:function(){
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
    
    gridPlantillaCorreo:function(wizard,resp){
            var rec={maestro: this.sm.getSelected().data};
            Phx.CP.loadWindows('../../../sis_workflow/vista/plantilla_correo/PlantillaCorreo.php',
            'PlantillaCorreo',
            {
                modal:true,
                width:'80%',
                height:400
            }, rec, 
               this.idContenedor,
               'PlantillaCorreo'
            )
         
    },
    
    preparaMenu:function(n){
      Phx.vista.TipoEstado.superclass.preparaMenu.call(this,n); 
      this.getBoton('btnPlaMen').enable();
      this.getBoton('btnPlanCorreo').enable();     
      
      return this.tbar;
    },
    
    liberaMenu:function(){
        var tb = Phx.vista.TipoEstado.superclass.liberaMenu.call(this);
        if(tb){
             this.getBoton('btnPlaMen').disable();
             this.getBoton('btnPlanCorreo').disable();  
        }
        return tb
    },
    
    bdel:true,
	bsave:false
	}
)
</script>
		
		