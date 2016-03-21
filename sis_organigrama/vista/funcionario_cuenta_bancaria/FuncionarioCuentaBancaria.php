<?php
/**
*@package pXP
*@file gen-FuncionarioCuentaBancaria.php
*@author  (admin)
*@date 20-01-2014 14:16:37
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FuncionarioCuentaBancaria=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.FuncionarioCuentaBancaria.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag,id_funcionario:this.maestro.id_funcionario}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_funcionario_cuenta_bancaria'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_funcionario'
			},
			type:'Field',
			form:true 
		},
		{
	   		config:{
	   				name:'id_institucion',
	   				fieldLabel: 'Institucion',
	   				anchor: '100%',
	   				tinit:true,
	   				allowBlank:true,
	   				origen:'INSTITUCION',
	   				gdisplayField:'nombre',
	   			    gwidth:200,	
	   			    baseParams: {es_banco:'si'}, 
	   			   	renderer:function (value, p, record){return String.format('{0}', record.data['nombre']);}
   			
	   			  },
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'instit.nombre',type:'string'},
   			grid:true,
   			form:true
	   	},	
		{
			config:{
				name: 'nro_cuenta',
				fieldLabel: 'Nro Cuenta',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
				type:'TextField',
				filters:{pfiltro:'funcue.nro_cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'fecha_ini',
				fieldLabel: 'Fecha Inicio',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'funcue.fecha_ini',type:'date'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'fecha_fin',
				fieldLabel: 'Fecha Fin',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'funcue.fecha_fin',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
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
	title:'Cuenta Bancaria',
	ActSave:'../../sis_organigrama/control/FuncionarioCuentaBancaria/insertarFuncionarioCuentaBancaria',
	ActDel:'../../sis_organigrama/control/FuncionarioCuentaBancaria/eliminarFuncionarioCuentaBancaria',
	ActList:'../../sis_organigrama/control/FuncionarioCuentaBancaria/listarFuncionarioCuentaBancaria',
	id_store:'id_funcionario_cuenta_bancaria',
	fields: [
		{name:'id_funcionario_cuenta_bancaria', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'id_institucion', type: 'numeric'},
		{name:'nro_cuenta', type: 'string'},
		{name:'fecha_fin', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_ini', type: 'date',dateFormat:'Y-m-d'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'nombre', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_funcionario_cuenta_bancaria',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onButtonEdit : function () {
    	this.ocultarComponente(this.Cmp.fecha_ini); 
    	Phx.vista.FuncionarioCuentaBancaria.superclass.onButtonEdit.call(this);
    	
    },
    onButtonNew : function () {
    	this.mostrarComponente(this.Cmp.fecha_ini); 
    	Phx.vista.FuncionarioCuentaBancaria.superclass.onButtonNew.call(this);
    },
    loadValoresIniciales:function()
    {	
        this.Cmp.id_funcionario.setValue(this.maestro.id_funcionario);       
        Phx.vista.FuncionarioCuentaBancaria.superclass.loadValoresIniciales.call(this);
    }
}
)
</script>
		
		