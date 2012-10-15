<script>
Phx.vista.periodo=Ext.extend(Phx.gridInterfaz,{
	Atributos:[
	{
   	  config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_periodo'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Periodo",
			gwidth: 130,
			name: 'periodo',
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

	title:'Periodo',
	ActSave:'../../sis_parametros/control/Periodo/guardarPeriodo',
	ActDel:'../../sis_parametros/control/Periodo/eliminarPeriodo',
	ActList:'../../sis_parametros/control/Periodo/listarPeriodo',
	id_store:'id_periodo',
	fields: [
	{name:'id_periodo'},
	{name:'periodo', type: 'string'},
	{name:'estado_reg', type: 'string'},
	{name:'id_gestion'},
	{name:'gestion', type: 'string'}
	
		],
	sortInfo:{
		field: 'id_periodo',
		direction: 'ASC'
	},
	bdel:true,// boton para eliminar
	bsave:true,// boton para eliminar


	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.periodo.superclass.preparaMenu.call(this,tb)
	},

	/*
	 * Grupos:[{
	 * 
	 * xtype:'fieldset', border: false, //title: 'Checkbox Groups', autoHeight:
	 * true, layout: 'form', items:[], id_grupo:0 }],
	 */

	constructor: function(config){
		// configuracion del data store
		
		Phx.vista.periodo.superclass.constructor.call(this,config);
		this.init();
		// this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip:
		// '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50}})
	}

}
)
</script>