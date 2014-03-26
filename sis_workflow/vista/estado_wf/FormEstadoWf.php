<?php
/**
*@package pXP
*@file    SubirArchivo.php
*@author  Freddy Rojas 
*@date    22-03-2012
*@description permites subir archivos a la tabla de documento_sol
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FormEstadoWf=Ext.extend(Phx.frmInterfaz,{
    ActSave:'../../sis_workflow/control/DocumentoWf/subirArchivoWf',
    
    
    //grupo de formulario
    
    layout:'fit',
    maxCount:1,
    utl_verificacion:'../../sis_workflow/control/ProcesoWf/verficarSigEstProcesoWf',
    constructor:function(config)
    {   
        //declaracion de eventos
        this.addEvents('beforesave');
        this.addEvents('successsave');
        
       // console.log('CONFIG',config)
        
         //llamada ajax para cargar los caminos posible de flujo
         Phx.CP.loadingShow();
         Ext.Ajax.request({
                url:this.utl_verificacion,
                params:{id_proceso_wf:config.data.id_proceso_wf,
                        operacion:'verificar'},
                argument:{'config':config},
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
              //inicia el proceso de dibjar la interface
              //console.log('xxx...',resp.argument.config, reg.ROOT.datos)
              this.iniciarInterfaz(resp.argument.config,reg.ROOT.datos);
        }
        else{
            alert('Error al idetificar siguientes pasos')
            
        }
    },
            
    addCardWizart:function(card){
        this.form.getComponent('card-wizard-panel').add(card)
        this.maxCount = this.maxCount +  1;
    },
    cardNav : function(incr){
            
                var l =   this.form.getComponent('card-wizard-panel').getLayout();
                var i = l.activeItem.id.split(this.idContenedor+'-card-')[1];
                var next = parseInt(i, 10) + incr;
                
                if( parseInt(i, 10) ==0){
                   if (this.form.getForm().isValid()) {
                        l.setActiveItem(next);
                        this.wizardLast.setDisabled(next==0);
                        this.wizardNext.setDisabled(next==this.maxCount); 
                   }
                }
                else{
                    l.setActiveItem(next);
                    this.wizardLast.setDisabled(next==0);
                    this.wizardNext.setDisabled(next==this.maxCount);  
                }
                
                
        },
    
    armarGrupos:function(config){
        
        //console.log('llega...',config,config.idContenedor)
        
                    
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
    
    iniciarInterfaz:function(config,datos){
        
        //TODO  contruir los grupos y formualrio con los datos obtenidos
        this.armarGrupos(config);
        
        Phx.vista.FormEstadoWf.superclass.constructor.call(this,config);
        
        //para agregar tarjeta al wizard
        this.addCardWizart({id: config.idContenedor+'-card-1',
                            html: '<h1>Congratulations!</h1><p>Step 3 of 3 - Complete</p>'
                       });
        this.init();    
        
        this.Cmp.id_tipo_estado.reset();
        this.Cmp.id_tipo_estado.store.baseParams.estados= datos.estados;
        this.Cmp.id_tipo_estado.modificado=true;    
        
        this.Cmp.id_tipo_estado.store.on('loadexception', this.conexionFailure,this);
        this.Cmp.id_funcionario_wf.store.on('loadexception', this.conexionFailure,this);
        
        console.log('config.data.id_estado_wf',config.data.id_estado_wf)
        //console.log(config.data,config,this)
        
        this.Cmp.id_funcionario_wf.disable();
        this.Cmp.id_depto_wf.disable();
        
        this.Cmp.id_tipo_estado.on('select',function(combo, record, index){
           
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
           //console.log('this.Cmp.id_tipo_estado',this.Cmp.id_tipo_estado.getValue())
             
           if(record.data.depto_asignacion != 'ninguno'){
               //console.log('this.Cmp.id_tipo_estado',this.Cmp.id_tipo_estado.getValue())
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
        },this);
        this.loadValoresIniciales();
    },
    
    loadValoresIniciales:function()
    {        
        Phx.vista.FormEstadoWf.superclass.loadValoresIniciales.call(this);
        //console.log(this.maestro)
        
        //Phx.CP.loadingShow();
        this.Cmp.id_funcionario_wf.store.baseParams.id_estado_wf=this.id_estado_wf;
        this.Cmp.id_funcionario_wf.store.baseParams.fecha=this.fecha_ini;
            
           
            
    },
    
   
    successSave:function(resp)
    {
        Phx.CP.loadingHide();
        Phx.CP.getPagina(this.idContenedorPadre).reload();
        this.panel.close();
    },
                
    
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
                        width:210,
                        gwidth:220,
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo_estado}</p>Prioridad: <strong>{nombre_estado}</strong> </div></tpl>'
                    
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
                        width:210,
                        gwidth:220,
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{desc_funcionario}</p>Prioridad: <strong>{prioridad}</strong> </div></tpl>'
                    
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
                        width:210,
                        gwidth:220,
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo}-{nombre_depto}</p><p>{subsistema}</p>Prioridad: <strong>{prioridad}</strong> </div></tpl>'
                    
             },
            type:'ComboBox',
            form:true
        },
        
        {
            config: {
                name: 'obs',
                fieldLabel: 'Obs',
                allowBlank: false,
                anchor: '80%',
                maxLength:500
            },
            type:'TextArea',
            form:true 
        },      
    ],
    title:'Estado del WF',
    
    
    onSubmit:function(){
       //TODO passar los datos obtenidos del wizard y pasar  el evento save 
        
        if (this.form.getForm().isValid()) {
            this.fireEvent('beforesave');
            
        }
        
    }
    
}
)    
</script>
