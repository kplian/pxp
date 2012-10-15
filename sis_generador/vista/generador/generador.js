<script>
/*
 * Ext JS Library 2.0.2 Copyright(c) 2006-2008, Ext JS, LLC. licensing@extjs.com
 * http://extjs.com/license autor:Jaime Rivera Rojas
 */

Phx.vista.generador=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
	this.maestro=config.maestro;
    //llama al constructor de la clase padre
	Phx.vista.generador.superclass.constructor.call(this,config);
	this.init();
	this.load({params:{start:0, limit:50}})

	
},
	Atributos:[
	       	{
	       		// configuracion del componente
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
	       			fieldLabel: "Tabla",
	       			name: 'tabla',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:false,
	       		form:true
	       	}

	       	
	       	
	       	
	       	],
	title:'Usuario',
	ActSave:'../../sis_generador/control/Generador/generarCodigo',
	ActDel:'../../sis_seguridad/control/Usuario/eliminarUsuario',
	ActList:'../../sis_seguridad/control/Usuario/listarUsuario',
	id_store:'id_usuario',
	fields: [
	{name:'id_usuario'},
	{name:'id_persona'},
	{name:'id_clasificador'},
	{name:'cuenta', type: 'string'},
	{name:'contrasena', type: 'string'},
	{name:'fecha_caducidad', mapping: 'fecha_caducidad', type: 'date', dateFormat: 'Y-m-d'},
	{name:'fecha_reg', mapping: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d'},
	{name:'desc_person', type: 'string'},
	{name:'descripcion', type: 'string'},
	{name:'estilo'}
	
		
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
		
		Phx.vista.generador.superclass.preparaMenu.call(this,tb)
	},
	liberaMenu:function(tb){

		// parece redundate es tb ********** OJO **************
				
		return Phx.vista.generador.superclass.liberaMenu.call(this,tb)
	}/*
		 * ,
		 * 
		 * //sobrecarga enable select
		 * 
		 * EnableSelect:function(sm, row, rec){
		 * 
		 * Phx.vista.generador.superclass.EnableSelect.call(this); //sobrecarga
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
		 * Phx.vista.generador.superclass.DisableSelect.call(this,sm,row,rec);
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