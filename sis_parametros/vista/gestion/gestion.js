<script>
Phx.vista.gestion=Ext.extend(Phx.gridInterfaz,{
	Atributos:[
	{
   	  config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_gestion'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Gestion",
			gwidth: 130,
			name: 'gestion',
			allowBlank:false,	
			maxLength:4,
			minLength:4,
			anchor:'100%'
		},
		type:'NumberField',
		filters:{type:'numeric'},
		id_grupo:0,
		grid:true,
		form:true,
		egrid:true
	},
	 {
		config:{
			fieldLabel: "Estado",
			gwidth: 130,
			name: 'estado_reg',
			allowBlank:false,	
			maxLength:150,
			
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:false
	}
	],

	title:'Gestion',
	ActSave:'../../sis_parametros/control/Gestion/guardarGestion',
	ActDel:'../../sis_parametros/control/Gestion/eliminarGestion',
	ActList:'../../sis_parametros/control/Gestion/listarGestion',
	id_store:'id_gestion',
	fields: [
	{name:'id_gestion'},
	{name:'gestion', type: 'string'},
	{name:'estado_reg', type: 'string'}
	
		],
	sortInfo:{
		field: 'id_gestion',
		direction: 'ASC'
	},
	bdel:true,// boton para eliminar
	bsave:true,// boton para eliminar


	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.gestion.superclass.preparaMenu.call(this,tb)
	},

	/*
	 * Grupos:[{
	 * 
	 * xtype:'fieldset', border: false, //title: 'Checkbox Groups', autoHeight:
	 * true, layout: 'form', items:[], id_grupo:0 }],
	 */

	constructor: function(config){
		// configuracion del data store
		
		Phx.vista.gestion.superclass.constructor.call(this,config);
		this.init();
		// this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip:
		// '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50}})
	}

}
)
</script>