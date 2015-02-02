<?php
/**
*@package pXP
*@file RepFuncionarioUo.php
*@author  rcm
*@date 17/05/2013
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.RepFuncionarioUo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config;
		console.log(this.maestro)
    	//llama al constructor de la clase padre
		Phx.vista.RepFuncionarioUo.superclass.constructor.call(this,config);
		this.init();
		
		this.dteFecha = new Ext.form.DateField({
		    name: 'fecha',
		    format: 'd/m/Y',
		    allowBlank: false,
	        width:103
		});
		this.dteFecha.setValue(new Date());
		this.tbar.add('Fecha: ',this.dteFecha);
		
		
		this.load({params:{start:0, limit:50,fecha:this.dteFecha.getValue(),id_uo:this.maestro.id_uo}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uo_funcionario'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'desc_funcionario1',
				fieldLabel: 'Nombre Completo',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'vfun.desc_funcionario1',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'fun.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_cargo',
				fieldLabel: 'Cargo',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'uo.nombre_cargo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'ci',
				fieldLabel: 'CI',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'vfun.ci',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_ingreso',
				fieldLabel: 'Fecha Ingreso',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'fun.fecha_ingreso',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'email_empresa',
				fieldLabel: 'Email Empresarial',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'fun.email_empresa',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'telefono_ofi',
				fieldLabel: 'Telf. Oficina',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'fun.telefono_ofi',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'interno',
				fieldLabel: 'Interno',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'fun.interno',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'telefono',
				fieldLabel: 'Teléfonos',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'per.telefono1#per.telefono2',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'celular',
				fieldLabel: 'Celular',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'per.celular1#per.celular2',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'correo',
				fieldLabel: 'Correo personal',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'per.correo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
	],
	title:'Funcionarios x Unidad',
	ActSave:'../../sis_organigrama/control/EstructuraUo/insertarFuncionarioUo',
	ActDel:'../../sis_organigrama/control/EstructuraUo/eliminarFuncionarioUo',
	ActList:'../../sis_organigrama/control/UoFuncionario/ListarUoFuncionario',
	id_store:'id_uo_funcionario',
	fields: [
		{name:'id_uo_funcionario', type: 'numeric'},
		{name:'desc_funcionario1', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'nombre_cargo', type: 'string'},
		{name:'ci', type: 'string'},
		{name:'fecha_ingreso', type: 'date', dateFormat:'Y-m-d'},
		{name:'email_ingreso', type: 'string'},
		{name:'telefono_ofi', type: 'string'},
		{name:'interno', type: 'string'},
		{name:'telefono', type: 'string'},
		{name:'celular', type: 'string'},
		{name:'correo', type: 'string'},
		{name:'horario1', type: 'numeric'},
		{name:'horario2', type: 'numeric'},
		{name:'horario3', type: 'numeric'},
		{name:'horario4', type: 'numeric'}
	],
	sortInfo:{
		field: 'uo.nombre_cargo',
		direction: 'ASC'
	},
	bdel:false,
	bsave:false,
	bedit:false,
	bnew:false,
    codReporte:'S/C',
	codSistema:'PXP',
	pdfOrientacion:'L',
	onButtonAct: function(){
		if(this.dteFecha.isValid()){
			this.load({params:{start:0, limit:50,fecha:this.dteFecha.getValue(),id_uo:this.maestro.id_uo}})
		}
	}
})
</script>