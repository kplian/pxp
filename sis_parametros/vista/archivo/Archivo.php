<?php
/**
*@package pXP
*@file gen-Archivo.php
*@author  (admin)
*@date 05-12-2016 15:04:48
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Archivo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Archivo.superclass.constructor.call(this,config);

		this.addButton('Subir Archivo', {
			argument: {imprimir: 'Subir Archivo'},
			text: '<i class="fa fa-thumbs-o-up fa-2x"></i> Subir Archivo', /*iconCls:'' ,*/
			disabled: false,
			handler: this.subirArchivo
		});

		this.addButton('Subir Archivos', {
			argument: {imprimir: 'Subir Archivos'},
			text: '<i class="fa fa-thumbs-o-up fa-2x"></i> Subir Archivos', /*iconCls:'' ,*/
			disabled: false,
			handler: this.subirArchivos
		});


		this.grid.addListener('cellclick', this.oncellclick,this);

		this.id_ = config.datos_extras_id;
		this.tabla_ = config.datos_extras_tabla;
		this.codigo_ = config.datos_extras_codigo;

		this.init();
		this.load({params:{start:0, limit:this.tam_pag,tabla:this.tabla_,id_tabla:this.id_}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_archivo'
			},
			type:'Field',
			form:true 
		},


		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'tipar.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tabla',
				fieldLabel: 'tabla',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'arch.tabla',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},

		{
			config:{
				fieldLabel: "Subir",
				gwidth: 65,
				inputType:'file',
				name: 'upload',
				buttonText: '',
				maxLength:150,
				anchor:'100%',
				renderer:function (value, p, record){

						if(record.data.extension!='') {
							return  String.format('{0}',"<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Reemplazar Archivo' src = '../../../lib/imagenes/icono_awesome/awe_upload.png' align='center' width='30' height='30'></div>");
						} else {
							return  String.format('{0}',"<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Subir Archivo' src = '../../../lib/imagenes/icono_awesome/awe_upload.png' align='center' width='30' height='30'></div>");
						}

				},

			},
			type:'Field',
			sortable:false,
			id_grupo:0,
			grid:true,
			form:false
		},

		{
			config:{
				name: 'folder',
				fieldLabel: 'folder',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
				type:'TextField',
				filters:{pfiltro:'arch.folder',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'extension',
				fieldLabel: 'extension',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
				type:'TextField',
				filters:{pfiltro:'arch.extension',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'id_tabla',
				fieldLabel: 'id_tabla',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'arch.id_tabla',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},

		{
			config:{
				name: 'nombre_archivo',
				fieldLabel: 'nombre_archivo',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
				type:'TextField',
				filters:{pfiltro:'arch.nombre_archivo',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config: {
				name: 'id_tipo_archivo',
				fieldLabel: 'id_tipo_archivo',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_/control/Clase/Metodo',
					id: 'id_',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_', 'nombre', 'codigo'],
					remoteSort: true,
					baseParams: {par_filtro: 'movtip.nombre#movtip.codigo'}
				}),
				valueField: 'id_',
				displayField: 'nombre',
				gdisplayField: 'desc_',
				hiddenName: 'id_tipo_archivo',
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
					return String.format('{0}', record.data['desc_']);
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'arch.fecha_reg',type:'date'},
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
				filters:{pfiltro:'arch.usuario_ai',type:'string'},
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
				name: 'id_usuario_ai',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'arch.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
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
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'arch.estado_reg',type:'string'},
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
				filters:{pfiltro:'arch.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Archivo',
	ActSave:'../../sis_parametros/control/Archivo/insertarArchivo',
	ActDel:'../../sis_parametros/control/Archivo/eliminarArchivo',
	ActList:'../../sis_parametros/control/Archivo/listarArchivoCodigo',
	id_store:'id_archivo',
	fields: [
		{name:'id_archivo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'folder', type: 'string'},
		{name:'extension', type: 'string'},
		{name:'id_tabla', type: 'numeric'},
		{name:'nombre_archivo', type: 'string'},
		{name:'id_tipo_archivo', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'tabla', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'codigo', type: 'string'},

	],
	sortInfo:{
		field: 'id_tipo_archivo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,

	subirArchivo: function (record) {

		var rec = {
			datos_extras_id:this.id_,
			datos_extras_tabla:this.tabla_,
			datos_extras_id_tipo_archivo:record.data.id_tipo_archivo,

		};

		Phx.CP.loadWindows('../../../sis_parametros/vista/archivo/upload.php',
			'Interfaces',
			{
				width: 900,
				height: 400
			}, rec, this.idContenedor, 'subirArchivo');


	},
	subirArchivos: function () {
		var rec = {
			datos_extras_id:this.id_,
			datos_extras_tabla:this.tabla_
		};
		Phx.CP.loadWindows('../../../sis_parametros/vista/archivo/subirArchivoMultiple.php',
			'Interfaces',
			{
				width: 900,
				height: 400
			}, rec, this.idContenedor, 'subirArchivoMultiple');


	},

	oncellclick : function(grid, rowIndex, columnIndex, e) {

		var record = this.store.getAt(rowIndex),
			fieldName = grid.getColumnModel().getDataIndex(columnIndex); // Get field name

		console.log('record seleccionado ',record);

		if (fieldName == 'nro_tramite_ori' && record.data.id_proceso_wf_ori) {
			//open documentos de origen
			this.loadCheckDocumentosSolWf(record);
		} else if (fieldName == 'upload') {
			//if (record.data.solo_lectura == 'no' &&  !record.data.id_proceso_wf_ori) {
				this.subirArchivo(record);
			//}
		} else if(fieldName == 'modificar') {
			if(record.data['modificar'] == 'si'){

				this.cambiarMomentoClick(record);

			}
		}



	},


	east:{
		url:'../../../sis_parametros/vista/archivo/ArchivoHistorico.php',
		title:'ArchivoHistorico',
		width:300,
		cls:'ArchivoHistorico'
	},



	}
)
</script>
		
		