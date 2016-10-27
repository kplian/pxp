<?php
/**
*@package pXP
*@file gen-ConceptoIngas.php
*@author  (admin)
*@date 25-02-2013 19:49:23
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ConceptoIngas=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ConceptoIngas.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}});
		this.crearFormularioOt();
		this.crearFormAuto();
		this.addButton('inserOT',{ text: 'Configurar OT', iconCls: 'blist',disabled: false, handler: this.mostarFormOt, tooltip: '<b>Configurar OT</b><br/>Permite añadir grupos de OT autorizados para el concepto de gasto'});
        this.addButton('inserAuto',{ text: 'Configurar Autorizaciones', iconCls: 'blist', disabled: false, handler: this.mostarFormAuto, tooltip: '<b>Configurar autorizaciones</b><br/>Permite seleccionar desde que modulos  puede selecionarse el concepto'});
        
        this.addButton('addImagen', {
				text : 'Imagen',
				iconCls : 'bundo',
				disabled : false,
				handler : this.addImagen,
				tooltip : ' <b>Subir imagen</b>'
			});
			
	
	
	},
	
	addImagen : function() {


			var rec = this.sm.getSelected();
			Phx.CP.loadWindows('../../../sis_parametros/vista/concepto_ingas/subirImagenConcepto.php', 'Subir', {
				modal : true,
				width : 500,
				height : 250
			}, rec.data, this.idContenedor, 'subirImagenConcepto')

			

	},
	
	
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_concepto_ingas',
					renderer:function (value, p, record){	
						//return  String.format('{0}',"<div style='text-align:center'><img src = ../../control/foto_persona/"+ record.data['foto']+"?"+record.data['nombre_foto']+hora_actual+" align='center' width='70' height='70'/></div>");
						var splittedArray = record.data['ruta_foto'].split('.');
						if (splittedArray[splittedArray.length - 1] != "") {
							return  String.format('{0}',"<div style='text-align:center'><img src = '"+ record.data['ruta_foto']+"' align='center' width='70' height='70'/></div>");
						} else {
							return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/noimagen2.jpg' align='center' width='70' height='70'/></div>");
						}
						
					},
			},
			type:'Field',
			grid:true,
			form:true 
		},
	       	{
	       		config:{
	       			name:'movimiento',
	       			fieldLabel:'Movimiento',
	       			allowBlank:false,
	       			emptyText:'Tipo...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    gwidth: 100,
	       		    store:['recurso','gasto']
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       		         pfiltro:'conig.movimiento',
	       				 options: ['recurso','gasto'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
	     	{
	       		config:{
	       			name:'tipo',
	       			fieldLabel:'Tipo',
	       			allowBlank:false,
	       			emptyText:'Tipo...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'estilo',
	       		    gwidth: 100,
	       		    store:['Bien','Servicio']
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       		         pfiltro:'conig.tipo',
	       				 options: ['Bien','Servicio'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
		{
			config:{
				name: 'desc_ingas',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:500
			},
			type:'TextArea',
			filters:{pfiltro:'conig.desc_ingas',type:'string'},
			id_grupo:1,
			grid:true,
			form:true,
			bottom_filter : true
		},
		{
   			config:{
   				name:'id_unidad_medida',
   				tipo: 'All',
   				origen:'UNIDADMEDIDA',
   				allowBlank:true,
   				fieldLabel:'Unidad',
   				gdisplayField:'desc_unidad_medida',//mapea al store del grid
   				gwidth:200,
   				width: 350,
   				listWidth: 350,
   				//anchor: '80%',
	   			renderer:function (value, p, record){return String.format('{0}', record.data['desc_unidad_medida']);}
       	     },
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{	
		        pfiltro:'um.codigo#um.descripcion',
				type:'string'
			},
   		   
   			grid:true,
   			form:true
	   	},
		{
			config:{
				name: 'nandina',
				fieldLabel: 'Nandina',
				qtip: 'Código de partida presupuestaria',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'conig.nandina',type:'string'},
			id_grupo:1,
			grid:true,
			form:true,
			bottom_filter : true
		},
	    {
	       		config:{
	       			name:'sw_tes',
	       			fieldLabel:'Habilitar en Tesoreria',
	       			allowBlank:false,
	       			emptyText:'Tipo...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    gwidth: 100,
	       		    store:new Ext.data.ArrayStore({
		        	fields: ['ID', 'valor'],
		        	data :	[[1,'si'],	
		        			[2,'no']]
		        				
		    		}),
					valueField:'ID',
					displayField:'valor',
					renderer:function (value, p, record){if (value == 1) {return 'si'} else {return 'no'}}
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,	       		
	       		grid:true,
	       		form:true
	       },
	     {
			config: {
				name: 'activo_fijo',
				fieldLabel: 'Activo Fijo?',
				anchor: '100%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'activo_fijo',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tgral__bandera_min'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['activo_fijo']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'conig.activo_fijo',type:'string'},
			grid: true,
			form: true
		},  
		{
			config: {
				name: 'almacenable',
				fieldLabel: 'Almacenable?',
				anchor: '100%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'almacenable',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tgral__bandera_min'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['almacenable']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'conig.almacenable',type:'string'},
			grid: true,
			form: true
		},
	    {
			config:{
				name: 'sw_autorizacion',
				fieldLabel: 'Autorizaciones',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:500
			},
			type:'TextArea',
			filters: {pfiltro:'conig.sw_autorizacion', type:'string'},
			
			id_grupo:1,
			grid:true,
			form:false
		 },	
		 
		{
			config: {
				typeAhead: false,
				forceSelection: false,
				name: 'id_cat_concepto',
				fieldLabel: 'Tipo Catálogo',
				allowBlank: true,
				emptyText: 'Tipo Catálogo',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/CatConcepto/listarCatConcepto',
					id: 'id_cat_concepto',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_cat_concepto', 'codigo','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {
						par_filtro: 'nombre'
					}
				}),
				valueField: 'id_cat_concepto',
				displayField: 'nombre',
				gdisplayField: 'desc_cat_concepto',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 10,
				queryDelay: 200,
				listWidth:'280',
				resizable:true,
				width: 250,
				minChars: 2,
				tpl: '<tpl for="."><div class="x-combo-list-item"><p> {codigo} - {nombre}</p></div></tpl>',
				renderer:function(value, p, record){return String.format('{0}', record.data['desc_cat_concepto']);},
				gwidth:130
			},
			type: 'ComboBox',
			id_grupo: 1,
			filters: {
				pfiltro: 'cc.nombre',
				type: 'string'
			},
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
			filters:{pfiltro:'conig.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'conig.fecha_reg',type:'date'},
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
			filters:{pfiltro:'conig.fecha_mod',type:'date'},
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
	
	
	crearFormularioOt:function(){
		  this.formOt = new Ext.form.FormPanel({
            baseCls: 'x-plain',
            autoDestroy: true,
           
            border: false,
            layout: 'form',
             autoHeight: true,
           
    
            items: [
                  {
	       			name:'requiere_ot',
	       			xtype:'combo',
	       			qtip:'Configura si la OT es obligatoria u opcional para este concepto',
	       			fieldLabel:'Requiere OT',
	       			allowBlank:false,
	       			typeAhead: false,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    gwidth: 100,
	       		    store:['opcional','obligatorio']
	       		},
	       		
	       		{
	       			name:'filtro_ot',
	       			xtype:'combo',
	       			qtip:'Configura si aplica un filtro por el listado de los grupos selecionado (listado), o no aplica ningún filtro (todos)',
	       			fieldLabel:'Filtro OT',
	       			allowBlank:false,
	       			typeAhead: false,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    gwidth: 100,
	       		    store:['todos','listado']
	       		},
            
                {
       				name:'id_grupo_ots',
       				xtype:"awesomecombo",
       				fieldLabel:'Grupos de OT',
       				allowBlank:true,
       				emptyText:'OTs...',
       				store: new Ext.data.JsonStore({
              			url: '../../sis_contabilidad/control/GrupoOt/listarGrupoOt',
       					id: 'id_grupo_ot',
       					root: 'datos',
       					sortInfo:{
       						field: 'descripcion',
       						direction: 'ASC'
       					},
       					totalProperty: 'total',
       					fields: ['id_grupo_ot','descripcion'],
       					// turn on remote sorting
       					remoteSort: true,
       					baseParams:{par_filtro:'descripcion'}
       					
       				}),
       				valueField: 'id_grupo_ot',
       				displayField: 'descripcion',
       				forceSelection:true,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:100,
       				queryDelay:1000,
       				width:250,
       				minChars:2,
	       			enableMultiSelect:true
       			
       				//renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}

       			}]
        });
        
		
		
		this.wOt = new Ext.Window({
            title: 'Estados',
            collapsible: true,
            maximizable: true,
            autoDestroy: true,
            width: 380,
            height: 170,
            layout: 'fit',
            plain: true,
            bodyStyle: 'padding:5px;',
            buttonAlign: 'center',
            items: this.formOt,
            modal:true,
             closeAction: 'hide',
            buttons: [{
                text: 'Guardar',
                handler:this.saveOt,
                scope:this
                
            },
             {
                text: 'Cancelar',
                handler:function(){this.wOt.hide()},
                scope:this
            }]
        });
        
         this.cmpOt=this.formOt.getForm().findField('id_grupo_ots');
         this.cmpFiltroOt=this.formOt.getForm().findField('filtro_ot');
         this.cmpRequiereOt=this.formOt.getForm().findField('requiere_ot');
         
         
	},
	mostarFormOt:function(){
		var data = this.getSelectedData();
		if(data){
			this.cmpOt.setValue(data.id_grupo_ots);
			this.cmpFiltroOt.setValue(data.filtro_ot);
			this.cmpRequiereOt.setValue(data.requiere_ot);
		    this.wOt.show();
		}
		
	},
	saveOt:function(){
		    var d = this.getSelectedData();
		    Phx.CP.loadingShow();
            Ext.Ajax.request({
                url: '../../sis_parametros/control/ConceptoIngas/editOt',
                params: { 
                	      id_grupo_ots: this.cmpOt.getValue(),
                	      requiere_ot: this.cmpRequiereOt.getValue(), 
                	      filtro_ot: this.cmpFiltroOt.getValue(),  
                	      id_concepto_ingas: d.id_concepto_ingas
                	    },
                success: this.successSinc,
                failure: this.conexionFailure,
                timeout: this.timeout,
                scope: this
            });
		
	},
	//formulario de autorizaciones
	crearFormAuto:function(){
		  this.formAuto = new Ext.form.FormPanel({
            baseCls: 'x-plain',
            autoDestroy: true,
           
            border: false,
            layout: 'form',
             autoHeight: true,
           
    
            items: [
                 {
       				name:'sw_autorizacion',
       				xtype:"awesomecombo",
       				fieldLabel:'Autorizaciones',
       				allowBlank: true,
       				emptyText:'Autorizaciones...',
       				store: new Ext.data.ArrayStore({
                        fields: ['variable', 'valor'],
                        data : [ ['adquisiciones', 'Adquisiciones'],
                                 ['pago_directo', 'Pago Recurrente'],
                                 ['caja_chica', 'Caja Chica'],
                                 ['fondo_avance', 'Fondo en Avance'],
                                 ['contrato', 'Contratos'],
                                 ['pago_unico', 'Pago Único'],
                                 ['especial', 'Especial']
                               ]
                        }),
       				valueField: 'variable',
				    displayField: 'valor',
				    mode: 'local',
	       		    forceSelection:true,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender: true,
       				queryDelay: 1000,
       				width: 250,
       				minChars: 2 ,
	       			enableMultiSelect: true
       			}]
        });
        
		
		
		this.wAuto = new Ext.Window({
            title: 'Configuracion',
            collapsible: true,
            maximizable: true,
            autoDestroy: true,
            width: 380,
            height: 170,
            layout: 'fit',
            plain: true,
            bodyStyle: 'padding:5px;',
            buttonAlign: 'center',
            items: this.formAuto,
            modal:true,
             closeAction: 'hide',
            buttons: [{
                text: 'Guardar',
                handler: this.saveAuto,
                scope: this
                
            },
             {
                text: 'Cancelar',
                handler: function(){ this.wAuto.hide() },
                scope: this
            }]
        });
        
         this.cmpAuto = this.formAuto.getForm().findField('sw_autorizacion');
         
         
	},
	
	mostarFormAuto:function(){
		var data = this.getSelectedData();
		if(data){
			this.cmpAuto.setValue(data.sw_autorizacion);
			this.wAuto.show();
		}
		
	},
	saveAuto: function(){
		    var d = this.getSelectedData();
		    Phx.CP.loadingShow();
            Ext.Ajax.request({
                url: '../../sis_parametros/control/ConceptoIngas/editAuto',
                params: { 
                	      sw_autorizacion: this.cmpAuto.getValue(),
                	      id_concepto_ingas: d.id_concepto_ingas
                	    },
                success: this.successSinc,
                failure: this.conexionFailure,
                timeout: this.timeout,
                scope: this
            });
		
	},
	successSinc:function(resp){
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
            	if(this.wOt){
            		this.wOt.hide(); 
            	}
            	if(this.wAuto){
            		this.wAuto.hide(); 
            	}
                
                this.reload();
             }else{
                alert('ocurrio un error durante el proceso')
            }
    },
	title:'Conceptos',
	ActSave:'../../sis_parametros/control/ConceptoIngas/insertarConceptoIngas',
	ActDel:'../../sis_parametros/control/ConceptoIngas/eliminarConceptoIngas',
	ActList:'../../sis_parametros/control/ConceptoIngas/listarConceptoIngas',
	id_store:'id_concepto_ingas',
	fields: [
		{name:'id_concepto_ingas', type: 'numeric'},
		{name:'desc_ingas', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'movimiento', type: 'string'},
		{name:'sw_tes', type: 'numeric'},
		{name:'id_oec', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'activo_fijo', type: 'string'},
		{name:'almacenable', type: 'string'},
		'id_grupo_ots','filtro_ot','requiere_ot',
		'sw_autorizacion','desc_unidad_medida','id_unidad_medida',
		'nandina','ruta_foto','id_cat_concepto','desc_cat_concepto'
		
	],
	sortInfo:{
		field: 'id_concepto_ingas',
		direction: 'ASC'
	},
	bdel:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
	bsave:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
	//bnew:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
	//bedit:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
	
	 preparaMenu:function(n){
        var data = this.getSelectedData();
        var tb =this.tbar;
        
        Phx.vista.ConceptoIngas.superclass.preparaMenu.call(this,n);
        this.getBoton('inserOT').enable();
        this.getBoton('inserAuto').enable();       
        this.getBoton('addImagen').enable();
		
        
        
        
        
        return tb 
     }, 
     liberaMenu:function(){
        var tb = Phx.vista.ConceptoIngas.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('inserOT').disable();
            this.getBoton('inserAuto').disable();
            this.getBoton('addImagen').disable();
		
        }
       return tb
    }
      
	
	}
)
</script>
		
		