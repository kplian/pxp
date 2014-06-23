<?php
/**
*@package pXP
*@file gen-ConceptoIngas.php
*@author  (admin)
*@date 25-02-2013 19:49:23
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ConceptoIngas=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ConceptoIngas.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_concepto_ingas'
			},
			type:'Field',
			form:true 
		},
	       	{
	       		config:{
	       			name:'movimiento',
	       			fieldLabel:'Movimiento',
	       			allowBlank:false,
	       			emptyText:'Tipo...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    gwidth: 100,
	       		    store:['ingreso','gasto']
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       		         pfiltro:'conig.movimiento',
	       				 options: ['ingreso','gasto'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
	     	{
	       		config:{
	       			name:'tipo',
	       			fieldLabel:'Tipo',
	       			allowBlank:false,
	       			emptyText:'Tipo...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'estilo',
	       		    gwidth: 100,
	       		    store:['Bien','Servicio']
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       		         pfiltro:'conig.tipo',
	       				 options: ['Bien','Servicio'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
		{
			config:{
				name: 'desc_ingas',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:500
			},
			type:'TextArea',
			filters:{pfiltro:'conig.desc_ingas',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
	
	     	{
	       		config:{
	       			name:'sw_tes',
	       			fieldLabel:'Habilitar en Tesoreria',
	       			allowBlank:false,
	       			emptyText:'Tipo...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'estilo',
	       		    gwidth: 100,
	       		    store:['si','no']
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       		         pfiltro:'conig.sw_tes',
	       				 options: ['si','no'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
	     {
			config: {
				name: 'activo_fijo',
				fieldLabel: 'Activo Fijo?',
				anchor: '100%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'activo_fijo',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tgral__bandera_min'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['activo_fijo']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'conig.activo_fijo',type:'string'},
			grid: true,
			form: true
		},  
		{
			config: {
				name: 'almacenable',
				fieldLabel: 'Almacenable?',
				anchor: '100%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'almacenable',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tgral__bandera_min'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['almacenable']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'conig.almacenable',type:'string'},
			grid: true,
			form: true
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
			filters:{pfiltro:'conig.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'conig.fecha_reg',type:'date'},
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
			filters:{pfiltro:'conig.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Conceptos de Ingreso/Gasto',
	ActSave:'../../sis_parametros/control/ConceptoIngas/insertarConceptoIngas',
	ActDel:'../../sis_parametros/control/ConceptoIngas/eliminarConceptoIngas',
	ActList:'../../sis_parametros/control/ConceptoIngas/listarConceptoIngas',
	id_store:'id_concepto_ingas',
	fields: [
		{name:'id_concepto_ingas', type: 'numeric'},
		{name:'desc_ingas', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'movimiento', type: 'string'},
		{name:'sw_tes', type: 'string'},
		{name:'id_oec', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'activo_fijo', type: 'string'},
		{name:'almacenable', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_concepto_ingas',
		direction: 'ASC'
	},
	bdel:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
	bsave:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
	bnew:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true,
	bedit:(Phx.CP.config_ini.sis_integracion=='ENDESIS')?false:true
	}
)
</script>
		
		