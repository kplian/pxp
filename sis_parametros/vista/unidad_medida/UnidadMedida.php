<?php
/**
 *@package pXP
 *@file gen-UnidadMedida.php
 *@author  (admin)
 *@date 08-08-2012 22:49:22
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.UnidadMedida = Ext.extend(Phx.gridInterfaz, {

		constructor : function(config) {
			this.maestro = config.maestro;
			//llama al constructor de la clase padre
			Phx.vista.UnidadMedida.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50
				}
			})
		},

		Atributos : [{
			//configuracion del componente
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_unidad_medida'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'codigo',
				fieldLabel : 'Código',
				allowBlank : false,
				anchor : '100%',
				gwidth : 100,
				maxLength : 20
			},
			type : 'TextField',
			filters : {
				pfiltro : 'ume.codigo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'descripcion',
				fieldLabel : 'Descripción',
				allowBlank : true,
				anchor : '100%',
				gwidth : 100,
				maxLength : 1000
			},
			type : 'TextArea',
			filters : {
				pfiltro : 'ume.descripcion',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'tipo',
				fieldLabel : 'Magnitud',
				anchor : '90%',
				tinit : false,
				allowBlank : false,
				origen : 'CATALOGO',
				gdisplayField : 'descripcion',
				gwidth : 200,
				anchor : '100%',
				baseParams : {
					cod_subsistema : 'PARAM',
					catalogo_tipo : 'tunidad_medida'
				}
			},
			type : 'ComboRec',
			id_grupo : 0,
			filters : {
				pfiltro : 'ume.tipo',
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
				pfiltro : 'ume.estado_reg',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'usr_reg',
				fieldLabel : 'Creado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'usu1.cuenta',
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
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'ume.fecha_reg',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'usr_mod',
				fieldLabel : 'Modificado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'usu2.cuenta',
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
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'ume.fecha_mod',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}],
		title : 'Unidad de Medida',
		ActSave : '../../sis_parametros/control/UnidadMedida/insertarUnidadMedida',
		ActDel : '../../sis_parametros/control/UnidadMedida/eliminarUnidadMedida',
		ActList : '../../sis_parametros/control/UnidadMedida/listarUnidadMedida',
		id_store : 'id_unidad_medida',
		fields : [{
			name : 'id_unidad_medida',
			type : 'numeric'
		}, {
			name : 'estado_reg',
			type : 'string'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'descripcion',
			type : 'string'
		}, {
			name : 'id_usuario_reg',
			type : 'numeric'
		}, {
			name : 'fecha_reg',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s'
		}, {
			name : 'id_usuario_mod',
			type : 'numeric'
		}, {
			name : 'fecha_mod',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s'
		}, {
			name : 'usr_reg',
			type : 'string'
		}, {
			name : 'usr_mod',
			type : 'string'
		}, {
			name : 'tipo',
			type : 'string'
		}],
		sortInfo : {
			field : 'id_unidad_medida',
			direction : 'ASC'
		},
		bdel : true,
		bsave : false,
		fwidth : 420,
		fheight : 250
	})
</script>

