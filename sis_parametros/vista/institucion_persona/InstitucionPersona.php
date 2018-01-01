<?php
/**
 *@package pXP
 *@file gen-InstitucionPersona.php
 *@author  fprudencio
 *@date 03-12-2017 16:13:21
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.InstitucionPersona=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.InstitucionPersona.superclass.constructor.call(this,config);

		this.init();
		//this.bloquearMenus();
		if(Phx.CP.getPagina(this.idContenedorPadre)){
      	 var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
	 	 if(dataMaestro){ 
	 	 	
	 	 	this.onEnablePanel(this,dataMaestro)
	 	 }
	  }
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_institucion_persona'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_institucion'
			},
			type:'Field',
			form:true 
		},
   	    
   	{
   			config:{
       		    name:'id_persona',
   				origen:'PERSONA',
      			tinit:true,
   				fieldLabel:'Persona',
   				gdisplayField:'desc_persona',//mapea al store del grid
   			    gwidth:200,
	   			 renderer:function (value, p, record){return String.format('{0}', record.data['desc_persona']);}
       	     },
   			type:'ComboRec',
   			filters:{	
		        pfiltro:'per.nombre_completo2',
				type:'string'
			},
   			grid:true,
   			form:true
   	      },
      	{
			config:{
				name: 'cargo_institucion',
				fieldLabel: 'Cargo',
				allowBlank: true,
				width: 300
			},
			type:'TextField',
			filters:{pfiltro:'instiper.cargo',type:'string'},
			grid:true,
			form:true
		},
   		{
			config : {
				name : 'estado_reg',
				fieldLabel : 'Estado Reg.',
				allowBlank : false,

				gwidth : 100,
				maxLength : 10
			},
			type : 'TextField',
			filters : {
				pfiltro : 'instiper.estado_reg',
				type : 'string'
			},
			grid : true,
			form : false
		}
	],
	title:'InstitucionPersona',
	ActSave:'../../sis_parametros/control/InstitucionPersona/insertarInstitucionPersona',
	ActDel:'../../sis_parametros/control/InstitucionPersona/eliminarInstitucionPersona',
	ActList:'../../sis_parametros/control/InstitucionPersona/listarInstitucionPersona',
	id_store:'id_institucion_persona',
	fields: [
		{name:'id_institucion_persona', type: 'numeric'},
		{name:'id_institucion', type: 'numeric'},
		{name:'nombre_institucion', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_persona', type: 'numeric'},
		{name:'desc_persona', type: 'string'},
		{name:'cargo_institucion', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_institucion_persona',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
    
	iniciarEventos:function(){ 
	


	},
	
	
	onReloadPage:function(m){

       
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_institucion;
		this.store.baseParams={id_institucion:this.maestro.id_institucion};
		this.load({params:{start:0, limit:50}})
			
	},
	preparaMenu:function(n){
      	
      	Phx.vista.CorrespondenciaDetalle.superclass.preparaMenu.call(this,n);
      	
		  var data = this.getSelectedData();
		  var tb =this.tbar;
		     
		  
		  //cuando el conrtato esta registrado el abogado no puede hacerle mas cambios
		  
		  		
		  			
			  		this.getBoton('edit').enable();
			  		this.getBoton('del').enable();
			  	
		   
		  return tb
		
	}, 

}
)
</script>

