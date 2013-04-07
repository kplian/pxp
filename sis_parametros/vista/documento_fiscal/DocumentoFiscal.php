<?php
/**
*@package pXP
*@file gen-DocumentoFiscal.php
*@author  (admin)
*@date 03-04-2013 15:48:47
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DocumentoFiscal=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.DocumentoFiscal.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
		
		//Eventos
		this.getComponente('nit').on('blur',this.cargarRazonSocial,this);

	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_documento_fiscal'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_plantilla',
				fieldLabel: 'Tipo Documento',
				allowBlank: false,
				emptyText:'Elija una plantilla...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_parametros/control/Plantilla/listarPlantilla',
					id: 'id_plantilla',
					root:'datos',
					sortInfo:{
						field:'desc_plantilla',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_plantilla','nro_linea','desc_plantilla','tipo','sw_tesoro', 'sw_compro'],
					remoteSort: true,
					baseParams:{par_filtro:'plt.desc_plantilla'}
				}),
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Nro.Linea: {nro_linea}</p><p>Tipo Documento: {desc_plantilla}</p></div></tpl>',
				valueField: 'id_plantilla',
				hiddenValue: 'id_plantilla',
				displayField: 'desc_plantilla',
				gdisplayField:'desc_plantilla',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth: 250,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_plantilla']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'pla.desc_plantilla',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nit',
				fieldLabel: 'NIT',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'docfis.nit',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'razon_social',
				fieldLabel: 'Razón Social',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:150
			},
			type:'TextField',
			filters:{pfiltro:'docfis.razon_social',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_doc',
				fieldLabel: 'Fecha Documento',
				allowBlank: false,
				gwidth: 100,
				format: 'd/m/Y', 
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'docfis.fecha_doc',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nro_documento',
				fieldLabel: 'Nro.Documento',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'NumberField',
			filters:{pfiltro:'docfis.nro_documento',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nro_autorizacion',
				fieldLabel: 'Nro.Autorizacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'docfis.nro_autorizacion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo_control',
				fieldLabel: 'Código de Control',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:8,
				minLength:6,
				vtype:'hex'
			},
			type:'TextField',
			filters:{pfiltro:'docfis.codigo_control',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'estado',
				fieldLabel: 'Estado',
				anchor: '100%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 200,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tdocumento_fiscal__estado'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['estado']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'docfis.estado',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'formulario',
				fieldLabel: 'Formulario',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'docfis.formulario',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tipo_retencion',
				fieldLabel: 'Tipo de Retención',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'docfis.tipo_retencion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'dui',
				fieldLabel: 'DUI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'docfis.dui',type:'string'},
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
			filters:{pfiltro:'docfis.estado_reg',type:'string'},
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
			filters:{pfiltro:'docfis.fecha_reg',type:'date'},
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
			filters:{pfiltro:'docfis.fecha_mod',type:'date'},
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
	
	title:'Documentos Fiscales',
	ActSave:'../../sis_parametros/control/DocumentoFiscal/insertarDocumentoFiscal',
	ActDel:'../../sis_parametros/control/DocumentoFiscal/eliminarDocumentoFiscal',
	ActList:'../../sis_parametros/control/DocumentoFiscal/listarDocumentoFiscal',
	id_store:'id_documento_fiscal',
	fields: [
		{name:'id_documento_fiscal', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nro_documento', type: 'numeric'},
		{name:'razon_social', type: 'string'},
		{name:'nro_autorizacion', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'nit', type: 'string'},
		{name:'codigo_control', type: 'string'},
		{name:'formulario', type: 'string'},
		{name:'tipo_retencion', type: 'string'},
		{name:'id_plantilla', type: 'numeric'},
		{name:'fecha_doc', type: 'date',dateFormat:'Y-m-d'},
		{name:'dui', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_plantilla',type: 'string'}
		
	],
	sortInfo:{
		field: 'id_documento_fiscal',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	cargarRazonSocial: function(obj){
		//Busca en la base de datos la razon social en función del NIT digitado. Si Razon social no esta vacío, entonces no hace nada
		if(this.getComponente('razon_social').getValue()==''){
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url:'../../sis_parametros/control/DocumentoFiscal/obtenerRazonSocialxNIT',
				params:{'nit': this.getComponente('nit').getValue()},
				success: function(resp){
					Phx.CP.loadingHide();
			        var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			        console.log(objRes);
			        var razonSocial=objRes.ROOT.datos.razon_social;
			        this.getComponente('razon_social').setValue(razonSocial);
				},
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope:this
			});
		}
	}
})
</script>
		
		