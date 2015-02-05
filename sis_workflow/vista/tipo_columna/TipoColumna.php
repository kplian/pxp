<?php
/**
*@package pXP
*@file gen-TipoColumna.php
*@author  (admin)
*@date 07-05-2014 21:41:15
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoColumna=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoColumna.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();
		this.comboTabla = new Ext.form.ComboBox({
	        store: new Ext.data.JsonStore({

	    		url: '../../sis_workflow/control/Tabla/listarTabla',
	    		id: 'id_tabla',
	    		root: 'datos',
	    		sortInfo:{
	    			field: 'tabla.bd_nombre_tabla',
	    			direction: 'ASC'
	    		},
	    		totalProperty: 'total',
	    		fields: [
					{name:'id_tabla'},
					{name:'bd_nombre_tabla', type: 'string'},
					{name:'bd_codigo_tabla', type: 'string'},
					{name:'estado_reg', type: 'string'}
				],
	    		remoteSort: true,
	    		baseParams:{start:0,limit:10}
	    	}),
	        displayField: 'bd_nombre_tabla',
	        valueField: 'id_tabla',
	        typeAhead: false,
	        mode: 'remote',
	        triggerAction: 'all',
	        emptyText:'Tabla...',
	        selectOnFocus:true,
	        width:100
	    });	
	    
	    this.equivalencias =  { 'varchar' : 'TextField',
	    						'text' : 'TextArea',
	    						'numeric' : 'NumberField',
	    						'integer' : 'NumberField',	    						
	    						'bigint' : 'NumberField',
	    						'date' : 'DateField',
	    						'timestamp' : 'DateField',
	    						'time' : 'time',
	    						'boolean' : 'CheckBox' };	    						
	    						
		var dataPadre = Phx.CP.getPagina(this.idContenedorPadre).getSelectedData()
        if(dataPadre){
        	this.onEnablePanel(this, dataPadre);
        } else
        {
           this.bloquearMenus();
        }
		
		
	    this.comboTabla.on('select',this.onComboTablaSelect, this);
	    this.tbar.add(this.comboTabla);
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_columna'
			},
			type:'Field',
			form:true,
			id_grupo: 1
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tabla'
			},
			type:'Field',
			form:true,
			id_grupo: 1 
		},
		
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_proceso'
			},
			type:'Field',
			form:true,
			id_grupo: 1 
		},
		{
			config:{
				name: 'bd_nombre_columna',
				fieldLabel: 'Nombre Columna',
				allowBlank: false,
				anchor: '100%',
				gwidth: 150,
				maxLength:100,
				qtip: 'El nombre de la columna debe ser escrito en minusculas y las palabras separadas por underscore ej: nombre_columna.'
			},
				type:'TextField',
				filters:{pfiltro:'tipcol.bd_nombre_columna',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'bd_tipo_columna',
				fieldLabel: 'Tipo Columna',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				typeAhead: false,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
				store:['varchar','text','numeric','integer','bigint','date','timestamp','time','boolean','integer[]','varchar[]']
			},
				type:'ComboBox',
				filters:{pfiltro:'tipcol.bd_tipo_columna',type:'string'},
				id_grupo:1,
				filters:{   
                         type: 'list',
                         pfiltro:'tipcol.bd_tipo_columna',
                         options: ['varchar','text','numeric','integer','bigint','date','timestamp','time','boolean','integer[]','varchar[]']  
                    },
				grid:true,
				form:true
		},
		{
			config:{
				name: 'bd_tamano_columna',
				fieldLabel: 'Tamaño Columna',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:5,
				vtype:'alphanum',
				qtip : 'Para la mayoria de los casos solo un numero, en caso de numeric dos numeros separados por underscore indicando la cantidad de digitos total y la cantidad de digitos decimales ej : 18_2',
			},
				type:'TextField',
				filters:{pfiltro:'tipcol.bd_tamano_columna',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'bd_prioridad',
				fieldLabel: 'Prioridad',
				allowBlank: true,
				anchor: '100%',
				qtip : 'Orden en el que se mostrara este campo en el formulario',
				gwidth: 150
			},
				type:'NumberField',
				filters:{pfiltro:'tipcol.bd_prioridad',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'bd_descripcion_columna',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '100%',
				qtip : 'Este dato se mostrara como tooltip en el formulario',
				gwidth: 150
			},
				type:'TextArea',
				filters:{pfiltro:'tipcol.bd_descripcion_columna',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'bd_formula_calculo',
				fieldLabel: 'Fórmula Cálculo',
				allowBlank: true,
				anchor: '100%',
				qtip : 'Fórmula a partir de la que se calculará este campo. Se puede hacer uso de procedimientos almacenados, datos de la tabla y fórmulas',
				gwidth: 150
			},
				type:'TextArea',
				filters:{pfiltro:'tipcol.bd_descripcion_columna',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'bd_campos_adicionales',
				fieldLabel: 'Campos Adicionales',
				allowBlank: true,
				anchor: '100%',
				qtip : 'El formato es : "nombre_columna nombre_modelo tipo" separados por comas por cada campo adicional',
				gwidth: 100
			},
				type:'TextArea',
				filters:{pfiltro:'tipcol.bd_campos_adicionales',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'bd_joins_adicionales',
				fieldLabel: 'Joins Adicionales',
				qtip : 'Joins adicionales a la consulta para obtener datos de la columna',
				allowBlank: true,
				anchor: '100%',
				gwidth: 150
			},
				type:'TextArea',
				filters:{pfiltro:'tipcol.bd_joins_adicionales',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
            config:{
                name: 'bd_campos_subconsulta',
                fieldLabel: 'Campos Subconsultas',
                allowBlank: true,
                anchor: '100%',
                qtip : 'El formato es : "(select campo from tabla where id = t.id) as campo text" separados por punto y comas por cada campo subconsulta',
                gwidth: 100
            },
                type:'TextArea',
                filters:{pfiltro:'tipcol.bd_campos_subconsulta',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
        },
		
		{
			config:{
				name: 'form_tipo_columna',
				fieldLabel: 'Tipo Columna',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				typeAhead: false,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
				store: ['TextField','TextArea','NumberField','DateField','time','CheckBox']
			},
				type:'ComboBox',
				filters:{   
                         type: 'list',
                         pfiltro:'tipcol.form_tipo_columna',
                         options:  ['TextField','TextArea','NumberField','DateField','time','CheckBox']
                    },
				id_grupo:2,
				grid:true,
				form:true
		},
				
		{
			config:{
				name: 'form_label',
				fieldLabel: 'Label',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:100
			},
				type:'TextField',
				filters:{pfiltro:'tipcol.form_label',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},
		
		
		{
			config:{
				name: 'form_es_combo',
				fieldLabel: 'Es combo',
				allowBlank: false,
				anchor: '100%',
				typeAhead: false,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
				store: ['si','no']
			},
				type:'ComboBox',
				filters:{   
                         type: 'list',
                         pfiltro:'tipcol.form_es_combo',
                         options: ['si','no']  
                    },
				id_grupo:2,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'form_combo_rec',
				fieldLabel: 'ComboRec',
				allowBlank: true,
				anchor: '100%',
				gwidth: 80,
				maxLength:50
			},
				type:'TextField',
				filters:{pfiltro:'tipcol.form_combo_rec',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'form_sobreescribe_config',
				fieldLabel: 'Config',
				allowBlank: true,
				anchor: '100%',
				qtip:'Sobreescribir el config de una columna en la vista, debe ser un objeto de tipo json {}',
				gwidth: 150
			},
				type:'TextArea',
				filters:{pfiltro:'tipcol.form_sobreescribe_config',type:'string'},
				id_grupo:2,
				grid:true,
				form:true
		},	
		
		{
			config:{
				name: 'form_grupo',
				fieldLabel: 'Grupo',
				allowBlank: true,
				anchor: '100%',
				qtip : 'El id_grupo del campo en caso que haya varios grupos dentro del formulario',
				gwidth: 150
			},
				type:'NumberField',
				filters:{pfiltro:'tipcol.form_grupo',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},			
		
		{
			config:{
				name: 'grid_sobreescribe_filtro',
				fieldLabel: 'Filtro',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				qtip : 'Sobreescribir el filtro de una columna en la vista, debe ser un objeto de tipo json {}'
			},
				type:'TextArea',
				filters:{pfiltro:'tipcol.grid_sobreescribe_filtro',type:'string'},
				id_grupo:3,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'grid_campos_adicionales',
				fieldLabel: 'Campos Adicionales',
				allowBlank: true,
				anchor: '100%',
				qtip: 'El formato es : "nombre tipo formato" separados por comas por cada campo adicional',
				gwidth: 100
			},
				type:'TextArea',
				filters:{pfiltro:'tipcol.grid_campos_adicionales',type:'string'},
				id_grupo:3,
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
				filters:{pfiltro:'tipcol.estado_reg',type:'string'},
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
				filters:{pfiltro:'tipcol.fecha_reg',type:'date'},
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
				filters:{pfiltro:'tipcol.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:10,	
	title:'Tipo Columna',
	ActSave:'../../sis_workflow/control/TipoColumna/insertarTipoColumna',
	ActDel:'../../sis_workflow/control/TipoColumna/eliminarTipoColumna',
	ActList:'../../sis_workflow/control/TipoColumna/listarTipoColumna',
	id_store:'id_tipo_columna',
	fwidth:'800',
	fields: [
		{name:'id_tipo_columna', type: 'numeric'},
		{name:'id_tabla', type: 'numeric'},
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'bd_campos_adicionales', type: 'string'},
		{name:'bd_tamano_columna', type: 'string'},
		{name:'bd_prioridad', type: 'numeric'},
		{name:'form_combo_rec', type: 'string'},
		{name:'form_label', type: 'string'},
		{name:'form_grupo', type: 'numeric'},
		{name:'bd_joins_adicionales', type: 'string'},
		{name:'bd_formula_calculo', type: 'string'},
		{name:'bd_descripcion_columna', type: 'string'},
		{name:'form_sobreescribe_config', type: 'string'},
		{name:'form_tipo_columna', type: 'string'},
		{name:'grid_sobreescribe_filtro', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'bd_nombre_columna', type: 'string'},
		{name:'form_es_combo', type: 'string'},
		{name:'grid_campos_adicionales', type: 'string'},
		{name:'bd_tipo_columna', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'bd_campos_subconsulta', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_tipo_columna',
		direction: 'ASC'
	},
	bdel:true,
	loadValoresIniciales:function()
    {
    	this.Cmp.id_tabla.setValue(this.comboTabla.getValue());
    	this.Cmp.id_tipo_proceso.setValue(this.maestro.id_tipo_proceso);
    	this.Cmp.form_es_combo.setValue('no'); 
    	this.ocultarComponente(this.Cmp.form_combo_rec);      
        Phx.vista.TipoColumna.superclass.loadValoresIniciales.call(this);        
    },
    iniciarEventos : function() {
    	this.Cmp.form_es_combo.on('select', this.onEsComboSelect, this);
    	this.Cmp.bd_tipo_columna.on('select', this.onTipoColumnaSelect, this);
    },
    onEsComboSelect : function(com, rec, i) {
    	if (rec.data.field1 == 'si') {
    		this.mostrarComponente(this.Cmp.form_combo_rec);
    	} else {
    		this.ocultarComponente(this.Cmp.form_combo_rec);
    	}
    },
    
    onTipoColumnaSelect : function(com, rec, i) {
    	
    	this.Cmp.form_tipo_columna.setValue(this.equivalencias[rec.data.field1]);
    },
    onButtonEdit : function () {
    	Phx.vista.TipoColumna.superclass.onButtonEdit.call(this);
    	if (this.sm.getSelected().data.form_es_combo == 'si') {
    		this.mostrarComponente(this.Cmp.form_combo_rec);
    	} else {
    		this.ocultarComponente(this.Cmp.form_combo_rec);
    	}
    },
	onReloadPage:function(m) {		
        this.maestro=m;
        this.comboTabla.store.setBaseParam('id_tipo_proceso' , this.maestro.id_tipo_proceso);        
        this.comboTabla.store.load();
        this.comboTabla.reset();
        this.store.removeAll();
        this.liberaMenu();
        this.getBoton('new').disable();
        this.getBoton('act').disable();
    },
    onComboTablaSelect:function(combo, rec, index){
        this.store.baseParams = {id_tabla : rec.data.id_tabla};        
        this.load({params:{start:0, limit:10}});
        this.desbloquearMenus();
        this.getBoton('new').enable();
        this.getBoton('act').enable();
    },
    south:
         {
          url:'../../../sis_workflow/vista/columna_estado/ColumnaEstado.php',
          title:'Columnas X Estado', 
          height:'50%',
          cls:'ColumnaEstado'
         }
    
       ,
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
					        }]
					    }, {
					        bodyStyle: 'padding-left:5px;',
					        items: [{
					            xtype: 'fieldset',
					            title: '2. Form',
					            autoHeight: true,
					            items: [],
						        id_grupo:2
					        },
					        {
					            xtype: 'fieldset',
					            title: '3. Grid',
					            autoHeight: true,
					            items: [],
						        id_grupo:3
					        }]
					    }]
            }
        ]
	}
)
</script>
		
		