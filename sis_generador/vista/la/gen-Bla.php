<?php
/**
*@package pXP
*@file gen-Bla.php
*@author  (rac)
*@date 13-06-2012 13:04:10
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Bla=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Bla.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tabla'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'alias',
				fieldLabel: 'alias',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'as.alias',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'direccion',
				fieldLabel: 'direccion',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'as.direccion',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'esquema',
				fieldLabel: 'esquema',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'as.esquema',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'as.estado_reg',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'reemplazar',
				fieldLabel: 'reemplazar',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'as.reemplazar',type:'string'},
			id_grupo:0,
			grid:false,
			form:false
		},
		{
			config:{
				name: 'id_subsistema',
				fieldLabel: 'id_subsistema',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'as.id_subsistema',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'menu',
				fieldLabel: 'menu',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'as.menu',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'as.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'titulo',
				fieldLabel: 'titulo',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:150
			},
			type:'TextField',
			filters:{pfiltro:'as.titulo',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'as.fecha_reg',type:'date'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'as.fecha_mod',type:'date'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '%',
				gwidth: ,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		}
	],
	title:'Tabla',
	ActSave:'../../sis_generador/control/Bla/insertarBla',
	ActDel:'../../sis_generador/control/Bla/eliminarBla',
	ActList:'../../sis_generador/control/Bla/listarBla',
	id_store:'id_tabla',
	fields: [
		{name:'id_tabla', type: 'numeric'},
		{name:'alias', type: 'string'},
		{name:'direccion', type: 'string'},
		{name:'esquema', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'reemplazar', type: 'string'},
		{name:'id_subsistema', type: 'numeric'},
		{name:'menu', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'titulo', type: 'string'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_tabla',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		