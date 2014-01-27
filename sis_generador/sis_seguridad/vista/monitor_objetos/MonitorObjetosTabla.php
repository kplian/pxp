<?php
/**
*@package pXP
*@file MonitorObjetosTabla.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar los objetos tabla de Base de Datos
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.monitor_objetos_tabla=function(config){
	
	
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
			fieldLabel: "Tabla",
			gwidth: 100,
			name: 'tablename'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	
	{
		config:{
			fieldLabel: "Dueño",
			gwidth: 100,
			name: 'usename'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
		
	{
		config:{
			fieldLabel: "# Indices",
			gwidth: 130,
			name: 'cantidad_indices'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Triggers",
			gwidth: 130,
			name: 'cantidad_triggers'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	
	{
		config:{
			fieldLabel: "Ultimo Vacuum ",
			gwidth: 130,
			name: 'last_vacuum'
			
		},
		type:'Textfield',
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Ultimo AutoVacuum ",
			gwidth: 130,
			name: 'last_autovacuum'
			
		},
		type:'TextField',
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Ultimo Analyze",
			gwidth: 130,
			name: 'last_analyze'
			
		},
		type:'TextField',
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Ultimo AutoAnalyze",
			gwidth: 130,
			name: 'last_autoanalyze'
			
		},
		type:'TextField',
		grid:true,
		form:false
	},
	
	
	{
		config:{
			fieldLabel: "KB Tabla",
			gwidth: 130,
			name: 'kb_tabla'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "KB Indices",
			gwidth: 130,
			name: 'kb_indices'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Seq. Scan",
			gwidth: 130,
			name: 'scaneos_secuenciales'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Tuplas Seq.",
			gwidth: 130,
			name: 'tuplas_seq_leidas'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Ind. Scan",
			gwidth: 130,
			name: 'indices_scaneados'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Tuplas Ind.",
			gwidth: 130,
			name: 'tuplas_idx_leidas'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Tuplas Ins.",
			gwidth: 130,
			name: 'tuplas_insertadas'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Tuplas Mod.",
			gwidth: 130,
			name: 'tuplas_actualizadas'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Tuplas Mod. HOT",
			gwidth: 130,
			name: 'tuplas_actualizadas_hot'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	
	{
		config:{
			fieldLabel: "# Tuplas Eli.",
			gwidth: 130,
			name: 'tuplas_borradas'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Tuplas Vivas",
			gwidth: 130,
			name: 'tuplas_vivas'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# Tuplas Muertas",
			gwidth: 130,
			name: 'tuplas_muertas'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Bloq. Tabla Leidos de Disco",
			gwidth: 130,
			name: 'bloques_leidos_disco_tabla'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Bloq. Tabla Leidos de Buffer",
			gwidth: 130,
			name: 'bloques_leidos_buffer_tabla'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Bloq. Índice Leidos de Disco",
			gwidth: 130,
			name: 'bloques_leidos_disco_indice'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Bloq. Índice Leidos de Buffer",
			gwidth: 130,
			name: 'bloques_leidos_buffer_indice'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Bloq. Toast Leidos de Disco",
			gwidth: 130,
			name: 'bloques_leidos_disco_toast'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Bloq. Toast Leidos de Buffer",
			gwidth: 130,
			name: 'bloques_leidos_buffer_toast'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Bloq. Indice-Toast Leidos de Disco",
			gwidth: 130,
			name: 'bloques_leidos_disco_toast_indice'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Bloq. Indice-Toast Leidos de Buffer",
			gwidth: 130,
			name: 'bloques_leidos_buffer_toast_indice'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	}
	];

	Phx.vista.monitor_objetos_tabla.superclass.constructor.call(this,config);
	this.init();
	
	
		
}
Ext.extend(Phx.vista.monitor_objetos_tabla,Phx.gridInterfaz,{
	
	title:'Log',
	ActList:'../../sis_seguridad/control/Log/listarMonitorTabla',
	id_store:'oid',
	fields: [
	{name:'oid'},
	{name:'tablename', type: 'string'},
	{name:'usename', type: 'string'},
	{name:'last_vacuum', type: 'string'},
	{name:'last_autovacuum', type: 'string'},
	{name:'last_analyze', type: 'string'},
	{name:'last_autoanalyze', type: 'string'},
	{name:'cantidad_indices'},
	{name:'cantidad_triggers'},
	{name:'scaneos_secuenciales'},
	{name:'tuplas_seq_leidas'},
	{name:'indices_scaneados'},
	{name:'tuplas_idx_leidas'},
	{name:'tuplas_insertadas'},
	{name:'tuplas_actualizadas'},
	{name:'tuplas_borradas'},
	{name:'tuplas_actualizadas_hot'},
	{name:'tuplas_vivas'},
	{name:'tuplas_muertas'},
	{name:'bloques_leidos_disco_tabla'},
	{name:'bloques_leidos_buffer_tabla'},
	{name:'bloques_leidos_disco_indice'},
	{name:'bloques_leidos_buffer_indice'},
	{name:'bloques_leidos_disco_toast'},
	{name:'bloques_leidos_buffer_toast'},
	{name:'bloques_leidos_disco_toast_indice'},
	{name:'bloques_leidos_buffer_toast_indice'},
	{name:'kb_tabla'},
	{name:'kb_indices'}	
	],
	sortInfo:{
		field: 'relname',
		direction: 'ASC'
	},
	bdel:false,//boton para eliminar
	bsave:false,//boton para eliminar
	bnew:false,//boton para eliminar
	bedit:false,//boton para eliminar

	east:{
		  url:'../../../sis_seguridad/vista/monitor_objetos/MonitorObjetosIndice.php',
		  title:'Indices', 
		  width:300,
		  cls:'monitor_objetos_indice'
		 },
	

	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
		Phx.vista.monitor_objetos_tabla.superclass.preparaMenu.call(this,tb);
		  
	},
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_esquema:this.maestro.nspoid};
		this.load({params:{start:0, limit:50}})
	}
	
}
)
</script>