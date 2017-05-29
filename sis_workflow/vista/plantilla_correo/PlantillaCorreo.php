<?php
/**
*@package pXP
*@file gen-PlantillaCorreo.php
*@author  (jrivera)
*@date 20-08-2014 21:52:38
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PlantillaCorreo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PlantillaCorreo.superclass.constructor.call(this,config);		
		this.init();
		this.load({params:{start:0, limit:this.tam_pag,id_tipo_estado:this.maestro.id_tipo_estado}});
		this.Cmp.documentos.store.baseParams.id_tipo_proceso = this.maestro.id_tipo_proceso;
	},
	fwidth: '80%',
	fheight:'90%',
	Grupos : [{ 
				layout: 'column',
				xtype: 'panel',
				width:'100%',
				border: false,
				padding : '0 0 0 0',							
				items:[
					{
						xtype:'fieldset',
						//region: 'north',
						layout: 'column',
						border:false,		                
		                title: 'Plantilla',
		                width:'70%',
		                padding: '0 0 0 0',
		                columnWidth: 0.6,
		                items:[],		                
				        id_grupo:1,
				        collapsible:false
					},{
						xtype:'fieldset',
						layout: 'form',
						//region: 'center',
		                border: true,
		                title: 'Datos',
		                width:'40%',
		                padding: '0 0 0 0',
		                columnWidth: 0.4,
		                items:[],
		                id_grupo:2,				        
				        collapsible:false
					}
					]
				}],
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_plantilla_correo'
			},
			type:'Field',
			form:true 
		},
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
				name: 'codigo_plantilla',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
				type:'TextField',
				filters:{pfiltro:'pcorreo.codigo_plantilla',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},
		{
            config:{
                name: 'asunto',
                fieldLabel: 'Asunto',
                allowBlank: true,
                anchor: '90%',
                gwidth: 100,
                maxLength: 255
            },
            type:'TextField',
            id_grupo:2,
            form:true,
            grid:true,
        },
		{
			config:{
				name: 'regla',
				fieldLabel: 'Regla',
				qtip:'Si no se define una regla el correo siempre es enviado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100
			},
				type:'TextArea',
				filters:{pfiltro:'pcorreo.regla',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'plantilla',				
				allowBlank: true,
				anchor: '98%',
				qtip:'Si no se define esta plantilla se utilizará la plantilla del estado',
				gwidth: 100
			},
				type:'HtmlEditor',
				//filters:{pfiltro:'pcorreo.plantilla',type:'string'},
				id_grupo:1,
				grid:false,
				form:true
		},
		{
			config:{
				name: 'correos',
				fieldLabel: 'Para',
				allowBlank: false,
				anchor: '80%',
				qtip:'Es posible registrar campos de la tabla definida en tipo proceso, los cuales deben estar entre llaves.<br> Ej: {$tabla.correo_proveedor}',
				gwidth: 100,
				maxLength:255
			},
				type:'TextArea',
				filters:{pfiltro:'pcorreo.correos',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},

        {
            config:{
                name: 'cc',
                fieldLabel: 'CC',
                allowBlank: true,
                anchor: '80%',
                qtip:'Es posible registrar campos de la tabla definida en tipo proceso, los cuales deben estar entre llaves.<br> Ej: {$tabla.correo_proveedor}',
                gwidth: 100,
                maxLength:255
            },
            type:'TextArea',
            filters:{pfiltro:'pcorreo.cc',type:'string'},
            id_grupo:2,
            grid:true,
            form:true
        },

        {
            config:{
                name: 'bcc',
                fieldLabel: 'BCC',
                allowBlank: true,
                anchor: '80%',
                qtip:'Es posible registrar campos de la tabla definida en tipo proceso, los cuales deben estar entre llaves.<br> Ej: {$tabla.correo_proveedor}',
                gwidth: 100,
                maxLength:255
            },
            type:'TextArea',
            filters:{pfiltro:'pcorreo.bcc',type:'string'},
            id_grupo:2,
            grid:true,
            form:true
        },
		
		{
       			config:{
       				name:'documentos',
       				fieldLabel:'Documentos',
       				allowBlank:true,
       				emptyText:'documentos...',
       				store: new Ext.data.JsonStore({
	                    url: '../../sis_workflow/control/TipoDocumento/listarTipoDocumento',
	                    id: 'id_tipo_documento',
	                    root: 'datos',
	                    sortInfo: {
	                        field: 'tipdw.codigo',
	                        direction: 'ASC'
	                    },
	                    totalProperty: 'total',
	                    fields: ['id_tipo_documento', 'codigo', 'nombre','descripcion'],
	                    // turn on remote sorting
	                    remoteSort: true,
	                    baseParams: {par_filtro: 'tipdw.nombre#tipdw.codigo'}
	                }),
       				valueField: 'id_tipo_documento',
       				displayField: 'nombre',
       				forceSelection:true,
       				typeAhead: false,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:100,
       				queryDelay:1000,
       				width:250,
       				minChars:2,
       				qtip:'Adjuntos a enviar con el correo',
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
				name: 'mandar_automaticamente',
				fieldLabel: 'Env. Aut.',
				qtip: 'Mandar el correo automaticamente cuando llegue al estado correpondiente, o, espera confirmación para el envio',
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
			id_grupo:2,
			valorInicial: 'no',
			filters:{	
	       		         type: 'list',
	       				 pfiltro:'pcorreo.reuiere_acuse',
	       				 options: ['si','no'],	
	       		 	},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'requiere_acuse',
				fieldLabel: 'Acuse?',
				qtip: 'incluir o no , el link para acuse recibo en el correo',
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
			id_grupo:2,
			valorInicial: 'no',
			filters:{	
	       		         type: 'list',
	       				 pfiltro:'pcorreo.mandar_automaticamente',
	       				 options: ['si','no'],	
	       		 	},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'url_acuse',
				fieldLabel: 'URL Acuse',
				allowBlank: true,
				anchor: '80%',
				qtip:'dirección donde apuntare el lin de acuse, se manda como parametro get el id_alarma',
				gwidth: 100,
				maxLength:255
			},
				type:'TextArea',
				filters:{pfiltro:'pcorreo.url_acuse',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'mensaje_link_acuse',
				fieldLabel: 'Mensaje link ',
				allowBlank: true,
				anchor: '80%',
				qtip:'Este es el mensaje que va por encima del linl de acuse de recibo en el correo electrónico',
				gwidth: 100,
				maxLength:255
			},
				type:'TextArea',
				filters:{pfiltro:'pcorreo.mensaje_link_acuse',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'mensaje_acuse',
				fieldLabel: 'Mensaje Acuse',
				allowBlank: true,
				anchor: '80%',
				qtip:'Una vez que acepta el acuse se le muestre este mensaje, acepta html',
				gwidth: 100,
				maxLength:255
			},
				type:'TextArea',
				filters:{pfiltro:'pcorreo.mensaje_acuse',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},
       	
       	
       	
		{
			config:{
				name: 'funcion_acuse_recibo',
				fieldLabel: 'Funcion acuse',
				qtip: 'Esta función se ejecuta al recibir el acuse de recibo, ejem  adq.f_acuse_orden_compra, recibe como parametro el (id_alarma, id_proceso_wf, id_estado_wf)',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
				type:'TextField',
				filters:{pfiltro:'pcorreo.funcion_acuse_recibo',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},
       	
       	
       	
		{
			config:{
				name: 'funcion_creacion_correo',
				fieldLabel: 'Funcion creación',
				qtip: 'Esta función se ejecuta al insertar la alarma , o al modificar el estado de envio, ejem  adq.f_orden_compra_pendiente_envio, recibe como parametro el (id_alarma, id_proceso_wf, id_estado_wf)',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength: 200
			},
				type: 'TextField',
				filters: { pfiltro:'pcorreo.funcion_creacion_correo', type:'string' },
				id_grupo: 2,
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
				filters:{pfiltro:'pcorreo.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: '',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'pcorreo.id_usuario_ai',type:'numeric'},
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
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
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
				filters:{pfiltro:'pcorreo.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'pcorreo.usuario_ai',type:'string'},
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
				filters:{pfiltro:'pcorreo.fecha_mod',type:'date'},
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
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Plantillas de Correo',
	ActSave:'../../sis_workflow/control/PlantillaCorreo/insertarPlantillaCorreo',
	ActDel:'../../sis_workflow/control/PlantillaCorreo/eliminarPlantillaCorreo',
	ActList:'../../sis_workflow/control/PlantillaCorreo/listarPlantillaCorreo',
	id_store:'id_plantilla_correo',
	fields: [
		{name:'id_plantilla_correo', type: 'numeric'},
		{name:'id_tipo_estado', type: 'numeric'},
		{name:'regla', type: 'string'},
		{name:'plantilla', type: 'string'},
		{name:'correos', type: 'string'},
		{name:'codigo_plantilla', type: 'string'},
		{name:'documentos', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'asunto', type: 'string'},'requiere_acuse',
		'url_acuse','mensaje_acuse','mensaje_link_acuse',
		'mandar_automaticamente','funcion_acuse_recibo','funcion_creacion_correo',
        'cc',
        'bcc'
		
	],
	sortInfo:{
		field: 'id_plantilla_correo',
		direction: 'ASC'
	},
	loadValoresIniciales:function()
	{
		Phx.vista.PlantillaCorreo.superclass.loadValoresIniciales.call(this);
		this.Cmp.id_tipo_estado.setValue(this.maestro.id_tipo_estado);	
		this.Cmp.id_plantilla_correo.setValue('');	
		
	},
	
		
	bdel:true,
	bsave:true
	}
)
</script>
		
		