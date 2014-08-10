<?php
/**
*@package pXP
*@file EstructuraDato.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar formulario de creación de Estrutura
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.estructura_dato=function(config){

		var ds_subsistema =new Ext.data.JsonStore({

				url: '../../../sis_seguridad/control/subsistema/ActionListarSubsistema.php',
				id: 'id_subsistema',
				root: 'datos',
				sortInfo:{
					field: 'nombre',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['id_subsistema','codigo','nombre'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_combo:'codigo'}
			});
			
			
			
			var FormatoVista=function (value,p,record){return value?value.dateFormat('d/m/Y'):''}

	this.Atributos=[
	{//configuración del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_estructura_dato'

		},
		type:'Field',
		form:true 
	},
	
	{
			config:{
				name:'id_subsistema',
				fieldLabel:'Subsistema',
				allowBlank:false,
				emptyText:'Subsistema...',
				store:ds_subsistema,
				valueField: 'id_subsistema',
				displayField: 'codigo',
				hiddenName: 'id_subsistema',
				
				forceSelection:true,
				typeAhead:true,
				mode:'remote',
				queryDelay:250,
				pageSize:20,
				minListWidth:'100%',
				grow:true,
				resizable:true,
				minChars:1,
				triggerAction:'all',
				editable:true,
				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_subsis']);},
				anchor:'100%',
				gwidth:150,
				disabled:false
			},
			type:'ComboBox',
			id_grupo:0,
			filters:{	dataIndex:'subsis.nombre',
						type:'string'
					},
			grid:true,
			form:true
	},
	
	
	
	{config:{
			fieldLabel: "Nombre",
			gwidth: 45,
			name: 'nombre',
			allowBlank:false,	
			maxLength:50,
			minLength:3,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	
	 {config:{
			fieldLabel: "Descripcion",
			gwidth: 200,
			name: 'descripcion',
			allowBlank:false,	
			//maxLength:3000,
			minLength:0,
			anchor:'100%'
		},
		type:'TextArea',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	
	 {
		config:{
			name:'encripta',
			fieldLabel:'Encripta',
			typeAhead: true,
			allowBlank:false,
    		triggerAction: 'all',
    		emptyText:'Seleccione Opcion...',
    		selectOnFocus:true,
			mode:'local',
			store:new Ext.data.ArrayStore({
        	fields: ['ID', 'valor'],
        	data :	[['si','si'],	
        			['no','no']]
        				
    		}),
			valueField:'ID',
			displayField:'valor',
			width:150,			
			
		},
		type:'ComboBox',
		filters:{type: 'string',
				dataIndex: 'encripta', 
				options:['si','no'],
			    phpMode: true
		},
		id_grupo:0,
		grid:true,
		form:true
	},
	
	 {
		config:{
			name:'log',
			fieldLabel:'Log',
			typeAhead: true,
			allowBlank:false,
    		triggerAction: 'all',
    		emptyText:'Seleccione Opcion...',
    		selectOnFocus:true,
			mode:'local',
			store:new Ext.data.ArrayStore({
        	fields: ['ID', 'valor'],
        	data :	[['si','si'],	
        			['no','no']]
        				
    		}),
			valueField:'ID',
			displayField:'valor',
			width:150,			
			
		},
		type:'ComboBox',
		filters:{type: 'string',
				dataIndex: 'log', 
				options:['si','no'],
			    phpMode: true
		},
		id_grupo:0,
		grid:true,
		form:true
	},
	
	{config:{
			fieldLabel: "Tipo",
			gwidth: 200,
			name: 'tipo',
			allowBlank:false,	
			maxLength:30,
			minLength:3,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	}
	
	
	];
	
	Phx.vista.estructura_dato.superclass.constructor.call(this,config);
	this.init();
	
//	function hijo(){
//		_CP.loadWindows('../../../sis_legal/vista/garantia/garantia.php','Garantia',{width:800,height:500},this.sm.getSelected().data,this.idContenedor);	
//	}
	this.load({params:{start:0, limit:50}})
}
	
Ext.extend(Phx.vista.estructura_dato,Phx.gridInterfaz,{
	title:'Estructura Dato',
	ActSave:'../../../sis_seguridad/control/estructura_dato/ActionGuardarEstructuraDato.php',
	ActDel:'../../../sis_seguridad/control/estructura_dato/ActionEliminarEstructuraDato.php',
	ActList:'../../../sis_seguridad/control/estructura_dato/ActionListarEstructuraDato.php',
	id_store:'id_estructura_dato',
	fields: [
		{name:'id_estructura_dato'},
		{name:'id_subsistema'},
		
		{name:'nombre', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'encripta', type: 'string'},
		{name:'log', type: 'string'},
		{name:'tipo',type:'string'},{name:'nombre_subsis',type:'string'}
				
	],
	sortInfo:{
		field: 'nombre',
		direction: 'ASC'
	},
	bdel:true,//boton para eliminar
	bsave:false,//boton para eliminar


	//sobre carga de funcion
//	preparaMenu:function(tb){
//		//llamada funcion clace padre
//		this.getBoton('garantia').enable();
//		this.getBoton('correspondencia').enable();
//		this.getBoton('informe').enable();
//		this.getBoton('resolucion').enable();
//		this.getBoton('propuesta').enable();
//		this.getBoton('anexo').enable();
//		Phx.vista.contrato.superclass.preparaMenu.call(this,tb)
//	},
//	liberaMenu:function(tb){
//		this.getBoton('garantia').disable();
//		this.getBoton('correspondencia').disable();
//		this.getBoton('informe').disable();
//		this.getBoton('resolucion').disable();
//		this.getBoton('propuesta').disable();
//		this.getBoton('anexo').disable();
//		return Phx.vista.contratista.superclass.liberaMenu.call(this,tb)
//	}
}
);
</script>
