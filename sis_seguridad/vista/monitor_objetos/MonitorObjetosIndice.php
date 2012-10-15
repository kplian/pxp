<?php
/**
*@package pXP
*@file MonitorObjetosIndice.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar los objetos indice de Base de Datos
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.monitor_objetos_indice=function(config){
	
	
	this.Atributos=[
	{
		//configuracion del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'indexrelid'

		},
		type:'Field',
		form:true 
		
	},	
	 {
		config:{
			fieldLabel: "Indice",
			gwidth: 100,
			name: 'indexrelname'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Index Scan",
			gwidth: 130,
			name: 'numero_index_scan'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Indices Obtenidos",
			gwidth: 130,
			name: 'numero_indices_devueltos'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Tuplas Obtenidas",
			gwidth: 130,
			name: 'numero_tuplas_vivas'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Bloq. Leidos de Disco",
			gwidth: 130,
			name: 'bloques_disco_leidos'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Bloq. Leidos de Buffer",
			gwidth: 130,
			name: 'bloques_buffer_leidos'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	}
	
	];

	Phx.vista.monitor_objetos_indice.superclass.constructor.call(this,config);
	this.init();
	
	
		
}
Ext.extend(Phx.vista.monitor_objetos_indice,Phx.gridInterfaz,{
	
	title:'Log',
	ActList:'../../sis_seguridad/control/Log/listarMonitorIndice',
	id_store:'indexrelid',
	fields: [
	{name:'indexrelid'},
	{name:'indexrelname', type: 'string'},
	{name:'numero_index_scan'},
	{name:'numero_indices_devueltos'},
	{name:'numero_tuplas_vivas'},
	{name:'bloques_disco_leidos'},
	{name:'bloques_buffer_leidos'}
	
		
	],
	sortInfo:{
		field: 'indexrelname',
		direction: 'ASC'
	},
	bdel:false,//boton para eliminar
	bsave:false,//boton para eliminar
	bnew:false,//boton para eliminar
	bedit:false,//boton para eliminar

	

	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
		Phx.vista.monitor_objetos_indice.superclass.preparaMenu.call(this,tb);
		  
	},
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_tabla:this.maestro.oid};
		this.load({params:{start:0, limit:50}})
	}
	
}
)
</script>