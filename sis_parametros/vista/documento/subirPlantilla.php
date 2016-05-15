<?php
/**
*@package pXP
*@file gen-Sensor.php
*@author  (rarteaga)
*@date 06-09-2011 11:45:42
*@description permites subir archivos  de imegenes a la tabla de personas
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.subirPlantilla=Ext.extend(Phx.frmInterfaz,{

	constructor:function(config)
	{
		
		
    	//llama al constructor de la clase padre
		Phx.vista.subirPlantilla.superclass.constructor.call(this,config);
		this.init();	
		this.loadValoresIniciales()	
		
	},
	

	
	loadValoresIniciales:function()
	{
		
		Phx.vista.subirPlantilla.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_documento').setValue(this.id_documento);
		
		
				
	},
	
	
	successSave:function(resp){
        Phx.CP.loadingHide();
        Phx.CP.getPagina(this.idContenedorPadre).reload();
        this.panel.close();
    },
				
	
	Atributos:[
	    {
   	      config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_documento'

		   },
		  type:'Field',
		  form:true 
		
	    },
		{
			//configuracion del componente
		   config:{
					fieldLabel: "Archivo",
					gwidth: 130,
					labelSeparator:'',
					inputType:'file',
					name: 'file_documento',
					maxLength:150,
					anchor:'100%',
					validateValue:function(archivo){
						var extension = (archivo.substring(archivo.lastIndexOf("."))).toLowerCase(); 
						if(extension!='.docx' && extension!='.DOCX'){
								this.markInvalid('solo se admiten archivos WORD');
								return false
						}
						else{
							this.clearInvalid();
						    return true
						}
					}	
			},
			type:'Field',
		    form:true 
		}		
	],
	title:'Subir archivo',
	ActSave:'../../sis_parametros/control/Documento/subirPlantilla',
	fileUpload:true,	
	}
)
	
</script>