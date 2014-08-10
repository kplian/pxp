<?php
/**
*@package pXP
*@file Procedimiento.php
*@author KPLIAN (JRR)
*@date 14-02-2011
*@description  Vista para registrar  procediemintos
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.procedimiento=Ext.extend(Phx.gridInterfaz,{



	Atributos:[
	{
		//configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_procedimiento'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Nombre",
			gwidth: 130,
			name: 'codigo',
			allowBlank:false,	
			maxLength:150,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Descripcion",
			gwidth: 230,
			name: 'descripcion',
			allowBlank:false,	
			maxLength:150,
			minLength:5,
			anchor:'100%'
		},
		type:'TextArea',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},{
		//configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_funcion'

		},
		type:'TextField',
		form:true 
		//defecto:maestro.id_subsistema
		
	}
	],



	title:'procedimiento',
	ActSave:'../../sis_seguridad/control/Procedimiento/Guardarprocedimiento',
	ActDel:'../../sis_seguridad/control/Procedimiento/Eliminarprocedimiento',
	ActList:'../../sis_seguridad/control/Procedimiento/ListarprocedimientoCmb',
	id_store:'id_procedimiento',
	fields: [
	{name:'id_procedimiento'},
	{name:'codigo', type: 'string'},
	{name:'descripcion', type: 'string'}
	
	],
	sortInfo:{
		field: 'codigo',
		direction: 'ASC'
	},
	onButtonNew:function(){

		Phx.vista.procedimiento.superclass.onButtonNew.call(this);
		this.getComponente('id_funcion').setValue(this.id_funcion);
		
	},
	/*onReloadPage:function(m){
        this.maestro=m;
        //this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);
        this.store.baseParams={};
		this.load({params:{start:0, limit:50}})
    },*/
	constructor: function(config){
		//configuraci�n del data store
		
		//console.log(config)
		
		//this.maestro=config


		Phx.vista.procedimiento.superclass.constructor.call(this,config);


		this.init();
		//this.grid.getTopToolbar().disable();
		//this.grid.getBottomToolbar().disable();
		//this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip: '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50, id_funcion: this.id_funcion}})

	},
	
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar


	//sobre carga de procedimiento
	preparaMenu:function(tb){
		//llamada procedimiento clace padre
		Phx.vista.procedimiento.superclass.preparaMenu.call(this,tb)
	}


  }
)
</script>