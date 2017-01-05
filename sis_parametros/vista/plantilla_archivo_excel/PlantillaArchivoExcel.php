<?php
/**
*@package pXP
*@file gen-PlantillaArchivoExcel.php
*@author  (gsarmiento)
*@date 15-12-2016 20:46:39
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PlantillaArchivoExcel=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PlantillaArchivoExcel.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_plantilla_archivo_excel'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'arxls.nombre',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Codigo',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'arxls.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'hoja_excel',
				fieldLabel: 'Hoja Excel',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:40
			},
			type:'TextField',
			filters:{pfiltro:'arxls.hoja_excel',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fila_inicio',
				fieldLabel: 'Fila Inicio',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:40
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fila_fin',
				fieldLabel: 'Fila Fin',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:40
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'filas_excluidas',
				fieldLabel: 'Filas Excluidas',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:40
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tipo_archivo',
				fieldLabel: 'Tipo Archivo',
				allowBlank: false,
				anchor: '60%',
				gwidth: 100,
				maxLength:10,
				emptyText:'Elija un tipo de archivo...',
				typeAhead: true,
				triggerAction: 'all',
				lazyRender:true,
				mode: 'local',
				//valueField: 'inicio',
				store:['xls','xlsx','xlsm','csv']
			},
			type:'ComboBox',
			id_grupo:1,
			filters:{
				type: 'list',
				pfiltro:'arxls.tipo_archivo',
				options: ['xls','xlsx','xlsm','csv'],
			},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'delimitador',
				fieldLabel: 'Delimitador',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:5
			},
			type:'TextField',
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
				filters:{pfiltro:'arxls.estado_reg',type:'string'},
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
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'arxls.usuario_ai',type:'string'},
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
				filters:{pfiltro:'arxls.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'arxls.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
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
				filters:{pfiltro:'arxls.fecha_mod',type:'date'},
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
	title:'Archivo Excel',
	ActSave:'../../sis_parametros/control/PlantillaArchivoExcel/insertarPlantillaArchivoExcel',
	ActDel:'../../sis_parametros/control/PlantillaArchivoExcel/eliminarPlantillaArchivoExcel',
	ActList:'../../sis_parametros/control/PlantillaArchivoExcel/listarPlantillaArchivoExcel',
	id_store:'id_plantilla_archivo_excel',
	fields: [
		{name:'id_plantilla_archivo_excel', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'hoja_excel', type: 'string'},
		{name:'fila_inicio', type: 'numeric'},
		{name:'fila_fin', type: 'numeric'},
		{name:'filas_excluidas', type: 'numeric'},
		{name:'tipo_archivo', type: 'string'},
		{name:'delimitador', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'}
	],
	sortInfo:{
		field: 'id_plantilla_archivo_excel',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	south : {
		url : '../../../sis_parametros/vista/columnas_archivo_excel/ColumnasArchivoExcel.php',
		title : 'Columnas Excel',
		height : '50%',
		cls : 'ColumnasArchivoExcel'
	},

	iniciarEventos:function(){

		this.cmpTipoArchivo = this.getComponente('tipo_archivo');
		this.cmpDelimitador = this.getComponente('delimitador');
		this.ocultarComponente(this.cmpDelimitador);

		this.cmpTipoArchivo.on('select',function(com,dat){

			if(dat.data.field1 == 'csv'){
				this.mostrarComponente(this.cmpDelimitador);
			}else{
				this.ocultarComponente(this.cmpDelimitador);
			}
		},this);
	}
	}
)
</script>
		
		