<?php
/**
*@package pXP
*@file Funcionario.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para registrar los datos de un funcionario
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.funcionario=function(config){

	this.Atributos=[
	       	{
	       		// configuracion del componente
	       		config:{
	       			labelSeparator:'',
	       			inputType:'hidden',
	       			name: 'id_funcionario'

	       		}, 
	       		type:'Field',
	       		form:true  
	       		
	       	},

	    	{
	   			config:{
	       		    name:'id_persona',
	   				origen:'PERSONA',
	   				tinit:true,
	   				fieldLabel:'Persona',
	   				gdisplayField:'desc_person',//mapea al store del grid
	   			    gwidth:200,
		   			 renderer:function (value, p, record){return String.format('{0}', record.data['desc_person']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'PERSON.nombre_completo1',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
	   	      },

	       	{
	       		config:{
	       			fieldLabel: "Código",
	       			gwidth: 120,
	       			name: 'codigo',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
	       	{
	       		config:{
	       			fieldLabel: "CI",
	       			gwidth: 120,
	       			name: 'ci',
	       			allowBlank:false,	
	       			maxLength:20,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:true,
	       		form:false
	       	},
	       	{
	       		config:{
	       			fieldLabel: "Fecha de Ingreso",
	       			gwidth: 120,
	       			name: 'fecha_ingreso',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			format:'d/m/Y',
	       			anchor:'100%',
	       			renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
	       		},
	       		type:'DateField',
	       		filters:{type:'date'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
	       	{
	       		config:{
	       			fieldLabel: "Correo EMP",
	       			gwidth: 120,
	       			name: 'email_empresa',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},

	       	{
	       		config:{
	       			fieldLabel: "Interno",
	       			gwidth: 120,
	       			name: 'interno',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
	       		{
	       		config:{
	       			fieldLabel: "Teléfono",
	       			gwidth: 120,
	       			name: 'telefon1',
	       			allowBlank:true,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'NumberField',
	       		filters:{type:'numeric'},
	       		id_grupo:0,
	       		grid:true,
	       		form:false
	       	},
	       		{
	       		config:{
	       			fieldLabel: "Celular",
	       			gwidth: 120,
	       			name: 'celular1',
	       			allowBlank:true,	
	       			
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'NumberField',
	       		filters:{type:'numeric'},
	       		id_grupo:0,
	       		grid:true,
	       		form:false
	       	},
	       	{
	       		config:{
	       			fieldLabel: "Correo",
	       			gwidth: 120,
	       			name: 'correo1',
	       			allowBlank:true,	
	       			vtype:'email',	
	       			maxLength:50,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
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
					format:'d/m/Y',
					renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				},
				type:'DateField',				
				filters:{pfiltro:'ins.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
			},
			{
	       		config:{
	       			name:'estado_reg',
	       			fieldLabel:'Estado',
	       			allowBlank:false,
	       			emptyText:'Estado...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'estado_reg',
	       		   // displayField: 'descestilo',
	       		    store:['activo','inactivo']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['activo','inactivo'],	
	       		 	},
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
				type:'TextField',
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
					renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				},
				type:'DateField',
				filters:{pfiltro:'ins.fecha_mod',type:'date'},
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
				type:'TextField',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
			}
	       	
	       	
	       	];
	       	
	Phx.vista.funcionario.superclass.constructor.call(this,config);
	
	this.init();
	var txt_ci=this.getComponente('ci');	
	var txt_correo=this.getComponente('correo');	
	var txt_telefono=this.getComponente('telefono');	
	this.getComponente('id_persona').on('select',onPersona);
	//this.getComponente();
	
	
	
	function onPersona(c,r,e){
		txt_ci.setValue(r.data.ci);
		txt_correo.setValue(r.data.correo);
		txt_telefono.setValue(r.data.telefono);
	}
	this.load({params:{start:0, limit:50}});
	
	
	
	
}

Ext.extend(Phx.vista.funcionario,Phx.gridInterfaz,{
	title:'Funcionarios',
	ActSave:'../../sis_organigrama/control/Funcionario/guardarFuncionario',
	ActDel:'../../sis_organigrama/control/Funcionario/eliminarFuncionario',
	ActList:'../../sis_organigrama/control/Funcionario/listarFuncionario',
	id_store:'id_funcionario',
	fields: [
	{name:'id_funcionario'},
	{name:'id_persona'},
	{name:'desc_person',type:'string'},
	{name:'codigo',type:'string'},

	{name:'estado_reg', type: 'string'},

	{name:'ci', type:'string'},
	{name:'documento', type:'string'},
	{name:'correo1', type:'string'},
	{name:'celular1'},
	{name:'telefono1'},
	{name:'email_empresa'},
	'interno',
	{name:'fecha_ingreso', type: 'date', dateFormat:'Y-m-d'},

	{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d'},
	{name:'id_usuario_reg', type: 'numeric'},
	{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d'},
	{name:'id_usuario_mod', type: 'numeric'},
	{name:'usr_reg', type: 'string'},
	{name:'usr_mod', type: 'string'}
		
	],
	sortInfo:{
		field: 'PERSON.nombre_completo1',
		direction: 'ASC'
	},
	
	
	// para configurar el panel south para un hijo
	
	/*
	 * south:{
	 * url:'../../../sis_seguridad/vista/usuario_regional/usuario_regional.php',
	 * title:'Regional', width:150
	 *  },
	 */	
	bdel:true,// boton para eliminar
	bsave:true// boton para eliminar
	
		  
		 
})
</script>