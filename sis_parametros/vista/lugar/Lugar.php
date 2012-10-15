<?php
/**
*@package pXP
*@file gen-Lugar.php
*@author  (rac)
*@date 29-08-2011 09:19:28
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Lugar=Ext.extend(Phx.arbInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Lugar.superclass.constructor.call(this,config);
		
		this.init();
		
		//de inicio bloqueamos el botono nuevo
		this.tbar.items.get('b-new-'+this.idContenedor).disable()
		//this.init();
		//this.loaderTree.baseParams={id_subsistema:this.id_subsistema};
		//this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_lugar'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_lugar_fk'
				
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'codigo_largo',
				fieldLabel: 'Codigo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:25,
				disabled:true
			},
			type:'TextField',
			
			filters:{pfiltro:'lug.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Codigo corto',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:25
			},
			type:'TextField',
			filters:{pfiltro:'lug.codigo',type:'string'},
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
			filters:{pfiltro:'lug.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'lug.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		 {
	       		config:{
	       			name:'sw_municipio',
	       		    fieldLabel: 'Es municipio',
				    allowBlank: false,
					typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    store:['si','no']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		form:true
	      },
		 {
	       		config:{
	       			name:'sw_impuesto',
	       		      fieldLabel: 'Paga impuestos',
				    allowBlank: false,
					typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    store:['si','no']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		form:true
	      },
		{
	     config:{
	       			name:'tipo',
	       		      fieldLabel: 'Tipo de lugar',
				    allowBlank: false,
					typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    store:['pais','departamento', 'provincia', 'localidad','Barrio']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		form:true
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
			filters:{pfiltro:'lug.fecha_reg',type:'date'},
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
			type:'TextField',
			id_grupo:1,
			
			form:false
		}		
	],
	title:'Lugar',
	ActSave:'../../sis_parametros/control/Lugar/insertarLugar',
	ActDel:'../../sis_parametros/control/Lugar/eliminarLugar',
	ActList:'../../sis_parametros/control/Lugar/listarLugarArb',
	id_store:'id_lugar',
	textRoot:'PAISES',
	id_nodo:'id_lugar',
	id_nodo_p:'id_lugar_fk',
	fields: [
	    'id',
	    'tipo_meta',
		{name:'id_lugar', type: 'numeric'},
		{name:'id_lugar_fk', type: 'numeric'},
		{name:'codigo_largo', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		
		{name:'nombre', type: 'string'},
		{name:'sw_impuesto', type: 'string'},
		{name:'sw_municipio', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
		
	east:{
		  url:'../../../sis_parametros/vista/lugar/mapaLugar.php',
		  title:'Ubicacion Lugar', 
		  width:'50%',
		  cls:'mapaLugar'
		 },
	
	sortInfo:{
		field: 'id_lugar',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	rootVisible:true,
	//sobrecarga prepara menu
	preparaMenu:function(n){
			//si es una nodo tipo carpeta habilitamos la opcion de nuevo
							
			if(n.attributes.tipo_nodo == 'hijo' || n.attributes.tipo_nodo == 'raiz' || n.attributes.id == 'id'){
					this.tbar.items.get('b-new-'+this.idContenedor).enable()
				}
				else {
					this.tbar.items.get('b-new-'+this.idContenedor).disable()
				}
			
		
			// llamada funcion clace padre
			Phx.vista.Lugar.superclass.preparaMenu.call(this,n)
		},
		
	EnableSelect:function(n){
	    var nivel = n.getDepth();
		var direc = this.getNombrePadre(n)
		if(direc){
			Phx.CP.getPagina(this.idContenedor+'-east').ubicarPos(direc,nivel)
			Phx.vista.Lugar.superclass.EnableSelect.call(this,n)
		}
		
	},
	
	getNombrePadre:function(n){
		var direc 
		
		
		var padre = n.parentNode;
		
		
		if(padre){
			if(padre.attributes.id!='id'){
			   direc = n.attributes.nombre +' - '+ this.getNombrePadre(padre)
			   return direc;
			}else{
				
				return n.attributes.nombre;
			}
		}
		else{
				return undefined;
		}

		
	 }
		


	}
)
</script>
		
		