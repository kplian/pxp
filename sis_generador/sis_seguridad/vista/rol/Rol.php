<?php
/**
*@package pXP
*@file Rol.php
*@author KPLIAN (FRH)
*@date 14-02-2011
*@description  Vista para desplegar rolesde usaurio
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.rol=function(config){

var ds_subsistema =new Ext.data.JsonStore({

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
				gdisplayField:'desc_subsis',
					
				hiddenName: 'id_subsistema',
				
				forceSelection:true,
				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				width:220,
				gwidth:220,
				minChars:2,
				renderer:render_id_subsistema
			},
			type:'ComboBox',
			id_grupo:0,
			filters:{	
		        pfiltro:'subsis.nombre',
				type:'string'
			},
			
			grid:true,
			form:true
	}
	];

	Phx.vista.rol.superclass.constructor.call(this,config);
	this.init();
	
	/*this.addButton('Procedimiento',{handler:hijo,disabled:false,tooltip: '<b>Procedimiento</b><br/>'});
			
		function hijo(){
			_CP.loadWindows('../../../sis_seguridad/vista/rol_procedimiento/rol_procedimiento.php','Rol Procedimiento',{width:800,height:500},this.sm.getSelected().data,this.idContenedor);	
		}*/
	
	this.load({params:{start:0, limit:50}})



}

Ext.extend(Phx.vista.rol,Phx.gridInterfaz,{
	tabEnter:true,
	title:'Usuario',
	ActSave:'../../sis_seguridad/control/Rol/guardarRol',
	ActDel:'../../sis_seguridad/control/Rol/eliminarRol',
	ActList:'../../sis_seguridad/control/Rol/listarRol',
	id_store:'id_rol',
	fheight:'70%',
	fwidth:'420',
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

	east:{
		  url:'../../../sis_seguridad/vista/gui_rol/GuiRol.php',
		  title:'Procedimientos', 
		  width:400,
		  cls:'gui_rol'
		 },

	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
		Phx.vista.rol.superclass.preparaMenu.call(this,tb)
	}



})
</script>