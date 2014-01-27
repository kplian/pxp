<?php
/**
*@package pXP
*@file gen-LibretaHer.php
*@author  (rac)
*@date 18-06-2012 16:45:50
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.LibretaHer=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.LibretaHer.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:10}})
	},
    tam_pag:10,//registro por paginas del grid	
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_libreta_her'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: false,
				anchor: '80%',
				gwidth: 300,
				maxLength:12
			},
			type:'TextField',
			filters:{pfiltro:'lib.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
	
		{
			config:{
				name: 'telefono',
				fieldLabel: 'telefono',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'lib.telefono',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
	
		{
			config:{
				name: 'obs',
				fieldLabel: 'Obser',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextArea',
			filters:{pfiltro:'lib.obs',type:'string'},
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
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'lib.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'lib.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'lib.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'LIBRETA',
	ActSave:'../../sis_seguridad/control/LibretaHer/insertarLibretaHer',
	ActDel:'../../sis_seguridad/control/LibretaHer/eliminarLibretaHer',
	ActList:'../../sis_seguridad/control/LibretaHer/listarLibretaHer',
	id_store:'id_libreta_her',
	fields: [
		{name:'id_libreta_her', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'telefono', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'obs', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_libreta_her',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		