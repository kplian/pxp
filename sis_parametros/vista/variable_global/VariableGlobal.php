<?php
/**
*@package pXP
*@file VariableGlobal.php
*@author  (jrivera)
*@date 16-08-2012 23:48:42
*@description Archivo con la interfaz la tabla variable global pxp
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.VariableGlobal=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.VariableGlobal.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_variable_global'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'variable',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '80%',
				gwidth: 150,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'varglo.variable',type:'string'},
			id_grupo:1,
			grid:true,
			form:true,
			bottom_filter : true
		},
		{
			config:{
				name: 'valor',
				fieldLabel: 'varchar',
				allowBlank: false,
				anchor: '80%',
				gwidth: 150,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'varglo.valor',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: false,
				anchor: '80%',
				gwidth: 400,
				maxLength:1000
			},
			type:'TextField',
			bottom_filter : true,
			filters:{pfiltro:'varglo.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		}
		
	],
	title:'Variable Global',
	ActSave:'../../sis_parametros/control/VariableGlobal/insertarVariableGlobal',
	ActDel:'../../sis_parametros/control/VariableGlobal/eliminarVariableGlobal',
	ActList:'../../sis_parametros/control/VariableGlobal/listarVariableGlobal',
	id_store:'id_variable_global',
	fields: [
		{name:'id_variable_global', type: 'numeric'},		
		{name:'variable', type: 'string'},
		{name:'valor', type: 'string'},
		{name:'descripcion', type: 'string'}	
	],
	sortInfo:{
		field: 'variable',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false
	}
)
</script>
		
		