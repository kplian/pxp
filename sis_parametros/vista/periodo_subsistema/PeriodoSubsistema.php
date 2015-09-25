<?php
/**
 *@package pXP
 *@file PeriodoSubsistema.php
 *@author  Ariel Ayaviri Omonte
 *@date 19-03-2013 13:58:30
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.PeriodoSubsistema = Ext.extend(Phx.gridInterfaz, {
		codSist : 'PXP',
		constructor : function(config) {
			this.maestro = config.maestro;
			this.initButtons=[this.cmbGestion];
			Phx.vista.PeriodoSubsistema.superclass.constructor.call(this, config);
			this.init();
			
			
			this.addButton('btnSwitchEstadoPeriodo', {
				text : '',
				iconCls : 'bunlock',
				disabled : true,
				handler : this.onBtnSwitchEstadoPeriodo,
				tooltip : '<b>Abrir Periodo</b>'
			});
			
			this.bloquearOrdenamientoGrid();
			this.cmbGestion.on('select', function(){
			    if(this.validarFiltros()){
	                  this.capturaFiltros();
	           }
			},this);
		
		
			//Setea el store del grid con el codigo del subsistema
			Ext.apply(this.store.baseParams,{codSist:this.codSist});
		},
		
		cmbGestion: new Ext.form.ComboBox({
				fieldLabel: 'Gestion',
				allowBlank: false,
				emptyText:'Gestion...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_parametros/control/Gestion/listarGestion',
					id: 'id_gestion',
					root: 'datos',
					sortInfo:{
						field: 'gestion',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_gestion','gestion'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'gestion'}
				}),
				valueField: 'id_gestion',
				triggerAction: 'all',
				displayField: 'gestion',
			    hiddenName: 'id_gestion',
    			mode:'remote',
				pageSize:50,
				queryDelay:500,
				listWidth:'280',
				width:80
			}),
			
		
		
		capturaFiltros:function(combo, record, index){
	        this.desbloquearOrdenamientoGrid();
	        this.store.baseParams.id_gestion=this.cmbGestion.getValue();
	        this.load(); 
	            
	        
	    },	
		
		validarFiltros:function(){
	        if(this.cmbGestion.isValid()){
	            return true;
	        }
	        else{
	            return false;
	        }
	        
	    },
	    
	    onButtonAct:function(){
	        if(!this.validarFiltros()){
	            alert('Especifique los filtros antes')
	         }
	        else{
	            this.store.baseParams.id_gestion=this.cmbGestion.getValue();
	            Phx.vista.PeriodoSubsistema.superclass.onButtonAct.call(this);
	        }
	    },
	    
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_periodo_subsistema'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_subsistema'
			},
			type : 'Field',
			grid : false
		}, {
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_periodo'
			},
			type : 'Field',
			grid : false
		}, {
			config : {
				name : 'desc_subsistema',
				fieldLabel : 'Subsistema',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 20
			},
			type : 'TextField',
			filters : {
				pfiltro : 'sis.codigo#sis.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'estado',
				fieldLabel : 'estado',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 20
			},
			type : 'TextField',
			filters : {
				pfiltro : 'pesu.estado',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'gestion',
				fieldLabel : 'Gestión',
				allowBlank : true,
				gwidth : 100,
			},
			type : 'TextField',
			filters : {
				pfiltro : 'gest.gestion',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'periodo',
				fieldLabel : 'Periodo',
				allowBlank : true,
				gwidth : 100,
			},
			type : 'TextField',
			filters : {
				pfiltro : 'peri.periodo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_ini',
				fieldLabel : 'Fecha Ini.',
				allowBlank : true,
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'peri.fecha_ini',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_fin',
				fieldLabel : 'Fecha Fin.',
				allowBlank : true,
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'peri.fecha_fin',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'estado_reg',
				fieldLabel : 'Estado Reg.',
				gwidth : 100,
				maxLength : 10
			},
			type : 'TextField',
			filters : {
				pfiltro : 'pesu.estado_reg',
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
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y H:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'pesu.fecha_reg',
				type : 'date'
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
				name : 'fecha_mod',
				fieldLabel : 'Fecha Modif.',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y H:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'pesu.fecha_mod',
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
		}],

		title : 'Periodo',
		ActSave : '../../sis_parametros/control/PeriodoSubsistema/insertarPeriodoSubsistema',
		ActDel : '../../sis_parametros/control/PeriodoSubsistema/eliminarPeriodoSubsistema',
		ActList : '../../sis_parametros/control/PeriodoSubsistema/listarPeriodoSubsistema',
		id_store : 'id_periodo_subsistema',
		fields : [{
			name : 'id_periodo_subsistema',
			type : 'numeric'
		}, {
			name : 'estado_reg',
			type : 'string'
		}, {
			name : 'id_subsistema',
			type : 'numeric'
		}, {
			name : 'id_periodo',
			type : 'numeric'
		}, {
			name : 'fecha_ini',
			type : 'date',
			dateFormat : 'Y-m-d'
		}, {
			name : 'fecha_fin',
			type : 'date',
			dateFormat : 'Y-m-d'
		}, {
			name : 'periodo',
			type : 'numeric'
		}, {
			name : 'id_gestion',
			type : 'numeric'
		}, {
			name : 'gestion',
			type : 'numeric'
		}, {
			name : 'estado',
			type : 'string'
		}, {
			name : 'fecha_reg',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'id_usuario_reg',
			type : 'numeric'
		}, {
			name : 'fecha_mod',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'id_usuario_mod',
			type : 'numeric'
		}, {
			name : 'usr_reg',
			type : 'string'
		}, {
			name : 'usr_mod',
			type : 'string'
		},
		'desc_subsistema'],
		/*sortInfo : {
			field : 'id_periodo_subsistema',
			direction : 'desc'
		},*/
		bdel : false,
		bedit : false,
		bnew : false,
		bsave : false,
		preparaMenu : function(n) {
			Phx.vista.PeriodoSubsistema.superclass.preparaMenu.call(this, n);
			var selectedRow = this.sm.getSelected();

			var btnSwitchEstado = this.getBoton('btnSwitchEstadoPeriodo');
			if (selectedRow.data.estado == 'abierto') {
				btnSwitchEstado.setIconClass('block');
				btnSwitchEstado.setTooltip('<b>Cerrar Periodo</b>');
			} else {
				console.log('entra a no abierto');
				btnSwitchEstado.setIconClass('bunlock');
				btnSwitchEstado.setTooltip('<b>Abrir Periodo</b>');
			}
			btnSwitchEstado.enable();
		},
		liberaMenu : function(n) {
			Phx.vista.PeriodoSubsistema.superclass.liberaMenu.call(this, n);
			this.getBoton('btnSwitchEstadoPeriodo').disable();
		},
		onBtnSwitchEstadoPeriodo : function() {
			var global = this;
			var rec = this.sm.getSelected();
            var data = rec.data;
            var msg = 'abrir';
			if (data.estado == 'abierto') {
				msg = 'cerrar'
			}
			
			Ext.Msg.confirm('Confirmación', '¿Está seguro de ' + msg + ' el periodo seleccionado?', function(btn) {
				if (btn == "yes") {
					global.switchEstadoPeriodo();
				}
			});
		},
		switchEstadoPeriodo : function() {
			var global = this;
			var rec = this.sm.getSelected();
            var data = rec.data;
			Ext.Ajax.request({
				url : '../../sis_parametros/control/PeriodoSubsistema/switchEstadoPeriodo',
				params : {
					id_periodo_subsistema : data.id_periodo_subsistema
				},
				success : global.successSave,
				failure : global.conexionFailure,
				timeout : global.timeout,
				scope : global
			});
		},
	loadValoresIniciales:function(){
		Phx.vista.PeriodoSubsistema.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_periodo').setValue(this.maestro.id_periodo);		
	},
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_periodo:this.maestro.id_periodo};
		this.load({params:{start:0, limit:50}})
	}
})
</script>

