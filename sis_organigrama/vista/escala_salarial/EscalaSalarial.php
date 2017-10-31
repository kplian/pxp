<?php
/**
*@package pXP
*@file gen-EscalaSalarial.php
*@author  (admin)
*@date 14-01-2014 00:28:29
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.EscalaSalarial=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.EscalaSalarial.superclass.constructor.call(this,config);
		this.init();		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_escala_salarial'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_categoria_salarial'
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
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'escsal.codigo',type:'string'},
				id_grupo:1,
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
				maxLength:200
			},
				type:'TextField',
				filters:{pfiltro:'escsal.nombre',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'nro_casos',
				fieldLabel: 'No Casos',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'NumberField',
				filters:{pfiltro:'escsal.nro_casos',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'haber_basico',
				fieldLabel: 'Haber Básico',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:589826
			},
				type:'NumberField',
				filters:{pfiltro:'escsal.haber_basico',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'aprobado',
				fieldLabel: 'Aprobado',
				allowBlank: false,
				emptyText:'Aprobado...',
	       		typeAhead: true,
	       		triggerAction: 'all',
	       		lazyRender:true,
	       		mode: 'local',
				gwidth: 100,
				store:['si','no']
			},
				type:'ComboBox',
				filters:{	
	       		         type: 'list',
	       				 options: ['si','no'],	
	       		 	},
				id_grupo:1,
				grid:true,
				form:true
		},		
		{
			config:{
				name: 'fecha_ini',
				fieldLabel: 'Aplicado Desde',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'escsal.fecha_ini',type:'date'},
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'fecha_fin',
				fieldLabel: 'Aplicado Hasta',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'escsal.fecha_fin',type:'date'},
				grid:true,
				form:false
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
				filters:{pfiltro:'escsal.estado_reg',type:'string'},
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
				filters:{pfiltro:'escsal.fecha_reg',type:'date'},
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
				filters:{pfiltro:'escsal.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Escala Salarial',
	ActSave:'../../sis_organigrama/control/EscalaSalarial/insertarEscalaSalarial',
	ActDel:'../../sis_organigrama/control/EscalaSalarial/eliminarEscalaSalarial',
	ActList:'../../sis_organigrama/control/EscalaSalarial/listarEscalaSalarial',
	id_store:'id_escala_salarial',
	fields: [
		{name:'id_escala_salarial', type: 'numeric'},
		{name:'aprobado', type: 'string'},
		{name:'id_categoria_salarial', type: 'numeric'},
		{name:'fecha_fin', type: 'date',dateFormat:'Y-m-d'},
		{name:'estado_reg', type: 'string'},
		{name:'haber_basico', type: 'numeric'},
		{name:'fecha_ini', type: 'date',dateFormat:'Y-m-d'},
		{name:'nro_nivel', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'nro_casos', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_escala_salarial',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onReloadPage:function(m){
			this.maestro=m;			
			this.getBoton('act').enable();
			this.store.baseParams.id_categoria_salarial = 	this.maestro.id_categoria_salarial;	
			this.load({params:{start:0, limit:this.tam_pag}});			
	},
	loadValoresIniciales:function()
    {
        this.Cmp.id_categoria_salarial.setValue(this.maestro.id_categoria_salarial);       
        Phx.vista.EscalaSalarial.superclass.loadValoresIniciales.call(this);
    },
    onButtonNew:function(){
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		//this.ocultarComponente(this.Cmp.fecha_ini);
		Phx.vista.EscalaSalarial.superclass.onButtonNew.call(this);
		//seteamos un valor fijo que vienen de la vista maestro para id_gui 
		
		
	},onButtonEdit:function(){
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		
		this.mostrarComponente(this.Cmp.fecha_ini);
		this.ocultarComponente(this.Cmp.codigo);
		Phx.vista.EscalaSalarial.superclass.onButtonEdit.call(this);
	}
	}
)
</script>
		
		