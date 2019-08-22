<?php
/**
*@package pXP
*@file gen-FuncionarioCuentaBancaria.php
*@author  (admin)
*@date 20-01-2014 14:16:37
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
ISSUE	FECHA		EMPRESA		AUTOR	DETALLE
 #41	31.07.2019	etr			mzm		adicion de relacion persona_dependiente
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PersonaRelacion=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PersonaRelacion.superclass.constructor.call(this,config);
		this.init();
		
		this.load({params:{start:0, limit:this.tam_pag,id_persona_fk:this.maestro.id_persona}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_persona_relacion'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_persona_fk'
			},
			type:'Field',
			form:true 
		},
			{
	   			config:{
	       		    name:'id_persona',
	   				origen:'PERSONA',
	   				tinit:true,
	   				fieldLabel:'Nombre Dependiente',
	   				gdisplayField:'desc_person',//mapea al store del grid
	   				anchor: '100%',
	   			    gwidth:200,
		   			 renderer:function (value, p, record){return String.format('{0}', record.data['desc_person']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			bottom_filter : true,
	   			filters:{	
			        pfiltro:'PERSON.nombre_completo2',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
			},
			{
	       		config:{
	       			name:'relacion',
	       			fieldLabel:'Relacion',
	       			allowBlank:true,
	       			emptyText:'Relacion...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    store:['hijo(a)','conyuge','padre/madre','otro']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['hijo(a)','conyuge','padre/madre','otro']
	       		 	},
	       		grid:true,	       		
	       		form:true
	       	},	
		
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
				type:'TextField',
				filters:{pfiltro:'funcue.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'funcue.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'NumberField',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'funcue.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Dependientes',
	ActSave:'../../sis_seguridad/control/PersonaRelacion/insertarPersonaRelacion',
	ActDel:'../../sis_seguridad/control/PersonaRelacion/eliminarPersonaRelacion',
	ActList:'../../sis_seguridad/control/PersonaRelacion/listarPersonaRelacion',
	id_store:'id_persona_relacion',
	fields: [
		{name:'id_persona'},
	{name:'nombre', type: 'string'},
	{name:'tipo_documento', type: 'string'},
	{name:'expedicion', type: 'string'},
	{name:'ap_paterno', type: 'string'},
	{name:'ap_materno', type: 'string'},
	{name:'ci', type: 'string'},
	{name:'correo', type: 'string'},
	{name:'celular1'},
	{name:'telefono1'},
	{name:'telefono2'},
	{name:'celular2'},
	{name:'foto'}
	//30.07.2019
	,{name:'desc_person',type:'string'},
	{name:'matricula'},
	{name:'historia_clinica'},
	{name:'relacion', type: 'string'},
	{name:'id_persona_fk'},
	{name:'id_persona_relacion'}

		
	],
	sortInfo:{
		field: 'id_persona_relacion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onButtonEdit : function () {
   
    	Phx.vista.PersonaRelacion.superclass.onButtonEdit.call(this);
    	
    },
    onButtonNew : function () {
    	
    	Phx.vista.PersonaRelacion.superclass.onButtonNew.call(this);
    	
    },
    loadValoresIniciales:function()
    {	
        this.Cmp.id_persona_fk.setValue(this.maestro.id_persona);       
        Phx.vista.PersonaRelacion.superclass.loadValoresIniciales.call(this);
    }
}
)
</script>
		
		