<?php
/**
*@package pXP
*@file ConfigAlarma.php
*@author  (fprudencio)
*@date 18-11-2011 11:59:10
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ConfigAlarma=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ConfigAlarma.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50,id_usuario:Phx.CP.config_ini.id_usuario}});
		this.iniciarEventos();
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_config_alarma'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name:'id_subsistema',
   				fieldLabel:'Sub Sistema',
   				allowBlank:false,
   				emptyText:'Sub Sistema...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_seguridad/control/Subsistema/listarSubsistema',
					id: 'id_subsistema',
					root: 'datos',
					sortInfo:{
						field: 'codigo',
						direction:'ASC'
					},
					totalProperty: 'total',
					fields: ['id_subsistema','codigo','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'subsis.codigo#subsis.nombre'}
				}),
   				valueField:'id_subsistema',
   				displayField: 'nombre',
   				gdisplayField:'desc_subsis',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p><p>Codigo:{codigo}</p> </div></tpl>',
   				hiddenName: 'id_subsistema',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:280,
   				minChars:2,
   				
   				renderer:function (value, p, record){return String.format('{0}', record.data['desc_subsis']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'subsis.codigo#subsis.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name:'codigo',
   				fieldLabel:'Codigo',
   				allowBlank:false,
   				emptyText:'Codigo...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_parametros/control/ConfigAlarma/listarAlarmaTabla',
					id: 'table_name',
					root: 'datos',
					sortInfo:{
						field: 'table_name',
						direction:'ASC'
					},
					totalProperty: 'total',
					fields: ['table_schema','table_name'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'table_name'}
				}),
   				valueField:'table_name',
   				displayField: 'table_name',
   				gdisplayField:'codigo',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Codigo:{table_name}</p><p>Esquema:{table_schema}</p> </div></tpl>',
   				hiddenName: 'codigo',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:280,
   				minChars:2,
   				
   				renderer:function (value, p, record){return String.format('{0}', record.data['codigo']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'conala.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextArea',
			filters:{pfiltro:'conala.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'dias',
				fieldLabel: 'Dias',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'conala.dias',type:'numeric'},
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
			filters:{pfiltro:'conala.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creaciÃ³n',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'conala.fecha_reg',type:'date'},
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
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'conala.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	iniciarEventos:function(){
		this.getComponente('id_subsistema').on('select',onSubsistemaSelect);
	    var cmbCodigo=this.getComponente('codigo');
	    function onSubsistemaSelect(s,r,i){
		
		cmbCodigo.store.baseParams.esquema=r.data.codigo;
         cmbCodigo.reset();
        cmbCodigo.modificado = true;
	
	     }
		
	},
	title:'Configuración de Alarmas',
	ActSave:'../../sis_parametros/control/ConfigAlarma/insertarConfigAlarma',
	ActDel:'../../sis_parametros/control/ConfigAlarma/eliminarConfigAlarma',
	ActList:'../../sis_parametros/control/ConfigAlarma/listarConfigAlarma',
	id_store:'id_config_alarma',
	fields: [
		{name:'id_config_alarma', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'dias', type: 'numeric'},
		{name:'id_subsistema', type: 'numeric'},
		{name:'desc_subsis', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'estado_reg', type: 'string'},		
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_usuario_mod', type: 'numeric'},		
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'}
	],
	sortInfo:{
		field: 'id_config_alarma',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		