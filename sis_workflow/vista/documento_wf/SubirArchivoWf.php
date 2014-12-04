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
Phx.vista.SubirArchivoWf=Ext.extend(Phx.frmInterfaz,{
    ActSave:'../../sis_workflow/control/DocumentoWf/subirArchivoWf',

    constructor:function(config)
    {   
        Phx.vista.SubirArchivoWf.superclass.constructor.call(this,config);
        this.init();    
        this.loadValoresIniciales();
    },
    
    loadValoresIniciales:function()
    {        
        Phx.vista.SubirArchivoWf.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_documento_wf').setValue(this.id_documento_wf); 
        this.getComponente('num_tramite').setValue(this.num_tramite);     
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
                name: 'id_documento_wf'
            },
            type:'Field',
            form:true
        },
        {
            config:{
                labelSeparator:'',
                inputType:'hidden',
                name: 'num_tramite'
            },
            type:'Field',
            form:true
        },
        {
            config:{
                fieldLabel: "Documento (archivo Pdf,Word)",
                gwidth: 130,
                inputType: 'file',
                name: 'archivo',
                allowBlank: false,
                buttonText: '', 
                maxLength: 150,
                anchor:'100%'                   
            },
            type:'Field',
            form:true 
        },      
    ],
    title:'Subir Archivo',    
    fileUpload:true
    
}
)    
</script>
