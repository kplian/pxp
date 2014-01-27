<?php
/**
*@package pXP
*@file Subsistema.php  
*@author KPLIAN (RAC)
*@date 14-02-2011
*@description  Vista para mostrar listado de subsistemas
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Subsistema=Ext.extend(Phx.gridInterfaz,{

	Atributos:[
	{
		// configuracion del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_subsistema'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Codigo",
			gwidth: 100,
			name: 'codigo',
			allowBlank:false,	
			maxLength:20,
			minLength:3
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Prefijo",
			gwidth: 80,
			name: 'prefijo',
			allowBlank:false,	
			maxLength:10,
			minLength:2
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Nombre",
			gwidth: 220,
			name: 'nombre',
			allowBlank:false,	
			maxLength:50,
			minLength:5
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	{
		config:{
			fieldLabel: "Nombre Carpeta",
			gwidth: 220,
			name: 'nombre_carpeta',
			allowBlank:false,	
			maxLength:50,
			minLength:5
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	}
	],

	title:'Subsistema',
	ActSave:'../../sis_seguridad/control/Subsistema/guardarSubsistema',
	ActDel:'../../sis_seguridad/control/Subsistema/eliminarSubsistema',
	ActList:'../../sis_seguridad/control/Subsistema/listarSubsistema',
	id_store:'id_subsistema',
	fields: [
	{name:'id_subsistema'},
	{name:'codigo', type: 'string'},
	{name:'prefijo', type: 'string'},
	{name:'nombre', type: 'string'},
	{name:'nombre_carpeta', type: 'string'}

		],
	sortInfo:{
		field: 'id_subsistema',
		direction: 'ASC'
	},
		
	bdel:true,// boton para eliminar
	bsave:false,// boton para eliminar

	east:{
		  url:'../../../sis_seguridad/vista/funcion/Funcion.php',
		  title:'Funcion', 
		  width:400,
		  cls:'funcion'
		 },
	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.Subsistema.superclass.preparaMenu.call(this,tb)
	},


	constructor: function(config){
		// configuracion del data store
		
		

		Phx.vista.Subsistema.superclass.constructor.call(this,config);

		this.init();
		
		this.addButton('aInterSis',{text:'Interfaces',iconCls: 'blist',disabled:true,handler:aInterSis,tooltip: '<b>Interfaces del Sistema</b><br/>Permite configurar transacciones por interfaz '});
		this.addButton('sinc_func',{text:'Sincronizar',iconCls: 'blist',disabled:true,handler:sinc_func,tooltip: '<b>Sincronizar Funciones</b><br/>Sinc '});
		this.addButton('exp_menu',{text:'Exportar Datos Seguridad',iconCls: 'blist',disabled:true,tooltip: '<b>Permite exportar los datos de seguridad del subsistema</b>',
		menu:{
   				items: [
   				{
   					text: 'Exportar Cambios Realizados', handler: this.expMenu, scope: this, argument : {todo:'no'}
   				},{
   					text: 'Exportar Todos los Datos de Seguridad', handler: this.expMenu, scope: this, argument : {todo : 'si'}
   				}
   				]
   			}
   		});
		//Incluye un menú
   		/*this.menuOp = new Ext.Toolbar.SplitButton({
   			text: 'Exportar Datos Seguridad',
   			scope: this,
   			tooltip : '<b>Exportar</b><br/>',
   			id : 'b-exp_menu-' + this.idContenedor,			
   			menu:{
   				items: [
   				{
   					text: 'Exportar Cambios Realizados', handler: this.expMenu, scope: this, argument : {todo:'no'}
   				},{
   					text: 'Exportar Todos los Datos de Seguridad', handler: this.expMenu, scope: this, argument : {todo : 'si'}
   				}
   				]
   			}
   		});*/
   		//this.menuOp.bconf.id = 'b-' + 'exp_menu' + '-' + this.idContenedor;
   		//this.tbar.add(this.menuOp);
		function aInterSis(){
			
		
			var rec=this.sm.getSelected();

			Phx.CP.loadWindows('../../../sis_seguridad/vista/gui/Gui.php',
					'Interfaces',
					{
						width:900,
						height:400
				    },rec.data,this.idContenedor,'gui')
			
			
			
		}
		
		function sinc_func(){
			var data=this.sm.getSelected().data.id_subsistema;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				// form:this.form.getForm().getEl(),
				url:'../../sis_seguridad/control/Funcion/sincFuncion',
				params:{'id_subsistema':data},
				success:this.successSinc,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
			// _CP.loadWindows('../../../sis_legal/vista/garantia/garantia.php','Garantia',{width:800,height:500},this.sm.getSelected().data,this.idContenedor);
		}
		
		
		this.load()
	},
	expMenu : function(resp){
			var data=this.sm.getSelected().data.id_subsistema;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url:'../../sis_seguridad/control/Subsistema/ExportarDatosSeguridad',
				params:{'id_subsistema' : data, 'todo' : resp.argument.todo},
				success:this.successExport,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
			
	},
	
	successSinc:function(resp){
			
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if(!reg.ROOT.error){
				alert(reg.ROOT.detalle.mensaje)
				
			}else{
				
				alert('ocurrio un error durante el proceso')
			}
			

		

			this.reload();
			
		},
	
	
	    preparaMenu:function(tb){
			
			this.getBoton('sinc_func').enable();
			this.getBoton('aInterSis').enable();
			this.getBoton('exp_menu').enable();

			
			
			
			Phx.vista.Subsistema.superclass.preparaMenu.call(this,tb)
			return tb
		},
	   liberaMenu:function(tb){
			
			this.getBoton('sinc_func').disable();
			this.getBoton('aInterSis').disable();
			this.getBoton('exp_menu').disable();

			
			
			
			Phx.vista.Subsistema.superclass.liberaMenu.call(this,tb)
			return tb
		}

}
)
</script>