<?php
/**
*@package pXP
*@file MonitorObjetos.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar los objetos de Base de Datos
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.monitor_objetos=function(config){
	
	
	this.Atributos=[
	{
		//configuracion del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'nspoid'

		},
		type:'Field',
		form:true 
		
	},	
	 {
		config:{
			fieldLabel: "Esquema",
			gwidth: 100,
			name: 'schemaname'
			
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
			fieldLabel: "# tablas",
			gwidth: 130,
			name: 'cantidad_tablas'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
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
			fieldLabel: "# KB Tablas",
			gwidth: 130,
			name: 'kb_tablas'
			
		},
		type:'NumberField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "# KB Indices",
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

	Phx.vista.monitor_objetos.superclass.constructor.call(this,config);
	this.init();
	this.load({params:{start:0, limit:50}});
	
	
		
}
Ext.extend(Phx.vista.monitor_objetos,Phx.gridInterfaz,{
	
	title:'Log',
	ActList:'../../sis_seguridad/control/Log/listarMonitorEsquema',
	id_store:'nspoid',
	fields: [
	{name:'nspoid'},
	{name:'id_usuario'},
	{name:'schemaname', type: 'string'},
	{name:'usename', type: 'string'},
	{name:'cantidad_tablas'},
	{name:'cantidad_indices'},
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
	{name:'kb_tablas'},
	{name:'kb_indices'}	
	],
	sortInfo:{
		field: 'schemaname',
		direction: 'ASC'
	},
	bdel:false,//boton para eliminar
	bsave:false,//boton para eliminar
	bnew:false,//boton para eliminar
	bedit:false,//boton para eliminar


	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
		Phx.vista.monitor_objetos.superclass.preparaMenu.call(this,tb);
		  
	},
	south:{
		  url:'../../../sis_seguridad/vista/monitor_objetos/MonitorObjetosTabla.php',
		  title:'Tablas', 
		  height:300,
		  cls:'monitor_objetos_tabla'
		 },
	east:{
		  url:'../../../sis_seguridad/vista/monitor_objetos/MonitorObjetosFuncion.php',
		  title:'Funciones', 
		  width:300,
		  cls:'monitor_objetos_funcion'
		 }
	
}
)
</script>