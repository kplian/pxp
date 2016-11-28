<?php
/**
*@package pXP
*@file gen-Entidad.php
*@author  (admin)
*@date 20-09-2015 19:11:44
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Entidad=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Entidad.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_entidad'
			},
			type:'Field',
			form:true 
		},{
            config:{
                name: 'nombre',
                fieldLabel: 'Nombre Entidad',
                allowBlank: false,
                anchor: '100%',
                gwidth: 250,
                maxLength:150
            },
                type:'TextField',
                filters:{pfiltro:'ent.nombre',type:'string'},
                id_grupo:1,
                grid:true,
                egrid:true,
                form:true
        },
		
		{
			config:{
				name: 'nit',
				fieldLabel: 'NIT',
				allowBlank: false,
				anchor: '50%',
				gwidth: 120,
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'ent.nit',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'identificador_min_trabajo',
				fieldLabel: 'Identificador Ministerio de Trabajo',
				allowBlank: true,
				anchor: '50%',
				gwidth: 120,
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'ent.identificador_min_trabajo',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'identificador_caja_salud',
				fieldLabel: 'Identificador Caja Salud',
				allowBlank: true,
				anchor: '50%',
				gwidth: 120,
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'ent.identificador_caja_salud',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
		    config:{
                name: 'tipo_venta_producto',
                fieldLabel: 'Integrar ventas con almacenes',
                allowBlank: true,
                anchor: '50%',
                gwidth: 200,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                store:['si','no']
            },
                type:'ComboBox',
                filters:{pfiltro:'ent.tipo_venta_producto',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
        },
		
		{
            config:{
                name: 'estados_comprobante_venta',
                fieldLabel: 'Estados Comprobante Venta',
                qtip:'Estados en los que se generara el comprobante de venta automaticamente(codigos separador por ,)',
                allowBlank: true,
                allowBlank: false,
                anchor: '50%',
                gwidth: 150,
                maxLength:20
            },
                type:'TextField',                
                id_grupo:1,
                grid:true,
                form:true
        },
        
        {
            config:{
                name: 'estados_anulacion_venta',
                fieldLabel: 'Estados Anulacion Venta',
                qtip:'Estados en los que se habilitara el boton para anular la venta(codigos separador por ,)',
                anchor: '50%',
                allowBlank: true,
                gwidth: 150,
                maxLength:20
            },
                type:'TextField',                
                id_grupo:1,
                grid:true,
                form:true
        },{
            config:{
                name: 'pagina_entidad',
                fieldLabel: 'Pagina Web',
                allowBlank: false,
                anchor: '100%',
                gwidth: 250,
                maxLength:150
            },
                type:'TextField',
                filters:{pfiltro:'ent.pagina_entidad',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
        },{
            config:{
                name: 'direccion_matriz',
                qtip: 'Dirección matriz o fiscal, este dato aparece en reporte como el LCV',
                fieldLabel: 'Dirección Fiscal',
                allowBlank: false,
                anchor: '100%',
                gwidth: 300,
                maxLength:400
            },
                type:'TextArea',
                filters:{pfiltro:'ent.direccion_matriz',type:'string'},
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
                filters:{pfiltro:'ent.estado_reg',type:'string'},
                id_grupo:1,
                grid:true,
                form:false
        },
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: '',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'ent.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
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
				filters:{pfiltro:'ent.fecha_reg',type:'date'},
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
				filters:{pfiltro:'ent.usuario_ai',type:'string'},
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
				filters:{pfiltro:'ent.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Entidad',
	ActSave:'../../sis_parametros/control/Entidad/insertarEntidad',
	ActDel:'../../sis_parametros/control/Entidad/eliminarEntidad',
	ActList:'../../sis_parametros/control/Entidad/listarEntidad',
	id_store:'id_entidad',
	fields: [
		{name:'id_entidad', type: 'numeric'},
		{name:'tipo_venta_producto', type: 'string'},
		
		{name:'identificador_min_trabajo', type: 'string'},
		{name:'identificador_caja_salud', type: 'string'},
		
		{name:'estados_comprobante_venta', type: 'string'},
		{name:'estados_anulacion_venta', type: 'string'},
		{name:'tipo_venta_producto', type: 'string'},
		{name:'nit', type: 'string'},
		{name:'pagina_entidad', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'direccion_matriz'
		
	],
	sortInfo:{
		field: 'id_entidad',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		