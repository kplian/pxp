<?php
/**
*@package pXP
*@file Regional.php
*@author KPLIAN (RCM)
*@date 14-02-2011
*@description  Vista para mostrar listado de Regionales
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.regional=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
	this.maestro=config.maestro;
    //llama al constructor de la clase padre
	Phx.vista.regional.superclass.constructor.call(this,config);
	this.init();
	this.load({params:{start:0, limit:50}})

	
},
	Atributos:[
	       	{
	       		// configuracion del componente
	       		config:{
	       			labelSeparator:'',
	       			inputType:'hidden',
	       			name: 'id_regional'

	       		},
	       		type:'Field',
	       		form:true 
	       		
	       	},
	       	{
				config:{
					fieldLabel: "Nombre",
					gwidth: 120,
					name: 'nombre',
					width:'100%',
					allowBlank:false,
					maxLength:100,
					minLength:5
				},
				type:'TextField',
				filters:{type:'string'},
				id_grupo:0,
				grid:true,
				form:true,
				egrid:true
			},

			{
				config:{
					fieldLabel: "Descripcion",
					gwidth: 400,
					width:'100%',
					name: 'descripcion',
					allowBlank:false
				},
				type:'TextArea',
				filters:{type:'string'},
				id_grupo:0,
				grid:true,
				form:true,
				egrid:true
			}
			],
			title:'Regional',
			ActSave:'../../sis_seguridad/control/Regional/guardarRegional',
			ActDel:'../../sis_seguridad/control/Regional/eliminarRegional',
			ActList:'../../sis_seguridad/control/Regional/listarRegional',
			id_store:'id_regional',
			fields: [
			{name:'id_regional'},
			{name:'nombre', type: 'string'},
			{name:'descripcion', type: 'string'}
			],
			sortInfo:{
				field: 'nombre',
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
	bsave:true,// boton para eliminar
			
	// sobre carga de funcion
	preparaMenu:function(tb){
		
		Phx.vista.regional.superclass.preparaMenu.call(this,tb)
	},
	liberaMenu:function(tb){

		// parece redundate es tb ********** OJO **************
				
		return Phx.vista.regional.superclass.liberaMenu.call(this,tb)
	}/*
		 * ,
		 * 
		 * //sobrecarga enable select
		 * 
		 * EnableSelect:function(sm, row, rec){
		 * 
		 * Phx.vista.regional.superclass.EnableSelect.call(this); //sobrecarga
		 * enable select
		 * _CP.getPagina(this.idContenedor+'-south').onReloadPage(this.sm.getSelected().data);
		 * //recupera la p�gina hijo
		 * _CP.getPagina(this.idContenedor+'-south').liberaMenu()
		 * _CP.getPagina(this.idContenedor+'-south').grid.getBottomToolbar().enable();
		 * 
		 * _CP.getPagina(this.idContenedor+'-west').onReloadPage(this.sm.getSelected().data);
		 * //recupera la p�gina hijo
		 * _CP.getPagina(this.idContenedor+'-west').liberaMenu()
		 * _CP.getPagina(this.idContenedor+'-west').grid.getBottomToolbar().enable();
		 *  }, DisableSelect:function(sm,row,rec){
		 * 
		 * Phx.vista.regional.superclass.DisableSelect.call(this,sm,row,rec);
		 * //sobrecarga disable select
		 * 
		 * _CP.getPagina(this.idContenedor+'-south').grid.getTopToolbar().disable();
		 * _CP.getPagina(this.idContenedor+'-south').store.removeAll();
		 * _CP.getPagina(this.idContenedor+'-south').grid.getBottomToolbar().disable();
		 * 
		 * _CP.getPagina(this.idContenedor+'-west').grid.getTopToolbar().disable();
		 * _CP.getPagina(this.idContenedor+'-west').store.removeAll();
		 * _CP.getPagina(this.idContenedor+'-west').grid.getBottomToolbar().disable();
		 *  }
		 */

})
</script>