<?php
/**
*@package pXP
*@file gen-ColumnasArchivoExcel.php
*@author  (gsarmiento)
*@date 15-12-2016 20:46:43
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ColumnasArchivoExcel=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ColumnasArchivoExcel.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_columna_archivo_excel'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_plantilla_archivo_excel'
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'nombre_columna',
				fieldLabel: 'Nombre Columna en Excel',
				allowBlank: false,
				anchor: '80%',
				gwidth: 150,
				//fieldStyle: 'text-transform:uppercase',
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'colxls.nombre_columna',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'numero_columna',
				fieldLabel: 'Numero Columna',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'NumberField',
				filters:{pfiltro:'colxls.numero_columna',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'nombre_columna_tabla',
				fieldLabel: 'Nombre Columna en Tabla',
				allowBlank: false,
				anchor: '80%',
				gwidth: 150,
				fieldStyle: 'text-transform:lowercase',
				listeners:{
					'change': function(field, newValue, oldValue){
						field.suspendEvents(true);
						field.setValue(newValue.toLowerCase());
						field.resumeEvents(true);
					}
				},
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'colxls.nombre_columna_tabla',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tipo_valor',
				fieldLabel: 'Tipo Valor',
				//qtip: 'Marca si la columna sera leida o no sera leida',
				allowBlank: false,
				anchor: '40%',
				gwidth: 100,
				maxLength:10,
				emptyText:'Elija un tipo de valor...',
				typeAhead: true,
				triggerAction: 'all',
				lazyRender:true,
				mode: 'local',
				valueField: 'inicio',
				store:['string','date','entero','numeric']
			},
			type:'ComboBox',
			id_grupo:1,
			filters:{
				type: 'list',
				pfiltro:'colxls.tipo_valor',
				options: ['string','date','entero','numeric'],
			},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'sw_legible',
				fieldLabel: 'Sera Legible?',
				qtip: 'Marca si la columna sera leida o no sera leida',
				allowBlank: false,
				anchor: '40%',
				gwidth: 100,
				maxLength:2,
				emptyText:'si/no...',
				typeAhead: true,
				triggerAction: 'all',
				lazyRender:true,
				mode: 'local',
				valueField: 'inicio',
				store:['si','no']
			},
			type:'ComboBox',
			id_grupo:1,
			filters:{
				type: 'list',
				pfiltro:'colxls.sw_legible',
				options: ['si','no'],
			},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'punto_decimal',
				fieldLabel: 'Punto Decimal',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'formato_fecha',
				fieldLabel: 'Formato Fecha',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'anio_fecha',
				fieldLabel: 'Año de la fecha',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
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
				filters:{pfiltro:'colxls.estado_reg',type:'string'},
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
				filters:{pfiltro:'colxls.id_usuario_ai',type:'numeric'},
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
				filters:{pfiltro:'colxls.fecha_reg',type:'date'},
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
				filters:{pfiltro:'colxls.usuario_ai',type:'string'},
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
				filters:{pfiltro:'colxls.fecha_mod',type:'date'},
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
		}
	],
	tam_pag:50,	
	title:'Columnas Excel',
	ActSave:'../../sis_parametros/control/ColumnasArchivoExcel/insertarColumnasArchivoExcel',
	ActDel:'../../sis_parametros/control/ColumnasArchivoExcel/eliminarColumnasArchivoExcel',
	ActList:'../../sis_parametros/control/ColumnasArchivoExcel/listarColumnasArchivoExcel',
	id_store:'id_columna_archivo_excel',
	fields: [
		{name:'id_columna_archivo_excel', type: 'numeric'},
		{name:'id_plantilla_archivo_excel', type: 'numeric'},
		{name:'sw_legible', type: 'string'},
		{name:'formato_fecha', type: 'string'},
		{name:'numero_columna', type: 'numeric'},
		{name:'nombre_columna', type: 'string'},
		{name:'nombre_columna_tabla', type: 'string'},
		{name:'tipo_valor', type: 'string'},
		{name:'punto_decimal', type: 'string'},
		{name:'anio_fecha', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_columna_archivo_excel',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,

	loadValoresIniciales:function(){
		Phx.vista.ColumnasArchivoExcel.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_plantilla_archivo_excel').setValue(this.maestro.id_plantilla_archivo_excel);
	},

	iniciarEventos:function(){

		this.cmpTipoValor = this.getComponente('tipo_valor');
		this.cmpFormatoFecha = this.getComponente('formato_fecha');
		this.cmpAnioFecha = this.getComponente('anio_fecha');
		this.cmpPuntoDecimal = this.getComponente('punto_decimal');
		this.ocultarComponente(this.cmpFormatoFecha);
		this.ocultarComponente(this.cmpAnioFecha);
		this.ocultarComponente(this.cmpPuntoDecimal);

		this.cmpTipoValor.on('select',function(com,dat) {
			if (dat.data.field1 == 'date') {
				this.mostrarComponente(this.cmpFormatoFecha);
				this.mostrarComponente(this.cmpAnioFecha);
				this.ocultarComponente(this.cmpPuntoDecimal);
			} else if (dat.data.field1 == 'numeric') {
				this.ocultarComponente(this.cmpFormatoFecha);
				this.ocultarComponente(this.cmpAnioFecha);
				this.mostrarComponente(this.cmpPuntoDecimal);
			} else {
				this.ocultarComponente(this.cmpFormatoFecha);
				this.ocultarComponente(this.cmpAnioFecha);
				this.ocultarComponente(this.cmpPuntoDecimal);
			}
		},this);
	},

	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_plantilla_archivo_excel:this.maestro.id_plantilla_archivo_excel};
		this.load({params:{start:0, limit:this.tam_pag}});
	}
}
)
</script>
		
		