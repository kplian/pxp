<?php
/**
*@package pXP
*@file Subsistema.php  
*@author KPLIAN (RAC)
*@date 14-02-2011
*@description  Vista para mostrar listado de subsistemas
* 	ISSUE  			FECHA  				AUTHOR						DESCRIPCION
*   #0              4/02/2011            RAC    Creación 
*	#1				03/12/2018			 EGS	Se aumento opcion en menu solo para inserte gui y estructura gui activo visibles
*	#2				05/12/2018	         EGS	Se agrego un boton donde solo se exporte los procedimientos, funciones y roles 
    #103		    09-01-2020	         RAC    adiciona columnas para manejo de importacion de git y reportes
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Subsistema=Ext.extend(Phx.gridInterfaz,{

	Atributos:[
	{
		// configuracion del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_subsistema'

		},
		type:'Field',
		form:true 
		
	},
	 {
		config:{
			fieldLabel: "Codigo",
			gwidth: 100,
			name: 'codigo',
			allowBlank:false,	
			maxLength:20,
			minLength:2
		},
		type:'TextField',
		filters:{type:'string'},
		bottom_filter: true,
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Prefijo",
			gwidth: 80,
			name: 'prefijo',
			allowBlank:false,	
			maxLength:10,
			minLength:2
		},
		type:'TextField',
		filters:{type:'string'},
		bottom_filter: true,
		id_grupo:0,
		grid:true,
		form:true
	},
	 {
		config:{
			fieldLabel: "Nombre",
			gwidth: 220,
			name: 'nombre',
			allowBlank:false,	
			maxLength:50,
			minLength:5
		},
		type:'TextField',
		filters:{type:'string'},
		bottom_filter: true,
		id_grupo:0,
		grid:true,
		form:true
	},
	{
		config:{
			fieldLabel: "Nombre Carpeta",
			gwidth: 220,
			name: 'nombre_carpeta',
			allowBlank:false,	
			maxLength:50,
			minLength:5
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	{
		config:{
			fieldLabel: "Organizacion",
			qtip: 'Nombre de la organizacion que aloja el repositorio  Ejm   KPLIAN', 
			gwidth: 220,
			name: 'organizacion_git',
			allowBlank:true,	
			maxLength:50,
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
	{
		config:{
			fieldLabel: "Nombre GIT",
			qtip: 'Nombre de sistema en GIT, ejm pxp, esto mas la organizacion permite armaar la url del repositorio,    http://github.com/KPLIAN/pxp', 
			gwidth: 220,
			name: 'codigo_git',
			allowBlank:true,	
			maxLength:50,
		},
		type:'TextField',
		filters:{type:'string'},
		id_grupo:0,
		grid:true,
		form:true
	},
    {
            config:{
                name: 'sw_importacion',
                fieldLabel: 'Importacion GIT',
                qtip: 'habilita la importació de la tareas realizadas desde git (issues, commits, etc)',
                allowBlank: false,
                anchor: '40%',
                gwidth: 50,
                maxLength:2,
                emptyText:'si/no...',                   
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                valueField: 'no',          
                store:['si','no']
            },
            type:'ComboBox',
            id_grupo:1,
            filters:{   
                         type: 'list',
                         pfiltro:'subsis.sw_importacion',
                         options: ['si','no'],  
                    },
            grid:true,
            form:true
      }
	],

	title:'Subsistema',
	ActSave:'../../sis_seguridad/control/Subsistema/guardarSubsistema',
	ActDel:'../../sis_seguridad/control/Subsistema/eliminarSubsistema',
	ActList:'../../sis_seguridad/control/Subsistema/listarSubsistema',
	id_store:'id_subsistema',
	fields: [
				{name:'id_subsistema'},
				{name:'codigo', type: 'string'},
				{name:'prefijo', type: 'string'},
				{name:'nombre', type: 'string'},
				{name:'nombre_carpeta', type: 'string'},'organizacion_git','codigo_git','sw_importacion'

		],
	sortInfo:{
		field: 'id_subsistema',
		direction: 'ASC'
	},
		
	bdel:true,// boton para eliminar
	bsave:false,// boton para eliminar
	tabeast:[
		{
		  url:'../../../sis_seguridad/vista/funcion/Funcion.php',
		  title:'Funcion', 
		  width:600,
		  cls:'funcion'
		 },
         {
          url:'../../../sis_seguridad/vista/video/Video.php',
          title:'Video', 
          width:600,
          cls:'Video'
         },
        {
            url:'../../../sis_seguridad/vista/branches/Branches.php',
            title:'Branch',
            width:600,
            cls:'Branches'
        }
          
        ],

	/*east:{
		  url:'../../../sis_seguridad/vista/funcion/Funcion.php',
		  title:'Funcion', 
		  width:400,
		  cls:'funcion'
		 },*/
	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.Subsistema.superclass.preparaMenu.call(this,tb)
	},


	constructor: function(config){
		// configuracion del data store
		
		Phx.vista.Subsistema.superclass.constructor.call(this,config);

		this.init();
		
		this.addButton('aInterSis',{text:'Interfaces',iconCls: 'blist',disabled:true,handler: aInterSis, tooltip: '<b>Interfaces del Sistema</b><br/>Permite configurar transacciones por interfaz '});
        this.addButton('tgithub',{text:'Importar GitHub',iconCls: 'blist',disabled:false,handler:this.onApiGitHub,tooltip: '<b>Importar GitHub</b><br/>Sinc '});

        this.addButton('sinc_func',{text:'Sincronizar',iconCls: 'blist',disabled:true,handler: sinc_func, tooltip: '<b>Sincronizar Funciones</b><br/>Sinc '});
		this.addButton('exp_menu',{text:'Exportar Datos Seguridad',iconCls: 'blist',disabled:true,tooltip: '<b>Permite exportar los datos de seguridad del subsistema</b>',
                		menu:{
                   				items: [
                   				{
                   					text: 'Exportar Cambios Realizados', handler: this.expMenu, scope: this, argument : {todo:'no'}
                   				},{
                   					text: 'Exportar Todos los Datos de Seguridad', handler: this.expMenu, scope: this, argument : {todo : 'si'}
                   				},
                   				{
                   					text: 'Exportar Todos los Datos Actuales', handler: this.expMenu, scope: this, argument : {todo : 'actual'}//  ///#1	EGS		03/12/2018
                   				}
                   				]
                   			}
                   		});
        ///#1	EGS		03/12/2018
        this.addButton('exp_rolPro',{text:'Exportar Datos de Roles y Procedimientos',iconCls: 'blist',disabled:true,tooltip: '<b>Permite exportar los datos roles y procedimientos sel subsistema/b> ',
        				menu:{
                   				items: [
                   				{
                   					text: 'Exportar Todos los Datos Actuales', handler: this.rolPro, scope: this, argument : {todo:'si'}
                   				}
                   				]
                   			}

        				});
        ///#1	EGS		03/12/2018

        this.addButton('testb',{text:'test',iconCls: 'blist',disabled:false,handler:this.text_func,tooltip: '<b>test action</b><br/>Sinc '});

        
   		
   		
		//Incluye un menú
   		/*this.menuOp = new Ext.Toolbar.SplitButton({
   			text: 'Exportar Datos Seguridad',
   			scope: this,
   			tooltip : '<b>Exportar</b><br/>',
   			id : 'b-exp_menu-' + this.idContenedor,			
   			menu:{
   				items: [
   				{
   					text: 'Exportar Cambios Realizados', handler: this.expMenu, scope: this, argument : {todo:'no'}
   				},{
   					text: 'Exportar Todos los Datos de Seguridad', handler: this.expMenu, scope: this, argument : {todo : 'si'}
   				}
   				]
   			}
   		});*/
   		//this.menuOp.bconf.id = 'b-' + 'exp_menu' + '-' + this.idContenedor;
   		//this.tbar.add(this.menuOp);
		function aInterSis(){
			
		
			var rec=this.sm.getSelected();

			Phx.CP.loadWindows('../../../sis_seguridad/vista/gui/Gui.php',
					'Interfaces',
					{
						width:900,
						height:400
				    },rec.data,this.idContenedor,'gui')
			
			
			
		}
		
		function sinc_func(){
			var data=this.sm.getSelected().data.id_subsistema;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url: '../../sis_seguridad/control/Funcion/sincFuncion',
				params: {'id_subsistema':data},
				success: this.successSinc,
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope: this
			});
		}
		this.load()
	},
	text_func :function(){
            Phx.CP.loadingShow();
            Ext.Ajax.request({
                url:'../../sis_seguridad/control/Gui/listarMenuMobile',
                params:{xxx:'xx'},
                success:this.successSinc,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });
    },
	
	
	expMenu : function(resp){
			var data=this.sm.getSelected().data.id_subsistema;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url:'../../sis_seguridad/control/Subsistema/ExportarDatosSeguridad',
				params:{'id_subsistema' : data, 'todo' : resp.argument.todo},
				success:this.successExport,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
			
	},
		
	rolPro : function(resp){
			var data=this.sm.getSelected().data.id_subsistema;
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url:'../../sis_seguridad/control/Subsistema/ExportarDatosRolProcedimiento',
				params:{'id_subsistema' : data, 'todo' : resp.argument.todo},
				success:this.successExport,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
			
	},
	successSinc:function(resp){
			
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if(!reg.ROOT.error){
				alert(reg.ROOT.detalle.mensaje)
				
			}else{
				
				alert('ocurrio un error durante el proceso')
			}
			

		

			this.reload();
			
		},
	
	
	    preparaMenu:function(tb){
			
			this.getBoton('sinc_func').enable();
			this.getBoton('aInterSis').enable();
			this.getBoton('exp_menu').enable();
			this.getBoton('exp_rolPro').enable();
			this.getBoton('tgithub').enable();


			
			
			
			Phx.vista.Subsistema.superclass.preparaMenu.call(this,tb)
			return tb
		},
	   liberaMenu:function(tb){
			
			this.getBoton('sinc_func').disable();
			this.getBoton('aInterSis').disable();
			this.getBoton('exp_menu').disable();
			this.getBoton('exp_rolPro').disable();
			this.getBoton('tgithub').disable();
			Phx.vista.Subsistema.superclass.liberaMenu.call(this,tb);
			return tb
		},
        onApiGitHub:function () {
            var rec = this.sm.getSelected().data;
            Phx.CP.loadWindows('../../../sis_seguridad/vista/subsistema/FormGitHub.php',
                'Rango Importar GitHub',
                {
                    modal: true,
                    width: 300,
                    height: 150
                }, rec, this.idContenedor, 'FormGitHub');
           /* Phx.CP.loadingShow();
            Ext.Ajax.request({
                url:'../../sis_seguridad/control/Subsistema/importarApiGitHub',
                params:{
                    id_subsistema: rec.id_subsistema,
                    codigo_git: rec.codigo_git,
                    organizacion_git: rec.organizacion_git
                },
                success:this.successSinc,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });*/
        }

}
)
</script>