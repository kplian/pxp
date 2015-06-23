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
Phx.vista.AntFormEstadoWf=Ext.extend(Phx.frmInterfaz,{
    ActSave:'../../sis_workflow/control/DocumentoWf/subirArchivoWf',
    layout: 'fit',
    maxCount: 0,
    constructor:function(config){   
        Phx.vista.AntFormEstadoWf.superclass.constructor.call(this,config);
        this.init(); 
        this.loadValoresIniciales();
        
        console.log('xxxxxxxxxxxxxxxxxx',this.obsValorInicial, config)
        //carga vaor inicial de las observaciones si existe
        this.Cmp.obs.setValue(this.obsValorInicial)  
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
           this.fireEvent('beforesave', this, this.getValues());
       }
    },
    getValues:function(){
    	console.log('this.estado_destino',this.estado_destino)
    	 var resp = {
                   id_proceso_wf: this.data.id_proceso_wf,
                   id_estado_wf: this.data.id_estado_wf,
                   obs:this.Cmp.obs.getValue(),
                   estado_destino:  this.estado_destino,
                   data:	this.data
            }
            
         return resp;   
     }
    
    
})    
</script>
