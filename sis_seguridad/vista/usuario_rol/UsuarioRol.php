<?php
/**
*@package pXP
*@file UsuarioRol.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para asociar roles a usuarios
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.usuario_rol=function(config){

var ds_rol =new Ext.data.JsonStore({

				url: '../../sis_seguridad/control/Rol/listarRol',
				id: 'id_rol',
				root: 'datos',
				sortInfo:{
					field: 'rol',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['id_rol','rol','descripcion'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_filtro:'rol'}
				
			});


function render_id_rol(value, p, record){return String.format('{0}', record.data['rol']);}
var FormatoVista=function (value,p,record){return value?value.dateFormat('d/m/Y'):''}

	this.Atributos=[
	{
		//configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_usuario_rol'

		},
		type:'Field',
		form:true 
		
	},{
		//configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_usuario'

		},
		type:'Field',
		form:true 
		
	},{
			config:{
				name:'id_rol',
				fieldLabel:'Rol',
				allowBlank:false,
				emptyText:'Rol...',
				store:ds_rol,
				valueField: 'id_rol',
				displayField: 'rol',
				hiddenName: 'id_rol',
				forceSelection:true,
				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				width:220,
				gwidth:220,
				//minListWidth:'200',
				renderer:render_id_rol
			},
			type:'ComboBox',
			id_grupo:0,
			filters:{	pfiltro:'rol',
						type:'string'
					},
			grid:true,
			//bottom_filter:true,
			form:true
	},
	 {
		config:{
			fieldLabel: "Descripcion",
			gwidth: 130,
			name: 'descripcion'
		},
		type:'TextArea',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Subsistema",
			gwidth: 130,
			name: 'nombre'
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},		
	{
		config:{
				fieldLabel: "fecha_reg",
				gwidth: 110,
				name:'fecha_reg',
				renderer:FormatoVista
			},
			type:'DateField',
			filters:{type:'date'},
			grid:true,
			form:false
	}
	];

	Phx.vista.usuario_rol.superclass.constructor.call(this,config);
	this.init();
	
	this.grid.getTopToolbar().disable();
	this.grid.getBottomToolbar().disable();

	

}

Ext.extend(Phx.vista.usuario_rol,Phx.gridInterfaz,{
	tabEnter:true,
	title:'Usuario',
	ActSave:'../../sis_seguridad/control/UsuarioRol/guardarUsuarioRol',
	ActDel:'../../sis_seguridad/control/UsuarioRol/eliminarUsuarioRol',
	ActList:'../../sis_seguridad/control/UsuarioRol/listarUsuarioRol',
	id_store:'id_usuario_rol',
	fields: [
	'id_usuario_rol','id_rol',
	'rol',
	'descripcion',
	{name:'fecha_reg',type: 'date', dateFormat: 'Y-m-d'},
	'nombre'],
	sortInfo:{
		field: 'rol',
		direction: 'ASC'
	},
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar
	bedit:false,//boton para editar


	loadValoresIniciales:function(){
		Phx.vista.usuario_rol.superclass.loadValoresIniciales.call(this);
	    this.getComponente('id_usuario').setValue(this.maestro.id_usuario);
	},
	
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_usuario:this.maestro.id_usuario};
		this.load({params:{start:0, limit:50}})
		
	},
	reload:function(p){
	    Phx.CP.getPagina(this.idContenedorPadre).reload()
	}

	
})
</script>