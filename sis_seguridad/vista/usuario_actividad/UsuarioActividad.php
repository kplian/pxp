<?php
/**
*@package pXP
*@file UsuarioActividad.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para la actividad de un usuario en el sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.usuario_actividad=function(config){
	
	var ds_actividad =new Ext.data.JsonStore({

				url: '../../../sis_seguridad/control/actividad/ActionListarActividad.php',
				id: 'id_actividad',
				root: 'datos',
				sortInfo:{
					field: 'nombre',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['id_actividad','nombre'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_combo:'nombre'}
			});
			
	
	
this.Atributos=[
	{
		//configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_usuario_actividad'

		},
		type:'Field',
		form:true 
		
	},
	
	{
		//configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_usuario',
			value:config.maestro.id_usuario

		},
		type:'Field',
		form:true 
		
	},
	
	{
			config:{
				name:'id_actividad',
				fieldLabel:'actividad',
				allowBlank:false,
				emptyText:'actividad...',
				store:ds_actividad,
				valueField: 'id_actividad',
				displayField: 'nombre',
				hiddenName: 'id_actividad',
				
				forceSelection:true,
				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:10,
				queryDelay:500,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_actividad']);},
				width:150,
				gwidth:150,
				minChars:2,
				minListWidth:'100%',
			},
			type:'ComboBox',
			id_grupo:0,
			filters:{	dataIndex:'nombre',
						type:'string'
					},
			grid:true,
			form:true
	}
	];
	
	Phx.vista.usuario_actividad.superclass.constructor.call(this,config);
	this.init();
	//this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip: '<b>My Boton</b><br/>Icon only button with tooltip'});
	this.store.baseParams={id_usuario:config.maestro.id_usuario};
	this.load({params:{start:0, limit:50}})
}

Ext.extend(Phx.vista.usuario_actividad,Phx.gridInterfaz,{


	title:'Regional',
	ActSave:'../../../sis_seguridad/control/usuario_actividad/ActionGuardarUsuarioActividad.php',
	ActDel:'../../../sis_seguridad/control/usuario_actividad/ActionEliminarUsuarioActividad.php',
	ActList:'../../../sis_seguridad/control/usuario_actividad/ActionListarUsuarioActividad.php',
	id_store:'id_usuario_actividad',
	fields: [
	{name:'id_usuario_actividad'},
	{name:'id_usuario'},
	{name:'id_actividad'},
	{name:'desc_actividad', type: 'string'},
	{name:'desc_person', type: 'string'}
	
	],
	
	sortInfo:{
		field: 'activi.nombre',
		direction: 'ASC'
	},
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar
	
		
	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
	
	  Phx.vista.usuario_actividad.superclass.preparaMenu.call(this,tb)
	}
	
	

}
);
</script>