<?php
/**
*@package pXP
*@file gen-Oficina.php
*@author  (admin)
*@date 15-01-2014 16:05:34
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Oficina=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Oficina.superclass.constructor.call(this,config);
		this.addButton('btnCuenta',
        {
            text: 'Cuentas de Servicios',
            iconCls: 'blist',
            disabled: true,
            handler: this.onBtnCuenta,
            tooltip: 'Servicios por oficina'
        });
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_oficina'
			},
			type:'Field',
			form:true 
		},
		
		{
			config:{
				name: 'id_lugar',
				fieldLabel: 'Lugar',
				allowBlank: false,
				emptyText:'Lugar...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_parametros/control/Lugar/listarLugar',
					id: 'id_lugar',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_lugar','id_lugar_fk','codigo','nombre','tipo','sw_municipio','sw_impuesto','codigo_largo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'lug.nombre',es_regional:'si'}
				}),
				valueField: 'id_lugar',
				displayField: 'nombre',
				gdisplayField:'nombre_lugar',
				hiddenName: 'id_lugar',
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				anchor:"100%",
				gwidth:150,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_lugar']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'lug.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'ofi.codigo',type:'string'},
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
				maxLength:200
			},
				type:'TextField',
				filters:{pfiltro:'ofi.nombre',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
        {
            config:{
                name: 'correo_oficina',
                fieldLabel: 'Correo Of.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:200
            },
            type:'TextField',
            filters:{pfiltro:'ofi.correo_oficina',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		
		{
			config:{
				name: 'aeropuerto',
				fieldLabel: 'Aeropuerto',
				allowBlank: false,
				emptyText:'Aeropuerto...',
	       		typeAhead: true,
	       		triggerAction: 'all',
	       		lazyRender:true,
	       		mode: 'local',
				gwidth: 100,
				store:['si','no']
			},
				type:'ComboBox',
				filters:{	
	       		         type: 'list',
	       				 options: ['si','no'],	
	       		 	},
				id_grupo:1,
				grid:true,
				form:true
		},

		{
			config:{
				name: 'direccion',
				fieldLabel: 'direccion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'ofi.direccion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name: 'telefono',
                fieldLabel: 'Telefono',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255


            },
            type:'TextField',
            filters:{pfiltro:'ofi.direccion',type:'string'},
            id_grupo:1,
            grid:true,
            egrid:true,
            form:true
        },
        {
            config:{
                name: 'orden',
                fieldLabel: 'Orden',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:1310721
            },
            type:'NumberField',
            filters:{pfiltro:'cms.precio_unitario',type:'numeric'},
            id_grupo:1,
            grid:true,
            egrid:true,
            form:true
        },

		{
			config:{
				name: 'zona_franca',
				fieldLabel: 'Es Zona Franca',
				allowBlank: false,
				emptyText:'Zona Franca...',
	       		typeAhead: true,
	       		triggerAction: 'all',
	       		lazyRender:true,
	       		mode: 'local',
				gwidth: 100,
				store:['si','no']
			},
				type:'ComboBox',
				filters:{	
	       		         type: 'list',
	       				 options: ['si','no'],	
	       		 	},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'frontera',
				fieldLabel: 'Es Frontera',
				allowBlank: false,
				emptyText:'Frontera...',
	       		typeAhead: true,
	       		triggerAction: 'all',
	       		lazyRender:true,
	       		mode: 'local',
				gwidth: 100,
				store:['si','no']
			},
				type:'ComboBox',
				filters:{	
	       		         type: 'list',
	       				 options: ['si','no'],	
	       		 	},
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
				filters:{pfiltro:'ofi.estado_reg',type:'string'},
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
				filters:{pfiltro:'ofi.fecha_reg',type:'date'},
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
				filters:{pfiltro:'ofi.fecha_mod',type:'date'},
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
	title:'Oficinas',
	ActSave:'../../sis_organigrama/control/Oficina/insertarOficina',
	ActDel:'../../sis_organigrama/control/Oficina/eliminarOficina',
	ActList:'../../sis_organigrama/control/Oficina/listarOficina',
	id_store:'id_oficina',
	fields: [
		{name:'id_oficina', type: 'numeric'},
		{name:'aeropuerto', type: 'string'},
		{name:'zona_franca', type: 'string'},
		{name:'frontera', type: 'string'},
		{name:'id_lugar', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'nombre_lugar', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'correo_oficina', type: 'string'},
		{name:'direccion', type: 'string'},
        {name:'telefono', type: 'string'},
        {name:'orden', type: 'numeric'}

	],
	sortInfo:{
		field: 'id_oficina',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onBtnCuenta: function(){
			var rec = {maestro: this.sm.getSelected().data} 
						      
            Phx.CP.loadWindows('../../../sis_organigrama/vista/oficina_cuenta/OficinaCuenta.php',
                    'Servicios de la Oficina',
                    {
                        width:700,
                        height:450
                    },
                    rec,
                    this.idContenedor,
                    'OficinaCuenta');
	},
	loadValoresIniciales:function()
    {	
        this.Cmp.aeropuerto.setValue('no'); 
        this.Cmp.zona_franca.setValue('no');    
        this.Cmp.frontera.setValue('no');          
        Phx.vista.Oficina.superclass.loadValoresIniciales.call(this);
    },
    preparaMenu:function()
    {	
        this.getBoton('btnCuenta').enable();      
        Phx.vista.Oficina.superclass.preparaMenu.call(this);
    },
    liberaMenu:function()
    {	
        this.getBoton('btnCuenta').disable();       
        Phx.vista.Oficina.superclass.liberaMenu.call(this);
    }
	}
)
</script>
		
		