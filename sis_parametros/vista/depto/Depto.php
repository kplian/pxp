<?php
/**
 *@package pXP
 *@file gen-Depto.php
 *@author  )
 *@date 24-11-2011 15:52:20
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.Depto = Ext.extend(Phx.gridInterfaz, {
		tipo : 'Depto',
		constructor : function(config) {
			this.maestro = config.maestro;
			//llama al constructor de la clase padre
			Phx.vista.Depto.superclass.constructor.call(this, config);

			this.init();

			//this.store.baseParams.id_depto=this.getComponente('id_depto').getValue();
			if (this.tipo == 'Depto') {
				this.load({
					params : {
						start : 0,
						limit : 50
					}
				})
			}

			this.addButton('addPlantilla', {
				text : 'addPlantilla',
				iconCls : 'bundo',
				disabled : false,
				handler : this.addPlantilla,
				tooltip : ' <b>Agrega Plantilla</b>plantilla word'
			});

		},
		/*east:{
		 url:'../../../sis_parametros/vista/depto_usuario/DeptoUsuario.php',
		 title:'Usuarios por Departamento',
		 width:400,
		 cls:'DeptoUsuario'
		 },	*/

		tabsouth : [{
			url : '../../../sis_parametros/vista/depto_usuario/DeptoUsuario.php',
			title : 'Usuarios por Departamento',
			//width:'50%',
			height : '50%',
			cls : 'DeptoUsuario'

		}, {
			url : '../../../sis_parametros/vista/depto_uo/DeptoUo.php',
			title : 'Depto - UO',
			height : '50%',
			cls : 'DeptoUo'
		}, {
			url : '../../../sis_parametros/vista/depto_ep/DeptoEp.php',
			title : 'Depto - EP',
			height : '50%',
			cls : 'DeptoEp'
		}, {
			url : '../../../sis_parametros/vista/depto_uo_ep/DeptoUoEp.php',
			title : 'Depto UO - EP',
			height : '50%',
			cls : 'DeptoUoEp'
		}, {
			url : '../../../sis_parametros/vista/firma/Firma.php',
			title : 'Firmas Documentos',
			height : '50%',
			cls : 'Firma'
		}, {
			url : '../../../sis_tesoreria/vista/depto_cuenta_bancaria/DeptoCuentaBancaria.php',
			title : 'Depto - Cuenta Bancaria',
			height : '50%',
			cls : 'DeptoCuentaBancaria'
		}, {
			url : '../../../sis_parametros/vista/depto_depto/DeptoDepto.php',
			title : 'Depto Relacionados',
			height : '50%',
			cls : 'DeptoDepto'
		}, {
			url : '../../../sis_parametros/vista/depto_var/DeptoVar.php',
			title : 'Config. Variables',
			height : '50%',
			cls : 'DeptoVar'
		}],
		Atributos : [{
			//configuracion del componente
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_depto'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'id_subsistema',
				fieldLabel : 'Subsistema',
				allowBlank : false,
				emptyText : 'Subsistema...',
				store : new Ext.data.JsonStore({

					url : '../../sis_seguridad/control/Subsistema/listarSubsistema',
					id : 'id_subsistema',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_subsistema', 'nombre'],
					// turn on remote sorting
					remoteSort : true
				}),
				valueField : 'id_subsistema',
				displayField : 'nombre',
				gdisplayField : 'desc_subsistema', //dibuja el campo extra de la consulta al hacer un inner join con orra tabla
				tpl : '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p></div></tpl>',
				hiddenName : 'id_subsistema',
				forceSelection : true,
				typeAhead : true,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 10,
				queryDelay : 1000,
				width : 250,
				gwidth : 280,
				minChars : 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_subsistema']);
				}
			},
			//type:'TrigguerCombo',
			type : 'ComboBox',
			id_grupo : 0,
			bottom_filter : true,
			filters : {
				pfiltro : 'SUBSIS.nombre',
				type : 'string'
			},

			grid : true,
			form : true
		}, {
			config : {
				name : 'estado_reg',
				fieldLabel : 'Estado Reg.',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 10
			},
			type : 'TextField',
			filters : {
				pfiltro : 'deppto.estado_reg',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'codigo',
				fieldLabel : 'Código',
				allowBlank : false,
				anchor : '80%',
				gwidth : 100,
				maxLength : 200
			},
			type : 'TextField',
			filters : {
				pfiltro : 'deppto.codigo',
				type : 'string'
			},
			id_grupo : 1,
			bottom_filter : true,
			grid : true,
			form : true
		}, {
			config : {
				name : 'nombre',
				fieldLabel : 'Nombre',
				allowBlank : false,
				anchor : '80%',
				gwidth : 100,
				maxLength : 200
			},
			type : 'TextField',
			filters : {
				pfiltro : 'deppto.nombre',
				type : 'string'
			},
			id_grupo : 1,
			bottom_filter : true,
			grid : true,
			form : true
		}, {
			config : {
				name : 'nombre_corto',
				fieldLabel : 'Nombre Corto',
				allowBlank : false,
				anchor : '80%',
				gwidth : 100,
				maxLength : 200
			},
			type : 'TextField',
			filters : {
				pfiltro : 'deppto.nombre_corto',
				type : 'string'
			},
			id_grupo : 1,
			bottom_filter : true,
			grid : true,
			form : true
		}, {
			config : {
				name : 'id_lugares',
				fieldLabel : 'Lugar',
				allowBlank : false,
				emptyText : 'Lugar...',
				store : new Ext.data.JsonStore({
					url : '../../sis_parametros/control/Lugar/listarLugar',
					id : 'id_lugar',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_lugar', 'id_lugar_fk', 'codigo', 'nombre', 'tipo', 'sw_municipio', 'sw_impuesto', 'codigo_largo'],
					// turn on remote sorting
					remoteSort : true,
					baseParams : {
						par_filtro : 'lug.nombre',
						es_regional : 'si'
					}
				}),
				valueField : 'id_lugar',
				displayField : 'nombre',
				gdisplayField : 'nombre_lugar',
				hiddenName : 'id_lugar',
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 50,
				queryDelay : 500,
				anchor : "90%",
				gwidth : 150,
				minChars : 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre_lugar']);
				},
				enableMultiSelect : true

			},
			type : 'AwesomeCombo',
			filters : {
				pfiltro : 'lug.nombre',
				type : 'string'
			},
			id_grupo : 0,
			grid : false,
			form : true
		}, {
			config : {
				name : 'prioridad',
				fieldLabel : 'Prioridad',
				allowBlank : false,
				allowDacimals : false,
				anchor : '80%',
				gwidth : 100,
				maxLength : 200
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'DEPPTO.prioridad',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'modulo',
				fieldLabel : 'Módulo',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 90
			},
			type : 'TextField',
			filters : {
				pfiltro : 'deppto.modulo',
				type : 'string'
			},
			id_grupo : 1,
			bottom_filter : true,
			grid : true,
			form : true
		}, {
			config : {
				name : 'id_entidad',
				fieldLabel : 'Entidad',
				qtip : 'entidad a la que pertenese el depto, ',
				allowBlank : false,
				emptyText : 'Entidad...',
				store : new Ext.data.JsonStore({
					url : '../../sis_parametros/control/Entidad/listarEntidad',
					id : 'id_entidad',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_entidad', 'nit', 'nombre'],
					// turn on remote sorting
					remoteSort : true,
					baseParams : {
						par_filtro : 'nit#nombre'
					}
				}),
				valueField : 'id_entidad',
				displayField : 'nombre',
				gdisplayField : 'desc_entidad',
				hiddenName : 'id_entidad',
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 50,
				queryDelay : 500,
				anchor : "90%",
				listWidth : 280,
				gwidth : 150,
				minChars : 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_entidad']);
				}
			},
			type : 'ComboBox',
			filters : {
				pfiltro : 'ENT.nombre',
				type : 'string'
			},
			id_grupo : 0,
			egrid : true,
			grid : true,
			form : true
		}, {
			config : {
				name : 'usureg',
				fieldLabel : 'Creado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'USUREG.cuenta',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_reg',
				fieldLabel : 'Fecha creación',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'deppto.fecha_reg',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'usumod',
				fieldLabel : 'Modificado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'USUMOD.cuenta',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_mod',
				fieldLabel : 'Fecha Modif.',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'deppto.fecha_mod',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}],
		title : 'Departamento',
		ActSave : '../../sis_parametros/control/Depto/insertarDepto',
		ActDel : '../../sis_parametros/control/Depto/eliminarDepto',
		ActList : '../../sis_parametros/control/Depto/listarDepto',
		id_store : 'id_depto',
		fields : [{
			name : 'id_depto',
			type : 'numeric'
		}, {
			name : 'estado_reg',
			type : 'string'
		}, {
			name : 'nombre',
			type : 'string'
		}, {
			name : 'id_usuario_reg',
			type : 'numeric'
		}, {
			name : 'fecha_reg',
			type : 'date',
			dateFormat : 'Y-m-d'
		}, {
			name : 'id_usuario_mod',
			type : 'numeric'
		}, {
			name : 'fecha_mod',
			type : 'date',
			dateFormat : 'Y-m-d'
		}, {
			name : 'usureg',
			type : 'string'
		}, {
			name : 'usumod',
			type : 'string'
		}, {
			name : 'id_subsistema',
			type : 'numeric'
		}, {
			name : 'desc_subsistema',
			type : 'string'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'nombre_corto',
			type : 'string'
		}, 'id_lugares', 'prioridad', 'modulo', 'id_entidad', 'desc_entidad'],
		sortInfo : {
			field : 'id_depto',
			direction : 'ASC'
		},
		bdel : true,
		bsave : true,

		
	})
</script>

