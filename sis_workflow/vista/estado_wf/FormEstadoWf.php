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
    
    constructor:function(config)
    {   
        Phx.vista.FormEstadoWf.superclass.constructor.call(this,config);
        //declaracion de eventos
        this.addEvents('beforesave');
        this.addEvents('successsave');
        
        this.init();    
        
        
        
        this.Cmp.id_tipo_estado.store.on('loadexception', this.conexionFailure,this);
        this.Cmp.id_funcionario_wf.store.on('loadexception', this.conexionFailure,this);
      
        this.cmbTipoEstado.on('select',function(){
            
            this.Cmp.id_funcionario_wf.enable();
            this.Cmp.id_funcionario_wf.store.baseParams.id_tipo_estado = this.cmbTipoEstado.getValue();
            this.Cmp.id_funcionario_wf.modificado=true;
        },this);
        
        
        this.loadValoresIniciales();
        
    },
    
    loadValoresIniciales:function()
    {        
        Phx.vista.FormEstadoWf.superclass.loadValoresIniciales.call(this);
        console.log(this.maestro)
        
        Phx.CP.loadingShow();
        
        
        this.Cmp.id_funcionario_wf.store.baseParams.id_estado_wf=this.maestro.id_estado_wf;
        this.Cmp.id_funcionario_wf.store.baseParams.fecha=this.maestro.fecha_ini;
            
           /*, Ext.Ajax.request({
                // form:this.form.getForm().getEl(),
                url:'../../sis_workflow/control/ProcesoWf/siguienteEstadoProcesoWf',
                params:{id_proceso_wf:this.maestro.id_proceso_wf,operacion:'verificar'},
                success:this.successSinc,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });*/
            
    },
    
   /* successSinc:function(resp){
            
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
           
            
        },*/
    
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
        if (this.form.getForm().isValid()) {
            this.fireEvent('beforesave');
            
        }
        
    }
    
}
)    
</script>
