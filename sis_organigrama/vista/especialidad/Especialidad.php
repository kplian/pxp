<?php
/**
*@package pXP
*@file gen-Especialidad.php
*@author  (admin)
*@date 17-08-2012 17:29:14
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Especialidad=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Especialidad.superclass.constructor.call(this,config);
		this.init();
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_especialidad'
			},
			type:'Field',
			form:true 
		},
		
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_especialidad_nivel'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				width: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'espcia.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},

		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre especialidad',
				allowBlank: false,
				width: '100%',
				gwidth: 300,
				maxLength:150
			},
			type:'TextField',
			filters:{pfiltro:'espcia.nombre',type:'string'},
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
			filters:{pfiltro:'espcia.estado_reg',type:'string'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'espcia.fecha_reg',type:'date'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'espcia.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Especialidad',
	ActSave:'../../sis_organigrama/control/Especialidad/insertarEspecialidad',
	ActDel:'../../sis_organigrama/control/Especialidad/eliminarEspecialidad',
	ActList:'../../sis_organigrama/control/Especialidad/listarEspecialidad',
	id_store:'id_especialidad',
	fields: [
		{name:'id_especialidad', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'id_especialidad_nivel', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_especialidad_nivel', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_especialidad',
		direction: 'ASC'
	},
	
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_especialidad_nivel:this.maestro.id_especialidad_nivel};
		this.load({params:{start:0, limit:50}})
	},
	onButtonNew:function(){

		Phx.vista.Especialidad.superclass.onButtonNew.call(this);
		this.Cmp.id_especialidad_nivel.setValue(this.maestro.id_especialidad_nivel);
		
	},
	
	bdel:true,
	bsave:false,
	fwidth: 450,
	fheight: 250,
	codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L',
	title1:'REGISTRO',
	title2:'Especialidades Técnicas'
})
</script>
		
		