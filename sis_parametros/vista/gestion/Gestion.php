<?php
/**
*@package pXP
*@file gen-Gestion.php
*@author  (admin)
*@date 05-02-2013 09:56:59
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Gestion=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Gestion.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name:'id_gestion'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_empresa',
				fieldLabel: 'Empresa',
				allowBlank:false,
				emptyText:'Empresa...',
				store:new Ext.data.JsonStore({
 						url: '../../sis_parametros/control/Empresa/listarEmpresa',
						id: 'id_empresa',
						root: 'datos',
						sortInfo:{
							field: 'nombre',
							direction: 'ASC'
						},
						totalProperty: 'total',
						fields: ['id_empresa','nombre','codigo'],
						// turn on remote sorting
						remoteSort: true,
						baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_empresa',
				displayField: 'codigo',
				gdisplayField:'desc_empresa',
				hiddenName: 'id_empresa',
				forceSelection:true,
				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2,
				listWidth:280,	
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_empresa']);}
	       			
			},
			type:'ComboBox',
			id_grupo:0,
			filters:{	
		        pfiltro:'emp.nombre',
				type:'string'
			},
			
			grid:true,
			form:true
	},
		
		{
			config:{
				name: 'gestion',
				fieldLabel: 'gestion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'ges.gestion',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
	   	{
	   			config:{
	       		    name:'id_moneda_base',
	   				origen:'MONEDA',
	   				fieldLabel:'Moneda',
	   				gdisplayField:'moneda',//mapea al store del grid
	   				gwidth:200,
		   			renderer:function (value, p, record){return String.format('{0} - {1}', record.data['codigo_moneda'], record.data['moneda']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'mon.codigo#mon.moneda',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
	   	 },
		{
			config:{
				name: 'estado',
				fieldLabel: 'estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:15
			},
			type:'TextField',
			filters:{pfiltro:'ges.estado',type:'string'},
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
			filters:{pfiltro:'ges.estado_reg',type:'string'},
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
			filters:{pfiltro:'ges.fecha_reg',type:'date'},
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
			filters:{pfiltro:'ges.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Gestion',
	ActSave:'../../sis_parametros/control/Gestion/insertarGestion',
	ActDel:'../../sis_parametros/control/Gestion/eliminarGestion',
	ActList:'../../sis_parametros/control/Gestion/listarGestion',
	id_store:'id_gestion',
	fields: [
		{name:'id_gestion', type: 'numeric'},
		{name:'id_moneda_base', type: 'numeric'},
		{name:'id_empresa', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'gestion', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_empresa','codigo_moneda','moneda'
		
	],
	sortInfo:{
		field: 'id_gestion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		