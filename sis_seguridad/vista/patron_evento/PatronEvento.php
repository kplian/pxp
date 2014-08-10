<?php
/**
*@package pXP
*@file PatronEvento.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar patrones de evento
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.patron_evento=Ext.extend(Phx.gridInterfaz,{



	Atributos:[
	{
		//configuración del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_patron_evento'

		},
		type:'Field',
		form:true 
		
	},{
		config:{
			fieldLabel: "Evento",
			gwidth: 200,
			name: 'nombre_patron',
			allowBlank:false,
			
			maxLength:100,
			minLength:5,
			anchor:'80%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {config:{
	       			name:'tipo_evento',
	       			fieldLabel:'Tipo de Evento',
	       			allowBlank:false,
	       			emptyText:'Evento...',
	       			gwidth: 120,
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'tipo_evento',
	       		   // displayField: 'descestilo',
	       		    store:['ERROR_WEB','ERROR_CONTROLADO_PHP','INYECCION','SESION','ERROR_TRANSACCION_BD','ERROR_CONTROLADO_BD','ERROR_PERMISOS','ERROR_BLOQUEO','ERROR_ACCESO']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['ERROR_WEB','ERROR_CONTROLADO_PHP','INYECCION','SESION','ERROR_TRANSACCION_BD','ERROR_CONTROLADO_BD','ERROR_PERMISOS','ERROR_BLOQUEO','ERROR_ACCESO'],	
	       		 	},
	       		grid:true,
	       		form:true
	},
	 {
		config:{
				name:'aplicacion',
	       			fieldLabel:'Nivel de Aplicación',
	       			allowBlank:false,
	       			emptyText:'Aplicación...',
	       			gwidth: 110,
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'aplicacion',
	       		    // displayField: 'descestilo',
	       		    store:['usuario','ip']
	       		    //store:[['usuario','control por Usuario'],['ip','control por IP']]
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['usuario','ip']
	       		 	},
	       		grid:true,
	       		form:true
	},{
		config:{
				name:'operacion',
	       			fieldLabel:'Operación',
	       			allowBlank:false,
	       			emptyText:'Operación...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    gwidth: 100,
	       		    valueField: 'operacion',
	       		   // displayField: 'descestilo',
	       		    //store:[['bloqueo','Bloqueo Cuenta'],['notificacion','Notificacion a Admin']]
	       		    store:['bloqueo','notificacion']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['bloqueo','notificacion'],	
	       		 	},
	       		grid:true,
	       		form:true
	},{config:{
			fieldLabel: "N. Max. Intentos",
			gwidth: 100,
			name: 'cantidad_intentos',
			allowBlank:true,	
			maxLength:20,
			allowDecimals:false,
			minLength:1,
			anchor:'60%',
			allowNegative:false
		},
		type:'NumberField',
		filters:{type:'numeric'},
		id_grupo:0,
		grid:true,
		form:true},
		
		{config:{
			fieldLabel: "Periodo de Intentos(min.)",
			gwidth: 120,
			name: 'periodo_intentos',
			allowBlank:true,	
			maxLength:20,
			allowDecimals:true,
			minLength:1,
			anchor:'60%',
			allowNegative:false
		},
		type:'NumberField',
		filters:{type:'numeric'},
		id_grupo:0,
		grid:true,
		form:true},
		
		{config:{
			fieldLabel: "Tiempo de Bloqueo(min.)",
			gwidth: 120,
			name: 'tiempo_bloqueo',
			allowBlank:true,	
			maxLength:20,
			minLength:1,
			allowDecimals:true,
			anchor:'60%',
			allowNegative:false
		},
		type:'NumberField',
		filters:{type:'numeric'},
		id_grupo:0,
		grid:true,
		form:true},
		{
		config:{
			fieldLabel: "Informar a",
			gwidth: 150,
			name: 'email',
			allowBlank:true,
			
			maxLength:100,
			minLength:5,
			anchor:'80%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	}
	],



	title:'Patrones de Eventos',
	ActSave:'../../sis_seguridad/control/PatronEvento/GuardarPatronEvento',
	ActDel:'../../sis_seguridad/control/PatronEvento/EliminarPatronEvento',
	ActList:'../../sis_seguridad/control/PatronEvento/ListarPatronEvento',
	id_store:'id_patron_evento',
	fields: [
	{name:'id_patron_evento'},
	{name:'tipo_evento', type: 'string'},
	{name:'aplicacion', type: 'string'},
	{name:'operacion', type: 'string'}
	,'cantidad_intentos',
	'periodo_intentos',
	'tiempo_bloqueo',
	'email',
	'nombre_patron'
	],
	sortInfo:{
		field: 'tipo_evento',
		direction: 'ASC'
	},
	onButtonNew:function(){

		Phx.vista.patron_evento.superclass.onButtonNew.call(this);
				
	},
	/*onReloadPage:function(m){
        this.maestro=m;
        //this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);
        this.store.baseParams={};
		this.load({params:{start:0, limit:50}})
    },*/
	constructor: function(config){
		//configuraci�n del data store
		
		//console.log(config)
		
		//this.maestro=config


		Phx.vista.patron_evento.superclass.constructor.call(this,config);


		this.init();
		//this.grid.getTopToolbar().disable();
		//this.grid.getBottomToolbar().disable();
		//this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip: '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50, id_funcion: this.id_funcion}})

	},
	
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar


	//sobre carga de patron_evento
	preparaMenu:function(tb){
		//llamada patron_evento clace padre
		Phx.vista.patron_evento.superclass.preparaMenu.call(this,tb)
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