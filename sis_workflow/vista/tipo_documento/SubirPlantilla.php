<?php
/**
*@package pXP
*@file    SubirArchivo.php
*@author  RCM
*@date    04/04/2015
*@description permites subir las plantillas
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.SubirPlantilla=Ext.extend(Phx.frmInterfaz,{
    ActSave:'../../sis_workflow/control/TipoDocumento/subirPlantilla',
    maestro: {},

    constructor: function(config){   
    	this.maestro=config;
        Phx.vista.SubirPlantilla.superclass.constructor.call(this,config);
        this.init();    
        this.loadValoresIniciales();
    },
    
    loadValoresIniciales: function(){        
        Phx.vista.SubirPlantilla.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_tipo_documento').setValue(this.id_tipo_documento); 
        this.Cmp.nombre_vista.setValue(this.maestro.nombre_vista);
        this.Cmp.esquema_vista.setValue(this.maestro.esquema_vista);
    },
    
    successSave: function(resp){
        Phx.CP.loadingHide();
        this.panel.close();
    },
                
    
    Atributos:[
        {
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
                fieldLabel: "Documento (Word)",
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
        {
            config:{
                fieldLabel: "Vista BD",
                gwidth: 130,
                name: 'nombre_vista',
                allowBlank: false,
                maxLength: 70,
                anchor:'100%'                   
            },
            type:'Field',
            form:true 
        },
        {
            config:{
                fieldLabel: "Esquema Vista BD",
                gwidth: 130,
                name: 'esquema_vista',
                allowBlank: false,
                maxLength: 10,
                anchor:'100%'                   
            },
            type:'Field',
            form:true 
        }
    ],
    title:'Subir Archivo',    
    fileUpload:true,
    
    agregarArgsExtraSubmit: function(){
	   delete this.argumentExtraSubmit.id_tipo_documento;
	   delete this.argumentExtraSubmit.id_tipo_proceso;
	   this.argumentExtraSubmit.id_tipo_documento = this.maestro.id_tipo_documento;
	   this.argumentExtraSubmit.id_tipo_proceso = this.maestro.id_tipo_proceso;
    }
    
}
)    
</script>
