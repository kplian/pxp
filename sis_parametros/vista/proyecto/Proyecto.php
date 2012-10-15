<?php
/**
*@package pXP
*@file gen-Proyecto.php
*@author  (rac)
*@date 26-10-2011 11:40:13
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Proyecto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Proyecto.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_proyecto'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_usuario',
				fieldLabel: 'id_usuario',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'pro.id_usuario',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion_proyecto',
				fieldLabel: 'descripcion_proyecto',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'pro.descripcion_proyecto',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo_sisin',
				fieldLabel: 'codigo_sisin',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:8
			},
			type:'TextField',
			filters:{pfiltro:'pro.codigo_sisin',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'hora_ultima_modificacion',
				fieldLabel: 'hora_ultima_modificacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:8
			},
			type:'TextField',
			filters:{pfiltro:'pro.hora_ultima_modificacion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo_proyecto',
				fieldLabel: 'codigo_proyecto',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'pro.codigo_proyecto',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'hora_registro',
				fieldLabel: 'hora_registro',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:8
			},
			type:'TextField',
			filters:{pfiltro:'pro.hora_registro',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_corto',
				fieldLabel: 'nombre_corto',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'pro.nombre_corto',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_ultima_modificacion',
				fieldLabel: 'fecha_ultima_modificacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'pro.fecha_ultima_modificacion',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_registro',
				fieldLabel: 'fecha_registro',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'pro.fecha_registro',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_proyecto',
				fieldLabel: 'nombre_proyecto',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'pro.nombre_proyecto',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_proyecto_actif',
				fieldLabel: 'id_proyecto_actif',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'pro.id_proyecto_actif',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		}
	],
	title:'PRO',
	ActSave:'../../sis_parametros/control/Proyecto/insertarProyecto',
	ActDel:'../../sis_parametros/control/Proyecto/eliminarProyecto',
	ActList:'../../sis_parametros/control/Proyecto/listarProyecto',
	id_store:'id_proyecto',
	fields: [
		{name:'id_proyecto', type: 'numeric'},
		{name:'id_usuario', type: 'numeric'},
		{name:'descripcion_proyecto', type: 'string'},
		{name:'codigo_sisin', type: 'string'},
		{name:'hora_ultima_modificacion', type: 'string'},
		{name:'codigo_proyecto', type: 'string'},
		{name:'hora_registro', type: 'string'},
		{name:'nombre_corto', type: 'string'},
		{name:'fecha_ultima_modificacion', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'fecha_registro', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'nombre_proyecto', type: 'string'},
		{name:'id_proyecto_actif', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_proyecto',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		