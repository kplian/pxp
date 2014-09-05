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
	nombreVista : 'ProcesoWf',
	constructor:function(config){
		this.maestro=config.maestro;
    	
    	//funcionalidad para listado de historicos
        this.historico = 'no';
        this.tbarItems = ['-',{
            text: 'Histórico',
            enableToggle: true,
            pressed: false,
            toggleHandler: function(btn, pressed) {
               
                if(pressed){
                    this.historico = 'si';
                     this.desBotoneshistorico();
                }
                else{
                   this.historico = 'no' 
                }
                
                this.store.baseParams.historico = this.historico;
                this.onButtonAct();
             },
            scope: this
           }];
    	
    	
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
        
       this.addButton('btnChequeoDocumentosWf',
            {
                text: 'Chequear Documentos',
                iconCls: 'bchecklist',
                disabled: true,
                handler: this.loadCheckDocumentosWf,
                tooltip: '<b>Documentos del Proceso</b><br/>Subir los documetos requeridos en el proceso seleccionada.'
            }
        ); 
        
       this.addButton('diagrama_gantt',{text:'',iconCls: 'bgantt',disabled:true,handler:this.diagramGantt,tooltip: '<b>Diagrama Gantt de proceso macro</b>'});
  
     
        this.addButton('ant_estado',{
                    text:'Anterior',
                    iconCls:'batras',
                    disabled:true,
                    handler:this.openAntFormEstadoWf,
                    tooltip: '<b>Retroceder un estado</b>'});
        
        
        this.addButton('sig_estado',{
                    text:'Siguiente',
                    iconCls:'badelante',
                    disabled:true,
                    handler:this.openFormEstadoWf,
                    tooltip: '<b>Cambiar al siguientes estado</b>'});
  
    },
    diagramGantt:function (){         
            var data=this.sm.getSelected().data.id_proceso_wf;
            Phx.CP.loadingShow();
            Ext.Ajax.request({
                url:'../../sis_workflow/control/ProcesoWf/diagramaGanttTramite',
                params:{'id_proceso_wf':data},
                success:this.successExport,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });         
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
                    baseParams: {par_filtro: 'promac.nombre#promac.codigo',codigo_subsistema:'WF'}
                }),
                valueField: 'id_proceso_macro',
                displayField: 'nombre',
              
                 triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                 listWidth:'280',
                anchor: '80%',
                minChars: 2,
               tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p>Codigo: <strong>{codigo}</strong> </div></tpl>'
       }),
    
    loadCheckDocumentosWf:function() {
            var rec=this.sm.getSelected();
            rec.data.nombreVista = this.nombreVista;
            Phx.CP.loadWindows('../../../sis_workflow/vista/documento_wf/DocumentoWf.php',
                    'Chequear documento del WF',
                    {
                        width:'90%',
                        height:500
                    },
                    rec.data,
                    this.idContenedor,
                    'DocumentoWf'
        )
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
        this.store.baseParams.id_proceso_macro=this.cmbProcesoMacro.getValue();
        this.load(); 
            
        
    },
    
    sortInfo:{
		field: 'id_proceso_wf',
		direction: 'DESC'
	},
     
    onAntEstado:function(wizard,resp){
            Phx.CP.loadingShow();
            Ext.Ajax.request({
                url:'../../sis_workflow/control/ProcesoWf/anteriorEstadoProcesoWf',
                params:{id_proceso_wf:resp.id_proceso_wf, 
                        id_estado_wf:resp.id_estado_wf, 
                        operacion: 'cambiar',
                        obs:resp.obs},
                argument:{wizard:wizard},        
                success:this.successSinc,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            }); 
     },
    
    
    successSinc:function(resp){
        Phx.CP.loadingHide();
        resp.argument.wizard.panel.destroy()
        this.reload();
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
    
    openFormEstadoWf:function(){
       
        
        var rec=this.sm.getSelected();
        
         console.log(rec.data)
        
        
            Phx.CP.loadWindows('../../../sis_workflow/vista/estado_wf/FormEstadoWf.php',
            'Estado de Wf',
            {
                modal:true,
                width:700,
                height:450
            }, {data:rec.data}, this.idContenedor,'FormEstadoWf',
            {
                config:[{
                          event:'beforesave',
                          delegate: this.onSaveWizard,
                          
                        }],
                
                scope:this
             })
        
        
    },
    
    
    openAntFormEstadoWf:function(){
         var rec=this.sm.getSelected();
            Phx.CP.loadWindows('../../../sis_workflow/vista/estado_wf/AntFormEstadoWf.php',
            'Estado de Wf',
            {
                modal:true,
                width:450,
                height:250
            }, {data:rec.data}, this.idContenedor,'AntFormEstadoWf',
            {
                config:[{
                          event:'beforesave',
                          delegate: this.onAntEstado,
                        }
                        ],
               scope:this
             })
   },
   
   
    
   
    successWizard:function(resp){
        Phx.CP.loadingHide();
        resp.argument.wizard.panel.destroy()
        this.reload();
     },
    
    onSaveWizard:function(wizard,resp){
        
        Phx.CP.loadingShow();
        Ext.Ajax.request({
            url:'../../sis_workflow/control/ProcesoWf/siguienteEstadoProcesoWf',
            params:{
                
                id_proceso_wf_act:  resp.id_proceso_wf_act,
                id_estado_wf_act:  resp.id_estado_wf_act,
                id_tipo_estado:     resp.id_tipo_estado,
                id_funcionario_wf:  resp.id_funcionario_wf,
                id_depto_wf:        resp.id_depto_wf,
                obs:                resp.obs,
                json_procesos:      Ext.util.JSON.encode(resp.procesos)
                },
            success:this.successWizard,
            failure: this.conexionFailure,
            argument:{wizard:wizard},
            timeout:this.timeout,
            scope:this
        });
         
    },
    
    //deshabilitas botones para informacion historica
    desBotoneshistorico:function(){
          
          this.getBoton('ant_estado').disable();
          this.getBoton('sig_estado').disable();
          
          if(this.bedit){
            this.getBoton('edit').disable();  
          }
          
          if(this.bdel){
               this.getBoton('del').disable();
          }
          if(this.bnew){
               this.getBoton('new').disable();
          }
         
          
    },
    preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
      Phx.vista.ProcesoWf.superclass.preparaMenu.call(this,n); 
     this.getBoton('btnChequeoDocumentosWf').setDisabled(false);
     this.getBoton('diagrama_gantt').enable();
       if(this.historico == 'no'){
          
          this.getBoton('sig_estado').enable();
          this.getBoton('ant_estado').enable();          
          
          if(data.codigo_estado == 'borrador' ){ 
             this.getBoton('ant_estado').disable();
           
          }
          if(data.codigo_estado == 'finalizado' || data.codigo_estado =='anulado'){
               this.getBoton('sig_estado').disable();
               this.getBoton('ant_estado').disable();
          }
       }   
      else{
          this.desBotoneshistorico();
          
      }    
      return tb;
    },
    liberaMenu:function(){
        var tb = Phx.vista.ProcesoWf.superclass.liberaMenu.call(this);
        this.getBoton('btnChequeoDocumentosWf').setDisabled(true);
        if(tb){
            this.getBoton('sig_estado').disable();
            this.getBoton('ant_estado').disable();
            this.getBoton('diagrama_gantt').disable();
           
        }
        return tb
    },
    
    bdel:true,
	bsave:false
	
	}
)
</script>
		
		
