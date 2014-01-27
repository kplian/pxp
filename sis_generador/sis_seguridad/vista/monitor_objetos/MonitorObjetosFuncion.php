<?php
/**
*@package pXP
*@file MonitorObjetosFuncion.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar los objetos función de Base de Datos
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.monitor_objetos_funcion=function(config){
	
	
	this.Atributos=[
	{
		//configuracion del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'oid'

		},
		type:'Field',
		form:true 
		
	},	
	 {
		config:{
			fieldLabel: "Función",
			gwidth: 100,
			name: 'proname'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	
	{
		config:{
			fieldLabel: "Dueño",
			gwidth: 80,
			name: 'usename'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
		
	{
		config:{
			fieldLabel: "Setuid",
			gwidth: 50,
			name: 'setuid'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	}
	];

	Phx.vista.monitor_objetos_funcion.superclass.constructor.call(this,config);
	this.init();
	
	
		
}
Ext.extend(Phx.vista.monitor_objetos_funcion,Phx.gridInterfaz,{
	
	title:'Log',
	ActList:'../../sis_seguridad/control/Log/listarMonitorFuncion',
	id_store:'oid',
	fields: [
	{name:'oid'},
	{name:'proname', type: 'string'},
	{name:'usename', type: 'string'},
	{name:'setuid', type: 'string'}
	],
	sortInfo:{
		field: 'proname',
		direction: 'ASC'
	},
	bdel:false,//boton para eliminar
	bsave:false,//boton para eliminar
	bnew:false,//boton para eliminar
	bedit:false,//boton para eliminar

	

	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
		Phx.vista.monitor_objetos_funcion.superclass.preparaMenu.call(this,tb);
		  
	},
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_esquema:this.maestro.nspoid};
		this.load({params:{start:0, limit:50}})
	}
	
}
)
</script>