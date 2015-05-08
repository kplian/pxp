<?php
/**
*@package pXP
*@file gen-TipoDocumentoEstado.php
*@author  (admin)
*@date 15-01-2014 03:12:38
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoDocumentoEstado=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
	    
	     this.Grupos= [
                   {
                    layout:'column',
                    width:'100%',
                    autoScroll:true,
                    items: [
                           {id: config.idContenedor+'-card-0',
                            width:'45%',
                            xtype: 'fieldset',
                            title: 'Datos principales',
                            autoHeight: true,
                            border:false,
                            margin:'5 5 5 5',
                            items: [],
                            id_grupo:0
                           },
                           {
                               xtype:'panel',
                               //margin:'5 5 5 5',
                               width:'45%',
                               html:'Es posible hacer una llamada a una funcion con las siguientes variables:<br/>wf.f_mi_funcion(p_id_usuario, p_id_proceso_wf, p_id_estado_anterior, p_id_tipo_estado_actual) El retorno debe ser FALSE o TRUE<br/>---------<b><h2>Variables WF, para las reglas</h2></b> <br> PROCESO_MACRO<br>TIPO_PROCESO<br>NUM_TRAMITE<br>USUARIO_PREVIO<br>ESTADO_ANTERIOR<br>OBS<br>ESTADO_ACTUAL<br>CODIGO_ANTERIOR<br><br>CODIGO_ACTUAL<br>FUNCIONARIO_PREVIO<br>DEPTO_PREVIO<br><br>** Verificar que las variables que referencian a la tabla existan  EJM {$tabla.desc_proveedor}'
                               
                           }]
                }
            
            ];
	    
	    
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoDocumentoEstado.superclass.constructor.call(this,config);
		this.init();
        this.bloquearMenus();
        this.iniciarEventos();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_documento_estado'
			},
			type:'Field',
			form:true 
		},
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
            config:{
                name: 'momento',
                fieldLabel: 'Momento',
                allowBlank: false,
                anchor: '80%',
                gwidth: 70,
                maxLength:50,
                emptyText:'momento...',                
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                valueField: 'momento',                  
                store:['crear','verificar','exigir','hacer_exigible','exigir_fisico','verificar_fisico','firmar','eliminar_firma','insertar','modificar','eliminar']
            },
            type:'ComboBox',
            //filters:{pfiltro:'des.momento',type:'string'},
            id_grupo:1,
            filters:{   
                         type: 'list',
                         pfiltro:'tipdw.tipo',
                         options: ['crear','verificar','exigir','hacer_exigible','exigir_fisico','virificar_fisico','firmar','eliminar_firma','insertar','modificar','eliminar'],   
                    },
            grid:true,
            form:true
        },
        
        {
			config: {
				name: 'id_tipo_proceso',
				fieldLabel: 'Tipo Proceso',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_workflow/control/TipoProceso/listarTipoProceso',
					id: 'id_',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_proceso', 'nombre', 'codigo','id_proceso_macro','desc_proceso_macro'],
					remoteSort: true,
					baseParams: {par_filtro: 'tipproc.nombre#tipproc.codigo'}
				}),
				valueField: 'id_tipo_proceso',
				displayField: 'nombre',
				gdisplayField: 'desc_tipo_proceso',
				hiddenName: 'id_tipo_proceso',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '80%',
				gwidth: 150,
				listWidth:'280',
                resizable:true,
                minChars: 2,
				tpl: '<tpl for="."><div class="x-combo-list-item"><p><b>({codigo})- {nombre}</b></p><p>Proceso Macro: {desc_proceso_macro}</p></strong> </div></tpl>',
                renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_tipo_proceso']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'movtip.nombre',type: 'string'},
			grid: true,
			form: true
		},
        {
            config: {
                name: 'id_tipo_estado',
                fieldLabel: 'Estado',
                typeAhead: false,
                forceSelection: false,
                allowBlank: false,
                emptyText: 'Lista de Estados...',
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
                valueField: 'id_tipo_estado',
                displayField: 'nombre_estado',
                gdisplayField: 'desc_tipo_estado',
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                anchor: '80%',
                listWidth:'280',
                resizable:true,
                minChars: 2,
                gwidth: 200,
                renderer: function(value, p, record) {
                    return String.format('{0}', record.data['desc_tipo_estado']);
                },
                tpl: '<tpl for="."><div class="x-combo-list-item"><p><b>({codigo_estado})- {nombre_estado}</b></p>Inicio: <strong>{inicio}</strong>, Fin: <strong>{fin} <p>Tipo Proceso: {desc_tipo_proceso}</p></strong> </div></tpl>'
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
                name: 'tipo_busqueda',
                fieldLabel: 'Busqueda ',
                allowBlank: false,
                anchor: '70%',
                gwidth: 150,
                maxLength:50,
                emptyText:'Tipo...',                
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                listWidth:'280',
                resizable:true,
                mode: 'local',
				
                valueField: 'tipo_asignacion',                  
              store:['superior','inferior']
            },
            type:'ComboBox',
            //filters:{pfiltro:'tipdw.tipo',type:'string'},
            id_grupo:1,
            filters:{   
                         type: 'list',
                         pfiltro:'des.tipo_busqueda',
                         options: ['superior','inferior'],   
                    },
            grid:true,
			egrid:true,
            form:true
        },
        {
            config:{
                name: 'regla',
                fieldLabel: 'Regla (función a llamar)',
                allowBlank: true,
                anchor: '100%',
                height:300,
                gwidth: 300,
				
                maxLength:1000
            },
            type:'TextArea',
            filters:{pfiltro:'des.regla',type:'string'},
            id_grupo:1,
            grid:true,
			egrid:true,
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
				filters:{pfiltro:'des.estado_reg',type:'string'},
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
				filters:{pfiltro:'des.fecha_reg',type:'date'},
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
				filters:{pfiltro:'des.fecha_mod',type:'date'},
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
	
	onReloadPage:function(m){
        this.maestro=m;
        this.store.baseParams={id_tipo_proceso:this.maestro.id_tipo_proceso};
        this.store.baseParams={id_tipo_documento:this.maestro.id_tipo_documento};
        this.load({params:{start:0, limit:50}});
        
        
        
    },
    loadValoresIniciales:function()
    {
        Phx.vista.TipoDocumentoEstado.superclass.loadValoresIniciales.call(this);
        this.Cmp.id_tipo_documento.setValue(this.maestro.id_tipo_documento); 
        this.Cmp.id_tipo_proceso.store.baseParams.id_proceso_macro=this.maestro.id_proceso_macro;
        this.Cmp.id_tipo_proceso.modificado=true;
        this.Cmp.id_tipo_proceso.reset(); 
        
            
    },
    
    iniciarEventos:function(){
        
        this.Cmp.momento.on('select',function(cmp,rec){ 
            
            //si el momento es del tipo crear solo que el tipo proceso 
            //sea el mismo al que corresponde el tipo documento
            if(rec.data.field1 == 'crear'){
                this.Cmp.id_tipo_proceso.store.baseParams.id_tipo_proceso=this.maestro.id_tipo_proceso;
                
            }
            else{
                this.Cmp.id_tipo_proceso.store.baseParams.id_tipo_proceso='';
               
                
            }
            this.Cmp.id_tipo_proceso.store.baseParams.pm_relacionado = 'si';
            this.Cmp.id_tipo_proceso.modificado=true;
            this.Cmp.id_tipo_proceso.reset();
            
            
           },this);
           
       
       
       
       this.Cmp.id_tipo_proceso.on('select',function(rec){ 
            //Aprobador  
            this.Cmp.id_tipo_estado.store.baseParams.id_tipo_proceso=this.Cmp.id_tipo_proceso.getValue();
            this.Cmp.id_tipo_estado.modificado=true;
            this.Cmp.id_tipo_estado.reset();
            
        },this);
        
        
         
         
    },
    
    onButtonEdit:function(){
      
      Phx.vista.TipoDocumentoEstado.superclass.onButtonEdit.call(this);
      if(this.Cmp.momento.getValue() == 'crear'){
          this.Cmp.id_tipo_proceso.store.baseParams.id_tipo_proceso=this.maestro.id_tipo_proceso;
      }
      else{
         this.Cmp.id_tipo_proceso.store.baseParams.id_tipo_proceso='';
      }
      
      this.Cmp.id_tipo_proceso.store.baseParams.id_proceso_macro=this.maestro.id_proceso_macro;
      this.Cmp.id_tipo_estado.store.baseParams.id_tipo_proceso=this.Cmp.id_tipo_proceso.getValue();
      
      this.Cmp.id_tipo_proceso.modificado=true;
       
       
       this.Cmp.id_tipo_estado.store.baseParams.id_tipo_proceso = this.Cmp.id_tipo_proceso.getValue();
       this.Cmp.id_tipo_estado.modificado=true;
          
    },
	
	tam_pag:50,	
	title:'Momentos por Estados ',
	ActSave:'../../sis_workflow/control/TipoDocumentoEstado/insertarTipoDocumentoEstado',
	ActDel:'../../sis_workflow/control/TipoDocumentoEstado/eliminarTipoDocumentoEstado',
	ActList:'../../sis_workflow/control/TipoDocumentoEstado/listarTipoDocumentoEstado',
	id_store:'id_tipo_documento_estado',
	fields: [
		{name:'id_tipo_documento_estado', type: 'numeric'},
		{name:'id_tipo_estado', type: 'numeric'},
		{name:'id_tipo_documento', type: 'numeric'},
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'momento', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'desc_tipo_proceso',
		'desc_tipo_estado','tipo_busqueda','regla'
		
	],
	sortInfo:{
		field: 'id_tipo_documento_estado',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
})


</script>