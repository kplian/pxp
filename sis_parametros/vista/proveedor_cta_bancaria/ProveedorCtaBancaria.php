<?php
/**
*@package pXP
*@file gen-ProveedorCtaBancaria.php
*@author  (gsarmiento)
*@date 30-10-2015 20:07:41
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ProveedorCtaBancaria=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ProveedorCtaBancaria.superclass.constructor.call(this,config);
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_proveedor_cta_bancaria'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nro_cuenta',
				fieldLabel: 'Nro Cuenta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
				type:'TextField',
				filters:{pfiltro:'pctaban.nro_cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'id_banco_beneficiario',
				fieldLabel: 'Banco Beneficiario',
				allowBlank: true,
				tinit:true,
				origen:'INSTITUCION',
				gdisplayField:'nombre',
				anchor: '80%',
				gwidth: 100,
				maxLength:100,
				baseParams:{es_banco:'si'},
	   			renderer:function (value, p, record){return String.format('{0}', record.data['banco_beneficiario']);}
			},
				type:'ComboRec',
				filters:{pfiltro:'pctaban.banco_beneficiario',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},		
		{
			config:{
				name: 'swift_big',
				fieldLabel: 'Swift/Big',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
				type:'TextField',
				filters:{pfiltro:'pctaban.swift_big',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'fw_aba_cta',
				fieldLabel: 'Fw/Aba/Cta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:15
			},
				type:'TextField',
				filters:{pfiltro:'pctaban.fw_aba_cta',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'banco_intermediario',
				fieldLabel: 'Banco Intermediario',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
				type:'TextField',
				filters:{pfiltro:'pctaban.banco_intermediario',type:'string'},
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
				filters:{pfiltro:'pctaban.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_proveedor'
			},
			type:'Field',
			form:true 
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
				filters:{pfiltro:'pctaban.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
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
				filters:{pfiltro:'pctaban.usuario_ai',type:'string'},
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
				filters:{pfiltro:'pctaban.fecha_reg',type:'date'},
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
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
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
				filters:{pfiltro:'pctaban.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:60,	
	title:'Proveedor Cuenta Bancaria',
	ActSave:'../../sis_parametros/control/ProveedorCtaBancaria/insertarProveedorCtaBancaria',
	ActDel:'../../sis_parametros/control/ProveedorCtaBancaria/eliminarProveedorCtaBancaria',
	ActList:'../../sis_parametros/control/ProveedorCtaBancaria/listarProveedorCtaBancaria',
	id_store:'id_proveedor_cta_bancaria',
	fields: [
		{name:'id_proveedor_cta_bancaria', type: 'numeric'},
		{name:'banco_beneficiario', type: 'string'},
		{name:'fw_aba_cta', type: 'string'},
		{name:'swift_big', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'banco_intermediario', type: 'string'},
		{name:'nro_cuenta', type: 'string'},
		{name:'id_proveedor', type: 'numeric'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_proveedor_cta_bancaria',
		direction: 'ASC'
	},
	
	onReloadPage:function(m){
        this.maestro=m;
		this.Atributos[7].valorInicial=this.maestro.id_proveedor;
        this.store.baseParams={id_proveedor:this.maestro.id_proveedor};      
        this.load({params:{start:0, limit:this.tam_pag}})
    },
	
	bdel:true,
	bsave:true
	}
)
</script>
		
		