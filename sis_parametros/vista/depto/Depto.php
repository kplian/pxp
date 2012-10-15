<?php
/**
*@package pXP
*@file gen-Depto.php
*@author  (rortiz)
*@date 24-11-2011 15:52:20
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Depto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Depto.superclass.constructor.call(this,config);
		this.init();
		
		
		
		this.load({params:{start:0, limit:50}})
	},
		 east:{
		  url:'../../../sis_parametros/vista/depto_usuario/DeptoUsuario.php',
		  title:'Usuarios por Departamento', 
		  width:400,
		  cls:'DeptoUsuario'
		 },	
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_depto'
			},
			type:'Field',
			form:true 
		},
		{
   			config:{
   				name:'id_subsistema',
   				fieldLabel:'Subsistema',
   				allowBlank:true,
   				emptyText:'Subsistema...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_seguridad/control/Subsistema/listarSubsistema',
					id: 'id_subsistema',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_subsistema','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
   				valueField: 'id_subsistema',
   				displayField: 'nombre',
   				gdisplayField:'desc_subsistema',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p></div></tpl>',
   				hiddenName: 'id_subsistema',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:280,
   				minChars:2,
   				renderer:function (value, p, record){return String.format('{0}', record.data['desc_subsistema']);}
   			},
   			//type:'TrigguerCombo',
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{	
   				        pfiltro:'nombre',
   						type:'string'
   					},
   		   
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
			filters:{pfiltro:'depto.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Codigo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'depto.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'depto.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_corto',
				fieldLabel: 'nombre Corto',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'depto.nombre_corto',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'usureg',
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'depto.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usumod',
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'depto.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Departamento',
	ActSave:'../../sis_parametros/control/Depto/insertarDepto',
	ActDel:'../../sis_parametros/control/Depto/eliminarDepto',
	ActList:'../../sis_parametros/control/Depto/listarDepto',
	id_store:'id_depto',
	fields: [
		{name:'id_depto', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d'},
		{name:'usureg', type: 'string'},
		{name:'usumod', type: 'string'},
		{name:'desc_subsistema', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'nombre_corto', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_depto',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		