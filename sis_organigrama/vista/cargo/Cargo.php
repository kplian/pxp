<?php
/**
*@package pXP
*@file gen-Cargo.php
*@author  (admin)
*@date 14-01-2014 19:16:06
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Cargo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		
		this.maestro=config;
		//llama al constructor de la clase padre
		Phx.vista.Cargo.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();
		this.addButton('btnCostos',
            {
                text: 'Centros de Costo',
                iconCls: 'blist',
                disabled: true,
                handler: this.onBtnCostos,
                tooltip: 'Centros de Costo asociados al cargo'
            }
        );
        this.store.baseParams.id_uo = this.maestro.id_uo;
        if (this.maestro.fecha) {
        	this.store.baseParams.fecha = this.maestro.fecha;
        } 
        if (this.maestro.tipo) {
        	this.store.baseParams.tipo = this.maestro.tipo;
        }       
		this.load({params:{start:0, limit:50}});		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_cargo'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uo'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					fieldLabel: 'Identificador',	
					name: 'identificador'
			},
			type:'Field',
			form:false,
			filters:{pfiltro:'cargo.id_cargo',type:'numeric'},
			grid:true 
		},
		{
			config:{
				name: 'acefalo',
				fieldLabel: 'ACEFALO',				
				gwidth: 90,
				renderer: function(value, p, record) {
					if (record.data['acefalo'] == 'ACEFALO') {
						return String.format('{0}', '<font color="green">ACEFALO</font>');	
					}					
				}
			},
				type:'TextField',				
				grid:true,
				form:false			 
		},
		{
			config: {
				name: 'id_tipo_contrato',
				fieldLabel: 'Tipo Contrato',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/TipoContrato/listarTipoContrato',
					id: 'id_tipo_contrato',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_contrato', 'nombre', 'codigo'],
					remoteSort: true,
					baseParams: {par_filtro: 'tipcon.nombre#tipcon.codigo'}
				}),
				valueField: 'id_tipo_contrato',
				displayField: 'nombre',
				gdisplayField: 'nombre_tipo_contrato',
				hiddenName: 'id_tipo_contrato',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 120,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre_tipo_contrato']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'tipcon.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'id_oficina',
				fieldLabel: 'Oficina',
				allowBlank: false,
				emptyText:'Oficina...',
				tinit:true,
   			    resizable:true,
   			    tasignacion:true,
   			    tname:'id_oficina',
		        tdisplayField:'nombre',   				
   				turl:'../../../sis_organigrama/vista/oficina/Oficina.php',
	   			ttitle:'Oficinas',
	   			tconfig:{width:'80%',height:'90%'},
	   			tdata:{},
	   			tcls:'Oficina',
	   			pid:this.idContenedor,
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_organigrama/control/Oficina/listarOficina',
					id: 'id_oficina',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_oficina','nombre','codigo','nombre_lugar'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'ofi.nombre,ofi.codigo,lug.nombre'}
				}),
				valueField: 'id_oficina',
				displayField: 'nombre',
				gdisplayField:'nombre_oficina',
				hiddenName: 'id_oficina',
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				anchor:"100%",
				gwidth:150,
				minChars:2,
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo}</p><p>{nombre}</p><p>{nombre_lugar}</p> </div></tpl>',
				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_oficina']);}
			},
			type:'TrigguerCombo',
			filters:{pfiltro:'ofi.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'nombre',
				fieldLabel: 'Nombre Cargo',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/TemporalCargo/listarTemporalCargo',
					id: 'id_temporal_cargo',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_temporal_cargo', 'nombre'],
					remoteSort: true,
					baseParams: {par_filtro: 'cargo.nombre'}
				}),
				valueField: 'nombre',
				displayField: 'nombre',
				gdisplayField: 'nombre',
				hiddenName: 'nombre',
				forceSelection: false,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 200,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'tcargo.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_escala_salarial',
				fieldLabel: 'Escala Salarial',
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
				gdisplayField: 'nombre_escala',
				hiddenName: 'id_escala_salarial',
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
					return String.format('{0}', record.data['nombre_escala']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'escsal.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Item/contrato',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'cargo.codigo',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},		
		{
			config:{
				name: 'fecha_ini',
				fieldLabel: 'Habilitado Desde',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'cargo.fecha_ini',type:'date'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'fecha_fin',
				fieldLabel: 'Habilitado Hasta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'cargo.fecha_fin',type:'date'},
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
				filters:{pfiltro:'cargo.estado_reg',type:'string'},
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
				filters:{pfiltro:'cargo.fecha_reg',type:'date'},
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
				filters:{pfiltro:'cargo.fecha_mod',type:'date'},
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
	title:'Cargo',
	ActSave:'../../sis_organigrama/control/Cargo/insertarCargo',
	ActDel:'../../sis_organigrama/control/Cargo/eliminarCargo',
	ActList:'../../sis_organigrama/control/Cargo/listarCargo',
	id_store:'id_cargo',
	fields: [
		{name:'id_cargo', type: 'numeric'},
		{name:'id_uo', type: 'numeric'},
		{name:'id_tipo_contrato', type: 'numeric'},
		{name:'id_lugar', type: 'numeric'},
		{name:'id_oficina', type: 'numeric'},
		{name:'id_temporal_cargo', type: 'numeric'},
		{name:'id_escala_salarial', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'nombre_tipo_contrato', type: 'string'},
		{name:'codigo_tipo_contrato', type: 'string'},
		{name:'nombre_escala', type: 'string'},
		{name:'nombre_oficina', type: 'string'},
		{name:'fecha_ini', type: 'date',dateFormat:'Y-m-d'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_fin', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'acefalo', type: 'string'},
		{name:'identificador', type: 'numeric'},
		
	],
	sortInfo:{
		field: 'id_cargo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	iniciarEventos : function() {
		//inicio de eventos 
        this.Cmp.id_tipo_contrato.on('select',function(x,rec,z){
        	
        	if (rec.data.codigo == 'PLA') {
        		this.ocultarComponente(this.Cmp.fecha_fin);
        		this.Cmp.fecha_fin.allowBlank = true;
        	} else {
        		this.mostrarComponente(this.Cmp.fecha_fin);
        		this.Cmp.fecha_fin.allowBlank = false;
        	}
             
        },this);	
	},
	loadValoresIniciales:function()
    {	
        this.Cmp.id_uo.setValue(this.maestro.id_uo);       
        Phx.vista.Cargo.superclass.loadValoresIniciales.call(this);
    },
    preparaMenu:function()
    {	
        this.getBoton('btnCostos').enable();      
        Phx.vista.Cargo.superclass.preparaMenu.call(this);
    },
    liberaMenu:function()
    {	
        this.getBoton('btnCostos').disable();       
        Phx.vista.Cargo.superclass.liberaMenu.call(this);
    },
    
    onButtonEdit : function () {
    	//this.ocultarComponente(this.Cmp.id_escala_salarial);
    	this.ocultarComponente(this.Cmp.id_tipo_contrato);
    	
    	Phx.vista.Cargo.superclass.onButtonEdit.call(this);
    },
    onButtonNew : function () {
    	this.mostrarComponente(this.Cmp.id_escala_salarial);
    	this.mostrarComponente(this.Cmp.id_tipo_contrato);
    	Phx.vista.Cargo.superclass.onButtonNew.call(this);
    },
    south:{
		  url:'../../../sis_organigrama/vista/cargo_presupuesto/CargoPresupuesto.php',
		  title:'Asignación de Presupuesto por Cargo', 
		  height:'50%',
		  cls:'CargoPresupuesto'
	},onBtnCostos: function(){
			var rec = {maestro: this.sm.getSelected().data} 
						      
            Phx.CP.loadWindows('../../../sis_organigrama/vista/cargo_centro_costo/CargoCentroCosto.php',
                    'Centros de Costo Asignados por Cargo',
                    {
                        width:700,
                        height:450
                    },
                    rec,
                    this.idContenedor,
                    'CargoCentroCosto');
	}
}
)
</script>
		
		
 