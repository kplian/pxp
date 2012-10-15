<script>
/*
* Ext JS Library 2.0.2
* Copyright(c) 2006-2008, Ext JS, LLC.
* licensing@extjs.com
* http://extjs.com/license
*/

Phx.vista.columna=function(config){

var FormatoVista=function (value,p,record){return value?value.dateFormat('d/m/Y'):''}

	this.Atributos=[
	{
		//configuracion del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_columna'

		},
		type:'Field',
		form:true 
		
	},{
		//configuracion del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_tabla'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Nombre",
			gwidth: 100,
			name: 'nombre',
			allowBlank:false,	
			maxLength:100,
			minLength:1,
			anchor:'100%'
			
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:false
	},
	 {
		config:{
			fieldLabel: "Descripcion",
			gwidth: 100,
			name: 'descripcion',
			allowBlank:true,	
			maxLength:500,
			minLength:1,
			anchor:'100%'
			
		},
		type:'TextArea',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		egrid:false,
		form:false
	},
	 {
		config:{
			fieldLabel: "Etiqueta",
			gwidth: 100,
			name: 'etiqueta',
			allowBlank:false,	
			maxLength:500,
			minLength:1,
			anchor:'100%'
			
		},
		type:'TextArea',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		egrid:true,
		form:true
	},
	{
	       		config:{
	       			name:'guardar',
	       			fieldLabel:'Guardar',
	       			allowBlank:false,
	       			emptyText:'Guardar...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'guardar',
	       		   // displayField: 'descestilo',
	       		    store:['si','no']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 dataIndex: 'guardar',
	       				 options: ['si','no'],	
	       		 	},
	       		grid:true,
	       		egrid:true,
	       		form:true
	 },
	 {
			config:{
				fieldLabel: "Tipo Dato",
				gwidth: 100,
				name: 'tipo_dato',
				allowBlank:false,	
				anchor:'100%'
				
			},
			type:'Field',
			filters:{type:'string'},
			id_grupo:0,
			grid:true,
			egrid:false,
			form:false
		},
		 {
			config:{
				fieldLabel: "Longitud",
				gwidth: 100,
				name: 'longitud',
				anchor:'100%'
				
			},
			type:'Field',
			filters:{type:'string'},
			id_grupo:0,
			grid:true,
			egrid:false,
			form:false
		},
		 {
			config:{
				fieldLabel: "Nulo",
				gwidth: 100,
				name: 'nulo',
				allowBlank:false,	
				anchor:'100%'
				
			},
			type:'Field',
			filters:{type:'string'},
			id_grupo:0,
			grid:true,
			egrid:false,
			form:false
		},
		 {
			config:{
				fieldLabel: "Constraints",
				gwidth: 100,
				name: 'checks',
				allowBlank:false,	
				anchor:'100%'
				
			},
			type:'Field',
			filters:{type:'string'},
			id_grupo:0,
			grid:true,
			egrid:false,
			form:false
		},
		 {
			config:{
				fieldLabel: "Valor Defecto",
				gwidth: 100,
				name: 'valor_defecto',
				allowBlank:false,	
				anchor:'100%'
				
			},
			type:'Field',
			filters:{type:'string'},
			id_grupo:0,
			grid:true,
			egrid:false,
			form:false
		},
		 {
			config:{
				fieldLabel: "Grid Ancho",
				gwidth: 100,
				name: 'grid_ancho',
				allowBlank:true,	
				maxLength:100,
				minLength:1,
				anchor:'100%'
				
			},
			type:'NumberField',
			filters:{type:'numeric'},
			id_grupo:0,
			grid:true,
			egrid:true,
			form:true
		},
		{
       		config:{
       			name:'grid_mostrar',
       			fieldLabel:'Grid Mostrar',
       			allowBlank:true,
       			emptyText:'Mostrar...',
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    valueField: 'grid_mostrar',
       		   // displayField: 'descestilo',
       		    store:['si','no']
       		    
       		},
       		type:'ComboBox',
       		id_grupo:0,
       		filters:{	
       		         type: 'list',
       				 dataIndex: 'grid_mostrar',
       				 options: ['si','no'],	
       		 	},
       		grid:true,
       		egrid:true,
       		form:true
		},
		 {
			config:{
				fieldLabel: "Form Ancho(%)",
				gwidth: 100,
				name: 'form_ancho_porcen',
				allowBlank:true,
				maxLength:100,
				minLength:1,
				anchor:'100%'
			},
			type:'NumberField',
			filters:{type:'numeric'},
			id_grupo:0,
			grid:true,
			egrid:true,
			form:true
		},
		 {
			config:{
				fieldLabel: "Orden",
				gwidth: 100,
				name: 'orden',
				allowBlank:true,	
				maxLength:100,
				minLength:1,
				anchor:'100%'
				
			},
			type:'NumberField',
			filters:{type:'numeric'},
			id_grupo:0,
			grid:true,
			egrid:true,
			form:true
		},
		 {
			config:{
				fieldLabel: "Grupo",
				gwidth: 100,
				name: 'grupo',
				allowBlank:true,	
				maxLength:100,
				minLength:1,
				anchor:'100%'
				
			},
			type:'NumberField',
			filters:{type:'numeric'},
			id_grupo:0,
			grid:true,
			egrid:true,
			form:true
		}
	];

	Phx.vista.columna.superclass.constructor.call(this,config);
	this.init();
	
}

Ext.extend(Phx.vista.columna,Phx.gridInterfaz,{
	title:'Columnas',
	ActSave:'../../sis_generador/control/Columna/guardarColumna',
	ActDel:'../../sis_generador/control/Columna/eliminarColumna',
	ActList:'../../sis_generador/control/Columna/listarColumna',
	id_store:'id_columna',
	fields: [
	'id_columna',
	'id_tabla',
	'nombre',
	'descripcion',
	'etiqueta',
	'guardar',
	'tipo_dato',
	'longitud',
	'nulo',
	'checks',
	'valor_defecto',
	'grid_ancho',
	'grid_mostrar',
	'form_ancho_porcen',
	'orden',
	'grupo'
	],
	sortInfo:{
		field: 'id_columna',
		direction: 'ASC'
	},
	bnew:false,
	bdel:true,//boton para eliminar
	bsave:true,//boton para eliminar
	bedit:false,//boton para editar
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.columna.superclass.preparaMenu.call(this,tb)
	},
    onButtonNew:function(){
		Phx.vista.columna.superclass.onButtonNew.call(this);
		this.getComponente('id_tabla').setValue(this.maestro.id_tabla);
	},
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_tabla:this.maestro.id_tabla};
		this.load({params:{start:0, limit:50}})
	}
})
</script>