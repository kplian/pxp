<?php
/**
*@package pXP
*@file gen-Asistente.php
*@author  (admin)
*@date 05-04-2013 14:02:14
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Asistente=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Asistente.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
		
		//Manejadores de Eventos
		this.Cmp.uo.on('focus',this.viewOrganigrama,this)
		this.Cmp.recursivo.on('select',this.onRecursivo,this);
		
		//Obtencion de componentes
		this.uo=this.Cmp.uo;
		this.id_uo=this.Cmp.id_uo;
		this.id_estructura_uo=this.Cmp.id_estructura_uo;
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_asistente'
			},
			type:'Field',
			form:true 
		},
   	     {
   			config:{
       		    name:'id_funcionario',
       		     hiddenName: 'id_funcionario',
   				origen:'FUNCIONARIO',
   				fieldLabel:'Funcionario',
   				allowBlank:false,
                gwidth:200,
   				valueField: 'id_funcionario',
   			    gdisplayField: 'desc_funcionario1',
   			    renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario1']);}
       	     },
   			type:'ComboRec',//ComboRec
   			id_grupo:0,
   			filters:{pfiltro:'fun.desc_funcionario1',type:'string'},
   		    grid:true,
   			form:true
		 },
   	     {
			config: {
				name: 'recursivo',
				fieldLabel: 'Recursivo',
				anchor: '100%',
				tinit: true,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'recursivo',
				gwidth: 100,
				tinit: false,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tgral__bandera'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['recursivo']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'asis.recursivo',type:'string'},
			grid: true,
			form: true
		},
		{
   			config:{
       		    name:'id_uo',
       		    hiddenName: 'id_uo',
          		origen:'UO',
   				fieldLabel:'Unidad Org.',
   				gdisplayField:'desc_uo',//mapea al store del grid
   			    gwidth:200,
   			     //baseParams: { presupuesta : 'si' },
   			     renderer:function (value, p, record){return String.format('{0}', record.data['desc_uo']);}
       	     },
   			type:'ComboRec',
   			id_grupo:1,
   			filters:{	
		        pfiltro:'uo.codigo#uo.nombre_unidad',
				type:'string'
			},
   		     grid:true,
   			form:true
   	      },
		{
			config: {
				name: 'uo',
				fieldLabel: 'Organigrama',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_uo']);
				}
			},
			type: 'TextArea',
			id_grupo: 0,
			filters: {pfiltro: 'uo.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_estructura_uo',
				labelSeparator:'',
				inputType:'hidden',
			},
			type: 'Field',
			grid: true,
			form: true
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
			filters:{pfiltro:'asis.estado_reg',type:'string'},
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
			filters:{pfiltro:'asis.fecha_reg',type:'date'},
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
			filters:{pfiltro:'asis.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Registro de Asistentes por UO',
	ActSave:'../../sis_parametros/control/Asistente/insertarAsistente',
	ActDel:'../../sis_parametros/control/Asistente/eliminarAsistente',
	ActList:'../../sis_parametros/control/Asistente/listarAsistente',
	id_store:'id_asistente',
	fields: [
		{name:'id_asistente', type: 'numeric'},
		{name:'id_uo', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'desc_funcionario1', type: 'string'},
		{name:'desc_uo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'recursivo', type: 'string'}
	],
	sortInfo:{
		field: 'id_asistente',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	id_uos:'',
	id_estructura_uo:'',
	uo:'',
	id_uorg:'',
	/*createWindow: function() {
		this.formNew = new Ext.form.FormPanel({
			baseCls: 'x-plain-' + this.idContenedor,
			bodyStyle: 'padding:10 20px 10;',
			autoDestroy: true,
			border: false,
			layout: 'form',
			items: [{
				xtype:'combo',
				name:'id_uo_frm',
				fieldLabel: 'Funcionario',
				allowBlank:false,
				emptyText: 'Funcionario...',
				store: new Ext.data.JsonStore({
						url: '../../sis_organigrama/control/Funcionario/listarFuncionario',
						id: 'id_funcionario',
						root: 'datos',
						sortInfo:{
							field: 'desc_person',
							direction: 'ASC'
						},
						totalProperty: 'total',
						fields: ['id_funcionario','codigo','desc_person','ci','documento','telefono','celular','correo'],
						remoteSort: true,
						baseParams: {par_filtro:'funcio.codigo#nombre_completo1'}
		    		
					}),
					tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo} - Sis: {codigo_sub} </p><p>{desc_person}</p><p>CI:{ci}</p> </div></tpl>',
					valueField: 'id_funcionario',
       				displayField: 'desc_person',
       				hiddenName: 'id_funcionario',
       				triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				listWidth:'280',
       				width:250,
       				minChars:2
				},{
				xtype: 'textarea',
				name: 'uo_frm',
				fieldLabel: 'Unidades Organizacionales',
				allowBlank: true,
				width: 250,
				anchor: '100%',
				readonly: true
			}]
		});

		this.uo = this.formNew.getForm().findField('uo_frm');
		this.id_uorg = this.formNew.getForm().findField('id_uo_frm');
		
		this.uo.on('focus',this.viewOrganigrama,this);

		this.winNew = new Ext.Window({
			title: 'Nuevo',
			collapsible: true,
			maximizable: true,
			autoDestroy: true,
			width: 450,
			height: 250,
			layout: 'fit',
			plain: true,
			bodyStyle: 'padding:5px;',
			buttonAlign: 'center',
			items: this.formNew,
			modal: true,
			closeAction: 'hide',
			buttons: [{
				text: 'Guardar',
				handler: this.onGuardar,
				scope: this

			}, {
				text: 'Cancelar',
				handler: function() {
					this.winNew.hide()
				},
				scope: this
			}]
		});

	},*/
		/*onGuardar: function(){
			if(this.formNew.getForm().isValid()){
				Phx.CP.loadingShow();
				Ext.Ajax.request({
					url: '../../sis_parametros/control/Asistente/insertarAsistente',
					params: {
						id_uos : this.id_uos,
						id_funcionario: this.id_uorg.getValue()
					},
					success: function(resp){
						Phx.CP.loadingHide();
						var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
						if (reg.ROOT.error) {
							alert("ERROR no esperado")
						} else {
							this.winNew.hide();
							this.reload();
						}
					},
					failure: this.conexionFailure,
					timeout: this.timeout,
					scope: this
				});
			}
			
		},*/
		viewOrganigrama: function(){
			var data={};
			data.recursivo='no';
			if(this.Cmp.recursivo.getValue()=='Si'){
				data.recursivo='si';
			}
			Phx.CP.loadWindows('../../../sis_organigrama/vista/estructura_uo/EstructuraUoCheck.php',
						'Organigrama',
						{
							width:'60%',
							height:'70%'
					    },
					    data,
					    this.idContenedor,
					    'EstructuraUoCheck'
				);
		},
		onButtonNew: function(){
			Phx.vista.Asistente.superclass.onButtonNew.call(this);
			this.Cmp.id_uo.disable();
			this.Cmp.uo.disable();
			this.Cmp.uo.show();
			this.Cmp.recursivo.enable();
		},
		onButtonEdit: function(){
			Phx.vista.Asistente.superclass.onButtonEdit.call(this);
			
			//Carga los parametros del store de UO
			if(this.Cmp.recursivo.getValue()=='Si'){
				Ext.apply(this.Cmp.id_uo.store.baseParams,{presupuesta: 'si'})
			} else{
				Ext.apply(this.Cmp.id_uo.store.baseParams,{presupuesta: 'no'})
			}
			this.Cmp.id_uo.modificado=true;
			
			//Muestra/Esconde los componentes
			this.Cmp.id_uo.show();
			this.Cmp.id_uo.enable();
			this.Cmp.uo.hide();
			this.Cmp.id_uo.allowBlank=false;
			this.Cmp.uo.allowBlank=true;
			//Bloquea Recursivo
			this.Cmp.recursivo.disable();
			
		},
		onRecursivo: function(cmb,rec){
 			if(rec.data){
 				if(rec.data.descripcion=='Si'){
 					Ext.apply(this.Cmp.id_uo.store.baseParams,{presupuesta: 'si'})
 					//Ext.apply(this.Cmp.id_uo.store.baseParams,{correspondencia: 'si'})
 					this.Cmp.uo.disable();
 					this.Cmp.id_uo.enable()
 					this.Cmp.id_uo.allowBlank=false
 					this.Cmp.uo.allowBlank=true
 				} else{
 					Ext.apply(this.Cmp.id_uo.store.baseParams,{presupuesta: 'no'})
 					//Ext.apply(this.Cmp.id_uo.store.baseParams,{correspondencia: 'no'})
 					this.Cmp.uo.enable();
 					this.Cmp.id_uo.disable()
 					this.Cmp.id_uo.allowBlank=true
 					this.Cmp.uo.allowBlank=false
 				}
 				this.Cmp.id_uo.modificado=true;
 			}
		}
})
</script>
		
		