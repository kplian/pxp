<?php
/**
*@package pXP
*@file UsuarioRegional.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para asociar usuairos a regionales
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.usuario_regional=function(config){
	
	var ds_regional =new Ext.data.JsonStore({

				url: '../../../sis_seguridad/control/regional/ActionListarRegional.php',
				id: 'id_regional',
				root: 'datos',
				sortInfo:{
					field: 'nombre',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['id_regional','nombre'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_combo:'nombre'}
			});
			
	
	
this.Atributos=[
	{
		//configuracion del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_usuario_regional'

		},
		type:'Field',
		form:true 
		
	},
	
	{
		//configuracion del componente
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
				name:'id_regional',
				fieldLabel:'Regional',
				allowBlank:false,
				emptyText:'Regional...',
				store:ds_regional,
				valueField: 'id_regional',
				displayField: 'nombre',
				hiddenName: 'id_regional',
				
				forceSelection:true,
				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:10,
				queryDelay:500,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_regional']);},
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
	
	Phx.vista.usuario_regional.superclass.constructor.call(this,config);
	this.init();
	//this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip: '<b>My Boton</b><br/>Icon only button with tooltip'});
	
	this.grid.getTopToolbar().disable();
	this.grid.getBottomToolbar().disable();
}

Ext.extend(Phx.vista.usuario_regional,Phx.gridInterfaz,{


	title:'Regional',
	ActSave:'../../../sis_seguridad/control/usuario_regional/ActionGuardarUsuarioRegional.php',
	ActDel:'../../../sis_seguridad/control/usuario_regional/ActionEliminarUsuarioRegional.php',
	ActList:'../../../sis_seguridad/control/usuario_regional/ActionListarUsuarioRegional.php',
	id_store:'id_usuario_regional',
	fields: [
	{name:'id_usuario_regional'},
	{name:'id_usuario'},
	{name:'id_regional'},
	{name:'desc_regional', type: 'string'},
	{name:'desc_person', type: 'string'}
	
	],
	
	sortInfo:{
		field: 'region.nombre',
		direction: 'ASC'
	},
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar
	
		
	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
	
	  Phx.vista.usuario_regional.superclass.preparaMenu.call(this,tb)
	},
	onButtonNew:function(){
		Phx.vista.usuario_regional.superclass.onButtonNew.call(this);
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