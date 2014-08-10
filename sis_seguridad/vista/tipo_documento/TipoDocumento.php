<?php
/**
*@package pXP
*@file TipoDocumento.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para deplegar los tipos documento
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.tipo_documento=Ext.extend(Phx.gridInterfaz,{
	Atributos:[
	{
		//configuración del componente
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
			fieldLabel: "Nombre",
			gwidth: 130,
			name: 'nombre',
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
			fieldLabel: "Fecha de Registro",
			gwidth: 130,
			name: 'fecha_reg',
			allowBlank:false,	
			maxLength:150,
			minLength:5,
			anchor:'100%'
		},
		type:'DateField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	{
		config:{
			fieldLabel: "Estado de Registro",
			gwidth: 120,
			name: 'estado_reg',
			allowBlank:true,	
			maxLength:20,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	}
	],


	title:'Tipo de Documento',
	ActSave:'../../sis_seguridad/control/TipoDocumento/guardarTipoDocumento',
	ActDel:'../../sis_seguridad/control/TipoDocumento/eliminarTipoDocumento',
	ActList:'../../sis_seguridad/control/TipoDocumento/listarTipoDocumento',
	id_store:'id_tipo_documento',
	fields: [
	{name:'id_persona'},
	{name:'nombre', type: 'string'},
	{name:'fecha_reg', type: 'date'},
	{name:'estado_reg', type: 'segu.activo_inactivo'},
	
		],
	sortInfo:{
		field: 'nombre',
		direction: 'ASC'
	},
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar


	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
		Phx.vista.tipo_documento.superclass.preparaMenu.call(this,tb)
	},

	/*Grupos:[{

	xtype:'fieldset',
	border: false,
	//title: 'Checkbox Groups',
	autoHeight: true,
	layout: 'form',
	items:[],
	id_grupo:0
	}],*/


	constructor: function(config){
		//configuraci�n del data store



		Phx.vista.tipo_documento.superclass.constructor.call(this,config);
		this.init();
		//this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip: '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50}})

	}

}
)
</script>