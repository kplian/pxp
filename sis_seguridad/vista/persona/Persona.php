<?php
/**
*@package pXP
*@file Persona.php
*@author KPLIAN (JRR)
*@date 14-02-2011
*@description  Vista para regitro de datos de persona 
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.persona=Ext.extend(Phx.gridInterfaz,{
	Atributos:[
	{
   	  config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_persona'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Nombre",
			gwidth: 130,
			name: 'nombre',
			allowBlank:false,	
			maxLength:150,
			minLength:2,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true,
		egrid:true
	},
	 {
		config:{
			fieldLabel: "Apellido Paterno",
			gwidth: 130,
			name: 'ap_paterno',
			allowBlank:false,	
			maxLength:150,
			
			anchor:'100%'
		},
		type:'TextField',
		filters:{pfiltro:'p.apellido_paterno',type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Apellido Materno",
			gwidth: 130,
			name: 'ap_materno',
			allowBlank:true,	
			maxLength:150,
			anchor:'100%'
		},
		type:'TextField',
		filters:{pfiltro:'p.apellido_materno',type:'string'},//p.apellido_paterno
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Foto",
			gwidth: 130,
			inputType:'file',
			name: 'foto',
			//allowBlank:true,
			  buttonText: '',	
			maxLength:150,
			anchor:'100%',
			renderer:function (value, p, record){	
						var momentoActual = new Date();
					
						var hora = momentoActual.getHours();
						var minuto = momentoActual.getMinutes();
						var segundo = momentoActual.getSeconds();
						
						hora_actual = hora+":"+minuto+":"+segundo;
						
					
						
						//return  String.format('{0}',"<div style='text-align:center'><img src = ../../control/foto_persona/"+ record.data['foto']+"?"+record.data['nombre_foto']+hora_actual+" align='center' width='70' height='70'/></div>");
						return  String.format('{0}',"<div style='text-align:center'><img src = '../../control/foto_persona/ActionArmafoto.php?nombre="+ record.data['foto']+"&asd="+hora_actual+"' align='center' width='70' height='70'/></div>");
					},	
			buttonCfg: {
                iconCls: 'upload-icon'
            }
		},
		//type:'FileUploadField',
		type:'Field',
		sortable:false,
		//filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:false
	},
	 {
		config:{
			fieldLabel: "CI",
			gwidth: 80,
			name: 'ci',
			allowBlank:true,	
			maxLength:15,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Telefono",
			gwidth: 120,
			name: 'telefono1',
			allowBlank:true,	
			maxLength:15,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	{
		config:{
			fieldLabel: "Celular",
			gwidth: 120,
			name: 'celular1',
			allowBlank:true,	
			maxLength:15,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Correo",
			gwidth: 150,
			name: 'correo',
			allowBlank:true,
			vtype:'email',	
			maxLength:100,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Telefono 2",
			gwidth: 120,
			name: 'telefono2',
			allowBlank:true,	
			maxLength:15,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	{
		config:{
			fieldLabel: "Celular 2",
			gwidth: 120,
			name: 'celular2',
			allowBlank:true,	
			maxLength:15,
			minLength:5,
			anchor:'100%'
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	}
	],


    fileUpload:true,
	title:'Persona',
	ActSave:'../../sis_seguridad/control/Persona/guardarPersona',
	ActDel:'../../sis_seguridad/control/Persona/eliminarPersona',
	ActList:'../../sis_seguridad/control/Persona/listarPersonaFoto',
	id_store:'id_persona',
	fields: [
	{name:'id_persona'},
	{name:'nombre', type: 'string'},
	{name:'ap_paterno', type: 'string'},
	{name:'ap_materno', type: 'string'},
	{name:'ci', type: 'string'},
	{name:'correo', type: 'string'},
	{name:'celular1'},
	{name:'telefono1'},
	{name:'telefono2'},
	{name:'celular2'},
	{name:'foto'}
	
		],
	sortInfo:{
		field: 'id_persona',
		direction: 'ASC'
	},
	bdel:true,// boton para eliminar
	bsave:true,// boton para eliminar


	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.persona.superclass.preparaMenu.call(this,tb)
		this.getBoton('aSubirFoto').enable();
	},
	
	liberaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.persona.superclass.liberaMenu.call(this,tb)
		this.getBoton('aSubirFoto').disable();
		
	},

	/*
	 * Grupos:[{
	 * 
	 * xtype:'fieldset', border: false, //title: 'Checkbox Groups', autoHeight:
	 * true, layout: 'form', items:[], id_grupo:0 }],
	 */

	constructor: function(config){
		// configuracion del data store
		Phx.vista.persona.superclass.constructor.call(this,config);
		this.init();
		// this.addButton('my-boton',{disabled:false,handler:myBoton,tooltip:
		// '<b>My Boton</b><br/>Icon only button with tooltip'});
		this.load({params:{start:0, limit:50}})
		//agregamos boton para mostrar ventana hijo
		this.addButton('aSubirFoto',{text:'Subir archivo',iconCls: 'blist',disabled:true,handler:SubirFoto,tooltip: '<b>Subir archivo</b><br/>Permite actualizar la foto de la persona'});
		
		function SubirFoto()
		{					
			var rec=this.sm.getSelected();
			//console.log(' rec',rec)
						
			Phx.CP.loadWindows('../../../sis_seguridad/vista/persona/subirFotoPersona.php',
			'Subir foto',
			{
				modal:true,
				width:400,
				height:150
		    },rec.data,this.idContenedor,'subirFotoPersona')
		}
		
		
	}

}
)
</script>