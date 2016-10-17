<?php
/**
*@package pXP
*@file gen-Widget.php
*@author  (admin)
*@date 10-09-2016 08:00:16
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Widget=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
		
		 this.addEvents({
            "selectwidget" : true
        });
	    
	    
		
    	//llama al constructor de la clase padre
		Phx.vista.Widget.superclass.constructor.call(this,config);
		
		


		
		
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
	
	
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					fieldLabel: 'Preview',
					inputType:'hidden',
					name: 'id_widget',
					renderer:function (value, p, record){	
						//return  String.format('{0}',"<div style='text-align:center'><img src = ../../control/foto_persona/"+ record.data['foto']+"?"+record.data['nombre_foto']+hora_actual+" align='center' width='70' height='70'/></div>");
						var splittedArray = record.data['foto'].split('.');
						if (splittedArray[splittedArray.length - 1] != "") {
							return  String.format('{0}',"<div style='text-align:center'><img src = '"+ record.data['foto']+"' align='center' width='70' height='70'/></div>");
						} else {
							return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/NoPerfilImage.jpg' align='center' width='70' height='70'/></div>");
						}
						
					},
			},
			type:'Field',
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
			},
				type:'TextField',
				filters:{pfiltro:'wid.nombre',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},		
		
		{
			config:{
				name: 'obs',
				fieldLabel: 'Obs',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100
			},
				type:'TextArea',
				filters:{pfiltro:'wid.obs',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'clase',
				fieldLabel: 'Clase',
				qtip:'nombe de la clase',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
				type:'TextField',
				filters:{pfiltro:'wid.clase',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'ruta',
				qtip:'ruta del objeto',
				fieldLabel: 'Ruta',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100
			},
				type:'TextArea',
				filters:{pfiltro:'wid.ruta',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name:'tipo',
				fieldLabel:'Tipo',
				qtip: 'Determina el tipo de widget',
				typeAhead: true,
				allowBlank:false,
	    		triggerAction: 'all',
	    		emptyText:'Seleccione Opcion...',
	    		selectOnFocus:true,
				mode:'local',
				store:new Ext.data.ArrayStore({
	        	fields: ['ID', 'valor'],
	        	data :	[['iframe','Iframe'],	
	        			['objeto','Objeto']]
	        				
	    		}),
				valueField:'ID',
				displayField:'valor',
				width:150,			
				anchor:'70%'
			},
			type:'ComboBox',
			filters:{pfiltro:'wid.tipo',type:'string'},				
			form:true,
			grid:true,
			id_grupo:0
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
				filters:{pfiltro:'wid.estado_reg',type:'string'},
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
				filters:{pfiltro:'wid.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
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
				filters:{pfiltro:'wid.fecha_reg',type:'date'},
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
				filters:{pfiltro:'wid.usuario_ai',type:'string'},
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'wid.fecha_mod',type:'date'},
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
		}
	],
	tam_pag:50,	
	title:'Widget',
	ActSave:'../../sis_parametros/control/Widget/insertarWidget',
	ActDel:'../../sis_parametros/control/Widget/eliminarWidget',
	ActList:'../../sis_parametros/control/Widget/listarWidget',
	id_store:'id_widget',
	fields: [
		{name:'id_widget', type: 'numeric'},
		{name:'ruta', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'foto', type: 'string'},
		{name:'obs', type: 'string'},
		{name:'clase', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_widget',
		direction: 'ASC'
	},
	
	
	
	
	bdel:true,
	bsave:true
	}
)
</script>
		
		