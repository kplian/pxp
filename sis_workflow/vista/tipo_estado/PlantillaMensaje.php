<?php
/**
*@package pXP
*@file    SolModPresupuesto.php
*@author  Rensi Arteaga Copari 
*@date    30-01-2014
*@description permites subir archivos a la tabla de documento_sol
*/
header("content-type: text/javascript; charset=UTF-8");
?>

<script>
Phx.vista.PlantillaMensaje=Ext.extend(Phx.frmInterfaz,{
    ActSave:'../../sis_workflow/control/TipoEstado/modificarPlantillaCorreo',
    constructor:function(config)
    {   
        this.Grupos= [
                   {
                    layout:'column',
                    width:'100%',
                    autoScroll:true,
                    items: [
                           {id: config.idContenedor+'-card-0',
                            width:'78%',
                            xtype: 'fieldset',
                            title: 'Datos principales',
                            autoHeight: true,
                            border:false,
                            items: [],
                            id_grupo:0
                           },
                           {
                               xtype:'panel',
                               width:'20%',
                               html:'<b><h2>Variables WF</h2></b> <br> PROCESO_MACRO<br>TIPO_PROCESO<br>NUM_TRAMITE<br>USUARIO_PREVIO<br>ESTADO_ANTERIOR<br>OBS<br>ESTADO_ACTUAL<br>CODIGO<br>FUNCIONARIO_PREVIO<br>DEPTO_PREVIO<br><br>** Verificar que las variables que referencian a la tabla existan  EJM {$tabla.desc_proveedor}'
                               
                           }]
                }
            
            ];
        
        
        Phx.vista.PlantillaMensaje.superclass.constructor.call(this,config);
        this.init();    
        this.loadValoresIniciales();
    },
    
     loadValoresIniciales:function() 
    {       
        console.log(this.data);
        
        this.Cmp.id_tipo_estado.setValue(this.data.id_tipo_estado); 
        
        //si la plantil ano tiene valores carga los valores por defecto
        if(this.data.plantilla_mensaje && this.data.plantilla_mensaje != ''){
            
            this.Cmp.plantilla_mensaje_asunto.setValue(this.data.plantilla_mensaje_asunto);
            this.Cmp.plantilla_mensaje.setValue(this.data.plantilla_mensaje);
            
        }
        else{
            
            var CuerpoCorreo = '<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS}<br>';
            this.Cmp.plantilla_mensaje_asunto.setValue('Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"')
            this.Cmp.plantilla_mensaje.setValue(CuerpoCorreo);
            
        }
        
     },
    
    successSave:function(resp)
    {
        Phx.CP.loadingHide();
        Phx.CP.getPagina(this.idContenedorPadre).reload();
        this.panel.close();
    },
                
    
    Atributos:[
       {
            config:{
                labelSeparator:'',
                inputType:'hidden',
                name: 'id_tipo_estado'
            },
            type:'Field',
            form:true
        },
        {
            config:{
                name: 'plantilla_mensaje_asunto',
                fieldLabel: 'Asunto',
                allowBlank: true,
                anchor: '90%',
                gwidth: 100,
                maxLength: 255
            },
            type:'TextField',
            id_grupo:1,
            form:true
        },
        {
            config:{
                name: 'plantilla_mensaje',
                fieldLabel: 'Mensaje',
                anchor: '100%'
            },
            type:'HtmlEditor',
             id_grupo:1,
            form:true
        },
    ],
    title:'Solicitud de Compra'
  
})    
</script>