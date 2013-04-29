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
		
		Phx.vista.ProcesoWf.superclass.constructor.call(this,config);
		this.init();
		 this.store.baseParams={tipo_interfaz:this.nombreVista};
		//this.load({params:{start:0, limit:this.tam_pag}});
		this.iniciarEventos();
        
        
        this.cmbProcesoMacro.on('select', function(){
            
            if(this.validarFiltros()){
                  this.capturaFiltros();
           }
            
            
        },this);
        
        
            this.formEstado = new Ext.form.FormPanel({
            baseCls: 'x-plain',
            autoDestroy: true,
           
            border: false,
            layout: 'form',
             autoHeight: true,
           
    
                items: [
                    {
                        xtype: 'combo',
                        name: 'id_tipo_estado',
                          hiddenName: 'id_tipo_estado',
                        fieldLabel: 'Siguiente Estado',
                        listWidth:280,
                        allowBlank: false,
                        emptyText:'Elija el estado siguiente',
                        store:new Ext.data.JsonStore(
                        {
                            url: '../../sis_workflow/control/TipoEstado/listarTipoEstado',
                            id: 'id_tipo_estado',
                            root:'datos',
                            sortInfo:{
                                field:'tipes.codigo',
                                direction:'ASC'
                            },
                            totalProperty:'total',
                            fields: ['id_tipo_estado','codigo_estado','nombre_estado'],
                            // turn on remote sorting
                            remoteSort: true,
                            baseParams:{par_filtro:'tipes.nombre_estado#tipes.codigo'}
                        }),
                        valueField: 'id_tipo_estado',
                        displayField: 'codigo_estado',
                        forceSelection:true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender:true,
                        mode:'remote',
                        pageSize:50,
                        queryDelay:500,
                        width:210,
                        gwidth:220,
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo_estado}</p>Prioridad: <strong>{nombre_estado}</strong> </div></tpl>'
                    
                    },
                    {
                        xtype: 'combo',
                        name: 'id_funcionario_wf',
                        hiddenName: 'id_funcionario_wf',
                        fieldLabel: 'Funcionario Resp.',
                        allowBlank: false,
                        emptyText:'Elija un funcionario',
                        listWidth:280,
                        store:new Ext.data.JsonStore(
                        {
                            url: '../../sis_workflow/control/TipoEstado/listarFuncionarioWf',
                            id: 'id_funcionario',
                            root:'datos',
                            sortInfo:{
                                field:'prioridad',
                                direction:'ASC'
                            },
                            totalProperty:'total',
                            fields: ['id_funcionario','desc_funcionario','prioridad'],
                            // turn on remote sorting
                            remoteSort: true,
                            baseParams:{par_filtro:'fun.desc_funcionario1'}
                        }),
                        valueField: 'id_funcionario',
                        displayField: 'desc_funcionario',
                        forceSelection:true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender:true,
                        mode:'remote',
                        pageSize:50,
                        queryDelay:500,
                        width:210,
                        gwidth:220,
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{desc_funcionario}</p>Prioridad: <strong>{prioridad}</strong> </div></tpl>'
                    
                    },
                    {
                        name: 'obs',
                        xtype: 'textarea',
                        fieldLabel: 'Intrucciones',
                        allowBlank: false,
                        anchor: '80%',
                        maxLength:500
                    }]
            });
        
            this.wEstado = new Ext.Window({
                title: 'Estados',
                collapsible: true,
                maximizable: true,
                 autoDestroy: true,
                width: 350,
                height: 200,
                layout: 'fit',
                plain: true,
                bodyStyle: 'padding:5px;',
                buttonAlign: 'center',
                items: this.formEstado,
                modal:true,
                 closeAction: 'hide',
                buttons: [{
                    text: '1 Guardar',
                    handler:this.confSigEstado,
                    scope:this
                    
                },
                {
                    text: '2 Guardar',
                    handler:this.antEstadoSubmmit,
                    scope:this
                    
                },
                {
                    text: 'Cancelar',
                    handler:function(){this.wEstado.hide()},
                    scope:this
                }]
            });
            
        this.cmbTipoEstado =this.formEstado.getForm().findField('id_tipo_estado');
        this.cmbTipoEstado.store.on('loadexception', this.conexionFailure,this);
     
        this.cmbFuncionarioWf =this.formEstado.getForm().findField('id_funcionario_wf');
        this.cmbFuncionarioWf.store.on('loadexception', this.conexionFailure,this);
      
        this.cmpObs =this.formEstado.getForm().findField('obs');
        
        
        
        this.cmbTipoEstado.on('select',function(){
            
            this.cmbFuncionarioWf.enable();
            this.cmbFuncionarioWf.store.baseParams.id_tipo_estado = this.cmbTipoEstado.getValue();
            this.cmbFuncionarioWf.modificado=true;
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
				gwidth: 180,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'pwf.nro_tramite',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
			
		},
        {
            config:{
                name: 'codigo_estado',
                fieldLabel: 'Estado',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:4
            },
            type:'NumberField',
            filters:{pfiltro:'te.codigo',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },{
           config:{
               name: 'tipo_ini',
               fieldLabel: 'Inicio del Proceso',
               gwidth: 100,
               items: [
                   {boxLabel: 'Persona',name: 'trg-auto',  inputValue: 'persona', checked:true},
                   {boxLabel: 'Institucion',name: 'trg-auto', inputValue: 'institucion'}
               ]
           },
           type:'RadioGroupField',
          
           filters:{pfiltro:'tipo_ini',type:'string'},
           id_grupo:1,
           grid:false,
           form:true
          },
          
                
         {
            config:{
                name:'id_persona',
                origen:'PERSONA',
                 tinit:true,
                allowBlank:false,
                fieldLabel:'Originado por',
                gdisplayField:'desc_persona',//mapea al store del grid
                gwidth:250,
                 renderer:function (value, p, record){
                     if(record.data.tipo_ini =='persona'){
                     return String.format('{0}', record.data['desc_persona']);
                    }
                    else{
                      return String.format('{0}', record.data['desc_institucion']);  
                    }}
             },
            type:'ComboRec',
            id_grupo:1,
            filters:{   
                pfiltro:'per.nombre_completo1#int.nombre',
                type:'string'
            },
            grid:true,
            form:true
          },         {
            config:{
                name:'id_institucion',
                origen:'INSTITUCION',
                 allowBlank:false,
                 tinit:true,
                 fieldLabel:'Originado por',
                 gdisplayField:'desc_institucion',//mapea al store del grid
                 gwidth:250,
                 //renderer:function (value, p, record){return String.format('{0}', record.data['desc_institucion']);}
             },
            type:'ComboRec',
            id_grupo:1,
            filters:{   
                //pfiltro:'mon.codigo',
                type:'string'
            },
            grid:false,
            form:true
          },
          {
            config:{
                name: 'fecha_ini',
                fieldLabel: 'Fecha Inicio',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                        format: 'd/m/Y', 
                        renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
            },
            type:'DateField',
            filters:{pfiltro:'pwf.fecha_ini',type:'date'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'obs',
                fieldLabel: 'Intrucciones',
                allowBlank: true,
                anchor: '80%',
                gwidth: 200,
                maxLength:4
            },
            type:'Field',
            filters:{pfiltro:'ew.obs',type:'string'},
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
		},{
            config:{
                name: 'estado_reg',
                fieldLabel: 'Estado Reg.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:10
            },
            type:'DateField',
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
		{name:'fecha_ini', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},'obs',
		{name:'usr_mod', type: 'string'},'tipo_estado_disparador','tipo_estado_inicio','tipo_estado_fin','id_estado_wf',
		'desc_tipo_proceso','desc_persona','desc_institucion','tipo_ini','codigo_estado'
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
    
    sortInfo:{
		field: 'id_proceso_wf',
		direction: 'ASC'
	},
     
     
     
	confSigEstado :function() {                   
            var d= this.sm.getSelected().data;
           
            if ( this.formEstado.getForm().isValid()){
                 Phx.CP.loadingShow();
                    Ext.Ajax.request({
                        // form:this.form.getForm().getEl(),
                        url:'../../sis_workflow/control/ProcesoWf/siguienteEstadoProcesoWf',
                        params:{
                            id_proceso_wf:d.id_proceso_wf,
                            operacion:'cambiar',
                            id_tipo_estado:this.cmbTipoEstado.getValue(),
                            id_funcionario:this.cmbFuncionarioWf.getValue(),
                            obs:this.cmpObs.getValue()
                            },
                        success:this.successSinc,
                        failure: this.conexionFailure,
                        timeout:this.timeout,
                        scope:this
                    }); 
              }    
    },
    sigEstado:function()
        {                   
            var d= this.sm.getSelected().data;
            
            this.cmbTipoEstado.show();
            this.cmbFuncionarioWf.show();
            
            this.cmbTipoEstado.enable();
            this.cmbFuncionarioWf.enable();
           
            Phx.CP.loadingShow();
            this.cmbTipoEstado.reset();
            this.cmbFuncionarioWf.reset();
            this.cmbFuncionarioWf.store.baseParams.id_estado_wf=d.id_estado_wf;
            this.cmbFuncionarioWf.store.baseParams.fecha=d.fecha_ini;
            
            
         
            Ext.Ajax.request({
                // form:this.form.getForm().getEl(),
                url:'../../sis_workflow/control/ProcesoWf/siguienteEstadoProcesoWf',
                params:{id_proceso_wf:d.id_proceso_wf,operacion:'verificar'},
                success:this.successSinc,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });     
        },
       
        antEstado:function(res,eve)
        {                   
            
            this.wEstado.buttons[0].hide();
            this.wEstado.buttons[1].show();
            this.wEstado.show();
            
            this.cmbTipoEstado.hide();
            this.cmbFuncionarioWf.hide();
            this.cmbTipoEstado.disable();
            this.cmbFuncionarioWf.disable();
            
                
        },
        
        antEstadoSubmmit:function(res){
            var d= this.sm.getSelected().data;
           
            Phx.CP.loadingShow();
            var operacion = 'cambiar';
            Ext.Ajax.request({
               
                url:'../../sis_workflow/control/ProcesoWf/anteriorEstadoProcesoWf',
                params:{id_proceso_wf:d.id_proceso_wf, 
                        id_estado_wf:d.id_estado_wf, 
                        operacion: operacion,
                        obs:this.cmpObs.getValue()},
                success:this.successSinc,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            }); 
            
            
        },
	
     successSinc:function(resp){
            
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
               if (reg.ROOT.datos.operacion=='preguntar_todo'){
                   //TO DO, verificar consiguracion de tipo_proceso para perdir observaciones
                   if(reg.ROOT.datos.num_estados==1 && reg.ROOT.datos.num_funcionarios==1){
                       //directamente mandamos los datos
                       Phx.CP.loadingShow();
                       var d= this.sm.getSelected().data;
                       Ext.Ajax.request({
                        // form:this.form.getForm().getEl(),
                        url:'../../sis_workflow/control/ProcesoWf/siguienteEstadoProcesoWf',
                        params:{id_proceso_wf:d.id_proceso_wf,
                            operacion:'cambiar',
                            id_tipo_estado:reg.ROOT.datos.id_tipo_estado,
                            id_funcionario:reg.ROOT.datos.id_funcionario_estado,
                            id_depto:reg.ROOT.datos.id_depto_estado,
                            id_proceso_wf:d.id_proceso_wf,
                            obs:this.cmpObs.getValue()
                            
                            },
                        success:this.successSinc,
                        failure: this.conexionFailure,
                        timeout:this.timeout,
                        scope:this
                    }); 
                 }
                   else{
                     this.cmbTipoEstado.store.baseParams.estados= reg.ROOT.datos.estados;
                     this.cmbTipoEstado.modificado=true;
                     this.cmbFuncionarioWf.disable();
                     this.wEstado.buttons[1].hide();
                     this.wEstado.buttons[0].show();
                     this.wEstado.show();  
                  }
                   
               }
               
                if (reg.ROOT.datos.operacion=='cambio_exitoso'){
                
                  this.reload();
                  this.wEstado.hide();
                
                }
               
                
            }else{
                
                alert('ocurrio un error durante el proceso')
            }
           
            
        },
    onButtonAct:function(){
          if(this.validarFiltros())
           {
               
             Phx.vista.ProcesoWf.superclass.onButtonAct.call(this);
            
            }
        else{
            alert('Seleccione el Trámite');
        }
       
       
        
    },
	
	bdel:true,
	bsave:false
	
	}
)
</script>
		
		