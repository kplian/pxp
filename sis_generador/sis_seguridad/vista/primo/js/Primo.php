<?php
/**
*@package pXP
*@file Primo.php
*@author KPLIAN (FRH)
*@date 14-02-2011
*@description  Vista para mostrar listado de numeros primos
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

_primo=Ext.extend(Ext.gridInterfaz,{
	
	
	constructor: function(config){
	//configuraci�n del data store
	
	
	
	_primo.superclass.constructor.call(this,config);
	this.init();
	this.addButton('my-boton',{disabled:false,tooltip: '<b>My Boton</b><br/>Icon only button with tooltip'});
	this.load({params:{start:0, limit:50}})
	

	

},
Atributos:[
	{
		//configuraci�n del componente
		config:{
			fieldLabel: "id_primo",
			anchor:'100%',
			gwidth: 100,
			name: 'id_primo',
			allowBlank:false

		},
		type:'NumberField', // tipo de componente (nombre del contructor)
		filters:{type: 'numeric'},
		id_grupo:0,
		grid:true, // aparece en el formulario
		form:true  // aparece en el grid

	}, {

		config:{
			fieldLabel: 'primo',
			name: 'primo',
			anchor:'100%',
			allowBlank:false

			//gwidth: 200
		},
		type:'NumberField',
		filters:{type: 'numeric'},
		id_grupo:0,
		grid:true,
		form:true
	}],

	

	title:'Primos',
	ActSave:'../../control/primo/ActionGuardarPrimo.php',
	ActDel:'../../control/primo/ActionEliminarPrimo.php',
	ActList:'../../control/primo/ActionListarPrimo.php',
	id_store:'id_primo',
	fields: [
	{name:'id_primo'},
	{name:'primo', type: 'string'},
	
	],
	sortInfo:{
		field: 'numero',
		direction: 'ASC'
	},
	bdel:true,//boton para eliminar
	
		
	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
	  _primo.superclass.preparaMenu.call(this,tb)
	}

}
)