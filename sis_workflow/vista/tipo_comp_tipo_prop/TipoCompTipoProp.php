<?php
/**
*@package pXP
*@file gen-TipoCompTipoProp.php
*@author  (admin)
*@date 15-05-2014 20:53:23
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoCompTipoProp=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoCompTipoProp.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_comp_tipo_prop'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_componente'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				name: 'id_tipo_propiedad',
				fieldLabel: 'Tipo Propiedad',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_workflow/control/TipoPropiedad/listarTipoPropiedad',
					id: 'id_tipo_propiedad',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_propiedad', 'nombre', 'codigo', 'tipo_dato'],
					remoteSort: true,
					baseParams: {par_filtro: 'tippro.codigo#tippro.nombre'}
				}),
				valueField: 'id_tipo_propiedad',
				displayField: 'nombre',
				gdisplayField: 'desc_tipo_propiedad',
				hiddenName: 'id_tipo_propiedad',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_tipo_propiedad']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'tippro.codigo#tippro.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'obligatorio',
				fieldLabel: 'Obligatorio',
				anchor: '100%',
				tinit: true,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'obligatorio',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tgral__bandera_min'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['obligatorio']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tcotpr.obligatorio',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'tipo_dato',
				fieldLabel: 'Tipo de dato',
				anchor: '100%',
				tinit: true,z|
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'tipo_dato',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'WF',
						catalogo_tipo:'ttipo_propiedad__tipo_dato'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['tipo_dato']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tcotpr.tipo_dato',type:'string'},
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
				filters:{pfiltro:'tcotpr.estado_reg',type:'string'},
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
				filters:{pfiltro:'tcotpr.fecha_reg',type:'date'},
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
				filters:{pfiltro:'tcotpr.fecha_mod',type:'date'},
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
	tam_pag:50,	
	title:'Tipo Componente - Propiedades',
	ActSave:'../../sis_workflow/control/TipoCompTipoProp/insertarTipoCompTipoProp',
	ActDel:'../../sis_workflow/control/TipoCompTipoProp/eliminarTipoCompTipoProp',
	ActList:'../../sis_workflow/control/TipoCompTipoProp/listarTipoCompTipoProp',
	id_store:'id_tipo_comp_tipo_prop',
	fields: [
		{name:'id_tipo_comp_tipo_prop', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'obligatorio', type: 'string'},
		{name:'id_tipo_propiedad', type: 'numeric'},
		{name:'id_tipo_componente', type: 'numeric'},
		{name:'tipo_dato', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_tipo_propiedad', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_tipo_comp_tipo_prop',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	loadValoresIniciales:function(){
		Phx.vista.TipoCompTipoProp.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_tipo_componente').setValue(this.maestro.id_tipo_componente);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_tipo_componente:this.maestro.id_tipo_componente};
		this.load({params:{start:0, limit:this.tam_pag}});			
	}
}
)
</script>
		
		