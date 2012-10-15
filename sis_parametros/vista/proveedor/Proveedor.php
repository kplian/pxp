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
				anchor: '90%',
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
	   				anchor: '90%',
	   				tinit:true,
	   				allowBlank:false,
	   				origen:'PERSONA',
	   				gdisplayField:'nombre_completo1',
	   			    gwidth:200,	
	   			    renderer:function (value, p, record){return String.format('{0}', record.data['nombre_completo1']);}
   			
	   			  },
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'nombre_completo1#nombre_completo2',type:'string'},
   		    grid:true,
   			form:true
	   	},{
	   		config:{
	   				name:'id_institucion',
	   				fieldLabel: 'Institucion',
	   				anchor: '90%',
	   				tinit:true,
	   				allowBlank:false,
	   				origen:'INSTITUCION',
	   				gdisplayField:'nombre',
	   			    gwidth:200,	
	   			   	renderer:function (value, p, record){return String.format('{0}', record.data['nombre']);}
   			
	   			  },
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'nombre',type:'string'},
   			grid:true,
   			form:true
	   	},	
		
		{
			config:{
				name: 'codigo',
				fieldLabel: 'codigo',
				allowBlank: true,
				anchor: '90%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'provee.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'nit',
				fieldLabel: 'NIT',
				allowBlank: false,
				anchor: '90%',
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
				anchor: '90%',
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
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: false,
				anchor: '90%',
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
		{name:'nombre', type: 'string'},'nit'
		
	],
	sortInfo:{
		field: 'id_proveedor',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
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
		
		this.getComponente('id_persona').on('select',function(c,r,n){this.getComponente('nit').setValue(r.data.ci)},this);
		this.getComponente('id_institucion').on('select',function(c,r,n){this.getComponente('nit').setValue(r.data.doc_id)},this);
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
	
	}
)
</script>
		
		