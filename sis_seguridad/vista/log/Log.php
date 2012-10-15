<?php
/**
*@package pXP
*@file Log.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar listado de vitacoras
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.log=Ext.extend(Phx.gridInterfaz,{
	Atributos:[
	{
		//configuracion del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_log'

		},
		type:'Field',
		form:true 
		
	},
	{
		//configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_usuario'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Usuario",
			gwidth: 100,
			name: 'cuenta'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Fecha/Hora",
			gwidth: 130,
			renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
   		    name: 'logg.fecha_reg'
			
		},
		type:'DateField',
		filters:{pfiltro:'logg.fecha_reg',
				type:'date'
				},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Tipo",
			gwidth: 110,
			name: 'tipo_log'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "IP",
			gwidth: 100,
			name: 'ip_maquina'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Transaccion",
			gwidth: 110,
			name: 'transaccion'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Descripción",
			gwidth: 120,
			name: 'descripcion'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Consulta",
			gwidth: 250,
			name: 'consulta'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Procedimientos Almacenados",
			gwidth: 150,
			name: 'procedimientos'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	}
	],



	title:'Log',
	ActList:'../../sis_seguridad/control/Log/listarLog',
	id_store:'id_log',
	fields: [
	{name:'id_log'},
	{name:'id_usuario'},
	{name:'cuenta', type: 'string'},
	{name:'mac_maquina', type: 'string'},
	{name:'ip_maquina', type: 'string'},
	{name:'tipo_log', type: 'string'},
	{name:'logg.fecha_reg', mapping: 'fecha_reg',type:'date',dateFormat: 'Y-m-d H:i:s'},
	{name:'procedimientos', type: 'string'},
	{name:'transaccion', type: 'string'},
	{name:'descripcion', type: 'string'},
	{name:'consulta', type: 'string'}
		],
	sortInfo:{
		field: 'logg.fecha_reg',
		direction: 'DESC'
	},
	bdel:false,//boton para eliminar
	bsave:false,//boton para eliminar
	bnew:false,//boton para eliminar
	bedit:false,//boton para eliminar

	

	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
		Phx.vista.log.superclass.preparaMenu.call(this,tb)
	},

	
	constructor: function(config){
		//configuraci�n del data store

		Phx.vista.log.superclass.constructor.call(this,config);


		this.init();
		//this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip: '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50}})






	}


}
)
</script>