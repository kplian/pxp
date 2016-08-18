<?php
/**
*@package pXP
*@file gen-FuncionarioEspecialidad.php
*@author  (admin)
*@date 30-08-2012 20:43:28
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FuncionarioEspecialidad=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.FuncionarioEspecialidad.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_funcionario_especialidad'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_funcionario',
				fieldLabel: 'id_funcionario',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'rhesfu.id_funcionario',type:'numeric'},
			id_grupo:2,
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
			filters:{pfiltro:'rhesfu.estado_reg',type:'string'},
			id_grupo:2,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'id_especialidad',
				fieldLabel: 'id_especialidad',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'rhesfu.id_especialidad',type:'numeric'},
			id_grupo:3,
			grid:true,
			form:true
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
			id_grupo:3,
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
			filters:{pfiltro:'rhesfu.fecha_reg',type:'date'},
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
			id_grupo:2,
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
			filters:{pfiltro:'rhesfu.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Especialidades Funcionarios',
	ActSave:'../../sis_recursos_humanos/control/FuncionarioEspecialidad/insertarFuncionarioEspecialidad',
	ActDel:'../../sis_recursos_humanos/control/FuncionarioEspecialidad/eliminarFuncionarioEspecialidad',
	ActList:'../../sis_recursos_humanos/control/FuncionarioEspecialidad/listarFuncionarioEspecialidad',
	id_store:'id_funcionario_especialidad',
	fields: [
		{name:'id_funcionario_especialidad', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_especialidad', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_funcionario_especialidad',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	Grupos:[{ 
		layout: 'column',
		items:[
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Grupo 0',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: '.5',
                items:[],
		        id_grupo:0,
			},
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Grupo 1',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: '.5',
                items:[],
		        id_grupo:1,
			},
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Grupo 2',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: '.5',
                items:[],
		        id_grupo:2,
			}
			]
		}]
	}
)
</script>
		
		