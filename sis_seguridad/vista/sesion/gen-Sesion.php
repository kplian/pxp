<?php
/**
*@package pXP
*@file gen-Sesion.php
*@author  (rac)
*@date 18-10-2011 18:43:29
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Sesion=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Sesion.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_sesion'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'datos',
				fieldLabel: 'datos',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'ses.datos',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'TextField',
			filters:{pfiltro:'ses.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'funcion_actual',
				fieldLabel: 'funcion_actual',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'ses.funcion_actual',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'hora_act',
				fieldLabel: 'hora_act',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:8
			},
			type:'TextField',
			filters:{pfiltro:'ses.hora_act',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'hora_des',
				fieldLabel: 'hora_des',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:8
			},
			type:'TextField',
			filters:{pfiltro:'ses.hora_des',type:'string'},
			id_grupo:1,
			grid:true,
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
			type:'TextField',
			filters:{pfiltro:'ses.id_usuario',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'inicio_proceso',
				fieldLabel: 'inicio_proceso',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'ses.inicio_proceso',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'ip',
				fieldLabel: 'ip',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'ses.ip',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'pid_bd',
				fieldLabel: 'pid_bd',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'TextField',
			filters:{pfiltro:'ses.pid_bd',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'pid_web',
				fieldLabel: 'pid_web',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'TextField',
			filters:{pfiltro:'ses.pid_web',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'transaccion_actual',
				fieldLabel: 'transaccion_actual',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'ses.transaccion_actual',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'variable',
				fieldLabel: 'variable',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'ses.variable',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'ses.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Sesion',
	ActSave:'../../sis_seguridad/control/Sesion/insertarSesion',
	ActDel:'../../sis_seguridad/control/Sesion/eliminarSesion',
	ActList:'../../sis_seguridad/control/Sesion/listarSesion',
	id_store:'id_sesion',
	fields: [
		{name:'id_sesion', type: 'string'},
		{name:'datos', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'funcion_actual', type: 'string'},
		{name:'hora_act', type: 'string'},
		{name:'hora_des', type: 'string'},
		{name:'id_usuario', type: 'numeric'},
		{name:'inicio_proceso', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'ip', type: 'string'},
		{name:'pid_bd', type: 'numeric'},
		{name:'pid_web', type: 'numeric'},
		{name:'transaccion_actual', type: 'string'},
		{name:'variable', type: 'string'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_sesion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		