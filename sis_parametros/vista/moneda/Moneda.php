<?php
/**
*@package pXP
*@file Moneda.php
*@author  FRH
*@date 05-02-2013 15:52:20
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Moneda=Ext.extend(Phx.gridInterfaz,{
	
	Atributos:[
	{
   	  config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_moneda'

		},
		type:'Field',
		form:true 
		
	},
	{
	  config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'origen'

		},
		type:'Field',
		form:true 
		
	},
	{
		config:{
			fieldLabel: "Simbolo",
			gwidth: 130,
			name: 'simbolo',
			allowBlank:false,	
			maxLength:4,
			minLength:2,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true,
		egrid:true
	},
	 {
		config:{
			fieldLabel: "Nombre",
			gwidth: 130,
			name: 'nombre',
			allowBlank:false,	
			maxLength:20,
			minLength:4,
			anchor:'100%'
		},
		type:'TextField',
		filters:{pfiltro: 'moneda.nombre', type:'string'},
		id_grupo:0,
		grid:true,
		form:true,
		egrid:true
	},
	 {
		config:{
			fieldLabel: "Estado",
			gwidth: 130,
			name: 'estado_reg',
			allowBlank:false,	
			maxLength:15,
			
			anchor:'100%'
		},
		type:'TextField',
		filters:{pfiltro:'moneda.estado_reg', type:'string'},
		id_grupo:0,
		grid:true,
		form:false
	},{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'depto.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],

	title:'Moneda',
	ActSave:'../../sis_parametros/control/Moneda/guardarMoneda',
	ActDel:'../../sis_parametros/control/Moneda/eliminarMoneda',
	ActList:'../../sis_parametros/control/Moneda/listarMoneda',
	id_store:'id_moneda',
	fields: [
		{name:'id_moneda'},
		{name:'origen'},
		{name:'simbolo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'}
	
	],
	sortInfo:{
		field: 'id_moneda',
		direction: 'ASC'
	},
	bdel:true,// boton para eliminar
	bsave:true,// boton para eliminar


	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.Moneda.superclass.preparaMenu.call(this,tb)
	},

	/*
	 * Grupos:[{
	 * 
	 * xtype:'fieldset', border: false, //title: 'Checkbox Groups', autoHeight:
	 * true, layout: 'form', items:[], id_grupo:0 }],
	 */

	constructor: function(config){
		// configuracion del data store
		
		Phx.vista.Moneda.superclass.constructor.call(this,config);
		this.init();
		// this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip:
		// '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50}})
	}

}
)
</script>