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
        Phx.vista.PlantillaMensaje.superclass.constructor.call(this,config);
        this.init();    
        this.loadValoresIniciales();
    },
    
    
   
    
    loadValoresIniciales:function() 
    {    /*    
        console.log(this)
        var CuerpoCorreo = " Solicitud de presupuesto <br>" ;
        CuerpoCorreo+= '<b>Funcionario: '+ this.desc_funcionario+'<br></b>';
        CuerpoCorreo+='Tramite: '+ this.num_tramite+'<br>';
        CuerpoCorreo+='Numero: '+this.numero+'</BR>';
        CuerpoCorreo+='<br>Solicitado por: <br> '+Phx.CP.config_ini.nombre_usuario+'<br>';
        CuerpoCorreo+='Se adjunta el solicitud de compra para referencia de los montos </BR>';
         
        Phx.vista.PlantillaMensaje.superclass.loadValoresIniciales.call(this);
        
        this.getComponente('asunto').setValue('ADQ: Solicitud de Presupuesto: '+this.numero); 
        this.getComponente('body').setValue(CuerpoCorreo); 
        
         this.getComponente('id_solicitud').setValue(this.id_solicitud); 
        this.getComponente('estado').setValue(this.estado); */
        
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
                name: 'id_tipo_proceso'
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
                maxLength: 100
            },
            type:'TextField',
            id_grupo:1,
            form:true
        },
        {
            config:{
                name: 'plantilla_mensaje',
                fieldLabel: 'Mensaje',
                anchor: '90%'
            },
            type:'HtmlEditor',
             id_grupo:1,
            form:true
        },
    ],
    title:'Solicitud de Compra'
  
})    
</script>