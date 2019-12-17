<?php
/**
*@package pXP
*@file gen-FuncionarioCuentaBancaria.php
*@author  (admin)
*@date 20-01-2014 14:16:37
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
ISSUE	FECHA		EMPRESA		AUTOR	DETALLE
 #41	31.07.2019	etr			mzm		adicion de relacion persona_dependiente
 #91	05.12.2019	ETR			MZM		cambio de consulta para evitar relacion con tpersona
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
		//#91
		this.load({params:{start:0, limit:this.tam_pag,id_persona:this.maestro.id_persona}})
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
					name: 'id_persona'
			},
			type:'Field',
			form:true 
		},
		{
	       		config:{
	       			fieldLabel: "Nombre",
	       			gwidth: 120,
	       			name: 'nombre',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{pfiltro:'pr.nombre',
	       				type:'string'},
	       		id_grupo:0,
	       		bottom_filter : true,
	       		grid:true,
	       		form:true
	       	},
			{ 
	       		config:{
	       			fieldLabel: "Fecha de Nacimiento",
	       			gwidth: 120,
	       			name: 'fecha_nacimiento',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			format:'d/m/Y',
	       			anchor:'100%',
	       			renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
				},
	       		type:'DateField',
	       		filters:{type:'date'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
		
			{
	       		config:{
	       			name:'relacion',
	       			fieldLabel:'Relacion',
	       			allowBlank:false,
	       			emptyText:'Relacion...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    store:['ESPOSO','ESPOSA','HIJO','HIJA','HERMANO','HERMANA','PADRE','MADRE','OTRO']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['ESPOSO','ESPOSA','HIJO','HIJA','HERMANO','HERMANA','PADRE','MADRE','OTRO']
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
	{name:'id_persona_relacion'},
	{name:'nombre', type: 'string'},
	{name:'fecha_nacimiento', type: 'date', dateFormat:'Y-m-d'},
	{name:'genero', type: 'string'},
	{name:'historia_clinica'},
	{name:'matricula'},
	{name:'relacion', type: 'string'},
	{name:'id_persona'},
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
        this.Cmp.id_persona.setValue(this.maestro.id_persona);       
        Phx.vista.PersonaRelacion.superclass.loadValoresIniciales.call(this);
    }
}
)
</script>
		
		