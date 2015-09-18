<?php
/**
*@package pXP
*@file gen-Tabla.php
*@author  (admin)
*@date 07-05-2014 21:39:40
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Tabla=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Tabla.superclass.constructor.call(this,config);
		this.init();
		this.addButton('btnGenerar',
            {
                text: 'Ejecutar',
                iconCls: 'bexecdb',
                disabled: true,
                handler: this.onBtnEjecutarScript,
                tooltip: 'Ejecutar Script de Creación de Base de Datos, Columnas y Scripts Adicionales'
            }
        );
		this.iniciarEventos();
		this.load({params:{start:0, limit:this.tam_pag,id_tipo_proceso : this.maestro.id_tipo_proceso}});
		this.Cmp.vista_estados_new.store.baseParams.id_tipo_proceso = this.maestro.id_tipo_proceso;
		this.Cmp.vista_estados_delete.store.baseParams.id_tipo_proceso = this.maestro.id_tipo_proceso;
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tabla'
			},
			type:'Field',
			id_grupo:1,
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_proceso'
			},
			type:'Field',
			id_grupo:1,
			form:true 
		},
		{
			config:{
				name: 'bd_nombre_tabla',
				fieldLabel: 'Nombre Tabla',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				qtip: 'El nombre de la tabla debe ser escrito en minusculas y las palabras separadas por underscore ej: nombre_tabla. Automáticamente se creara una llave primaria con el nombre: id_nombre_tabla',
				maxLength:150
			},
				type:'TextField',
				filters:{pfiltro:'tabla.bd_nombre_tabla',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'bd_codigo_tabla',
				fieldLabel: 'Código Tabla',
				allowBlank: false,
				anchor: '100%',
				gwidth: 80,
				maxLength:25
			},
				type:'TextField',
				filters:{pfiltro:'tabla.bd_codigo_tabla',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},	
		
		{
			config:{
				name: 'bd_descripcion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '100%',
				gwidth: 150
			},
				type:'TextArea',
				filters:{pfiltro:'tabla.bd_descripcion',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},	
		
		{
			config:{
				name: 'bd_scripts_extras',
				fieldLabel: 'Scripts Extras',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				qtip: 'En este campo se puede definir llaves foraneas, indices, triggers, funciones y otros que puedan ser necesarios para la tabla'
			},
				type:'TextArea',
				filters:{pfiltro:'tabla.bd_scripts_extras',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
            config:{
                name: 'vista_tipo',
                fieldLabel: 'Tipo Vista',
                allowBlank: false,
                anchor: '100%',
                gwidth: 100,
                maxLength:50,
                emptyText:'Tipo...',                
                typeAhead: false,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',                 
              store:['maestro','detalle','detalle-modal']
            },
            type:'ComboBox',
            //filters:{pfiltro:'tipdw.tipo',type:'string'},
            id_grupo:2,
            filters:{   
                         type: 'list',
                         pfiltro:'tabla.vista_tipo',
                         options: ['maestro','detalle','detalle-modal'],   
                    },
            grid:true,
            form:true
        },
        {
			config:{
				name: 'vista_campo_ordenacion',
				fieldLabel: 'Campo Ordenación',
				allowBlank: false,
				anchor: '100%',
				gwidth: 80,
				maxLength:25
			},
				type:'TextField',
				filters:{pfiltro:'tabla.vista_campo_ordenacion',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},	
		
		{
            config:{
                name: 'vista_dir_ordenacion',
                fieldLabel: 'Dir Ordenación',
                allowBlank: false,
                anchor: '100%',
                gwidth: 100,
                maxLength:50,
                emptyText:'Dirección...',                
                typeAhead: false,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local' ,               
              store:['ASC','DESC']
            },
            type:'ComboBox',
            //filters:{pfiltro:'tipdw.tipo',type:'string'},
            id_grupo:2,
            filters:{   
                         type: 'list',
                         pfiltro:'tabla.dir_ordenacion',
                         options: ['ASC','DESC'],   
                    },
            grid:true,
            form:true
        },
        {
       			config:{
       				name:'vista_estados_new',
       				fieldLabel:'Boton Nuevo',
       				allowBlank:true,
       				emptyText:'Estados...',
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
	                    baseParams: {par_filtro: 'tipes.nombre_estado#tipes.codigo'}
	                }),
       				valueField: 'codigo_estado',
       				displayField: 'codigo_estado',
       				forceSelection:true,
       				typeAhead: false,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:100,
       				queryDelay:1000,
       				width:250,
       				minChars:2,
	       			enableMultiSelect:true,
       			
       				//renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}

       			},
       			type:'AwesomeCombo',
       			id_grupo:2,
       			grid:false,
       			form:true
       	},
       	{
       			config:{
       				name:'vista_estados_delete',
       				fieldLabel:'Boton Delete',
       				allowBlank:true,
       				emptyText:'Estados...',
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
	                    baseParams: {par_filtro: 'tipes.nombre_estado#tipes.codigo'}
	                }),
       				valueField: 'codigo_estado',
       				displayField: 'codigo_estado',
       				forceSelection:true,
       				typeAhead: false,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:100,
       				queryDelay:1000,
       				width:250,
       				minChars:2,
	       			enableMultiSelect:true,
       			
       				//renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}

       			},
       			type:'AwesomeCombo',
       			id_grupo:2,
       			grid:false,
       			form:true
       	},
		
		{
			config:{
				name: 'vista_posicion',
				fieldLabel: 'Posición',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
                maxLength:50,
                emptyText:'Tipo...',                
                typeAhead: false,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                  
              store:['north','south','east','west','xnorth','xsouth','xeast','xwest','tabnorth','tabsouth','tabeast','tabwest']
			},
				type:'ComboBox',
				filters:{   
                         type: 'list',
                         pfiltro:'tabla.vista_tipo',
                         options: ['north','south','east','west','xnorth','xsouth','xeast','xwest','tabnorth','tabsouth','tabeast','tabwest'],   
                    },
				id_grupo:2,
				grid:true,
				form:true
		},
		{
            config: {
                name: 'vista_id_tabla_maestro',
                fieldLabel: 'Tabla Maestro',
                typeAhead: false,
                forceSelection: true,
                allowBlank: false,
                hiddenName: 'vista_id_tabla_maestro',
                emptyText: 'Lista de Tablas...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_workflow/control/Tabla/listarTabla',
                    id: 'id_tabla',
                    root: 'datos',
                    sortInfo: {
                        field: 'TABLA.id_tabla',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_tabla', 'bd_nombre_tabla', 'bd_codigo_tabla'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {par_filtro: 'TABLA.bd_nombre_tabla#TABLA.bd_codigo_tabla'}
                }),
                valueField: 'id_tabla',
                displayField: 'bd_nombre_tabla',
                gdisplayField: 'bd_nombre_tabla_maestro',
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                anchor: '100%',
                minChars: 2,
                gwidth: 200,
                qtip:'La tabla que es el maestro de esta tabla',
                renderer: function(value, p, record) {
                    return String.format('{0}', record.data['nombre_tabla_maestro']);
                },
                tpl: '<tpl for="."><div class="x-combo-list-item"><p>({bd_codigo_tabla})- {bd_nombre_tabla}</p></div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 2,
            filters: {
                pfiltro: 'te.nombre_estado',
                type: 'string'
            },
            grid: true,
            form: true
        },
		{
			config:{
				name: 'vista_campo_maestro',
				fieldLabel: 'Campo Maestro',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:50,
				qtip: 'El campo del maestro con el cual se enlaza'
			},
				type:'TextField',
				filters:{pfiltro:'tabla.vista_campo_maestro',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'vista_scripts_extras',
				fieldLabel: 'Scripts Extras',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				qtip:'En este campo debe registrarse un json con los metodos que se desean sobrescribir de la clase'
			},
				type:'TextArea',
				filters:{pfiltro:'tabla.vista_scripts_extras',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},	
        
		{
			config:{
				name: 'menu_nombre',
				fieldLabel: 'Nombre',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:100
			},
				type:'TextField',
				filters:{pfiltro:'tabla.menu_nombre',type:'string'},
				id_grupo:3,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'menu_codigo',
				fieldLabel: 'Código',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:25
			},
				type:'TextField',
				filters:{pfiltro:'tabla.menu_codigo',type:'string'},
				id_grupo:3,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'menu_icono',
				fieldLabel: 'URL Icono',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:100
			},
				type:'TextField',
				filters:{pfiltro:'tabla.menu_icono',type:'string'},
				id_grupo:3,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:10
			},
				type:'TextField',
				filters:{pfiltro:'tabla.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'tabla.fecha_reg',type:'date'},
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
				filters:{pfiltro:'tabla.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Tabla',
	ActSave:'../../sis_workflow/control/Tabla/insertarTabla',
	ActDel:'../../sis_workflow/control/Tabla/eliminarTabla',
	ActList:'../../sis_workflow/control/Tabla/listarTabla',
	fheight:'80%',
	fwidth:'800',
	id_store:'id_tabla',
	fields: [
		{name:'id_tabla', type: 'numeric'},
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'vista_id_tabla_maestro', type: 'numeric'},
		{name:'bd_scripts_extras', type: 'string'},
		{name:'vista_estados_new', type: 'string'},
		{name:'vista_estados_delete', type: 'string'},
		{name:'bd_scripts_extras', type: 'string'},
		{name:'vista_campo_maestro', type: 'string'},
		{name:'vista_scripts_extras', type: 'string'},
		{name:'bd_descripcion', type: 'string'},
		{name:'vista_tipo', type: 'string'},
		{name:'menu_icono', type: 'string'},
		{name:'menu_nombre', type: 'string'},
		{name:'vista_campo_ordenacion', type: 'string'},
		{name:'vista_posicion', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'menu_codigo', type: 'string'},
		{name:'bd_nombre_tabla', type: 'string'},
		{name:'nombre_tabla_maestro', type: 'string'},
		{name:'bd_codigo_tabla', type: 'string'},
		{name:'vista_dir_ordenacion', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_tabla',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function()
    {
    	this.Cmp.id_tipo_proceso.setValue(this.maestro.id_tipo_proceso);
    	this.Cmp.vista_tipo.setValue('maestro'); 
    	this.Cmp.vista_dir_ordenacion.setValue('DESC');        
        Phx.vista.Tabla.superclass.loadValoresIniciales.call(this);        
    },
    iniciarEventos : function() {
    	this.Cmp.vista_tipo.on('select',this.onVistaTipoSelect,this);
    },
    
    onVistaTipoSelect : function (i, r) {
    	if (r.data.field1 == 'maestro') {
    		this.habilitaCamposMaestro();
    	} else {
    		this.habilitaCamposDetalle(r.data.field1);
    	}    	
    },
    onButtonNew : function () {
    	Phx.vista.Tabla.superclass.onButtonNew.call(this);
    	this.habilitaCamposMaestro();
    },
    onButtonEdit : function () {
    	Phx.vista.Tabla.superclass.onButtonEdit.call(this);
    	if (this.sm.getSelected().data.vista_tipo == 'maestro') {
    		this.habilitaCamposMaestro();
    	} else {
    		this.habilitaCamposDetalle(this.sm.getSelected().data.vista_tipo);
    	}
    },
    
    habilitaCamposMaestro : function () {
    	this.Cmp.vista_posicion.allowBlank = true;
    	this.ocultarComponente(this.Cmp.vista_posicion);
    	
    	this.Cmp.vista_id_tabla_maestro.allowBlank = true;
    	this.ocultarComponente(this.Cmp.vista_id_tabla_maestro);    	
    	this.Cmp.vista_campo_maestro.allowBlank = false;
    	this.ocultarComponente(this.Cmp.vista_campo_maestro);
    	
    	this.mostrarGrupo(3);
    	this.Cmp.menu_nombre.allowBlank = false;
    	//this.Cmp.menu_codigo.allowBlank = false;
    	this.Cmp.menu_icono.allowBlank = true;  
    },
    habilitaCamposDetalle : function (tipo_detalle) {
    	if (tipo_detalle == 'detalle') {
    		//habilitar el campo de posicion
    		this.Cmp.vista_posicion.allowBlank = false;
    		this.mostrarComponente(this.Cmp.vista_posicion);
    	} else {
    		this.Cmp.vista_posicion.allowBlank = true;
    		this.ocultarComponente(this.Cmp.vista_posicion);
    	}
    	this.Cmp.vista_id_tabla_maestro.allowBlank = false;
    	this.mostrarComponente(this.Cmp.vista_id_tabla_maestro);
    	
    	this.Cmp.vista_campo_maestro.allowBlank = false;
    	this.mostrarComponente(this.Cmp.vista_campo_maestro);
    	
    	this.ocultarGrupo(3);
    	this.Cmp.menu_nombre.allowBlank = true;
    	this.Cmp.menu_codigo.allowBlank = true;
    	this.Cmp.menu_icono.allowBlank = true;    	
    	
    },
    preparaMenu : function () {
    	this.getBoton('btnGenerar').enable();
    	Phx.vista.Tabla.superclass.preparaMenu.call(this);
    },
    liberaMenu : function () {
    	this.getBoton('btnGenerar').disable();
    	Phx.vista.Tabla.superclass.liberaMenu.call(this);
    },
    onBtnEjecutarScript : function (params){
    	var rec = this.sm.getSelected();		
		Ext.Ajax.request({
				url:'../../sis_workflow/control/Tabla/ejecutarScriptTabla',
				success:this.successDel,
				failure:this.conexionFailure,
				params:{'id_tabla':rec.data.id_tabla },
				timeout:this.timeout,
				scope:this
			})
    	    	
    },
	Grupos: [
            {
                layout: 'column',
                border: false,
                // defaults are applied to all child items unless otherwise specified by child item
                defaults: {
                   // columnWidth: '.5',
                    border: false
                },            
                items: [{
					        bodyStyle: 'padding-right:5px;',
					        items: [{
					            xtype: 'fieldset',
					            title: '1. Base de Datos',
					            autoHeight: true,
					            items: [],
						        id_grupo:1
					        },
					        {
					            xtype: 'fieldset',
					            title: '3. Menu',
					            autoHeight: true,
					            items: [],
						        id_grupo:3
					        }]
					    }, {
					        bodyStyle: 'padding-left:5px;',
					        items: [{
					            xtype: 'fieldset',
					            title: '2. Vista',
					            autoHeight: true,
					            items: [],
						        id_grupo:2
					        }]
					    }]
            }
        ]
	}
)
</script>
		
		