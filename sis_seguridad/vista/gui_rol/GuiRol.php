<?php
/**
*@package pXP
*@file GuiRol.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para asociar las vistas a un rol
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.gui_rol=function(config){
	
   this.Atributos =[
		{
			//configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_gui'

			},
			type:'Field',
			form:true

		},
			{
			//configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_gui_padre'

			},
			type:'Field',
			form:true

		},
		{
			//configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_subsistema'

			},
			type:'Field',
			form:true

		},
		{
			//configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_rol'

			},
			type:'Field',
			form:true

		},{
			config:{
			fieldLabel: "nombre",
			gwidth: 120,
			name: 'nombre',
			allowBlank:false,
			anchor:'100%'
			
		},
		type:'Field',
		id_grupo:0,
		form:true
	},
	{
		config:{
			fieldLabel: "Descripción",
			gwidth: 120,
			name: 'descripcion',
			allowBlank:false,
			anchor:'100%'
		},
		type:'Field',
		id_grupo:0,
		form:true
	},
	{
		config:{
			fieldLabel: "Codigo",
			gwidth: 120,
			name: 'codigo_gui',
			allowBlank:false,
			anchor:'100%'
			
		},
		type:'TextField',
		id_grupo:0,
		form:true
	},
		{
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'checked'
							
			},
			type:'Field',
			form:true
		},
		{
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'tipo_meta'
							
			},
			type:'Field',
			form:true
		}
		];
	
		
		
		Phx.vista.gui_rol.superclass.constructor.call(this,config);
			
		
	
		this.init();	
		
		this.root.ui.hide();
		this.treePanel.getTopToolbar().disable();
		
		
			
}






Ext.extend(Phx.vista.gui_rol,Phx.arbInterfaz,{

	    title:'GUI ROL',
		ActList:'../../sis_seguridad/control/GuiRol/listarGuiRol',  
		enableDD:false,
		expanded:false,
		
		NodoCheck:true,//si los nodos tienen los valos para el check
		ActCheck:'../../sis_seguridad/control/GuiRol/checkGuiRol',
		textRoot:'Asignacion de Permisos',
		rootVisible:true,
		rootExpandable:false,
		//rootHidden:true,
		id_nodo:'id_gui_proc',
		id_nodo_p:'id_gui_padre',
		fields:[
		{name:'id'},
		{name:'id_gui_proc'},
		{name:'id_gui_padre'},
		{name:'nombre',type:'string'},
		{name:'descripcion',type:'string'},
		{name:'text',type:'string'},	
		{name:'tipo_meta',type:'string'},
		{name:'checked'},
		{name:'qtip'}

		],
		sortInfo:{
			field: 'id',
			direction: 'ASC'
		},
			
		bdel:false,//boton para eliminar
		bsave:false,//boton para eliminar
		bdet:false,
		bnew:false,
		bedit:false,
		
		grupos:[
			{
				tituloGrupo:'Oculto',
				columna:0,
				id_grupo:0
			}],
		
		onReloadPage:function(m){
			this.root.ui.show();
			//this.root.hidden=false;
			//this.treePanel.setRootNode(this.root)
			this.maestro=m;
			//this.getComponente('id_subsistema').setValue(m.id_subsistema);
			//this.getComponente('id_rol').setValue(m.id_rol);
			if(this.maestro.id_subsistema!='' && this.maestro.id_subsistema!=undefined){
				this.getBoton('act').enable();
				this.loaderTree.baseParams={id_rol:this.maestro.id_rol,id_subsistema:this.maestro.id_subsistema};
				this.root.reload();
				this.paramsCheck={id_rol:this.maestro.id_rol,id_subsistema:this.maestro.id_subsistema};
				
			}
			else{
				this.getBoton('act').disable();
				
			}
		},
				
		//estable el manejo de eventos del formulario
		/*iniciarEventos:function(){
			
			
			
			//this.treePanel.on('checkchange',this.onCheckChange)
			
		},*/
		
	
}


)
</script>
