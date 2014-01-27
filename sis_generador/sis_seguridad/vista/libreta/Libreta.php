<?php
/**
*@package pXP
*@file gen-Libreta.php
*@author  (rac)
*@date 18-06-2012 16:21:29
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Libreta=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Libreta.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_libreta'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:15
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
				fieldLabel: 'obs',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'lib.obs',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		}
	],
	title:'LIBRETA',
	ActSave:'../../sis_seguridad/control/Libreta/insertarLibreta',
	ActDel:'../../sis_seguridad/control/Libreta/eliminarLibreta',
	ActList:'../../sis_seguridad/control/Libreta/listarLibreta',
	id_store:'id_libreta',
	fields: [
		{name:'id_libreta', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'telefono', type: 'numeric'},
		{name:'obs', type: 'string'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_libreta',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		