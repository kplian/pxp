<?php
/**
*@package pXP
*@file Funcion.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar listado de funciones
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
/***
 * Nombre:		funcion.js
 * Proposito:	Vista para mostrar listado de funciones
 * Autor:		Kplian (JRR)
 * Fecha:		03/01/2011
 */
Phx.vista.funcion=Ext.extend(Phx.gridInterfaz,{
   Atributos:[
	{
		//configuración del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_funcion'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Nombre",
			gwidth: 130,
			name: 'nombre',
			allowBlank:false,	
			maxLength:150,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{pfiltro:'funcio.nombre',type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Descripcion",
			gwidth: 130,
			name: 'descripcion',
			allowBlank:false,	
			maxLength:150,
			minLength:5,
			anchor:'100%'
		},
		type:'TextArea',
		filters:{pfiltro:'funcio.descripcion',type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},{
		//configuración del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_subsistema'

		},
		type:'TextField',
		form:true 
		//defecto:maestro.id_subsistema
		
	}
	],



	title:'Funcion',
	ActSave:'../../sis_seguridad/control/Funcion/guardarFuncion',
	ActDel:'../../sis_seguridad/control/Funcion/eliminarFuncion',
	ActList:'../../sis_seguridad/control/Funcion/listarFuncion',
	id_store:'id_funcion',
	fields: [
	{name:'id_funcion'},
	{name:'nombre', type: 'string'},
	{name:'descripcion', type: 'string'},
	{name:'estado_reg', type: 'string'}
	
	],
	sortInfo:{
		field: 'nombre',
		direction: 'ASC'
	},
	onButtonNew:function(){

		Phx.vista.funcion.superclass.onButtonNew.call(this);
		this.getComponente('id_subsistema').setValue(this.maestro.id_subsistema);
		
	},
	bedit:false,
	/*onReloadPage:function(m){


		this.maestro=m;


		//this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);

			
		if(parseFloat(this.maestro.id_subsistema)>0){
			this.store.baseParams={id_subsistema:this.maestro.id_subsistema};
		}else{ 
			this.store.baseParams={id_subsistema:0};
		}

		
		this.load({params:{start:0, limit:50}})


	},*/
	
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_subsistema:this.maestro.id_subsistema};
		this.load({params:{start:0, limit:50}})
	},
	
	constructor: function(config){
		//configuración del data store
		this.maestro=config.maestro


		Phx.vista.funcion.superclass.constructor.call(this,config);


		this.init();
		this.addButton('proced',{text:'Procedimientos',iconCls: 'blist',disabled:true,handler:procedimiento,tooltip: '<b>Procedimientos por Funcion</b><br/>Procedimiento de funciones'});
		
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		//this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip: '<b>My Boton</b><br/>Icon only button with tooltip'});
		
		function procedimiento(){
			
			var rec=this.sm.getSelected();

			Phx.CP.loadWindows('../../../sis_seguridad/vista/procedimiento/Procedimiento.php',
					'Procedimientos',
					{
						modal:true,
						width:900,
						height:400
				    },rec.data,this.idContenedor,'procedimiento')
		}
		
		//this.load({params:{id_subsistema:0, start:0, limit:50}})
		//this.load({params:{start:0, limit:50}})
	},
	
/*	south:{	
	url:'../../../sis_seguridad/vista/procedimiento/procedimiento.js',	
	title:'Procedimientos de BD',
	height:200	,
	width:380,
	cls:'procedimiento'
	},*/
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar


	//sobre carga de funcion
	preparaMenu:function(tb){
		//llamada funcion clace padre
		this.getBoton('proced').enable();
		Phx.vista.funcion.superclass.preparaMenu.call(this,tb)
	}

	/*Grupos:[{

	xtype:'fieldset',
	border: false,
	//title: 'Checkbox Groups',
	autoHeight: true,
	layout: 'form',
	items:[],
	id_grupo:0
	}],*/


  }
)
</script>