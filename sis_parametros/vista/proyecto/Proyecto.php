<?php
/**
*@package pXP
*@file Proyecto.php
*@author  Gonzalo Sarmiento Sejas
*@date 06-02-2013 17:04:17
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
				name: 'codigo_proyecto',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '80%',
				gwidth: 120,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'proy.codigo_proyecto',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_proyecto',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 240,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'proy.nombre_proyecto',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_corto',
				fieldLabel: 'Nombre Corto',
				allowBlank: true,
				anchor: '80%',
				gwidth: 140,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'proy.nombre_corto',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion_proyecto',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:300
			},
			type:'TextArea',
			filters:{pfiltro:'proy.descripcion_proyecto',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_proyecto_cat_prog',
				fieldLabel: 'Proyecto Cat Prog',
				allowBlank: true,
				anchor: '80%',
				gwidth: 130,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'proy.id_proyecto_cat_prog',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo_sisin',
				fieldLabel: 'Código Sisin',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:8
			},
			type:'TextField',
			filters:{pfiltro:'proy.codigo_sisin',type:'string'},
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
			filters:{pfiltro:'proy.estado_reg',type:'string'},
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
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'proy.fecha_reg',type:'date'},
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'proy.fecha_mod',type:'date'},
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
		}
	],
	
	title:'Proyecto',
	ActSave:'../../sis_parametros/control/Proyecto/insertarProyecto',
	ActDel:'../../sis_parametros/control/Proyecto/eliminarProyecto',
	ActList:'../../sis_parametros/control/Proyecto/listarProyecto',
	id_store:'id_proyecto',
	fields: [
		{name:'id_proyecto', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'hidro', type: 'string'},
		{name:'id_proyecto_cat_prog', type: 'numeric'},
		{name:'codigo_proyecto', type: 'string'},
		{name:'descripcion_proyecto', type: 'string'},
		{name:'nombre_proyecto', type: 'string'},
		{name:'nombre_corto', type: 'string'},
		{name:'id_proyecto_actif', type: 'numeric'},
		{name:'codigo_sisin', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
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
		
		