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
Phx.vista.subirLogo=Ext.extend(Phx.frmInterfaz,{

	constructor:function(config)
	{  //llama al constructor de la clase padre
		Phx.vista.subirLogo.superclass.constructor.call(this,config);
		this.init();	
		this.loadValoresIniciales()	
		
	},
	

	
	loadValoresIniciales:function()
	{
		
		Phx.vista.subirLogo.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_empresa').setValue(this.id_empresa);
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
			name: 'id_empresa'

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
					name: 'file_logo',
					maxLength:150,
					anchor:'100%',
					validateValue:function(archivo){
						var extension = (archivo.substring(archivo.lastIndexOf("."))).toLowerCase(); 
						
						extension = extension.toLowerCase();
						
						 if(extension!='.jpg' &&extension!='.png' && extension!='.gif' & extension!='.jpeg'){
								this.markInvalid('solo se admiten imagenes png, jpg, gif');
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
	ActSave:'../../sis_parametros/control/Empresa/subirLogo',
	fileUpload:true,	
	}
)
	
</script>