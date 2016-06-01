<?php
/**
*@package pXP
*@file TipoCambio.php
*@author  Gonzalo Sarmiento Sejas
*@date 08-03-2013 15:30:14
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoCambio=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoCambio.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_cambio'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'fecha',
				fieldLabel: 'Fecha',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'tcb.fecha',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'compra',
				fieldLabel: 'Compra',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179654,
				decimalPrecision:6
			},
			type:'NumberField',
			filters:{pfiltro:'tcb.compra',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'venta',
				fieldLabel: 'Venta',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179654,
				decimalPrecision:6
			},
			type:'NumberField',
			filters:{pfiltro:'tcb.venta',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'oficial',
				fieldLabel: 'Oficial',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179654,
				decimalPrecision:6
			},
			type:'NumberField',
			filters:{pfiltro:'tcb.oficial',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
   			config:{
   				name:'id_moneda',
   				fieldLabel:'Moneda',
   				allowBlank:false,
   				emptyText:'Moneda...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_parametros/control/Moneda/listarMoneda',
					id: 'id_moneda',
					root: 'datos',
					sortInfo:{
						field: 'prioridad',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_moneda','codigo','moneda'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'codigo#moneda'}
				}),
   				valueField: 'id_moneda',
   				displayField: 'moneda',
   				gdisplayField: 'moneda',
   				hiddenName: 'id_moneda',
   				forceSelection:true,
   				typeAhead: true,
       triggerAction: 'all',
       lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:300,
   				minChars:2,
   			
   				renderer:function(value, p, record){return String.format('{0}', record.data['moneda']);}

   			},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{   pfiltro:'moneda',
   						type:'string'
   					},
   			grid:true,
   			form:true
	 },
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'tcb.observaciones',type:'string'},
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
			filters:{pfiltro:'tcb.estado_reg',type:'string'},
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
			filters:{pfiltro:'tcb.fecha_reg',type:'date'},
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
			filters:{pfiltro:'tcb.fecha_mod',type:'date'},
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
	
	title:'Tipo de Cambio',
	ActSave:'../../sis_parametros/control/TipoCambio/insertarTipoCambio',
	ActDel:'../../sis_parametros/control/TipoCambio/eliminarTipoCambio',
	ActList:'../../sis_parametros/control/TipoCambio/listarTipoCambio',
	id_store:'id_tipo_cambio',
	fields: [
		{name:'id_tipo_cambio', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha', type: 'date',dateFormat:'Y-m-d'},
		{name:'observaciones', type: 'string'},
		{name:'compra', type: 'numeric'},
		{name:'venta', type: 'numeric'},
		{name:'oficial', type: 'numeric'},
		{name:'id_moneda', type: 'numeric'},
		{name:'moneda', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_tipo_cambio',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		