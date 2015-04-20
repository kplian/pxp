<?php
/**
*@package pXP
*@file gen-TipoDocumento.php
*@author  (admin)
*@date 14-01-2014 17:43:47
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoDocumento=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoDocumento.superclass.constructor.call(this,config);
		this.init();
        var dataPadre = Phx.CP.getPagina(this.idContenedorPadre).getSelectedData()
        if(dataPadre){
            this.onEnablePanel(this, dataPadre);
        }
        else
        {
           this.bloquearMenus();
        }
        
        //Adiciona botón para plantilla de documentos
        this.addButton('btnPlantilla',
            {
                text: 'Plantilla',
                iconCls: 'bchecklist',
                disabled: true,
                handler: this.loadPlantilla,
                tooltip: '<b>Plantilla</b><br/>Plantilla de Documentos'
            }
        );

	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_documento'
			},
			type:'Field',
			form:true 
		},
		
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
                fieldLabel: 'Codigo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:25
            },
                type:'TextField',
                filters:{pfiltro:'tipdw.codigo',type:'string'},
                id_grupo:0,
                grid:true,
                form:true
        },
		
		
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:255
			},
				type:'TextField',
				filters:{pfiltro:'tipdw.nombre',type:'string'},
				id_grupo:0,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
				type:'TextArea',
				filters:{pfiltro:'tipdw.descripcion',type:'string'},
				id_grupo:0,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'orden',
				fieldLabel: 'Orden',
				qtip: 'Posición en la Ordenación ',
				allowBlank: false,
				allowDecimals: true,
				anchor: '80%',
				gwidth: 70
			},
				type:'NumberField',
				filters: { pfiltro:'tipdw.ordenacion', type:'numeric' },
				valorInicial: 1.00,
				id_grupo:1,
				egrid: true,
				grid:true,
				form:true
		},
		
        {
            config:{
                name: 'tipo',
                fieldLabel: 'Tipo ',
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
              store:['escaneado','generado']
            },
            type:'ComboBox',
            //filters:{pfiltro:'tipdw.tipo',type:'string'},
            id_grupo:0,
            filters:{   
                         type: 'list',
                         pfiltro:'tipdw.tipo',
                         options: ['escaneado','generado'],   
                    },
            grid:true,
            form:true
        },
		
        {
            config:{
                name: 'solo_lectura',
                fieldLabel: 'Solo Llectura ',
                allowBlank: false,
                anchor: '70%',
                gwidth: 150,
                maxLength:50,
                emptyText:'Tipo...',                
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                valueField: 'solo_lectura',                  
              store:['si','no']
            },
            type:'ComboBox',
            //filters:{pfiltro:'tipdw.tipo',type:'string'},
            id_grupo:0,
            filters:{   
                         type: 'list',
                         pfiltro:'tipdw.solo_lectura',
                         options: ['si','no'],   
                    },
            grid:true,
            form:true
        },
		
		{
			config:{
				name: 'action',
				fieldLabel: 'Action',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:250
			},
				type:'TextField',
				filters:{pfiltro:'tipdw.action',type:'string'},
				id_grupo:0,
				grid:true,
				form:true
		},
		{
            config:{
                name: 'esquema_vista',
                fieldLabel: 'Esquema BD',
                allowBlank: true,
                anchor: '100%',
                gwidth: 100,
                maxLength:70
            },
            type:'TextField',
            filters:{pfiltro:'tipdw.esquema_vista',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
            config:{
                name: 'nombre_vista',
                fieldLabel: 'Nombre Vista BD',
                allowBlank: true,
                anchor: '100%',
                gwidth: 100,
                maxLength:70
            },
            type:'TextField',
            filters:{pfiltro:'tipdw.nombre_vista',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'nombre_archivo_plantilla',
                fieldLabel: 'Nombre Archivo Plantilla',
                allowBlank: true,
                anchor: '100%',
                gwidth: 100,
                maxLength:70
            },
            type:'TextField',
            filters:{pfiltro:'tipdw.nombre_archivo_plantilla',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                    name:'categoria_documento',
                    fieldLabel:'Categoria',
                    qtip:'sir para clasificar las cateogiras del documento',
                    tinit:false,
                    resizable:true,
                    tasignacion:false,
                    allowBlank:true,
                    store: new Ext.data.JsonStore({
                            url: '../../sis_workflow/control/CategoriaDocumento/listarCategoriaDocumento',
                            id: 'id_categoria_documento',
                            root: 'datos',
                            sortInfo:{
                                field: 'nombre',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_categoria_documento','codigo','nombre'],
                            // turn on remote sorting
                            remoteSort: true
                        }),
                    
                    valueField: 'codigo',
                    displayField: 'nombre',
                    gdisplayField: 'categoria_documento',
                    hiddenName: 'codigo',
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
                name: 'estado_reg',
                fieldLabel: 'Estado Reg.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:10
            },
                type:'TextField',
                filters:{pfiltro:'tipdw.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'tipdw.fecha_reg',type:'date'},
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
				filters:{pfiltro:'tipdw.fecha_mod',type:'date'},
				id_grupo:0,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Tipo Documentos',
	ActSave:'../../sis_workflow/control/TipoDocumento/insertarTipoDocumento',
	ActDel:'../../sis_workflow/control/TipoDocumento/eliminarTipoDocumento',
	ActList:'../../sis_workflow/control/TipoDocumento/listarTipoDocumento',
	id_store:'id_tipo_documento',
	fields: [
		{name:'id_tipo_documento', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'id_proceso_macro', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'id_usuario_asignado', type: 'numeric'},
		{name:'id_num_tramite', type: 'numeric'},
		{name:'action', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'solo_lectura','categoria_documento','orden',
		{name:'nombre_vista', type: 'string'},
		{name:'nombre_archivo_plantilla', type: 'string'},
		{name:'esquema_vista', type: 'string'}
	],
	
	onReloadPage:function(m){
		this.maestro=m;
        this.store.baseParams={id_tipo_proceso:this.maestro.id_tipo_proceso};
        this.load({params:{start:0, limit:50}})
    },
    loadValoresIniciales:function()
    {
        Phx.vista.TipoDocumento.superclass.loadValoresIniciales.call(this);
        this.Cmp.id_tipo_proceso.setValue(this.maestro.id_tipo_proceso);
        this.Cmp.id_proceso_macro.setValue(this.maestro.id_proceso_macro);        
    },
    
    tabsouth:[
         {
          url:'../../../sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstado.php',
          title:'Estados por momento', 
          height:'50%',
          cls:'TipoDocumentoEstado'
         }
    
       ],
    
	
	sortInfo:{
		field: 'nombre',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	Grupos:[{ 
        layout: 'column',
        items:[
            {
                xtype:'fieldset',
                layout: 'form',
                border: true,
                title: 'Datos Generales',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: 0.5,
                items:[],
                id_grupo:0,
                collapsible:true
            },
            {
                xtype:'fieldset',
                layout: 'form',
                border: true,
                title: 'Plantilla Documento',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: 0.5,
                items:[],
                id_grupo:1,
                collapsible:true,
                collapsed:false
            }
            ]
        }],

    loadPlantilla: function(a,b,c,d){
        var data = this.getSelectedData();
        
        var html = new Ext.form.HtmlEditor({
            region: 'center',
            margins:'3 3 3 0',
            fieldLabel: 'First Name',
            name: 'first',
            allowBlank:false,
            enableDragDrop   : true,
            ddGroup          : 'gridDDGroup',
        });
        
        /*var Panel = new Ext.Panel({
            region     : 'center',
            items: html
        });*/
       
       var Panel = new Ext.form.FormPanel({
           region     : 'center',
           title      : 'Generic Form Panel',
           bodyStyle  : 'padding: 10px; background-color: #DFE8F6',
           labelWidth : 100,
           width      : 325,
           items      : html
        });
        
        console.log(html)
        console.log(Panel)
        var formPanelDropTargetEl =  Panel;
        
        /*var formPanelDropTarget = new Ext.dd.DropTarget(formPanelDropTargetEl, {
        ddGroup     : 'gridDDGroup',
        notifyEnter : function(ddSource, e, data) {

            //Add some flare to invite drop.
            Panel.body.stopFx();
            Panel.body.highlight();
        },
        notifyDrop  : function(ddSource, e, data){

            // Reference the record (single selection) for readability
            var selectedRecord = ddSource.dragData.selections[0];


            // Load the record into the form
            //html.getForm().loadRecord(selectedRecord);


            // Delete record from the grid.  not really required.
            //ddSource.grid.store.remove(selectedRecord);

            return(true);
        }
    });*/
        
        var tabs = new Ext.TabPanel({
            region: 'center',
            margins:'3 3 3 0', 
            activeTab: 0,
            defaults:{autoScroll:true},

            items:[html]
        });
        
        
        
        var store1 = new Ext.data.JsonStore({
            url: '../../sis_workflow/control/TipoDocumento/listarColumnasPlantillaDocumento',
            id: 'column_name',
            root: 'datos',
            totalProperty: 'total',
            remoteSort: true,
            fields: ['column_name', 'data_type', 'character_maximum_length'],
            baseParams:{nombre_vista:data.nombre_vista}//,
            //autoLoad: true
        });
        store1.on('exception', this.conexionFailure);
        
        store1.load();
        
        /*var listView = new Ext.list.ListView({
            store: store1,
            multiSelect: false,
            emptyText: 'No hay columnas disponibles',
            loadingText: 'Cargando...',
            autoScroll: true,
            reserveScrollOffset: true,
            singleSelect: true,
            region: 'west',
            split: true,
            //width: 200,
            collapsible: true,
            margins:'3 0 3 3',
            cmargins:'3 3 3 3',
            columns: [{
                header: 'Claves',
                width: .5,
                dataIndex: 'column_name'
            }]
        });*/
       
       var listView = new Ext.grid.GridPanel({
            store: store1,
            multiSelect: false,
            collapsible: false,
            margins:'3 0 3 3',
            cmargins:'3 3 3 3',
            region: 'west',
            autoWidth: true,
            autoHeight: true,
            columns: [{
                header: 'Claves',
                width: 150, 
                dataIndex: 'column_name'
            }],
            stripeRows: true,
            //draggable: true
            ddGroup: 'dd',
            enableDragDrop: true
        });
        
        // Panel for the west
        var nav = new Ext.Panel({
            title: 'Panel',
            region: 'west',
            split: true,
            width: 200,
            collapsible: true,
            margins:'3 0 3 3',
            cmargins:'3 3 3 3',
            items: [listView],
            autoScroll: true
        });

        var win = new Ext.Window({
            title: 'Plantilla de Documentos',
            closable:true,
            width:750,
            height:500,
            //border:false,
            plain:true,
            layout: 'border',
            items: [nav, html]
        });

        win.show(this);
        
    },
    
    preparaMenu:function(n){
          var data = this.getSelectedData();
          var tb =this.tbar;
          Phx.vista.TipoDocumento.superclass.preparaMenu.call(this,n);  
          this.getBoton('btnPlantilla').enable();
          return tb 
     }, 
     
     liberaMenu:function(){
        var tb = Phx.vista.TipoDocumento.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('btnPlantilla').disable();
        }
       return tb
    }
        
})
</script>
		
		