<script>
Phx.vista.moneda=Ext.extend(Phx.gridInterfaz,{
	Atributos:[
	{
   	  config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_moneda'

		},
		type:'Field',
		form:true 
		
	},
	{
		config:{
			fieldLabel: "Codigo",
			gwidth: 130,
			name: 'codigo',
			allowBlank:false,	
			maxLength:4,
			minLength:2,
			anchor:'100%'
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
			fieldLabel: "Moneda",
			gwidth: 130,
			name: 'moneda',
			allowBlank:false,	
			maxLength:20,
			minLength:4,
			anchor:'100%'
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
			fieldLabel: "Estado",
			gwidth: 130,
			name: 'estado_reg',
			allowBlank:false,	
			maxLength:15,
			
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:false
	},{
	     config:{
	       	fieldLabel: "Fecha Registro",
	       	gwidth: 110,
	       	allowBlank:true,
	       	name:'fecha_reg',
	       	renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
	       	anchor:'70%',
	       	format:'d/m/Y'
	      },
	      type:'DateField',
	      filters:{type:'date'},
	      grid:true,
	      form:false,
	      dateFormat:'m-d-Y',
	      egrid:true
	   }
	],

	title:'Moneda',
	ActSave:'../../sis_parametros/control/Moneda/guardarMoneda',
	ActDel:'../../sis_parametros/control/Moneda/eliminarMoneda',
	ActList:'../../sis_parametros/control/Moneda/listarMoneda',
	id_store:'id_moneda',
	fields: [
	{name:'id_moneda'},
	{name:'codigo', type: 'string'},
	{name:'moneda', type: 'string'},
	{name:'estado_reg', type: 'string'}
	
		],
	sortInfo:{
		field: 'id_moneda',
		direction: 'ASC'
	},
	bdel:true,// boton para eliminar
	bsave:true,// boton para eliminar


	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.moneda.superclass.preparaMenu.call(this,tb)
	},

	/*
	 * Grupos:[{
	 * 
	 * xtype:'fieldset', border: false, //title: 'Checkbox Groups', autoHeight:
	 * true, layout: 'form', items:[], id_grupo:0 }],
	 */

	constructor: function(config){
		// configuracion del data store
		
		Phx.vista.moneda.superclass.constructor.call(this,config);
		this.init();
		// this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip:
		// '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50}})
	}

}
)
</script>