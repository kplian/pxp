<?php
/**
*@package pXP
*@file gen-CargoCentroCosto.php
*@author  (admin)
*@date 15-01-2014 13:05:35
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.CargoCentroCosto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro = config.maestro;
		
		//llama al constructor de la clase padre
		this.initButtons=[this.cmbGestion];
		Phx.vista.CargoCentroCosto.superclass.constructor.call(this,config);
		this.init();
		
		this.cmbGestion.on('select',function () {
					
			this.load({params:{start:0, limit:this.tam_pag,id_cargo:this.maestro.id_cargo,id_gestion:this.cmbGestion.getValue()}});
			this.Cmp.id_centro_costo.store.baseParams = Ext.apply({id_gestion:this.cmbGestion.getValue()}, this.Cmp.id_centro_costo.store.baseParams);
		
		},this);
		
		this.cmbGestion.store.load({params:{start:0, limit:this.tam_pag}, scope:this,callback: function (arr,op,suc) {
			this.cmbGestion.setValue(arr[0].data.id_gestion);
			this.Cmp.id_centro_costo.store.baseParams = Ext.apply({id_gestion:this.cmbGestion.getValue()}, this.Cmp.id_centro_costo.store.baseParams);
			this.cmbGestion.fireEvent('select');			
		}});
			
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_cargo_centro_costo'
			},
			type:'Field',
			form:true 
		},
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
            config:{
                    name:'id_centro_costo',
                    origen:'CENTROCOSTO',
                    fieldLabel: 'Centro de Costos',
                    url: '../../sis_parametros/control/CentroCosto/listarCentroCostoCombo',
                    emptyText : 'Centro Costo...',
                    allowBlank:false,
                    gdisplayField:'desc_centro_costo',//mapea al store del grid
                    gwidth:250,
                    baseParams:{filtrar:'grupo_ep'},
                    renderer:function (value, p, record){return String.format('{0}', record.data['desc_centro_costo']);}
                },
            type:'ComboRec',
            id_grupo:0,
            filters:{pfiltro:'cc.codigo_cc',type:'string'},
            grid:true,
            form:true
        },
        {
            config:{
                name:'id_ot',
                fieldLabel: 'Orden Trabajo',
                sysorigen:'sis_contabilidad',
                origen:'OT',
                allowBlank:true,
                gwidth:200,
                baseParams:{par_filtro:'desc_orden#motivo_orden'},
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_orden']);}

            },
            type:'ComboRec',
            id_grupo:0,
            filters:{pfiltro:'ot.motivo_orden#ot.desc_orden',type:'string'},
            grid:true,
            form:true
        },
		{
			config:{
				name: 'porcentaje',
				fieldLabel: 'Porcentaje',
				allowBlank: false,
				anchor: '40%',
				gwidth: 100,
				maxLength:3
			},
				type:'NumberField',
				filters:{pfiltro:'carpre.porcentaje',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'fecha_ini',
				fieldLabel: 'Fecha Aplicación',
				allowBlank: false,
				anchor: '80%',
				gwidth: 150,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'carpre.fecha_ini',type:'date'},
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
				filters:{pfiltro:'carpre.estado_reg',type:'string'},
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
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'carpre.fecha_reg',type:'date'},
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
				filters:{pfiltro:'carpre.fecha_mod',type:'date'},
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
	title:'Presupuesto Asignado por Cargo',
	ActSave:'../../sis_organigrama/control/CargoCentroCosto/insertarCargoCentroCosto',
	ActDel:'../../sis_organigrama/control/CargoCentroCosto/eliminarCargoCentroCosto',
	ActList:'../../sis_organigrama/control/CargoCentroCosto/listarCargoCentroCosto',
	id_store:'id_cargo_centro_costo',
	fields: [
		{name:'id_cargo_centro_costo', type: 'numeric'},
        {name:'id_ot', type: 'numeric'},
        {name:'desc_orden', type: 'string'},
		{name:'id_cargo', type: 'numeric'},
		{name:'id_gestion', type: 'numeric'},
		{name:'id_centro_costo', type: 'numeric'},
		{name:'desc_centro_costo', type: 'string'},
		{name:'porcentaje', type: 'numeric'},
		{name:'fecha_ini', type: 'date',dateFormat:'Y-m-d'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_cargo_centro_costo',
		direction: 'ASC'
	},
	bdel:true,
	bedit:false,
	bsave:true,	
	loadValoresIniciales:function()
    {
        this.Cmp.id_cargo.setValue(this.maestro.id_cargo);       
        Phx.vista.CargoCentroCosto.superclass.loadValoresIniciales.call(this);
    },
    cmbGestion:new Ext.form.ComboBox({
				fieldLabel: 'Gestion',
				allowBlank: true,
				emptyText:'Gestion...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_parametros/control/Gestion/listarGestion',
					id: 'id_gestion',
					root: 'datos',
					sortInfo:{
						field: 'gestion',
						direction: 'DESC'
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
	}
)
</script>
		
		