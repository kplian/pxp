<?php
/**
*@package pXP
*@file RolProcedimiento.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para desplegar roles por procedimiento
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.rol_procedimiento=function(config){

var ds_subsistema =new Ext.data.JsonStore({

				url: '../../sis_seguridad/control/subsistema/ActionListarSubsistema.php',
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
				baseParams:{par_combo:'nombre'}
			});


function render_id_subsistema(value, p, record){return String.format('{0}', record.data['desc_subsis']);}
var FormatoVista=function (value,p,record){return value?value.dateFormat('d/m/Y'):''}

	this.Atributos=[
	{
		//configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_rol'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Nombre",
			gwidth: 100,
			name: 'rol',
			allowBlank:false,	
			maxLength:100,
			minLength:1,/*aumentar el minimo*/
			anchor:'80%'
			
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Descripcion",
			gwidth: 130,
			name: 'descripcion',
			allowBlank:true,	
			maxLength:100,
			minLength:1,/*aumentar el minimo*/
			anchor:'80%'
			
		},
		type:'TextArea',
		
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},{
			config:{
				name:'id_subsistema',
				fieldLabel:'Subsistema',
				allowBlank:false,
				emptyText:'Subsistema...',
				store:ds_subsistema,
				valueField: 'id_subsistema',
				displayField: 'nombre',
				hiddenName: 'id_subsistema',
				
				forceSelection:true,
				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2,
				minListWidth:'100%',
				renderer:render_id_subsistema
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

	Phx.vista.rol.superclass.constructor.call(this,config);
	this.init();
	
	this.addButton('Procedimiento',{handler:hijo,disabled:false,tooltip: '<b>Procedimiento</b><br/>'});
			
		function hijo(){
			_CP.loadWindows('../../sis_seguridad/vista/rol_procedimiento/rol_procedimiento.php','Rol Procedimiento',{width:800,height:500},this.sm.getSelected().data,this.idContenedor);	
		}
	
	this.load({params:{start:0, limit:50}})



}

Ext.extend(Phx.vista.rol,Phx.gridInterfaz,{
	title:'Usuario',
	ActSave:'../../../sis_seguridad/control/rol/ActionGuardarRol.php',
	ActDel:'../../../sis_seguridad/control/rol/ActionEliminarRol.php',
	ActList:'../../../sis_seguridad/control/rol/ActionListarRol.php',
	id_store:'id_rol',
	fields: [
	{name:'id_rol'},
	{name:'rol', type: 'string'},
	{name:'descripcion', type: 'string'},
	{name:'id_subsistema'},
	{name:'desc_subsis', type: 'string'},
		],
	sortInfo:{
		field: 'rol',
		direction: 'ASC'
	},
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar


	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
		Phx.vista.rol.superclass.preparaMenu.call(this,tb)
	},

EnableSelect:function(sm, row, rec){
		
		Phx.vista.rol.superclass.EnableSelect.call(this); //sobrecarga enable select
		
	},
	DisableSelect:function(sm,row,rec){
		
		Phx.vista.rol.superclass.DisableSelect.call(this,sm,row,rec); //sobrecarga disable select
		
//		_CP.getPagina(this.idContenedor+'-south').grid.getTopToolbar().disable();
//		_CP.getPagina(this.idContenedor+'-south').store.removeAll();
//		_CP.getPagina(this.idContenedor+'-south').grid.getBottomToolbar().disable();
//		
//		
//		_CP.getPagina(this.idContenedor+'-west').grid.getTopToolbar().disable();
//		_CP.getPagina(this.idContenedor+'-west').store.removeAll();
//		
//		_CP.getPagina(this.idContenedor+'-west').grid.getBottomToolbar().disable();
	}
})
</script>