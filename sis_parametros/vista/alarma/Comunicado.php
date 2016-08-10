<?php
/**
*@package pXP
*@file gen-Alarma.php
*@author  (rac)
*@date 18-11-2011 11:59:10
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Comunicado=Ext.extend(Phx.gridInterfaz,{
    
    fheight:'80%',
    fwidth: '80%',
	
	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Comunicado.superclass.constructor.call(this,config);
		this.init();
		this.store.baseParams={vista: 'comunicado'};
		this.load( { params: { start:0, limit:50 }});
		
		this.addButton('btnFinalizar', {
				text : 'Finalizar',
				iconCls : 'balert',
				disabled : true,
				handler : this.finalizar,
				tooltip : '<b>Finalizar</b><br/>Finalizar el registro del comunicado, (los correos electrónicos entran en cola para ser enviados)'
		});
		
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_alarma'
			},
			type:'Field',
			form:true 
		},
		
		{
   			config:{
       				name:'id_uos',
       			    tinit:false,
       			    resizable:true,
       			    tasignacion:false,
       			    allowBlank:false,
       				emptyText:'Unidad...',
       				store: new Ext.data.JsonStore({
						url: '../../sis_organigrama/control/Uo/listarUo',
    					id: 'id_uo',
    					root: 'datos',
    					sortInfo:{
    						field: 'nombre_unidad',
    						direction: 'ASC'
    					},
    					totalProperty: 'total',
    					fields: ['id_uo','codigo','nombre_unidad','nombre_cargo','presupuesta','correspondencia'],
    					// turn on remote sorting
    					remoteSort: true,
    					
    					baseParams: {par_filtro:'nombre_unidad#codigo',gerencia:'si'}
    				}),
       				valueField: 'id_uo',
       				displayField: 'nombre_unidad',
       				tpl:'<tpl for="."><div class="x-combo-list-item" ><div class="awesomecombo-item {checked}">{codigo}</div><p style="padding-left: 20px;">{nombre_unidad}</p> </div></tpl>',
			        hiddenName: 'id_uos',
       				forceSelection:true,
       				typeAhead: false,
           			triggerAction: 'all',
           			lazyRender:false,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				width:250,
       				listWidth:'280',
       				minChars:2,
       				enableMultiSelect:true
				
			},
   			type:'AwesomeCombo',
   			id_grupo:0,
   			filters:{	
   				        pfiltro:'nombre_unidad',
   						type:'string'
   					},
   		   
   			grid:false,
   			form:true
   	    },
   	    
   	    {
			config:{
				name: 'titulo',
				fieldLabel: 'Remitente',
				allowBlank: false,
				anchor: '80%',
				gwidth: 250,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'alarm.titulo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		
		{
			config:{
				name: 'titulo_correo',
				fieldLabel: 'Asunto',
				allowBlank: false,
				anchor: '80%',
				gwidth: 250,
				maxLength:200
			},
			type:'TextArea',
			filters:{pfiltro:'alarm.titulo_correo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',				
				allowBlank: false,
				anchor: '98%',
				qtip:'Descripción',
				gwidth: 500
			},
				type:'HtmlEditor',
				filters:{pfiltro:'alarm.descripcion',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		
		{
			config:{
				name: 'estado_comunicado',
				fieldLabel: 'Estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'alarm.estado_comunicado',type:'string'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'alarm.fecha_reg',type:'date'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'alarm.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Alarmas',
	ActSave:'../../sis_parametros/control/Alarma/insertarAlarma',
	ActDel:'../../sis_parametros/control/Alarma/eliminarAlarma',
	ActList:'../../sis_parametros/control/Alarma/listarComunicado',
	id_store:'id_alarma',
	fields: [
		{name:'id_alarma', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'titulo', type: 'string'},
		'id_uos','estado_comunicado',
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'titulo_correo'
		
	],
	
	finalizar: function() {
			  
			 if(confirm("¿Finaliar el envio del comunicado?")){
			 	 
				 	var rec = this.sm.getSelected().data;
				    Phx.CP.loadingShow();
					Ext.Ajax.request({
						url : '../../sis_parametros/control/Alarma/finalizarComunicado',
						params : {
							id_alarma : rec.id_alarma
						},
						success : function(resp) {
							Phx.CP.loadingHide();
							var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
							if (reg.ROOT.error) {
								Ext.Msg.alert('Error', 'Error al finalizar alarma: ' + reg.ROOT.error)
							} else {
								this.reload();
							}
						},
						failure : this.conexionFailure,
						timeout : this.timeout,
						scope : this
					});
				
			 }
			    
	},
	preparaMenu : function(n) {
		    
		    var data = this.getSelectedData();
			var tb = Phx.vista.Comunicado.superclass.preparaMenu.call(this);
			
			if (data['estado_comunicado'] == 'borrador') {
				this.getBoton('btnFinalizar').enable();
				this.getBoton('edit').enable();
			}
			else{
				this.getBoton('btnFinalizar').disable();
				this.getBoton('edit').disable();
			}
			
			
			return tb;
	},
	liberaMenu : function() {
			var tb = Phx.vista.Comunicado.superclass.liberaMenu.call(this);
			
			this.getBoton('btnFinalizar').disable();
			
	},
	
	sortInfo:{
		field: 'id_alarma',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		
