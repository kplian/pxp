<?php
/**
*@package pXP
*@file gen-ProcesoWf.php
*@author  (admin)
*@date 18-04-2013 09:01:51
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ProcesoWf=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		this.initButtons=[this.cmbProcesoMacro];
		Phx.vista.ProcesoWf.superclass.constructor.call(this,config);
		this.init();
		//this.load({params:{start:0, limit:this.tam_pag}});
		this.iniciarEventos();
        this.cmbProcesoMacro.on('select', function(){
            
            if(this.validarFiltros()){
                  this.capturaFiltros();
           }
            
            
        },this);
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_proceso_wf'
			},
			type:'Field',
			form:true 
		},
        {
            config: {
                name: 'id_tipo_proceso',
                fieldLabel: 'Tipo',
                typeAhead: false,
                forceSelection: false,
                 hiddenName: 'id_tipo_proceso',
                allowBlank: false,
                emptyText: 'Lista de Procesos...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_workflow/control/TipoProceso/listarTipoProceso',
                    id: 'id_tipo_proceso',
                    root: 'datos',
                    sortInfo: {
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_tipo_proceso', 'nombre', 'codigo'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {par_filtro: 'tipproc.nombre#tipproc.codigo',inicio:'si'}
                }),
                valueField: 'id_tipo_proceso',
                displayField: 'nombre',
                gdisplayField: 'desc_tipo_proceso',
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                listWidth:280,
                minChars: 2,
                gwidth: 170,
                renderer: function(value, p, record) {
                    return String.format('{0}', record.data['desc_tipo_proceso']);
                },
                tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p>Codigo: <strong>{codigo}</strong> </div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'tp.nombre',
                type: 'string'
            },
            grid: true,
            form: true
        },
		{
			config:{
				name: 'nro_tramite',
				fieldLabel: 'nro_tramite',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100,
				readOnly:true
			},
			type:'TextField',
			filters:{pfiltro:'pwf.nro_tramite',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
			
		},{
           config:{
               name: 'inicioProceso',
               fieldLabel: 'Inicio del Proceso',
               gwidth: 100,
               maxLength:30,
               renderer:this.renderFunction,
               items: [
                   {boxLabel: 'Persona',name: 'rg-auto',  inputValue: 'persona', checked:true},
                   {boxLabel: 'Institucion',name: 'rg-auto', inputValue: 'institucion'}
               ]
           },
           type:'RadioGroupField',
           filters:{pfiltro:'plapa.tipo',type:'string'},
           id_grupo:1,
           grid:false,
           form:true
          },
          
                
         {
            config:{
                name:'id_persona',
                origen:'PERSONA',
                 allowBlank:false,
                fieldLabel:'Nombre',
                gdisplayField:'desc_persona',//mapea al store del grid
                gwidth:50,
                 renderer:function (value, p, record){return String.format('{0}', record.data['desc_persona']);}
             },
            type:'ComboRec',
            id_grupo:1,
            filters:{   
                //pfiltro:'mon.codigo',
                type:'string'
            },
            grid:true,
            form:true
          },         {
            config:{
                name:'id_institucion',
                origen:'INSTITUCION',
                 allowBlank:false,
                fieldLabel:'Nombre',
                gdisplayField:'desc_institucion',//mapea al store del grid
                gwidth:50,
                 renderer:function (value, p, record){return String.format('{0}', record.data['desc_institucion']);}
             },
            type:'ComboRec',
            id_grupo:1,
            filters:{   
                //pfiltro:'mon.codigo',
                type:'string'
            },
            grid:true,
            form:true
          },
		/*{
			config:{
				name: 'id_persona',
				fieldLabel: 'id_persona',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'pwf.id_persona',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},{
			config:{
				name: 'id_institucion',
				fieldLabel: 'id_institucion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'pwf.id_institucion',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},*/{
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
		},{
            config:{
                name: 'estado_reg',
                fieldLabel: 'Estado Reg.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:10
            },
            type:'TextField',
            filters:{pfiltro:'pwf.estado_reg',type:'string'},
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
			filters:{pfiltro:'pwf.fecha_reg',type:'date'},
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
			filters:{pfiltro:'pwf.fecha_mod',type:'date'},
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
	
	title:'PROCESO WF',
	ActSave:'../../sis_workflow/control/ProcesoWf/insertarProcesoWf',
	ActDel:'../../sis_workflow/control/ProcesoWf/eliminarProcesoWf',
	ActList:'../../sis_workflow/control/ProcesoWf/listarProcesoWf',
	id_store:'id_proceso_wf',
	fields: [
		{name:'id_proceso_wf', type: 'numeric'},
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'nro_tramite', type: 'string'},
		{name:'id_estado_wf_prev', type: 'numeric'},
		{name:'estado_reg', type: 'string'},		
		{name:'id_persona', type: 'numeric'},
		{name:'valor_cl', type: 'string'},
		{name:'id_institucion', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'desc_tipo_proceso',
	],
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
                minChars: 2,
               tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p>Codigo: <strong>{codigo}</strong> </div></tpl>'
       }),
            
    
    validarFiltros:function(){
        if(this.cmbProcesoMacro.isValid()){
            return true;
        }
        else{
            return false;
        }
        
    },
    
     capturaFiltros:function(combo, record, index){
        this.store.baseParams.id_proceso_macro=this.cmbProcesoMacro.getValue();
        this.load(); 
            
        
    },
    
     filtraAddEdit:function(){
        this.cmpTipoProceso.store.baseParams.id_proceso_macro=this.cmbProcesoMacro.getValue();
        this.cmpTipoProceso.modificado=true;
            
        
    },
    
     iniciarEventos:function(){
          
          this.cmpTipoProceso=this.getComponente('id_tipo_proceso');
          
          this.cmpInicioProceso=this.getComponente('inicioProceso');
          
          this.cmpIdPersona=this.getComponente('id_persona');
          this.cmpIdInstitucion=this.getComponente('id_institucion');
          
          
            this.cmpInicioProceso.on('change',function(groupRadio,radio){
                        this.enableDisable(radio.inputValue);
                        
                    },this); 
                    
    },
    
    sortInfo:{
		field: 'id_proceso_wf',
		direction: 'ASC'
	},
	
	onButtonNew: function() {
	    
	    if(this.validarFiltros())
	       {Phx.vista.ProcesoWf.superclass.onButtonNew.call(this);
            this.filtraAddEdit();
            this.enableDisable('persona');
            
            }
        else{
            alert('Seleccione el Trámite');
        }
       
    },
    onButtonEdit: function() {
        Phx.vista.ProcesoWf.superclass.onButtonEdit.call(this);
        this.filtraAddEdit();
    },
     
     enableDisable:function(val){
      if(val =='institucion'){
            
            this.cmpIdPersona.disable();
            this.cmpIdInstitucion.enable();
            this.cmpIdPersona.setVisible(false);
            this.cmpIdInstitucion.setVisible(true);
        }
        else{
            this.cmpIdPersona.enable();
            this.cmpIdInstitucion.disable();
            this.cmpIdPersona.setVisible(true);
            this.cmpIdInstitucion.setVisible(false);
            
         }
         
     },
	
	bdel:true,
	bsave:false
	
	}
)
</script>
		
		