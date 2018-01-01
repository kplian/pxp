<?php
/**
*@package pXP
*@file gen-TipoProceso.php
*@author  (FRH)
*@date 21-02-2013 15:52:52
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoProceso=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro = config.maestro;
		this.initButtons= [this.cmbProcesoMacro];
    	//llama al constructor de la clase padre
		Phx.vista.TipoProceso.superclass.constructor.call(this,config);
		this.init();
		this.addButton('btnTabla',
            {
                text: 'Tablas',
                iconCls: 'blist',
                disabled: true,
                handler: this.onBtnTablas,
                tooltip: 'Tablas del Proceso'
            }
        );
		
		this.bloquearOrdenamientoGrid();
		this.cmbProcesoMacro.on('select', function(){
		    
		    if(this.validarFiltros()){
                  this.capturaFiltros();
           }
		    
		    
		},this);
		
		
		
		//this.load({params:{start:0, limit:50}})
	},
	validarFiltros:function(){
        if(this.cmbProcesoMacro.isValid()){
            return true;
        }
        else{
            return false;
        }
        
    },
    
     capturaFiltros:function(combo, record, index){
        this.desbloquearOrdenamientoGrid();
        this.store.baseParams.id_proceso_macro=this.cmbProcesoMacro.getValue();
        this.load(); 
            
        
    },
    onButtonAct:function(){
        if(!this.validarFiltros()){
            alert('Especifique los filtros antes')
         }
        else{
            this.store.baseParams.id_proceso_macro=this.cmbProcesoMacro.getValue();
            Phx.vista.TipoProceso.superclass.onButtonAct.call(this);
        }
    },
     loadValoresIniciales:function()
    {
        Phx.vista.TipoProceso.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_proceso_macro').setValue(this.cmbProcesoMacro.getValue());  
    },
    
    cmbProcesoMacro:new Ext.form.ComboBox({
                name: 'id_proceso_macro',
                fieldLabel: 'Proceso',
                typeAhead: false,
                forceSelection: true,
                allowBlank: false,
                emptyText: 'Proceso Macro...',
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
              
                 triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                anchor: '80%',
                listWidth:'280',
                resizable:true,
                minChars: 2,
               tpl: '<tpl for="."><div class="x-combo-list-item"><p><b>{nombre}</b></p>Codigo: <strong>{codigo}</strong> </div></tpl>'
            }),
	
			
	Atributos:[
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
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '60%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'tipproc.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name: 'codigo_llave',
                fieldLabel: 'Código Llave',
                allowBlank: false,
                anchor: '60%',
                gwidth: 100,
                maxLength:150
            },
            type:'TextField',
            filters:{pfiltro:'tipproc.codigo_llave',type:'string'},
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
				gwidth: 250,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'tipproc.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		
		{
			config: {
				name: 'id_tipo_estado',
				fieldLabel: 'Tipo Estado',
				typeAhead: false,
				forceSelection: false,
				allowBlank: true,
				emptyText: 'Lista de tipos estados...',
				store: new Ext.data.JsonStore({
					url: '../../sis_workflow/control/TipoEstado/listarTipoEstado',
					id: 'id_tipo_estado',
					root: 'datos',
					sortInfo: {
						field: 'nombre_estado',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_estado', 'nombre_estado', 'inicio','codigo','disparador','fin','desc_tipo_proceso'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {par_filtro: 'tipes.nombre_estado#tipes.inicio',disparador:'si'}
				}),
				valueField: 'id_tipo_estado',
				displayField: 'nombre_estado',
				gdisplayField: 'desc_tipo_estado',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				anchor: '80%',
				minChars: 2,
				gwidth: 200,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_tipo_estado']);
				},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>({codigo})- {nombre_estado}</p>Inicio: <strong>{inicio}</strong>, Fin: <strong>{fin} <p>Tipo Proceso: {desc_tipo_proceso}</p></strong> </div></tpl>'
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'te.nombre_estado',
				type: 'string'
			},
			grid: true,
			form: true
		},
        {
            config:{
                name: 'tipo_disparo',
                fieldLabel: 'Tipo disparo',
                allowBlank: true,
                anchor: '40%',
                gwidth: 80,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                store:['opcional','obligatorio','bandeja_espera','manual']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{   pfiltro:'tipproc.tipo_disparo',
                        type: 'list',
                        //dataIndex: 'size',
                        options: ['opcional','obligatorio','bandeja_espera'],  
                    },
            grid:true,
            form:true
        },
        {
            config:{
                name: 'funcion_validacion_wf',
                fieldLabel: 'Func. Val Dips.',
                allowBlank: true,
                anchor: '60%',
                gwidth: 150,
                maxLength:100
            },
            type:'TextField',
            filters:{pfiltro:'tipproc.funcion_validacion_wf',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'tabla',
				fieldLabel: 'Tabla',
				allowBlank: true,
				anchor: '60%',
				gwidth: 150,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'tipproc.tabla',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'columna_llave',
				fieldLabel: 'Columna Llave',
				allowBlank: true,
				anchor: '60%',
				gwidth: 100,
				maxLength:150
			},
			type:'TextField',
			filters:{pfiltro:'tipproc.columna_llave',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'inicio',
				fieldLabel: 'Inicio (raiz)?',
				allowBlank: true,
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
			id_grupo:1,
			filters:{	pfiltro:'tipproc.inicio',
	       		         type: 'list',
	       				 //dataIndex: 'size',
	       				 options: ['si','no'],	
	       		 	},
			grid:true,
			form:true
		},
        {
            config:{
                name: 'descripcion',
                fieldLabel: 'Desc',
                allowBlank: true,
                anchor: '70%',
                gwidth: 200,
                maxLength:150
            },
            type:'TextArea',
            filters:{pfiltro:'tipproc.descripcion',type:'string'},
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
			filters:{pfiltro:'tipproc.estado_reg',type:'string'},
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
			filters:{pfiltro:'tipproc.fecha_reg',type:'date'},
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
			grid: true,
			form: false
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
			filters:{pfiltro:'tipproc.fecha_mod',type:'date'},
			id_grupo:1,
			grid: true,
			form: false
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
			grid: true,
			form: false
		}
	],
	
	title:'Tipo Proceso',
	ActSave:'../../sis_workflow/control/TipoProceso/insertarTipoProceso',
	ActDel:'../../sis_workflow/control/TipoProceso/eliminarTipoProceso',
	ActList:'../../sis_workflow/control/TipoProceso/listarTipoProceso',
	id_store:'id_tipo_proceso',
	fields: [
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'id_proceso_macro', type: 'numeric'},
		{name:'tabla', type: 'string'},
		{name:'columna_llave', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_tipo_estado', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_proceso_macro', type: 'string'},
		{name:'desc_tipo_estado', type: 'string'},
		'inicio','tipo_disparo',
		'funcion_validacion_wf',
		'descripcion',
		'codigo_llave'
		
	],
	onButtonNew: function() {
        
        if(this.validarFiltros()){
             Phx.vista.TipoProceso.superclass.onButtonNew.call(this);
             this.filtraAddEdit();
            
            
            }
        else{
            alert('Seleccione el Proceso Macro');
        }
        
       
    },
    
    filtraAddEdit:function(){
        this.Cmp.id_tipo_estado.store.baseParams.id_proceso_macro=this.cmbProcesoMacro.getValue();
        this.Cmp.id_tipo_estado.modificado=true;
            
        
    },
	
	sortInfo:{
		field: 'id_tipo_proceso',
		direction: 'ASC'
	},
	onBtnTablas: function(){
			var rec = {maestro: this.sm.getSelected().data};
						      
            Phx.CP.loadWindows('../../../sis_workflow/vista/tabla/Tabla.php',
                    'Tablas Relacionadas a este tipo proceso',
                    {
                        width:800,
                        height:'90%'
                    },
                    rec,
                    this.idContenedor,
                    'Tabla');
	},
	tabeast:[
		  {
    		  url:'../../../sis_workflow/vista/tipo_estado/TipoEstado.php',
    		  title:'Estados', 
    		  width:'60%',
    		  cls:'TipoEstado'
		  },
		  {
              url:'../../../sis_workflow/vista/tipo_documento/TipoDocumento.php',
              title:'Tipo Documento', 
              width:'60%',
              cls:'TipoDocumento'
          },
           {
              url:'../../../sis_workflow/vista/tipo_columna/TipoColumna.php',
              title:'Tipo Columna', 
              width:'60%',
              cls:'TipoColumna'
          },
           {
              url:'../../../sis_workflow/vista/tipo_proceso_origen/TipoProcesoOrigen.php',
              title:'Origenes', 
              width:'60%',
              cls:'TipoProcesoOrigen'
          },
		  {
    		url:'../../../sis_workflow/vista/labores_tipo_proceso/LaboresTipoProceso.php',
            title:'Labores', 
            width:'60%',
            cls:'LaboresTipoProceso'    
		  }
		],
	bdel:true,
	bsave:false,
	preparaMenu:function()
    {	
        this.getBoton('btnTabla').enable();  
            
        Phx.vista.TipoProceso.superclass.preparaMenu.call(this);
    },
    liberaMenu:function()
    {	
        this.getBoton('btnTabla').disable(); 
              
        Phx.vista.TipoProceso.superclass.liberaMenu.call(this);
    },
	}
)
</script>
		
		