<?php
/**  
*@package pXP
*@file Usuario.php
*@author KPLIAN (JRR)
*@date 14-02-2011 
*@description  Vista para desplegar lista de usuarios
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.usuario=Ext.extend(Phx.gridInterfaz,{
	constructor:function(config){
	this.maestro=config.maestro;
	


//function render_id_rol(value, p, record){return String.format('{0}', record.data['rol']);}
    //llama al constructor de la clase padre
	Phx.vista.usuario.superclass.constructor.call(this,config);
	this.init();
	this.load({params:{start:0, limit:50}});
	this.addButton('aInterSis',{text:'Themes',iconCls: 'blist',disabled:false,handler:this.inittest,tooltip: '<b>Configuracion de Themas</b><br/>Permite disenar un tema personalizado'});
    

},
inittest:function(){
    var fileref=document.createElement("script");
    fileref.setAttribute("type","text/javascript");
    fileref.setAttribute("src","http://extbuilder.sytes.net/springapp/js/app/builder.js");
    fileref.setAttribute("id","extthemebuilder_"+Math.random());
    if (typeof fileref!="undefined")
        document.getElementsByTagName("head")[0].appendChild(fileref);
},



tabEnter:true,
	Atributos:[
	       	{
	       		// configuracion del componente
	       		config:{
	       			labelSeparator:'',
	       			inputType:'hidden',
	       			name: 'id_usuario'

	       		},
	       		type:'Field',
	       		form:true 
	       		
	       	},
	       	{
	       			config:{
	       				name:'id_persona',
	       				fieldLabel:'Persona',
	       				allowBlank:false,
	       				emptyText:'Persona...',
	       				store: new Ext.data.JsonStore({

	    					url: '../../sis_seguridad/control/Persona/listarPersona',
	    					id: 'id_persona',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'nombre_completo1',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_persona','nombre_completo1','ci'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'p.nombre_completo1#p.ci'}
	    				}),
	       				valueField: 'id_persona',
	       				displayField: 'nombre_completo1',
	       				gdisplayField:'desc_person',//mapea al store del grid
	       				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre_completo1}</p><p>CI:{ci}</p> </div></tpl>',
	       				hiddenName: 'id_persona',
	       				forceSelection:true,
	       				typeAhead: true,
	           			triggerAction: 'all',
	           			lazyRender:true,
	       				mode:'remote',
	       				pageSize:10,
	       				queryDelay:1000,
	       				width:250,
	       				gwidth:280,
	       				minChars:2,
	       				turl:'../../../sis_seguridad/vista/persona/Persona.php',
	       			    ttitle:'Personas',
	       			   // tconfig:{width:1800,height:500},
	       			    tdata:{},
	       			    tcls:'persona',
	       			    pid:this.idContenedor,
	       			
	       				renderer:function (value, p, record){return String.format('{0}', record.data['desc_person']);}
	       			},
	       			type:'TrigguerCombo',
	       			bottom_filter:true,
	       			id_grupo:0,
	       			filters:{	
	       				        pfiltro:'nombre_completo1',
	       						type:'string'
	       					},
	       		   
	       			grid:true,
	       			form:true
	       	},
	       	
	       	{
	       			config:{
	       				name:'id_clasificador',
	       				fieldLabel:'Clasificador',
	       				allowBlank:true,
	       				emptyText:'Clasificador...',
	       				store: new Ext.data.JsonStore({

	    					url: '../../sis_seguridad/control/Clasificador/listarClasificador',
	    					id: 'id_clasificador',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'prioridad',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_clasificador','codigo','descripcion'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'codigo#descripcion'}
	    				}),
	       				valueField: 'id_clasificador',
	       				displayField: 'descripcion',
	       				gdisplayField: 'descripcion',
	       				hiddenName: 'id_clasificador',
	       				forceSelection:true,
	       				typeAhead: true,
	           			triggerAction: 'all',
	           			lazyRender:true,
	       				mode:'remote',
	       				pageSize:10,
	       				queryDelay:1000,
	       				width:250,
	       				minChars:2,
		       			 enableMultiSelect:true,
	       			
	       				renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}

	       			},
	       			type:'ComboBox',
	       			id_grupo:0,
	       			filters:{   pfiltro:'descripcion',
	       						type:'string'
	       					},
	       			grid:true,
	       			form:true
	       	},
	       	
	       	{
	       		config:{
	       			fieldLabel: "Cuenta",
	       			gwidth: 120,
	       			name: 'cuenta',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
				bottom_filter:true,
	       		grid:true,
	       		form:true
	       	},
	       	{
	       		config:{
	       			id:'contrasena_'+this.idContenedor,
	       			fieldLabel: "Contrasena",
	       			name: 'contrasena',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%',
	       			inputType:'password',
	       			/*validator:function(value){
	       				var texto= new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
	       				if(texto.test(value)){
	       					return true;
	       				}else{
	       					return 'La contraseña es demasiado débil (Debe tener un mínimo de 8 caracteres y contener mayusculas, minusculas, números y caracteres especiales)';
	       				}
	       			}*/
	       			
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:false,
	       		form:true
	       	},
	       	{
	       		config:{
	       			fieldLabel: "Confirmar Contrasena",
	       			name: 'conf_contrasena',
	       			mapeo:'contrasena',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%',
	       			inputType:'password',
	       			initialPassField:'contrasena_'+this.idContenedor,
	       			vtype: 'password'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:false,
	       		form:true
	       	},
	       	{
	       		// configuracion del componente
	       		config:{
	       			labelSeparator:'',
	       			inputType:'hidden',
	       			name: 'contrasena_old',
	       			mapeo:'contrasena'

	       		},
	       		type:'Field',
	       		form:true 
	       		
	       	}
	       	,
	       	
	       	 {
	       		config:{
	       			fieldLabel: "Fecha Caducidad",
	       			gwidth: 110,
	       				allowBlank:false,
	       				name:'fecha_caducidad',
	       				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
	       				anchor:'70%',
	       				format:'Y-m-d'
	       			},
	       			type:'DateField',
	       			filters:{type:'date'},
	       			grid:true,
	       			form:true,
	       			dateFormat:'m-d-Y'
	       	},
	       	{
	       		config:{
	       			name:'estilo',
	       			fieldLabel:'Estilo Interfaz',
	       			allowBlank:false,
	       			emptyText:'Estilo...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    //readOnly:true,
	       		    valueField: 'estilo',
	       		   // displayField: 'descestilo',
	       		    store:['xtheme-blue.css','xtheme-gray.css','xtheme-access.css','verdek/css/xtheme-verdek.css','lilamarti/css/xtheme-lilamarti.css','rosaguy/css/xtheme-rosaguy.css']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['xtheme-blue.css','xtheme-gray.css','xtheme-access.css','verdek/css/xtheme-verdek.css','lilamarti/css/xtheme-lilamarti.css','rosaguy/css/xtheme-rosaguy.css'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
	       	{
	       		config:{
	       			name:'autentificacion',
	       			fieldLabel:'Autentificación',
	       			allowBlank:false,
	       			emptyText:'Auten...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    //readOnly:true,
	       		    valueField: 'autentificacion',
	       		   // displayField: 'descestilo',
	       		    store:['local','ldap']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['local','ldap'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
	       	
	       	{
	       		config:{
	       				fieldLabel: "fecha_reg",
	       				gwidth: 110,
	       				name:'fecha_reg',
	       				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
	       			},
	       			type:'DateField',
	       			filters:{pfiltro:'USUARI.fecha_reg',type:'date'},
	       			grid:true,
	       			form:false
	       	},

	    	{
       			config:{
       				name:'id_roles',
       				fieldLabel:'Roles',
       				allowBlank:true,
       				emptyText:'Roles...',
       				store: new Ext.data.JsonStore({
              			url: '../../sis_seguridad/control/Rol/listarRol',
       					id: 'id_rol',
       					root: 'datos',
       					sortInfo:{
       						field: 'rol',
       						direction: 'ASC'
       					},
       					totalProperty: 'total',
       					fields: ['id_rol','rol','descripcion'],
       					// turn on remote sorting
       					remoteSort: true,
       					baseParams:{par_filtro:'rol'}
       					
       				}),
       				valueField: 'id_rol',
       				displayField: 'rol',
       				forceSelection:true,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				width:250,
       				minChars:2,
	       			enableMultiSelect:true
       			
       				//renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}

       			},
       			type:'AwesomeCombo',
       			id_grupo:0,
       			grid:false,
       			form:true
       	}
        /*{
            config:{
                name: 'usuario_externo',
                fieldLabel: 'Usuario Externo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 200,
                maxLength:100

            },
            type:'TextField',
            filters:{pfiltro:'usx.usuario_externo',type:'string'},
            id_grupo:1,
            grid:false,
            form:false,
            bottom_filter:true
        }*/

    ],
	title:'Usuario',
	ActSave:'../../sis_seguridad/control/Usuario/guardarUsuario',
	ActDel:'../../sis_seguridad/control/Usuario/eliminarUsuario',
	ActList:'../../sis_seguridad/control/Usuario/listarUsuario',
	id_store:'id_usuario',
	fields: [
	{name:'id_usuario'},
	{name:'id_persona'},
	{name:'id_clasificador'},
	{name:'cuenta', type: 'string'},
	{name:'contrasena', type: 'string'},
	{name:'fecha_caducidad', mapping: 'fecha_caducidad', type: 'date', dateFormat: 'Y-m-d'},
	{name:'fecha_reg', mapping: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d'},
	{name:'desc_person', type: 'string'},
	{name:'descripcion', type: 'string'},
	{name:'estilo'},
	'id_roles','autentificacion'
      //  {name:'usuario_externo', type: 'string'}
	
		
	],
	sortInfo:{
		field: 'nombre',
		direction: 'ASC'
	},
	
	
	
	/*onButtonEdit:function(){
		this.getComponente('conf_contrasena').disable();
		Phx.vista.usuario.superclass.onButtonEdit.call(this);
	},*/
	
	
	// para configurar el panel south para un hijo
	
	/*
	 * south:{
	 * url:'../../../sis_seguridad/vista/usuario_regional/usuario_regional.php',
	 * title:'Regional', width:150
	 *  },
	 */	
	bdel:true,// boton para eliminar
	bsave:true,// boton para eliminar
	
	onSubmit : function(o) {
		  this.Cmp.contrasena_old.setValue(encodeURIComponent(this.Cmp.contrasena_old.getValue()));
		  this.Cmp.contrasena.setValue(encodeURIComponent(this.Cmp.contrasena.getValue()));
		  this.Cmp.conf_contrasena.setValue(encodeURIComponent(this.Cmp.conf_contrasena.getValue()));
		  Phx.vista.usuario.superclass.onSubmit.call(this,o);
	},

	
    tabeast:[
         {
          url:'../../../sis_seguridad/vista/usuario_rol/UsuarioRol.php',
          title:'Roles', 
          width:400,
          cls:'usuario_rol'
         },
          {
          url:'../../../sis_seguridad/vista/usuario_grupo_ep/UsuarioGrupoEp.php',
          title:'EP\'', 
          width:400,
          cls:'UsuarioGrupoEp'    
          },
        {
            url:'../../../sis_seguridad/vista/usuario_externo/UsuarioExterno.php',
            title:'Usuario Externo',
            width:400,
            cls:'UsuarioExterno'
        }

        ]
	

		  
		  
		 
})
</script>