<?php
/**
*@package pXP
*@file UsuarioProyecto.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para asociar usuarios a proyectos
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.usuario_proyecto=function(config){
	
	var ds_proyecto =new Ext.data.JsonStore({

				url: '../../../sis_seguridad/control/proyecto/ActionListarProyecto.php',
				id: 'id_proyecto',
				root: 'datos',
				sortInfo:{
					field: 'nombre',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['id_proyecto','nombre'],
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
			name: 'id_usuario_proyecto'

		},
		type:'Field',
		form:true 
		
	},
	
	{
		//configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_usuario'

		},
		type:'Field',
		form:true 
		
	},
	
	{
			config:{
				name:'id_proyecto',
				fieldLabel:'Proyecto',
				allowBlank:false,
				emptyText:'proyecto...',
				store:ds_proyecto,
				valueField: 'id_proyecto',
				displayField: 'nombre',
				hiddenName: 'id_proyecto',
				forceSelection:true,
				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:10,
				queryDelay:500,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_proyecto']);},
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
	
	Phx.vista.usuario_proyecto.superclass.constructor.call(this,config);
	this.init();
	//this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip: '<b>My Boton</b><br/>Icon only button with tooltip'});
	this.grid.getTopToolbar().disable();
	this.grid.getBottomToolbar().disable();
}

Ext.extend(Phx.vista.usuario_proyecto,Phx.gridInterfaz,{


	title:'Proyecto',
	ActSave:'../../../sis_seguridad/control/usuario_proyecto/ActionGuardarUsuarioProyecto.php',
	ActDel:'../../../sis_seguridad/control/usuario_proyecto/ActionEliminarUsuarioProyecto.php',
	ActList:'../../../sis_seguridad/control/usuario_proyecto/ActionListarUsuarioProyecto.php',
	id_store:'id_usuario_proyecto',
	fields: [
	{name:'id_usuario_proyecto'},
	{name:'id_usuario'},
	{name:'id_proyecto'},
	{name:'desc_proyecto', type: 'string'},
	{name:'desc_person', type: 'string'}
	
	],
	
	sortInfo:{
		field: 'proyec.nombre',
		direction: 'ASC'
	},
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar
	
		
	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
	
	  Phx.vista.usuario_proyecto.superclass.preparaMenu.call(this,tb)
	},
	onButtonNew:function(){
		Phx.vista.usuario_rol.superclass.onButtonNew.call(this);
		this.getComponente('id_usuario').setValue(this.maestro.id_usuario);
	},
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_usuario:this.maestro.id_usuario};
		this.load({params:{start:0, limit:50}})
	}
	
	

}
);

</script>
