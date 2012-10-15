<?php
/**
*@package pXP
*@file gen-Institucion.php
*@author  (gvelasquez)
*@date 21-09-2011 10:50:03
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Institucion=Ext.extend(Phx.gridInterfaz,{

	
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_institucion'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'instit.codigo',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: false,
				anchor: '80%',
				gwidth: 250,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'instit.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'doc_id',
				fieldLabel: 'NIT',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'instit.doc_id',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'direccion',
				fieldLabel: 'Dirección Empresa',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'instit.direccion',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
	   	{
	   		config:{
	   				name:'id_persona',
	   				fieldLabel: 'Representante',
	   				tinit:true,
	   				allowBlank:true,
	   				origen:'PERSONA',
	   				gdisplayField:'desc_persona',//mapea al store del grid
	   			    gwidth:200,
	      			renderer:function (value, p, record){return String.format('{0}', record.data['desc_persona']);}
   			},
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'nombre_completo1#nombre_completo2',type:'string'},
   		    grid:true,
   			form:true
	   	},
		{
			config:{
				name: 'cargo_representante',
				fieldLabel: 'Cargo Representante',
				allowBlank: true,
				width: 250,
				gwidth: 250
			},
			type:'TextField',
			filters:{pfiltro:'instit.cargo_representante',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'es_banco',
				fieldLabel: 'Es Banco',
				allowBlank: false,
				anchor: '45%',
				gwidth: 100,
				maxLength:25,
				typeAhead:true,
				triggerAction:'all',
				mode:'local',
				store:['SI','NO']
			},
			valorInicial:'NO',
			type:'ComboBox',
			filters:{pfiltro:'instit.es_banco',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo_banco',
				fieldLabel: 'codigo_banco',
				allowBlank: true,
				width: 250,
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'instit.codigo_banco',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'observaciones',
				allowBlank: true,
				width: 250,
				heith: 250,
				gwidth: 100,
				maxLength:500
			},
			type:'TextArea',
			filters:{pfiltro:'instit.observaciones',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		
		{
			config:{
				name: 'casilla',
				fieldLabel: 'casilla',
				allowBlank: true,
				width: 250,
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'instit.casilla',type:'string'},
			id_grupo:2,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'telefono1',
				fieldLabel: 'telefono1',
				allowBlank: true,
				width: 250,
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'instit.telefono1',type:'string'},
			id_grupo:2,
			grid:true,
			form:true
		},
		
		{
			config:{
				name: 'telefono2',
				fieldLabel: 'telefono2',
				allowBlank: true,
				width: 250,
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'instit.telefono2',type:'string'},
			id_grupo:2,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fax',
				fieldLabel: 'fax',
				allowBlank: true,
				width: 250,
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'instit.fax',type:'string'},
			id_grupo:2,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'email1',
				fieldLabel: 'email1',
				allowBlank: true,
				width: 250,
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'instit.email1',type:'string'},
			id_grupo:2,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'email2',
				fieldLabel: 'email2',
				allowBlank: true,
				width: 250,
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'instit.email2',type:'string'},
			id_grupo:2,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'celular1',
				fieldLabel: 'celular1',
				allowBlank: true,
				width: 250,
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'instit.celular1',type:'string'},
			id_grupo:2,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'celular2',
				fieldLabel: 'celular2',
				allowBlank: true,
				width: 250,
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'instit.celular2',type:'string'},
			id_grupo:2,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'pag_web',
				fieldLabel: 'pag_web',
				allowBlank: true,
				width: 250,
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'instit.pag_web',type:'string'},
			id_grupo:2,
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
			filters:{pfiltro:'instit.estado_reg',type:'string'},
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
			type:'TextField',
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'instit.fecha_reg',type:'date'},
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
			type:'TextField',
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'instit.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Institución',
	ActSave:'../../sis_parametros/control/Institucion/insertarInstitucion',
	ActDel:'../../sis_parametros/control/Institucion/eliminarInstitucion',
	ActList:'../../sis_parametros/control/Institucion/listarInstitucion',
	id_store:'id_institucion',
	fields: [
		{name:'id_institucion', type: 'numeric'},
		{name:'fax', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'estado_institucion', type: 'string'},
		{name:'casilla', type: 'string'},
		{name:'direccion', type: 'string'},
		{name:'doc_id', type: 'string'},
		{name:'telefono2', type: 'string'},
		{name:'id_persona', type: 'numeric'},
		{name:'email2', type: 'string'},
		{name:'celular1', type: 'string'},
		{name:'email1', type: 'string'},
		{name:'id_tipo_doc_institucion', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'observaciones', type: 'string'},
		{name:'telefono1', type: 'string'},
		{name:'celular2', type: 'string'},
		{name:'es_banco', type: 'string'},
		{name:'codigo_banco', type: 'string'},
		{name:'pag_web', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_persona', type: 'string'},
		{name:'cargo_representante', type: 'string'} 
		
		
	],
	Grupos: [
            {
                layout: 'column',
                autowidth: true,
                border: false,
                defaults: {
                   border: false
                },            
                items: [
                
                 { 
                autowidth: true,
                border: false,
                defaults: {
                   border: false
                },            
                items: [
                
                         {
					        bodyStyle: 'padding-right:5px;padding-left:5px;',
					        bodyStyle: 'padding-left:5px;padding-left:5px;',
					        autowidth: true,
					        items: [{
					            xtype: 'fieldset',
					            title: 'Datos Basicos',
					            autoHeight: true,
					            items: [],
						        id_grupo:0
					        }]
					    }, {
					        bodyStyle: 'padding-right:5px;padding-left:5px;',
					        bodyStyle: 'padding-left:5px;padding-left:5px;',
					        autowidth: true,
					         items: [{
					            xtype: 'fieldset',
					            title: 'Datos Banco',
					            autoHeight: true,
					            items: [],
						        id_grupo:1
					        }]
					    }]},
					   
					    {
					        bodyStyle: 'padding-right:5px;padding-left:5px;',
					        bodyStyle: 'padding-left:5px;padding-left:5px;',
					        autowidth: true,
					        items: [{
					            xtype: 'fieldset',
					            title: 'Datos Contacto',
					            autoHeight: true,
					            items: [],
						        id_grupo:2
					        }]
					    }
					    ]
            }
        ],
        
     constructor:function(config){ 
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Institucion.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}});
		
		
		
	},
	onButtonNew:function(){
	  Phx.vista.Institucion.superclass.onButtonNew.call(this);
	},
	onButtonEdit:function(){
		var nodo=this.sm.getSelected().data;
		//console.log(nodo);
		Phx.vista.Institucion.superclass.onButtonEdit.call(this);
	},
	
	sortInfo:{
		field: 'id_institucion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	

	
	
	}
)
</script>
		
		