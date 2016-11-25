<?php
/**
*@package pXP
*@file gen-DeptoVar.php
*@author  (admin)
*@date 22-11-2016 20:17:52
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DeptoVar=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.DeptoVar.superclass.constructor.call(this,config);
		this.init();
		this.bloquearMenus();
		if(Phx.CP.getPagina(this.idContenedorPadre)){
      	 var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
	 	 if(dataMaestro){ 
	 	 	this.onEnablePanel(this,dataMaestro)
	 	 }
	    }
	    this.iniciarEventos();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_depto_var'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_depto'
			},
			type:'Field',
			form:true 
		},
		
		{
			config: {
				name: 'id_subsistema_var',
				fieldLabel: 'Variable',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/SubsistemaVar/listarSubsistemaVar',
					id: 'id_subsistema_var',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_subsistema_var', 'nombre', 'codigo','descripcion','valor_def'],
					remoteSort: true,
					baseParams: {par_filtro: 'nombre#codigo'}
				}),
				valueField: 'id_subsistema_var',
				displayField: 'nombre',
				gdisplayField: 'desc_subsistema_var',
				hiddenName: 'id_subsistema_var',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 300,
				minChars: 2,
				tpl : '<tpl for="."><div class="x-combo-list-item"><p>({codigo}) - {nombre}</p><p>{descripcion}</p></div></tpl>',
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_subsistema_var']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'movtip.nombre',type: 'string'},
			grid: true,
			form: true
		},
		
		{
			config:{
				name: 'valor',
				fieldLabel: 'valor',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'deva.valor',type:'string'},
			id_grupo:1,
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
				filters:{pfiltro:'deva.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: '',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'deva.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
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
				type:'Field',
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
				filters:{pfiltro:'deva.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'deva.usuario_ai',type:'string'},
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
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
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
				filters:{pfiltro:'deva.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Variables',
	ActSave:'../../sis_parametros/control/DeptoVar/insertarDeptoVar',
	ActDel:'../../sis_parametros/control/DeptoVar/eliminarDeptoVar',
	ActList:'../../sis_parametros/control/DeptoVar/listarDeptoVar',
	id_store:'id_depto_var',
	fields: [
		{name:'id_depto_var', type: 'numeric'},
		{name:'valor', type: 'string'},
		{name:'id_depto', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_subsistema_var', type: 'numeric'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_subsistema_var'
		
	],
	iniciarEventos: function(){
	    this.Cmp.id_subsistema_var.on('select', function( cmb, rec, ind ){
	    	  this.Cmp.valor.setValue(rec.data.valor_def);	    	
	    },this)	
	},
	sortInfo:{
		field: 'id_depto_var',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams = { id_depto:this.maestro.id_depto };
		this.Cmp.id_subsistema_var.store.baseParams = { id_subsistema: this.maestro.id_subsistema};
		this.Cmp.id_subsistema_var.modificado = true;
		this.load({params:{start:0, limit:50}});
		
	},
	loadValoresIniciales:function(){
		Phx.vista.DeptoVar.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_depto').setValue(this.maestro.id_depto);		
	},
})
</script>
		
		