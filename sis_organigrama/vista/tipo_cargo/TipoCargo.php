<?php
/**
*@package pXP
*@file gen-TipoCargo.php
*@author  (rarteaga)
*@date 15-07-2019 19:39:12
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*  HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #30                15-07-2019          RAC                 creacion    

*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoCargo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoCargo.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_cargo'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
				type:'TextField',
				filters:{pfiltro:'tcar.codigo',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'tcar.nombre',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config: {
				name: 'id_escala_salarial_min',
				fieldLabel: 'Escala Salarial Mínima',
				allowBlank: false,
				tinit:true,
   			    resizable:true,
   			    tasignacion:true,
   			    tname:'id_escala_salarial',
		        tdisplayField:'nombre',   				
   				turl:'../../../sis_organigrama/vista/escala_salarial/EscalaSalarial.php',
	   			ttitle:'Escalas Salariales',
	   			tconfig:{width:'80%',height:'90%'},
	   			tdata:{},
	   			tcls:'EscalaSalarial',
	   			pid:this.idContenedor,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/EscalaSalarial/listarEscalaSalarial',
					id: 'id_escala_salarial',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_escala_salarial', 'nombre', 'codigo','haber_basico'],
					remoteSort: true,
					baseParams: {par_filtro: 'escsal.haber_basico#escsal.nombre#escsal.codigo'}
				}),
				valueField: 'id_escala_salarial',
				displayField: 'nombre',
				gdisplayField: 'desc_escmim',
				hiddenName: 'id_escala_salarial_min',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 200,
				minChars: 2,
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p><p>{codigo}</p><p>Haber Basico {haber_basico}</p> </div></tpl>',
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_escmim']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'escmin.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_escala_salarial_max',
				fieldLabel: 'Escala Salarial Máxima',
				allowBlank: false,
				tinit:true,
   			    resizable:true,
   			    tasignacion:true,
   			    tname:'id_escala_salarial',
		        tdisplayField:'nombre',   				
   				turl:'../../../sis_organigrama/vista/escala_salarial/EscalaSalarial.php',
	   			ttitle:'Escalas Salariales',
	   			tconfig:{width:'80%',height:'90%'},
	   			tdata:{},
	   			tcls:'EscalaSalarial',
	   			pid:this.idContenedor,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/EscalaSalarial/listarEscalaSalarial',
					id: 'id_escala_salarial',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_escala_salarial', 'nombre', 'codigo','haber_basico'],
					remoteSort: true,
					baseParams: {par_filtro: 'escsal.haber_basico#escsal.nombre#escsal.codigo'}
				}),
				valueField: 'id_escala_salarial',
				displayField: 'nombre',
				gdisplayField: 'desc_escmax',
				hiddenName: 'id_escala_salarial_max',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 200,
				minChars: 2,
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p><p>{codigo}</p><p>Haber Basico {haber_basico}</p> </div></tpl>',
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_escmax']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'escmax.nombre',type: 'string'},
			grid: true,
			form: true
		},
		
		{
			config:{
				name: 'factor_disp',
				fieldLabel: 'Factor Disponibilidad',
				qtip: 'Factor de disponibilidad de 0 a 1, para cálculo de bono de disponibilidad',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100			
				},
				type:'NumberField',
				filters:{pfiltro:'tcar.factor_disp',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'obs',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:400
			},
				type:'TextArea',
				filters:{pfiltro:'tcar.obs',type:'string'},
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
				filters:{pfiltro:'tcar.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'tcar.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'tcar.id_usuario_ai',type:'numeric'},
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
				filters:{pfiltro:'tcar.usuario_ai',type:'string'},
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
				filters:{pfiltro:'tcar.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Tipo Cargo',
	ActSave:'../../sis_organigrama/control/TipoCargo/insertarTipoCargo',
	ActDel:'../../sis_organigrama/control/TipoCargo/eliminarTipoCargo',
	ActList:'../../sis_organigrama/control/TipoCargo/listarTipoCargo',
	id_store:'id_tipo_cargo',
	fields: [
		{name:'id_tipo_cargo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'id_escala_salarial_min', type: 'numeric'},
		{name:'id_escala_salarial_max', type: 'numeric'},
		{name:'factor_disp', type: 'numeric'},
		{name:'obs', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_escmim','desc_escmax'
		
	],
	sortInfo:{
		field: 'id_tipo_cargo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		