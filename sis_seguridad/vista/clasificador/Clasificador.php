<?php
/**
*@package pXP
*@file Clasificador.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar formulario del clasificador
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.clasificador=Ext.extend(Phx.gridInterfaz,{
Atributos:[
	{
		//configuración del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_clasificador'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Codigo",
			gwidth: 130,
			name: 'codigo',
			allowBlank:false,	
			maxLength:20,
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
			gwidth: 130,
			name: 'descripcion',
			allowBlank:false,	
			//maxLength:150,
			minLength:5,
			anchor:'100%'
		},
		type:'TextArea',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	{config:{
			fieldLabel: "Prioridad",
			gwidth: 100,
			width:'100%',
			maxLength:15,
			minLength:1,
			allowBlank:false,
			selectOnFocus:true,
			allowDecimals:false,
			allowNegative:false,
			minValue:1,
			name: 'prioridad'
		},
		type:'NumberField',
		id_grupo:0,
		filters:{type: 'numeric'},
		grid:true,
		form:true
	}
	],



	title:'Clasificador',
	ActSave:'../../sis_seguridad/control/Clasificador/guardarClasificador',
	ActDel:'../../sis_seguridad/control/Clasificador/eliminarClasificador',
	ActList:'../../sis_seguridad/control/Clasificador/listarClasificador',
	id_store:'id_clasificador',
	fields: [
	{name:'id_clasificador'},
	{name:'codigo', type: 'string'},
	{name:'descripcion', type: 'string'},
	{name:'prioridad'}
		],
	sortInfo:{
		field: 'prioridad',
		direction: 'ASC'
	},
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar


	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
		Phx.vista.clasificador.superclass.preparaMenu.call(this,tb)
	},

	
	constructor: function(config){
		//configuración del data store
		Phx.vista.clasificador.superclass.constructor.call(this,config);
		this.init();
		//this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip: '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50}})

	}


}
)
</script>