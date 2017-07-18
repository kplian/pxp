<?php
/**
*@package pXP
*@file gen-Moneda.php
*@author  (admin)
*@date 05-02-2013 18:17:03
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Moneda=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Moneda.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_moneda'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'prioridad',
				fieldLabel: 'Prioridad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'moneda.prioridad',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:5
			},
			type:'TextField',
			filters:{pfiltro:'moneda.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo_internacional',
				fieldLabel: 'Código Internacional',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'TextField',
			filters:{pfiltro:'moneda.codigo_internacional',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'moneda',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:250
			},
			type:'TextField',
			filters:{pfiltro:'moneda.moneda',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'origen',
				fieldLabel: 'Origen',
				anchor: '100%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'origen',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tmoneda__origen'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['origen']);}
			},
			type: 'ComboRec',
			id_grupo: 1,
			filters:{pfiltro:'moneda.origen',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'tipo_actualizacion',
				fieldLabel: 'Tipo Actualización',
				anchor: '100%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'tipo_actualizacion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tmoneda__tipo_actualizacion'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['tipo_actualizacion']);}
			},
			type: 'ComboRec',
			id_grupo: 1,
			filters:{pfiltro:'moneda.tipo_actualizacion',type:'string'},
			grid: true,
			form: true
		},
		
		{
            config:{
                name:'tipo_moneda',
                fieldLabel:'Tipo',
                allowBlank: false,
                anchor: '80%',
                emptyText:'Tipo...',                   
                typeAhead:true,
                triggerAction:'all',
                lazyRender:true,
                mode:'local',
                valueField:'inicio',                   
                store:['base','intercambio','ref']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{type: 'list',
                     pfiltro:'moneda.tipo_moneda',
                     options: ['base','intercambio','ref']
                    },
            grid:true,
            form:true
        },
		
		{
            config:{
                name:'triangulacion',
                fieldLabel:'Triangulación?',
                qtip: 'la moneda sirve para trigular valores con monedas extranjeras, solo podemos tener una moneda para triangulación',
                allowBlank: false,
                anchor: '80%',
                emptyText:'Tipo...',                   
                typeAhead:true,
                triggerAction:'all',
                lazyRender:true,
                mode:'local',
                valueField:'inicio',                   
                store:['si','no']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{type: 'list',
                     pfiltro:'moneda.triangulacion',
                     options: ['si','no']
                    },
            grid:true,
            form:true
        },
        
        {
            config:{
                name:'actualizacion',
                fieldLabel:'Actualización?',
                qtip: 'la moneda sirve para actulizar por inflación y tenencia de bienes AITB , solo podemos tener una moneda para actualización',
                allowBlank: false,
                anchor: '80%',
                emptyText:'Tipo...',                   
                typeAhead:true,
                triggerAction:'all',
                lazyRender:true,
                mode:'local',
                valueField:'inicio',                   
                store:['si','no']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{type: 'list',
                     pfiltro:'moneda.actualizacion',
                     options: ['si','no']
                    },
            grid:true,
            form:true
        },
        
        
        {
            config:{
                name:'contabilidad',
                fieldLabel:'Contabilidad',
                qtip: 'La moneda se utilizará en contabilidad?',
                allowBlank: false,
                anchor: '80%',
                emptyText:'Tipo...',                   
                typeAhead:true,
                triggerAction:'all',
                lazyRender:true,
                mode:'local',
                valueField:'inicio',                   
                store:['si','no']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{type: 'list',
                     pfiltro:'moneda.contabilidad',
                     options: ['si','no']
                    },
            grid:true,
            form:true
        },
        
         {
            config:{
                name:'show_combo',
                fieldLabel:'Mostrar en Combos',
                qtip: 'Si se muestras en combos otras interfaces como solicitud de compra o solicitud de fondos etc',
                allowBlank: false,
                anchor: '80%',
                emptyText:'Tipo...',                   
                typeAhead:true,
                triggerAction:'all',
                lazyRender:true,
                mode:'local',
                valueField:'inicio',                   
                store:['si','no']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{type: 'list',
                     pfiltro:'moneda.show_combo',
                     options: ['si','no']
                    },
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
			filters:{pfiltro:'moneda.estado_reg',type:'string'},
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
			filters:{pfiltro:'moneda.fecha_reg',type:'date'},
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
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'moneda.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Moneda',
	ActSave:'../../sis_parametros/control/Moneda/insertarMoneda',
	ActDel:'../../sis_parametros/control/Moneda/eliminarMoneda',
	ActList:'../../sis_parametros/control/Moneda/listarMoneda',
	id_store:'id_moneda',
	fields: [
		{name:'id_moneda', type: 'numeric'},
		{name:'prioridad', type: 'numeric'},
		{name:'origen', type: 'string'},
		{name:'tipo_actualizacion', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'codigo_internacional', type: 'string'},
		{name:'moneda', type: 'string'},
		{name:'tipo_moneda', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'triangulacion','contabilidad','show_combo','actualizacion'
		
		
	],
	sortInfo:{
		field: 'id_moneda',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		