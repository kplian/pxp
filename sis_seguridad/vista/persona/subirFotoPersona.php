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
Phx.vista.subirFotoPersona=Ext.extend(Phx.frmInterfaz,{

	constructor:function(config)
	{
		
		
    	//llama al constructor de la clase padre
		Phx.vista.subirFotoPersona.superclass.constructor.call(this,config);
		this.init();	
		this.loadValoresIniciales()

	},
	
	loadValoresIniciales:function()
	{
		
		Phx.vista.subirFotoPersona.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_persona').setValue(this.id_persona);		
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
			name: 'id_persona'

		   },
		  type:'Field',
		  form:true 
		
	    },
		{
			//configuracion del componente
			config:{
					fieldLabel: "Archivo",
					gwidth: 130,
					//labelSeparator:'',
					inputType:'file',
					name: 'foto',
					buttonText: '',	
					maxLength:150,
					anchor:'100%'					
			},
			type:'Field',
		  form:true 
		},		
	],
	title:'Subir archivo',
	ActSave:'../../sis_seguridad/control/Persona/subirFotoPersona',
	fileUpload:true,	
	}
)
	
</script>