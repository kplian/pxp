<?php
/**
*@package pXP
*@file gen-Proveedor.php
*@author  (mzm)
*@date 15-11-2011 10:44:58
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.proveedor=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.proveedor.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}});
		
		this.iniciarEventos();
		
		var cmbServ = new Ext.form.ComboBox({
			name:'id_servicio',
			fieldLabel:'Servicios',
			allowBlank:true,
			emptyText:'Elija un Servicio...',
			store: new Ext.data.JsonStore({
  				url : '../../sis_parametros/control/Servicio/listarServicio',
				id: 'id_servicio',
				root: 'datos',
				sortInfo:{
					field: 'nombre',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['id_servicio','nombre','codigo','descripcion'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_filtro:'nombre'}
			}),
			valueField: 'id_servicio',
			displayField: 'nombre',
			forceSelection:true,
			typeAhead: false,
			triggerAction: 'all',
			lazyRender:true,
			mode:'remote',
			pageSize:10,
			queryDelay:1000,
			minChars:2,
			width:180,
			listWidth:300,
			tpl: '<tpl for="."><div class="x-combo-list-item"><p>Código: {codigo}</p><p>Nombre: {nombre}</p><p>Descripción: {descripcion}</p></div></tpl>'
		});
		
		var cmbItem = new Ext.form.ComboBox({
			name:'id_item',
			fieldLabel:'Items',
			allowBlank:true,
			emptyText:'Elija un Item...',
			store: new Ext.data.JsonStore({
  				url : '../../sis_almacenes/control/Item/listarItemNotBase',
				id: 'id_item',
				root: 'datos',
				sortInfo:{
					field: 'nombre',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['id_item','nombre','codigo','desc_clasificacion'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_filtro:'item.nombre#item.codigo#cla.nombre'}
			}),
			valueField: 'id_item',
			displayField: 'nombre',
			forceSelection:true,
			typeAhead: false,
			triggerAction: 'all',
			lazyRender:true,
			mode:'remote',
			pageSize:10,
			queryDelay:1000,
			minChars:2,
			width:180,
			listWidth:300,
			tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Clasif.: {desc_clasificacion}</p></div></tpl>'
		});
		
		//Agrega el combo a la barra de herramientas
		this.tbar.add(cmbServ);
		this.tbar.add(cmbItem);
		
		//Agrega eventos a los componentes creados
		cmbServ.on('blur',function (combo, record, index){
			//Verifica que el campo de texto tenga algun valor
			this.store.baseParams.id_servicio=cmbServ.getValue();
			this.store.load({params:{start:0, limit:this.tam_pag}});
		},this);
		
		cmbItem.on('blur',function (combo, record, index){
			//Verifica que el campo de texto tenga algun valor
			this.store.baseParams.id_item=cmbItem.getValue();
			this.store.load({params:{start:0, limit:this.tam_pag}});
		},this);
		
		cmbServ.store.on('exception', this.conexionFailure);
		cmbItem.store.on('exception', this.conexionFailure);
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_proveedor'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'tipo',
				fieldLabel: 'Tipo',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:25,
				typeAhead:true,
				triggerAction:'all',
				mode:'local',
				store:['persona natural','persona juridica']
			},
			valorInicial:'',
			type:'ComboBox',
			filters:{pfiltro:'provee.tipo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
	   	{
	   		config:{
	   				name:'id_persona',
	   				fieldLabel: 'Persona',
	   				anchor: '100%',
	   				tinit:true,
	   				allowBlank:false,
	   				origen:'PERSONA',
	   				gdisplayField:'nombre_completo1',
	   			    gwidth:200,	
	   			    renderer:function (value, p, record){return String.format('{0}', record.data['nombre_completo1']);}
   			
	   			  },
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'person.nombre_completo1',type:'string'},
   		    grid:true,
   			form:true
	   	},{
	   		config:{
	   				name:'id_institucion',
	   				fieldLabel: 'Institucion',
	   				anchor: '100%',
	   				tinit:true,
	   				allowBlank:false,
	   				origen:'INSTITUCION',
	   				gdisplayField:'nombre',
	   			    gwidth:200,	
	   			   	renderer:function (value, p, record){return String.format('{0}', record.data['nombre']);}
   			
	   			  },
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'instit.nombre',type:'string'},
   			grid:true,
   			form:true
	   	},	
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'provee.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nit',
				fieldLabel: 'NIT',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'provee.nit',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'numero_sigma',
				fieldLabel: 'Num.Sigma',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'provee.numero_sigma',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'pais',
				fieldLabel: 'País',
				allowBlank: true,
				anchor: '90%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:false
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
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_lugar',
				displayField: 'nombre',
				gdisplayField:'lugar',
				hiddenName: 'id_lugar',
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				anchor:"100%",
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['lugar']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'lug.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'correos',
				fieldLabel: 'Correos',
				allowBlank: true,
				anchor: '90%',
				gwidth: 130,
				maxLength:50
			},
			type:'Field',
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'telefonos',
				fieldLabel: 'Teléfonos',
				allowBlank: true,
				anchor: '90%',
				gwidth: 130,
				maxLength:50
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'items',
				fieldLabel: 'Items que oferta',
				allowBlank: true,
				anchor: '90%',
				gwidth: 130,
				maxLength:50
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'servicios',
				fieldLabel: 'Servicios que oferta',
				allowBlank: true,
				anchor: '90%',
				gwidth: 130,
				maxLength:50
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'provee.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '90%',
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
				fieldLabel: 'Fecha Registro',
				allowBlank: false,
				anchor: '90%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'provee.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '90%',
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
				anchor: '90%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'provee.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
		
	],
	title:'Proveedores',
	ActSave:'../../sis_parametros/control/Proveedor/insertarProveedor',
	ActDel:'../../sis_parametros/control/Proveedor/eliminarProveedor',
	ActList:'../../sis_parametros/control/Proveedor/listarProveedor',
	id_store:'id_proveedor',
	fields: [
		{name:'id_proveedor', type: 'numeric'},
		{name:'id_persona', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'numero_sigma', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_institucion', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'nombre_completo1', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'nit', type: 'string'},
		{name:'id_lugar', type: 'string'},
		{name:'lugar', type: 'string'},
		{name:'pais', type: 'string'},
		{name:'correos', type: 'string'},
		{name:'telefonos', type: 'string'},
		{name:'items', type: 'string'},
		{name:'servicios', type: 'string'}
	],
    east:{
		  url:'../../../sis_parametros/vista/proveedor_item_servicio/ProveedorItemServicio.php',
		  title:'Items/Servicios ofertados', 
		 // height:'50%',	//altura de la ventana hijo
		  width:'50%',		//ancho de la ventana hjo
		  cls:'ProveedorItemServicio'
	},	
	sortInfo:{
		field: 'id_proveedor',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	fwidth:400,
	
	iniciarEventos:function()
	{		
		//this.ocultarComponente(this.getComponente('id_institucion'));
		//this.ocultarComponente(this.getComponente('id_persona'));
		
		//console.log('entra_antes');
		//cuando se tikea un registro salta este evento
		this.getComponente('id_institucion').disable();
		this.getComponente('id_persona').disable();
		
		
		this.getComponente('tipo').on('select',function(c,r,n){
				
				if(n=='persona natural' || n=='0'){
					this.getComponente('id_persona').enable();
					this.mostrarComponente(this.getComponente('id_persona'));
					this.ocultarComponente(this.getComponente('id_institucion'));
					//this.getComponente('id_institucion').allowBlank=true;
					//this.getComponente('id_persons').allowBlank=false;
					this.getComponente('id_institucion').reset();
					this.getComponente('id_institucion').disable();
				}else{
					this.getComponente('id_institucion').enable();
					
					this.ocultarComponente(this.getComponente('id_persona'));
					this.mostrarComponente(this.getComponente('id_institucion'));
					
					//this.getComponente('id_persona').allowBlank=true;
					this.getComponente('id_persona').reset();
					this.getComponente('id_persona').disable();
				}
				
		},this);
		
		this.getComponente('id_persona').on('select',function(c,r,n){
			this.getComponente('nit').setValue(r.data.ci);
			this.getComponente('codigo').setValue('');
			},this);
		
		this.getComponente('id_institucion').on('select',function(c,r,n){
			this.getComponente('nit').setValue(r.data.doc_id);
			this.getComponente('codigo').setValue(r.data.codigo);
			},
			this);
	},
	onButtonEdit:function(){
		datos=this.sm.getSelected().data;
		Phx.vista.proveedor.superclass.onButtonEdit.call(this); //sobrecarga enable select
		if(datos.tipo=='persona natural'){
			//this.ocultarComponente(this.getComponente('id_institucion'));
			this.getComponente('id_persona').enable();
			
			//this.getComponente('id_institucion').allowBlank=true;
			this.getComponente('id_institucion').reset();
			this.getComponente('id_institucion').disable();
			this.mostrarComponente(this.getComponente('id_persona'));
			this.ocultarComponente(this.getComponente('id_institucion'));
			
		}else{
			//this.getComponente('id_persona').allowBlank=true;
			this.getComponente('id_institucion').enable();
			this.getComponente('id_persona').reset();
			this.getComponente('id_persona').disable();
			this.ocultarComponente(this.getComponente('id_persona'));
			this.mostrarComponente(this.getComponente('id_institucion'));
		}
		
	}
})
</script>
		
		