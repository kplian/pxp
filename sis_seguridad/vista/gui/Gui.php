<?php
/**
*@package pXP
*@file Gui.php 
*@author KPLIAN (admin) 
*@date 14-02-2011
*@description  Vista para registrar la vistas
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.gui=function(config) {
	   this.Atributos =[
	      //Primera posicion va el identificador de nodo
		{
			// configuracion del componente (el primero siempre es el
			// identificador)
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_gui'

			},
			type:'Field',
			form:true  

		},
		 //En segunda posicion siempre va el identificador del nodo padre
			{
			// configuracin del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name:'id_gui_padre'

			},
			type:'Field',
			form:true

		},
		{ 
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
		
		{   config:{
			name:'tipo_dato',
			fieldLabel:'Tipo Nodo',
			typeAhead: true,
			allowBlank:false,
    		triggerAction: 'all',
    		emptyText:'Seleccione un tipo...',
    		selectOnFocus:true,
   			mode:'local',
			store:['carpeta','interface','reporte'],
			valueField:'ID',
			width:150,			
				
			   },
			type:'ComboBox',
			id_grupo:0,
			form:true
		},
		{
			config:{
				name:'visible',
				fieldLabel:'Visible',
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
			id_grupo:1,
			form:true
		},
		{config:{
				fieldLabel: "Orden Logico",
				gwidth: 100,
				width:'100%',
				maxLength:15,
				minLength:1,
				allowBlank:false,
				selectOnFocus:true,
				allowDecimals:false,
				allowNegative:false,
				minValue:1,
				name: 'orden_logico'
			},
			type:'NumberField',
			id_grupo:1,
			form:true
		},
		{
			config:{
				fieldLabel: "Ruta Archivo",
				gwidth: 120,
				name: 'ruta_archivo',
				
				allowBlank:false,
				anchor:'100%'
				
			},
			type:'TextArea',
			id_grupo:1,
			form:true
		},
	    {config:{
			fieldLabel: "Nivel",
			disabled:true,
			gwidth: 100,
			width:'100%',
			maxLength:15,
			minLength:1,
			allowBlank:false,
			selectOnFocus:true,
			allowDecimals:false,
			allowNegative:false,
			minValue:1,
			name: 'nivel'
			},
			type:'NumberField',
			id_grupo:1,
			filters:{type: 'numeric'},
		
			form:true
		},
		{	config:{
					fieldLabel: "Icono",
					gwidth: 120,
					
					name: 'icono',
					allowBlank:true,
					anchor:'100%'
					
				},
				type:'TextArea',
				id_grupo:1,
				
				form:true
		},
		{config:{
				fieldLabel: "Nombre de la Clase",
				gwidth: 120,
				
				name: 'clase_vista',
				allowBlank:false,
				anchor:'100%'
				
			},
			type:'TextField',
			id_grupo:1,
			form:true
		},
		{
			config:{
				fieldLabel: "Parametros",
				gwidth: 120,
				name: 'json_parametros',
				
				allowBlank:true,
				anchor:'100%'
				
			},
			type:'TextArea',
			id_grupo:1,
			form:true
		},
        {
            config:{
                name:'sw_mobile',
                fieldLabel:'Mobile',
                typeAhead: true,
                allowBlank:false,
                triggerAction: 'all',
                emptyText:'Seleccione Opcion...',
                selectOnFocus:true,
                mode:'local',
                store:new Ext.data.ArrayStore({
                fields: ['ID', 'valor'],
                data :  [['si','si'],   
                        ['no','no']]
                            
                }),
                valueField:'ID',
                displayField:'valor',
                width:150,          
                
            },
            type:'ComboBox',
            valorInicial:'no',
            id_grupo:3,
            form:true
        },
        {
            config:{
                fieldLabel: "Codigo Mobile",
                gwidth: 120,
                name: 'codigo_mobile',
                
                allowBlank:true,
                anchor:'100%'
                
            },
            type:'TextField',
            id_grupo:3,
            form:true
        },
        {config:{
            fieldLabel: "Orden Mobile",
            gwidth: 100,
            width:'100%',
            maxLength:15,
            minLength:1,
            allowBlank:true,
            selectOnFocus:true,
            allowDecimals:false,
            allowNegative:false,
            minValue:0,
            name: 'orden_mobile'
            },
            type:'NumberField',
            valorInicial:0.0,
            id_grupo:3,
            filters:{type: 'numeric'},
        
            form:true
        }];
		
		Phx.vista.gui.superclass.constructor.call(this,config);
		
			//inicia los eventos del formulario
		this.iniciarEventos();
		
		
		//de inicio bloqueamos el botono nuevo
		this.tbar.items.get('b-new-'+this.idContenedor).disable()
		
			
		this.init();
		
		
		this.loaderTree.baseParams={id_subsistema:this.id_subsistema};
	
		
}


Ext.extend(Phx.vista.gui,Phx.arbInterfaz,{
    	title:'GUI',
    	ActDragDrop:'../../sis_seguridad/control/Gui/guardarGuiDragDrop',
		ActSave:'../../sis_seguridad/control/Gui/guardarGui',
		ActDel:'../../sis_seguridad/control/Gui/eliminarGui',	
		ActList:'../../sis_seguridad/control/Gui/listarGui',
	    enableDD:true,
	    idNodoDD: 'id_gui',
	    idOldParentDD: 'id_gui_padre',
	    idTargetDD:'id_gui',
		expanded:false,
		useArrows: true,
		rootVisible: true,
		fheight:'50%',
		fwidth:'900',
		textRoot:'Menú de navegación',
		id_nodo:'id_gui',
		id_nodo_p:'id_gui_padre',
		fields: [
		'id', //identificador unico del nodo (concatena identificador de tabla con el tipo de nodo)
		      //porque en distintas tablas pueden exitir idetificadores iguales
		'tipo_meta',
		'id_gui',
		'id_gui_padre',
		'nombre',
		'descripcion',
		'visible',
		'orden_logico',
		'ruta_archivo',
		'json_parametros',
		'icono',
		'sw_mobile',
		'codigo_mobile',
		'orden_mobile'],
		sortInfo:{
			field: 'id',
			direction:'ASC'
		},
		//sobrecarga prepara menu
		preparaMenu:function(n){
			//si es una nodo tipo carpeta habilitamos la opcion de nuevo	
			if((n.attributes.tipo_dato == 'carpeta' || n.attributes.tipo_dato == 'interface' )&& n.attributes.id != 'id'){
					this.tbar.items.get('b-new-'+this.idContenedor).enable()
				}
				else {
					this.tbar.items.get('b-new-'+this.idContenedor).disable()
				}
			
		
			// llamada funcion clace padre
			Phx.vista.gui.superclass.preparaMenu.call(this,n)
		},
		/*Sobre carga boton new */
		
		loadValoresIniciales:function(){
			var nodo = this.sm.getSelectedNode();			
			Phx.vista.gui.superclass.loadValoresIniciales.call(this);			
			this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
			if(nodo.attributes.tipo_dato=='interface'){
				//componente 5 y tipo_dato son el mismo
				this.getComponente('tipo_dato').disable();				
				this.Componentes[5].setValue('interface');
				this.getComponente('ruta_archivo').enable();
				this.getComponente('icono').enable();
				this.getComponente('clase_vista').enable();
				this.getComponente('json_parametros').enable();
			}
			else{
				
				this.getComponente('tipo_dato').enable();
				this.getComponente('ruta_archivo').disable();
				this.getComponente('icono').disable();
				this.getComponente('clase_vista').disable();
				this.getComponente('json_parametros').disable();
				
			}	
		
		
	     },
		
	/*	onButtonNew:function(){
			var nodo = this.sm.getSelectedNode();			
			Phx.vista.gui.superclass.onButtonNew.call(this);			
			this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
			if(nodo.attributes.tipo_dato=='interface'){
				//componente 5 y tipo_dato son el mismo
				this.getComponente('tipo_dato').disable();				
				this.Componentes[5].setValue('interface');
				this.getComponente('ruta_archivo').enable();
				this.getComponente('icono').enable();
				this.getComponente('clase_vista').enable();
			}
			else{
				
				this.getComponente('tipo_dato').enable();
				this.getComponente('ruta_archivo').disable();
				this.getComponente('icono').disable();
				this.getComponente('clase_vista').disable();
				
			}	
		},*/
		
		/*Sobre carga boton EDIT */
		onButtonEdit:function(){
	
			var nodo = this.sm.getSelectedNode();			
						
			//this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
			
			if(nodo.attributes.tipo_dato=='interface'){		
				
				//componente 5 y tipo_dato son el mismo
				this.getComponente('tipo_dato').disable();				
				this.Componentes[5].setValue('interface');
				this.getComponente('ruta_archivo').enable();
				this.getComponente('icono').enable();
				this.getComponente('clase_vista').enable();
				this.getComponente('json_parametros').enable();
			}
			else{
				
				this.getComponente('tipo_dato').enable();
				this.getComponente('ruta_archivo').disable();
				this.getComponente('icono').disable();
				this.getComponente('clase_vista').disable();
				this.getComponente('json_parametros').disable();
			}	
			Phx.vista.gui.superclass.onButtonEdit.call(this);
		},
		
	
		
		//estable el manejo de eventos del formulario
		iniciarEventos:function(){
			this.getComponente('tipo_dato').on('beforeselect',function(combo,record,index){
				if(record.json[0]=='interface'){
				
					this.getComponente('ruta_archivo').enable();
				    this.getComponente('icono').enable();
				    this.getComponente('clase_vista').enable();
				    this.getComponente('json_parametros').enable();
				}
				else{ 
					this.getComponente('ruta_archivo').disable();
					this.getComponente('icono').disable();
					this.getComponente('clase_vista').disable();
					this.getComponente('json_parametros').disable();
				}
			},this)
		},
	/*
	 * south:{ url:'../../sis_legal/vista/representante/representante.php',
	 * title:'Representante', height:200 },
	 */	
		 
		east:{
		  url:'../../../sis_seguridad/vista/procedimiento_gui/ProcedimientoGui.php',
		  title:'Procedimientos', 
		  width:400,
		  cls:'procedimiento_gui'
		 },
		bdel:true,// boton para eliminar
		bsave:false,// boton para eliminar
		
		//DEFINIE LA ubicacion de los datos en el formulario

    Grupos: [
            {
                layout: 'column',
                border: false,
                // defaults are applied to all child items unless otherwise specified by child item
                defaults: {
                   // columnWidth: '.5',
                    border: false
                },            
                items: [{
    					       
    					        bodyStyle: 'padding-right:5px;',
    					        items: [{
    					            xtype: 'fieldset',
    					            title: 'Datos principales',
    					            autoHeight: true,
    					            items: [],
    						        id_grupo:0
    					        }]
    					    }, {
                                bodyStyle: 'padding-left:5px;',
                                items: [{
                                    xtype: 'fieldset',
                                    title: 'Mobile',
                                    autoHeight: true,
                                    items: [],
                                    id_grupo:3
                                }]
                            }
                        , {
					        bodyStyle: 'padding-left:5px;',
					        items: [{
					            xtype: 'fieldset',
					            title: 'Orden y rutas',
					            autoHeight: true,
					            items: [],
						        id_grupo:1
					        }]
					    }]
            }
        ]

}
)
</script>