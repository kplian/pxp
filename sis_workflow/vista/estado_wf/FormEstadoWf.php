<?php
/**
*@package pXP
*@file    SubirArchivo.php
*@author  Rensi ARteaga Copari
*@date    27-03-2014
*@description permites subir archivos a la tabla de documento_sol
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FormEstadoWf=Ext.extend(Phx.frmInterfaz,{
    ActSave:'../../sis_workflow/control/DocumentoWf/subirArchivoWf',
    banderaCerrar :true ,
    layout:'fit',
    maxCount:0,
    url_verificacion:'../../sis_workflow/control/ProcesoWf/verficarSigEstProcesoWf',
    url_check_state:'../../sis_workflow/control/ProcesoWf/checkNextState',
    reclaim: false,
    configExtra:[],
    constructor:function(config)
    {    	
    	this.forzar_documentos = 'no';
		if (config.data.hasOwnProperty('forzar_documentos')) {
			if (config.data.forzar_documentos == 'si') {
				this.forzar_documentos = 'si';
			}
		}
        //declaracion de eventos
        this.addEvents('beforesave');
        this.addEvents('successsave');
        this.addEvents('requirefields');
        if(config.configExtra){
        	 this.Atributos = this.Atributos.concat(config.configExtra);
        }
       
        if(config.data.url_verificacion){
           this.url_verificacion =  config.data.url_verificacion;
        }
        this.config = config; 
        //llamada ajax para cargar los caminos posible de flujo
        this.verificar();
           
        //Setea bandera de autoasignacion
        if(config.data.reclaim){
            this.reclaim = config.data.reclaim;    
        }
        
        
     },
     siguienteDocumento : function () {
     	this.banderaCerrar = false;
     	
     	this.verificar();
     },
     verificar : function() {
     	
     	Phx.CP.loadingShow();
        Ext.Ajax.request({
                url: this.url_verificacion,
                params: { id_proceso_wf: this.config.data.id_proceso_wf,
                          operacion: 'verificar'},
                argument: { 'config': this.config },
                success: this.successSinc,
                failure: this.meConexionFailure,
                timeout: this.timeout,
                scope: this
            });
     },
     
     meConexionFailure:function(resp){
         this.conexionFailure(resp);
         this.close();    	
         this.destroy();
    },
    
    cerrar : function () {  
    	
    	if (this.banderaCerrar) { 	
    		Ext.getCmp(this.config.idContenedor).close();
    	}    	
    },     
     
    successSinc:function(resp){
        Phx.CP.loadingHide();
        var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
        if(!reg.ROOT.error && reg.ROOT.datos.error_validacion_campos == 'no' && 
        	reg.ROOT.datos.error_validacion_documentos == 'no' && this.forzar_documentos == 'no'){
              //inicia el proceso de dibjar la interface
              this.iniciarInterfaz(resp.argument.config,reg.ROOT.datos);
        } else if (reg.ROOT.datos.error_validacion_campos == 'si') {
        	this.fireEvent('requirefields',this,reg.ROOT.datos.mensaje);
        	Ext.getCmp(this.config.idContenedor).close();
        
        } else if (reg.ROOT.datos.error_validacion_documentos == 'si' || this.forzar_documentos == 'si') {
        	this.forzar_documentos = 'no';
        	this.banderaCerrar = true;
        	this.loadCheckDocumentosWf();
        }
        else{
            alert('Error al identificar siguientes pasos')
        }
    },
    
    loadCheckDocumentosWf:function() {	            
        this.config.data.tipo = 'wizard'    
        Phx.CP.loadWindows('../../../sis_workflow/vista/documento_wf/DocumentoWf.php',
                'Documentos del Proceso',
                {
                    width:'90%',
                    height:500
                },
                this.config.data,
                this.idContenedor,
                'DocumentoWf',
                {
                    config:[{
                              event:'loadWizard',
                              delegate: this.siguienteDocumento,
                              
                            },
                            {
                              event:'closepanel',
                              delegate: this.cerrar
                              
                            }],
                    
                    scope:this
                 }
       );
       
    },
    
    
    iniciarInterfaz:function(config,datos){
        
        //contruir los grupos y formualrio con los datos obtenidos
        this.armarGrupos(config);
        Phx.vista.FormEstadoWf.superclass.constructor.call(this,config);
       
        this.init();
        
       
        
        // CONFIGURA ESTADOS INICIALES DE LOS ATRIBUTOS BASICOS   
        this.Cmp.id_tipo_estado.reset();
        this.Cmp.id_tipo_estado.store.baseParams.estados= datos.estados;
        this.Cmp.id_tipo_estado.modificado=true;    
        this.Cmp.id_tipo_estado.store.on('loadexception', this.conexionFailure,this);
        this.Cmp.id_funcionario_wf.store.on('loadexception', this.conexionFailure,this);
        this.Cmp.id_depto_wf.store.on('loadexception', this.conexionFailure,this);
        this.Cmp.id_funcionario_wf.disable();
        this.Cmp.id_depto_wf.disable();
        
        //deshabilitar boton submit
        this.form.buttons[0].disable();
        //esconde boton reset
        this.form.buttons[1].hide();
        this.wizardNext.setDisabled(true);
        this.wizardLast.setDisabled(true);
        
        ////////////////////////
        //DEFINE EVENTOS
        ///////////////////////////
        
        this.Cmp.id_tipo_estado.on('select',function(combo, record, index){
               
               //cheque que procesos dispara
               this.checkNextState();
               
               //'tipo_asignacion','depto_asignacion'
               if(record.data.tipo_asignacion != 'ninguno'){
                   this.Cmp.id_funcionario_wf.reset();
                   this.Cmp.id_funcionario_wf.enable();
                   this.Cmp.id_funcionario_wf.store.baseParams.id_estado_wf=config.data.id_estado_wf;
                   this.Cmp.id_funcionario_wf.store.baseParams.fecha=config.data.fecha_ini;
                   this.Cmp.id_funcionario_wf.store.baseParams.id_tipo_estado = this.Cmp.id_tipo_estado.getValue();
                   this.Cmp.id_funcionario_wf.modificado=true;
               }
               else{
                 this.Cmp.id_funcionario_wf.disable();  
               }
               if(record.data.depto_asignacion != 'ninguno'){
                   this.Cmp.id_depto_wf.reset(); 
                   this.Cmp.id_depto_wf.enable();  
                   this.Cmp.id_depto_wf.store.baseParams.id_estado_wf=config.data.id_estado_wf;
                   this.Cmp.id_depto_wf.store.baseParams.fecha=config.data.fecha_ini;
                   this.Cmp.id_depto_wf.store.baseParams.id_tipo_estado = this.Cmp.id_tipo_estado.getValue();
                   this.Cmp.id_depto_wf.modificado=true;
               }
               else{
                   this.Cmp.id_depto_wf.disable();  
               }
               
               if(record.data.pedir_obs == 'si'){
                    
                    this.Cmp.obs.allowBlank = false;
               }
               else{
                    this.Cmp.obs.allowBlank = true; 
               }
               
               
               
        },this);
        
        
        this.Cmp.id_depto_wf.on('select',function(combo, record, index){
               
               
               this.Cmp.id_funcionario_wf.reset(); 
               this.Cmp.id_funcionario_wf.store.baseParams.id_depto_wf=record.data.id_depto;
               this.Cmp.id_funcionario_wf.modificado=true;
               
               
               
               
               
        },this);
        
        
        
        this.loadValoresIniciales();
        console.log('antes de iniciar')
        //carga valores por defecto si los combos tiene una sola opcion
        this.Cmp.id_tipo_estado.store.load({params:{start:0,limit:50}, 
           callback : function (r) {
                //si solo tenemos un estado cargamos valores pro defecto
                if (r.length == 1 ) {                       
                    this.Cmp.id_tipo_estado.setValue(r[0].data.id_tipo_estado);
                    this.Cmp.id_tipo_estado.fireEvent('select',this.Cmp.id_tipo_estado, r[0], 0)

                    //carga valores para el combo depto
                     if(r[0].data.depto_asignacion != 'ninguno'){
                       var ttasig =  r[0].data.tipo_asignacion
                        this.Cmp.id_depto_wf.store.load({params:{start:0,limit:50}, 
                               callback : function (r) {
                                    if (r.length == 1 ) {                       
                                        this.Cmp.id_depto_wf.setValue(r[0].data.id_depto);
                                        console.log('asignacion del funcionario...', ttasig)
                                        if(ttasig == 'segun_depto'){
                                        	//si la signacion del funcionario es segun depto disparamos ...
                                        	this.Cmp.id_funcionario_wf.store.baseParams.id_depto_wf = r[0].data.id_depto;
                                        	this.Cmp.id_funcionario_wf.store.load({params:{start:0,limit:50}, 
													                               callback : function (r) {
													                                    if (r.length == 1 ) {                       
													                                        this.Cmp.id_funcionario_wf.setValue(r[0].data.id_funcionario);
													                                    } 
													                                }, scope : this
													                            });
                                        }
                                        
                                    }    
                                                    
                                }, scope : this
                        });
                      }
                    if(r[0].data.tipo_asignacion != 'segun_depto'){
		                    //carga el combo de funcionario si es que tiene asignacion
		                    if(r[0].data.tipo_asignacion != 'ninguno'){
		                        //Verifica si es caso de autoasignación para cargar valores para el combo funcionario
		                        if(this.reclaim==true){
		                            //Carga al funcionario que envíe el funcionario
		                            var recTem = new Array();
		                            recTem['id_funcionario'] = Phx.CP.config_ini.id_funcionario;
		                            recTem['desc_funcionario'] = Phx.CP.config_ini.nombre_usuario;
		                            recTem['prioridad'] = 1;
		                            
		                            this.Cmp.id_funcionario_wf.store.add(new Ext.data.Record(recTem, Phx.CP.config_ini.id_funcionario));
		                            this.Cmp.id_funcionario_wf.store.commitChanges();
		                            this.Cmp.id_funcionario_wf.setValue(Phx.CP.config_ini.id_funcionario);
		                            this.Cmp.id_funcionario_wf.disable();
		    
		                            
		                        } else {                        
		                            this.Cmp.id_funcionario_wf.store.load({params:{start:0,limit:50}, 
		                               callback : function (r) {
		                                    if (r.length == 1 ) {                       
		                                        this.Cmp.id_funcionario_wf.setValue(r[0].data.id_funcionario);
		                                    } 
		                                }, scope : this
		                            });
		                        }
		
		                    }
                    }
                    
                    
                 }   
                                
            }, scope : this
        });   
        //carga vaor inicial de las observaciones si existe
        this.Cmp.obs.setValue(this.obsValorInicial) 
        
        
        if(config.eventosExtra){
        	config.eventosExtra(this);
        }
        
            
    },
    
    ///////////////////////////////////////
    // ARMA GRUPOS  PARA APRIENCIA TIPO WIZARD
    ////////////////////////////////////////
     
     armarGrupos:function(config){
        
        //this.fheight = this.calTamPor('100', Ext.getBody())
        this.wizardNext = new Ext.Button({
                        text: 'Next &raquo;',
                        handler: this.cardNav.createDelegate(this, [1])
                });
        this.wizardLast = new Ext.Button({
                        text: '&laquo; Previous',
                        handler: this.cardNav.createDelegate(this, [-1]),
                        disabled: true
                    });
        //creacion del wizard con un grupo bascio            
        this.Grupos= [
                   {
                    layout:'card',
                    itemId:'card-wizard-panel',
                    activeItem: 0,
                    margins: '2 5 5 0',
                    autoScroll: true,
                    bodyStyle: 'padding:15px',
                    defaults: {border:false},
                    bbar: ['->',this.wizardLast, this.wizardNext],
                    items: [
                           {id: config.idContenedor+'-card-0',
                            xtype: 'fieldset',
                            title: 'Datos principales',
                            autoHeight: true,
                            items: [],
                            id_grupo:0
                           }]
                }
            
            ];
        
        
    },
    
    
   cardNav : function(incr){
        //obtiene tarjeta actual 
        var l =   this.form.getComponent('card-wizard-panel').getLayout();
        var i = l.activeItem.id.split(this.idContenedor+'-card-')[1];
         
        var is_valid=false;   
        //si esta avanzando validaos los componentes de la tarjeta
        if(incr==1){
            is_valid = this.validarTarjeta(i);
        }
        else{
           //si retrosede saltamos la validacion
           is_valid = true; 
        }
        
        if(is_valid){
            var next = parseInt(i, 10) + incr;
            l.setActiveItem(next);
            this.wizardLast.setDisabled(next==0);
            this.wizardNext.setDisabled(next==this.maxCount);
            if(next==this.maxCount){
                 this.form.buttons[0].enable(); 
            }
            else{
                 this.form.buttons[0].disable(); 
            }
            
        }
        
             
   },
   
   validarTarjeta:function(num_tar){
       //si es la tarjeta 0 validamos los comp basicos
       if(num_tar==0){
            if( this.Cmp.id_tipo_estado.isValid()&&
                   this.Cmp.id_funcionario_wf.isValid()&&
                   this.Cmp.id_depto_wf.isValid()&&
                   this.Cmp.obs.isValid()){
                   
                   return true;
             }
             else{
                 return false;
             }
       }
       else{
           
           //validamos otras tarjetas segun el indice
           var bolFun = this.form.getForm().findField('id_funcionario_wf_pro['+num_tar+']').isValid();
           var bolObs = this.form.getForm().findField('obs_pro['+num_tar+']').isValid();
           var bolTip = this.form.getForm().findField('id_tipo_estado_pro['+num_tar+']').isValid();
           var bolDep = this.form.getForm().findField('id_depto_wf_pro['+num_tar+']').isValid();
           
           if(bolFun&&bolObs&&bolTip&&bolDep){
                return true;
           }else{
               return false; 
           }
       }
       
       
   },
   
   checkNextState:function(){
        //llamada ajax para cargar los caminos posible de flujo
        
         Phx.CP.loadingShow();
         Ext.Ajax.request({
                url:this.url_check_state,
                params:{id_proceso_wf:this.data.id_proceso_wf,
                        id_tipo_estado_sig: this.Cmp.id_tipo_estado.getValue()},
                success:this.successNextState,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            }); 
    },
    
    successNextState:function(resp){
          Phx.CP.loadingHide();
          
          var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
          
          if(!reg.ROOT.error){
               
                    //DESTRUIR TARJETAS
                    this.destruirTarjetas();
                    // CREAR TARJETAS .....
                    var procesos = Ext.util.JSON.decode(reg.ROOT.datos.json_procesos);
                    //optine al  panel de wizard
                    var wizard = this.form.getComponent('card-wizard-panel');
                        
                    for (var i=0;i < procesos.length;i++ ){
                        //para agregar tarjeta al wizard
                        this.addProceso(procesos[i])
                        //define contador maximo para habilitar o habilitar boton next y submit
                        this.maxCount = this.maxCount +1
                    }
                        
                    if(this.maxCount==0){
                       this.form.buttons[0].enable(); 
                       this.wizardNext.setDisabled(true);
                       
                    }
                    else{
                      this.form.buttons[0].disable();
                      this.wizardNext.setDisabled(false);
                    }
                    this.wizardLast.setDisabled(true);
          }
          else{
              alert('Error al identificar siguientes pasos')
          }  
    },
    
    /////////////////Adiciona Tarjeta con los items enviados/////////////
    addTarjetaItems:function(items_to_add){
        var cont = this.contadorTarjetas;
        var cont = this.contadorTarjetas;
        
        this.addCardWizart({
                           id: this.idContenedor+'-card-'+cont,
                           layout:'form',
                           autoScroll:true,
                           items : items_to_add });
        this.contadorTarjetas = this.contadorTarjetas + 1;
        
        this.maxCount = this.maxCount + 1;
    },
    
    /////////////////////////////////////
    //  Adiciona tarjetas de Procesos disparados
    //
    //////////////////////////////////////
    contadorTarjetas:1,
    addProceso:function(proc){
       var cont = this.contadorTarjetas;
       this.addCardWizart({
                           id: this.idContenedor+'-card-'+cont,
                           layout:'form',
                           autoScroll:true,
                           items:[
                             {
                               xtype:'label',
                               fieldLabel: 'Proceso',
                               name:'name_proceso',
                               html:'<h2>('+proc.codigo+') '+proc.nombre+'</h2>',
                               value: 'TEST'
                             },
                             
                             {
                               xtype:'field',
                               labelSeparator:'',
                               inputType:'hidden',
                               name:'id_tipo_proceso_pro['+cont+']',
                               value: proc.id_tipo_proceso
                             },
                             {
                               xtype:'checkbox',
                               fieldLabel: 'Iniciar Proceso',
                               name:'iniar_pro['+cont+']',
                               itemId: this.idContenedor+'-iniar_pro['+cont+']',
                               checked :false,
                               
                              
                             },
                             
                             {
                                // Fieldset in Column 1
                                xtype:'fieldset',
                                title: 'Datos para: ('+proc.codigo+') '+proc.nombre,
                                id: this.idContenedor+'-fieldset['+cont+']',
                                defaultType: 'textfield',
                                items :[
                                           {xtype: 'combo',
                                            name: 'id_tipo_estado_pro['+cont+']',
                                            itemId: this.idContenedor+'-id_tipo_estado_pro['+cont+']',
                                            fieldLabel: 'Estado',
                                            listWidth:280,
                                            allowBlank: false,
                                            emptyText:'Elija el estado Inicial',
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
                                                fields: ['id_tipo_estado','codigo_estado','nombre_estado','alerta','disparador','inicio','pedir_obs','tipo_asignacion','depto_asignacion'],
                                                remoteSort: true,
                                                baseParams:{par_filtro:'tipes.nombre_estado#tipes.codigo',id_tipo_proceso:proc.id_tipo_proceso,inicio:'si'}
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
                                            listWidth:'280',
                                            minChars:2,
                                            tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo_estado}</p>Prioridad: <strong>{nombre_estado}</strong> </div></tpl>',
                                            listeners:{
                                                scope:this,
                                                'select':function(combo, record, index ){
                                                   var func = this.form.getForm().findField('id_funcionario_wf_pro['+cont+']');
                                                   var dept = this.form.getForm().findField('id_depto_wf_pro['+cont+']');
                                                    
                                                   if(record.data.tipo_asignacion != 'ninguno'){
                                                       func.reset();
                                                       func.enable();
                                                       func.store.baseParams.id_estado_wf=this.data.id_estado_wf;
                                                       func.store.baseParams.fecha=this.data.fecha_ini;
                                                       func.store.baseParams.id_tipo_estado = combo.getValue();
                                                       func.modificado=true;
                                                   }
                                                   else{
                                                     func.disable();  
                                                   }
                                                   
                                                   if(record.data.depto_asignacion != 'ninguno'){
                                                       dept.reset(); 
                                                       dept.enable();  
                                                       dept.store.baseParams.id_estado_wf=this.data.id_estado_wf;
                                                       dept.store.baseParams.fecha=this.data.fecha_ini;
                                                       dept.store.baseParams.id_tipo_estado = combo.getValue();
                                                       dept.modificado=true;
                                                   }
                                                   else{
                                                       dept.disable();  
                                                   }
                                                 }
                                            }
                                        
                                        },
                                        {
                                            xtype: 'combo',
                                            name: 'id_depto_wf_pro['+cont+']',
                                            itemId: this.idContenedor+'-id_depto_wf_pro['+cont+']',
                                            fieldLabel: 'Depto Resp.',
                                            allowBlank: false,
                                            disabled:true,
                                            emptyText:'Elija un depto',
                                            listWidth:280,
                                            store: new Ext.data.JsonStore(
                                            {
                                                url: '../../sis_workflow/control/TipoEstado/listarDeptoWf',
                                                id: 'id_depto',
                                                root:'datos',
                                                sortInfo:{
                                                    field:'prioridad',
                                                    direction:'ASC'
                                                },
                                                totalProperty:'total',
                                                fields: ['id_depto','nombre_depto','subsistema','codigo','nombre_corto_depto','prioridad'],
                                                // turn on remote sorting
                                                remoteSort: true,
                                                baseParams:{par_filtro:'dep.nombre#dep.codigo#dep.nombre_corto'}
                                            }),
                                            valueField: 'id_depto',
                                            displayField: 'nombre_corto_depto',
                                            forceSelection:true,
                                            typeAhead: false,
                                            triggerAction: 'all',
                                            lazyRender:true,
                                            mode:'remote',
                                            pageSize:50,
                                            queryDelay:500,
                                            width:210,
                                            gwidth:220,
                                            listWidth:'280',
                                            minChars:2,
                                            tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo}-{nombre_depto}</p><p>{subsistema}</p>Prioridad: <strong>{prioridad}</strong> </div></tpl>',
                                            listeners: {
                                                scope: this,
                                                'select': function(combo, record, index ){
                                                   var func = this.form.getForm().findField('id_funcionario_wf_pro['+cont+']');                                                   
                                                       func.reset();                                                       
                                                       func.store.baseParams.id_depto_wf = combo.getValue();
                                                       func.modificado=true;                                                  
                                                 }
                                            }
                                
                                        },
                                        {
                                            xtype: 'combo',
                                            name: 'id_funcionario_wf_pro['+cont+']',
                                            itemId: this.idContenedor+'-id_funcionario_wf_pro['+cont+']',
                                            fieldLabel: 'Funcionario Resp.',
                                            allowBlank: false,
                                            emptyText:'Elija un funcionario',
                                            listWidth:280,
                                            disabled:true,
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
                                             listWidth:'280',
                                            minChars:2,
                                            tpl: '<tpl for="."><div class="x-combo-list-item"><p>{desc_funcionario}</p>Prioridad: <strong>{prioridad}</strong> </div></tpl>'
                                        
                                        },
                                        {
                                            xtype: 'textarea',
                                            name: 'obs_pro['+cont+']',
                                            itemId: this.idContenedor+'-obs_pro['+cont+']',
                                            fieldLabel: 'Proveido',
                                            allowBlank: false,
                                            anchor: '80%',
                                            maxLength:2000
                                        }
                                         
                                  ]}
                      
                          ]
                      });
       
       var inipro = this.form.getForm().findField('iniar_pro['+cont+']');
       
       if(proc.tipo_disparo=='' ||  proc.tipo_disparo=='obligatorio'){
           //proceso obligatorio
           inipro.setValue(true);
           inipro.disable()
       }
       else{
       	
	       	if(proc.tipo_disparo == 'manual' ||  proc.tipo_disparo =='bandeja_espera'){
	       		inipro.setValue(false);
	            inipro.disable();
	            this.form.getForm().findField('id_tipo_estado_pro['+cont+']').setDisabled(true);
	            this.form.getForm().findField('obs_pro['+cont+']').setDisabled(true);
	       	}
	       	else{
	       		inipro.setValue(false);
	            this.form.getForm().findField('id_tipo_estado_pro['+cont+']').setDisabled(true);
	            this.form.getForm().findField('obs_pro['+cont+']').setDisabled(true);
	       	}
           
       }
       
        
       
       
       
       inipro.on('check',function(obj, checked ){
           
           //var wizard = this.form.getComponent('card-wizard-panel');
           //var i = wizard.getLayout().activeItem.id.split(this.idContenedor+'-card-')[1];
           // var card = wizard.getComponent(this.idContenedor+'-card-'+i).getComponent(this.idContenedor+'-card-'+i)
           //var card = Ext.getCmp(this.idContenedor+'-fieldset['+cont+']');
           //card.setDisabled(checked)
          
          if(checked){
              this.form.getForm().findField('id_tipo_estado_pro['+cont+']').setDisabled(!checked);
              this.form.getForm().findField('obs_pro['+cont+']').setDisabled(!checked);
          }
          else{
             this.form.getForm().findField('id_tipo_estado_pro['+cont+']').setDisabled(!checked);
             this.form.getForm().findField('id_funcionario_wf_pro['+cont+']').setDisabled(!checked);
             this.form.getForm().findField('id_depto_wf_pro['+cont+']').setDisabled(!checked);
             this.form.getForm().findField('obs_pro['+cont+']').setDisabled(!checked);
          }
           
       },this)
                           
       this.contadorTarjetas = this.contadorTarjetas + 1;
       
       //carga inicial de valores en los procesos de la tarjeta
       //carga valores por defecto si los combos tiene una sola opcion
       Phx.CP.loadingShow();
       var cmpEstado = this.form.getForm().findField('id_tipo_estado_pro['+cont+']');
       var cmpFun = this.form.getForm().findField('id_funcionario_wf_pro['+cont+']');
       var cmpDep = this.form.getForm().findField('id_depto_wf_pro['+cont+']')
       cmpEstado.store.load( { params: { start:0, limit:50 }, 
           callback : function (r) {
                Phx.CP.loadingHide();
                //si solo tenemos un estado cargamos valores pordefecto
                if (r.length == 1 ) {                       
                    
                    cmpEstado.setValue(r[0].data.id_tipo_estado);
                    cmpEstado.fireEvent('select',cmpEstado, r[0], 0)
                    var tipo_asignacion = r[0].data.tipo_asignacion;
                    
                    //carga valores para el combo depto
                    if(r[0].data.depto_asignacion != 'ninguno'){
                    
                        cmpDep.store.load({params:{start:0,limit:50}, 
                               callback : function (r) {
                                     if (r.length == 1 ) {                       
                                        cmpDep.setValue(r[0].data.id_depto);
                                     } 
                                    
                                     if(tipo_asignacion == 'segun_depto'){
                                     	cmpFun.store.baseParams.id_depto_wf = r[0].data.id_depto;
                                     	cmpFun.store.load( { params: { start:0, limit:50 }, 
				                           callback : function (r) {
				                                if (r.length == 1 ) {                       
				                                    cmpFun.setValue(r[0].data.id_funcionario);
				                                } 
				                            }, scope : this
				                        });
                                     }	   
                              }, scope : this
                        });
                     }
                    
                    if(tipo_asignacion != 'segun_depto'){
	                    //caga valores para el combo funcionario
	                    if(tipo_asignacion != 'ninguno'){
	                         cmpFun.store.load( { params: { start:0, limit:50 }, 
	                           callback : function (r) {
	                                if (r.length == 1 ) {                       
	                                    cmpFun.setValue(r[0].data.id_funcionario);
	                                } 
	                            }, scope : this
	                        });
	                    }	
                    }
                    
                    
                 }   
            }, scope : this
        });
        
    },
    
    addCardWizart:function(card){
       this.form.getComponent('card-wizard-panel').add(card)
    },
    
    ////////////////////////////////////////////
    //  DETRURI TARJETA DE PROCESOS DISPARAOS
    //////////////////////////////////////////////
    
    destruirTarjetas:function(){
        var wizard = this.form.getComponent('card-wizard-panel');
        // si existen tarjetas las destruye
        for (var i=1;i<this.contadorTarjetas;i++){
          wizard.getComponent(this.idContenedor+'-card-'+i).destroy(); 
           
        }
        
        //reinicia variables de conteo
        this.contadorTarjetas = 1;
        this.maxCount = 0;
         
    },
    
    /////////////////////////////////////
    // Definicion de atributos basicos del formuario 
    // (Los que siemre estaran presentes)
    /////////////////////////////////////
    
    
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_estado_wf'
            },
            type:'Field',
            form:true 
        },
    
        {
            config:{
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
                            fields: ['id_tipo_estado','codigo_estado','nombre_estado','alerta','disparador','inicio','pedir_obs','tipo_asignacion','depto_asignacion'],
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
                        anchor: '80%',
                        gwidth:220,
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo_estado}</p>Prioridad: <strong>{nombre_estado}</strong> </div></tpl>'
                    
                    },
            type:'ComboBox',
            form:true
        },
        {
            config:{
                        name: 'id_depto_wf',
                        hiddenName: 'id_depto_wf',
                        fieldLabel: 'Depto',
                        allowBlank: false,
                        emptyText:'Elija un depto',
                        listWidth:280,
                        store:new Ext.data.JsonStore(
                        {
                            url: '../../sis_workflow/control/TipoEstado/listarDeptoWf',
                            id: 'id_depto',
                            root:'datos',
                            sortInfo:{
                                field:'prioridad',
                                direction:'ASC'
                            },
                            totalProperty:'total',
                            fields: ['id_depto','nombre_depto','subsistema','codigo','nombre_corto_depto','prioridad'],
                            // turn on remote sorting
                            remoteSort: true,
                            baseParams:{par_filtro:'dep.nombre#dep.codigo#dep.nombre_corto'}
                        }),
                        valueField: 'id_depto',
                        displayField: 'nombre_corto_depto',
                        forceSelection:true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender:true,
                        mode:'remote',
                        pageSize:50,
                        queryDelay:500,
                        anchor: '80%',
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo}-{nombre_depto}</p><p>{subsistema}</p>Prioridad: <strong>{prioridad}</strong> </div></tpl>'
                    
             },
            type:'ComboBox',
            form:true
        },
        {
            config:{
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
                        anchor: '80%',
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{desc_funcionario}</p>Prioridad: <strong>{prioridad}</strong> </div></tpl>'
                    
             },
            type:'ComboBox',
            form:true
        },
        
        {
            config: {
                name: 'obs',
                fieldLabel: 'Proveido',
                allowBlank: false,
                anchor: '80%',
                maxLength:2000
            },
            type:'TextArea',
            form:true 
        },      
    ],
    
    title:'Estado del WF',
    
    onSubmit:function(){
       //passar los datos obtenidos del wizard y pasar  el evento save 
       if (this.form.getForm().isValid()) {
           this.fireEvent('beforesave',this,this.getValues());
       }
    },
    
    
    getValues:function(){
	        var resp = {
	                   id_proceso_wf_act: this.data.id_proceso_wf,
	                   id_estado_wf_act: this.data.id_estado_wf,
	                   id_tipo_estado: this.Cmp.id_tipo_estado.getValue(),
	                   id_funcionario_wf: this.Cmp.id_funcionario_wf.getValue(),
	                   id_depto_wf: this.Cmp.id_depto_wf.getValue(),
	                   obs: this.Cmp.obs.getValue(),
	                   procesos: []
	            }
	        
	        for (var obj = 0; obj < this.configExtra.length; obj++) { 
	             var nameatr = this.configExtra[obj].config.name;
	             resp[nameatr] = this.Cmp[nameatr].getValue();	
	        }
        
        
            
            for (var i=1;i<this.contadorTarjetas;i++){
                
                if(this.form.getForm().findField('iniar_pro['+i+']').getValue()){
                    
                    var t_id_depto = this.form.getForm().findField('id_depto_wf_pro['+i+']').getValue(),
                        t_id_func = this.form.getForm().findField('id_funcionario_wf_pro['+i+']').getValue();
                      
                      resp.procesos.push({
                        iniar_pro:this.form.getForm().findField('iniar_pro['+i+']').getValue(),
                        id_tipo_proceso_pro:this.form.getForm().findField('id_tipo_proceso_pro['+i+']').getValue(),
                        id_tipo_estado_pro:this.form.getForm().findField('id_tipo_estado_pro['+i+']').getValue(),
                        id_depto_wf_pro:(t_id_depto)?t_id_depto:undefined,
                        id_funcionario_wf_pro:(t_id_func)?t_id_func:undefined,
                        obs_pro:this.form.getForm().findField('obs_pro['+i+']').getValue()
                      });  
                 }
                
            }
            //validamos otras tarjetas segun el indice
            
         return resp;   
     }
})    
</script>
