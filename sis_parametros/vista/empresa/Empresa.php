<?php
/**
*@package pXP
*@file gen-Empresa.php
*@author  (admin)
*@date 04-02-2013 16:03:19
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Empresa=Ext.extend(Phx.gridInterfaz,{
   constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Empresa.superclass.constructor.call(this,config);
		
		this.init();
		this.addButton('bLogo',{text:'Subir Logo',iconCls:'bupload',disabled:true,handler:this.SubirLogo,tooltip: '<b>Subir archivo</b><br/>Permite actualizar el logotipo'});
		
		this.load({params:{start:0, limit:50}})
	},
	 SubirLogo:function()
		{					
			var rec=this.sm.getSelected();
			
						
			Phx.CP.loadWindows('../../../sis_parametros/vista/empresa/subirLogo.php',
			'subir Logo',
			{
				modal:true,
				width:500,
				height:250
		    },rec.data,this.idContenedor,'subirLogo')
	 },
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_empresa'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Codigo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:150
			}, 
			type:'TextField',
			filters:{pfiltro:'emp.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 250,
				maxLength:150
			}, 
			type:'TextField',
			filters:{pfiltro:'emp.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nit',
				fieldLabel: 'NIT',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:150
			},
			type:'TextField',
			filters:{pfiltro:'emp.nit',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'logo',
				fieldLabel: 'Logo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255,
				renderer:function (value, p, record){	
						var splittedArray = record.data['logo'].split('.');
						if (splittedArray[splittedArray.length - 1] != "") {
							return  String.format('{0}',"<div style='text-align:center'><img src = '../../../control/_archivos/"+ record.data['logo']+"?date ="+Date('H:i:s')+"  ' align='center' /></div>");
						} else {
							return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/NoPerfilImage.jpg' align='center' width='70' height='70'/></div>");
						}
					},
			},
			type:'TextField',
			filters:{pfiltro:'emp.logo',type:'string'},
			id_grupo:1,
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
			filters:{pfiltro:'emp.estado_reg',type:'string'},
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
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'emp.fecha_reg',type:'date'},
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
			filters:{pfiltro:'emp.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	 preparaMenu:function(n){
	 	var tb = Phx.vista.Empresa.superclass.preparaMenu.call(this,n);
      	this.getBoton('bLogo').enable();
      	 return tb
	},
	liberaMenu:function(n){
	 	var tb = Phx.vista.Empresa.superclass.liberaMenu.call(this,n);
      	this.getBoton('bLogo').disable();
      	 return tb
	},
	title:'Empresa',
	ActSave:'../../sis_parametros/control/Empresa/insertarEmpresa',
	ActDel:'../../sis_parametros/control/Empresa/eliminarEmpresa',
	ActList:'../../sis_parametros/control/Empresa/listarEmpresa',
	id_store:'id_empresa',
	fields: [
		{name:'id_empresa', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'logo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'nit', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'codigo'
		
	],
	sortInfo:{
		field: 'id_empresa',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>		
		
