<?php
/**
*@package pXP
*@file gen-DocumentoCategoriaClasificacion.php
*@author  (gsarmiento)
*@date 06-10-2014 16:00:33
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DocumentoCategoriaClasificacion=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.DocumentoCategoriaClasificacion.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_documento_categoria_clasificacion'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				name: 'id_categoria',
				fieldLabel: 'Categoria',
				allowBlank: true,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/CategoriaProveedor/listarCategoriaProveedor',
					id: 'id_categoria_proveedor',
					root: 'datos',
					sortInfo: {
						field: 'nombre_categoria',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_categoria_proveedor', 'nombre_categoria'],
					remoteSort: true,
					baseParams: {par_filtro: 'catpro.nombre_categoria'}
				}),
				valueField: 'id_categoria_proveedor',
				displayField: 'nombre_categoria',
				gdisplayField: 'nombre_categoria',
				hiddenName: 'id_categoria',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '80%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre_categoria']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'movtip.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_clasificacion',
				fieldLabel: 'Clasificacion',
				allowBlank: true,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/ClasificacionProveedor/listarClasificacionProveedor',
					id: 'id_clasificacion_proveedor',
					root: 'datos',
					sortInfo: {
						field: 'nombre_clasificacion',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_clasificacion_proveedor', 'nombre_clasificacion', 'descripcion'],
					remoteSort: true,
					baseParams: {par_filtro: 'CLAPRO.nombre_clasificacion#CLAPRO.descripcion'}
				}),
				valueField: 'id_clasificacion_proveedor',
				displayField: 'nombre_clasificacion',	//campo que se muestra al seleccionar el combo
				gdisplayField: 'nombre_clasificacion',  //campo que carga al editar el registro
				hiddenName: 'id_clasificacion',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '80%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre_clasificacion']);
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
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
				type:'TextField',
				filters:{pfiltro:'docatcla.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'documento',
				fieldLabel: 'Documento',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:45
			},
				type:'TextField',
				filters:{pfiltro:'docatcla.documento',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'presentar_legal',
				fieldLabel: 'Presentar Legal',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:25,
				typeAhead:true,
				triggerAction:'all',
				mode:'local',
				store:['si','no']
			},
			valorInicial:'no',
			type:'ComboBox',
			filters:{pfiltro:'docatcla.presentar_legal',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
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
				filters:{pfiltro:'docatcla.fecha_reg',type:'date'},
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
				filters:{pfiltro:'docatcla.usuario_ai',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'docatcla.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
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
				filters:{pfiltro:'docatcla.fecha_mod',type:'date'},
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
	title:'Documentos',
	ActSave:'../../sis_parametros/control/DocumentoCategoriaClasificacion/insertarDocumentoCategoriaClasificacion',
	ActDel:'../../sis_parametros/control/DocumentoCategoriaClasificacion/eliminarDocumentoCategoriaClasificacion',
	ActList:'../../sis_parametros/control/DocumentoCategoriaClasificacion/listarDocumentoCategoriaClasificacion',
	id_store:'id_documento_categoria_clasificacion',
	fields: [
		{name:'id_documento_categoria_clasificacion', type: 'numeric'},
		{name:'id_categoria', type: 'numeric'},
		{name:'nombre_categoria', type: 'string'},
		{name:'id_clasificacion', type: 'numeric'},
		{name:'nombre_clasificacion', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'documento', type: 'string'},
		{name:'presentar_legal', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_documento_categoria_clasificacion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		