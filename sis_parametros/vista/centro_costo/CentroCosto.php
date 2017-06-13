<?php
/**
*@package pXP
*@file gen-CentroCosto.php
*@author  (admin)
*@date 19-02-2013 22:53:59
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.CentroCosto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.CentroCosto.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
		this.iniciarEventos();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					fieldLabel: 'ID',
					inputType:'hidden',
					name: 'id_centro_costo'
			},
			type:'Field',
			gwidth: 100,
			grid:true,
			form:true 
		},
		{
			config:{
				name: 'id_gestion',
				origen:'GESTION',
	   			tinit:false,
				fieldLabel: 'Gestion',
				gdisplayField:'gestion',//mapea al store del grid
				allowBlank:false,
				gwidth: 200,
				width:250,
				renderer:function (value, p, record){return String.format('{0}', record.data['gestion']);}
			},
			type:'ComboRec',
			filters:{pfiltro:'gestion',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
	   		config:{
	   				name:'id_tipo_cc',
	   				qtip: 'Tipo de centro de costos, cada tipo solo puede tener un centro por gestión',	   				
	   				origen:'TIPOCC',
	   				fieldLabel:'Tipo Centro',
	   				gdisplayField: 'descripcion_tcc',	   				
	   				allowBlank:false,
	   				width:250,
	   				gwidth:200,
	   				renderer:function (value, p, record){return String.format('{0} - {1}', record.data['codigo_tcc'],  record.data['descripcion_tcc']);}
	   				
	      		},
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'cec.codigo_tcc#cec.descripcion_tcc',type:'string'},
   		    grid:true,
   			form:true
	    },
	    {
	   		config:{
	   				name:'id_ep',
	   				qtip:'La estructura programatica se utiliza para determinar permisos sobre los centros de costos', 
	   				origen:'EP',
	   				fieldLabel:'EP',
	   				allowBlank:false,
	   				gdisplayField:'ep',//mapea al store del grid
	   			    gwidth:200,
	   			    width:250,
	   			    renderer:function (value, p, record){return String.format('{0}', record.data['ep']);}
	      		},
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'ep',type:'string'},
   		    grid:true,
   			form:false
	    },
		{
	   		config:{
	   				name:'id_uo',
	   				qtip:'La unidad dueña del centro de costo  (no es necesiramente la que aplique el costo)',
	   				origen:'UO',
	   				fieldLabel:'Unidad',
	   				allowBlank:false,
	   				gdisplayField:'nombre_uo',//mapea al store del grid
	   			    gwidth:200,
	   			    width:250,
	   			    baseParams:{presupuesta:'si'},
	      			renderer:function (value, p, record){return String.format('{0} {1}' , record.data['codigo_uo'], record.data['nombre_uo']);}
	      		},
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'nombre_uo',type:'string'},
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
			filters:{pfiltro:'estado_reg',type:'string'},
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
			filters:{pfiltro:'usr_reg',type:'string'},
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
			filters:{pfiltro:'fecha_reg',type:'date'},
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
			filters:{pfiltro:'usr_mod',type:'string'},
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
			filters:{pfiltro:'fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	 
	title:'Centro de Costos',
	ActSave:'../../sis_parametros/control/CentroCosto/insertarCentroCosto',
	ActDel:'../../sis_parametros/control/CentroCosto/eliminarCentroCosto',
	ActList:'../../sis_parametros/control/CentroCosto/listarCentroCostoGrid',
	id_store:'id_centro_costo',
	fields: [
		{name:'id_centro_costo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_ep', type: 'numeric'},
		{name:'id_gestion', type: 'numeric'},
		{name:'id_uo', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'gestion','ep','codigo_uo','nombre_uo','id_tipo_cc','codigo_tcc','descripcion_tcc'
		
	],
	sortInfo:{
		field: 'id_centro_costo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	iniciarEventos: function(){
		this.Cmp.id_gestion.on('select', function(cmp, rec, indice){
			  this.Cmp.id_tipo_cc.reset();
			  console.log(rec)
			  this.Cmp.id_tipo_cc.store.baseParams.gestion = rec.data.gestion;
			  this.Cmp.id_tipo_cc.modificado = true; 
			
		},this);
		
	}
})
</script>
		
		