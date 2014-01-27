///////////////////////////////
//		CLASE MENU		  	//
//////////////////////////////
/**
 * @class SamplePackage.SampleClass
 * @extends Ext.Panel This is a sample class <br/> UTF-8 Check: utf-8 <br/>
 * 
 * @author Rensi Arteaga Copari
 * @version 0.1
 */
Ext.BLANK_IMAGE_URL = 'resources/s.gif';
Ext.FORMATO_MONETARIO = '0.000,00/i';

//RCM: 18/11/2011 Vtype personalizado para validación de fechas por rango y de comparación de passwords
Ext.apply(Ext.form.VTypes, {
    daterange : function(val, field) {
        var date = field.parseDate(val);

        if(!date){
            return false;
        }
        if (field.startDateField && (!this.dateRangeMax || (date.getTime() != this.dateRangeMax.getTime()))) {
            var start = Ext.getCmp(field.startDateField);
            start.setMaxValue(date);
            start.validate();
            this.dateRangeMax = date;
        }
        else if (field.endDateField && (!this.dateRangeMin || (date.getTime() != this.dateRangeMin.getTime()))) {
            var end = Ext.getCmp(field.endDateField);
            end.setMinValue(date);
            end.validate();
            this.dateRangeMin = date;
        }
        /*
         * Always return true since we're only using this vtype to set the
         * min/max allowed values (these are tested for after the vtype test)
         */
        return true;
    },

    password : function(val, field) {
        if (field.initialPassField) {
            var pwd = Ext.getCmp(field.initialPassField);
            return (val == pwd.getValue());
        }
        return true;
    },

    passwordText : 'Las contraseñas no son iguales',
    
    hex: function(val, field){
		var v=/^[0-9A-F]+$/i .test(val);;
    	console.log(v);
    	return /^[0-9A-F]+$/i .test(val);;
    },
    hexText:'El valor no está en Hexadecimal',
    hexMask : /[0-9A-F]/i
});
//FIN RCM


// /////////////////////////////////
// DEFINICON DE LA CLASE MANU //
// ////////////////////////////////
Menu=function(config){
	
	
	Menu.superclass.constructor.call(this,Ext.apply({},config,{
		region:'west',
		layout: 'accordion',
		varLog:false,
	
		split:true,
		width: 300,
		
		maxSize: 500,
		collapsible: true,
		//collapseMode:'mini',
		// floatable:true,
		animCollapse:true,
        animate: true,
        lines:false,
        header: true,		
		rootVisible:false,
		autoScroll: true,
		useArrows:true,// estilo vista
		// loader:iloader,
		enableDrag:true,
		containerScroll: true,
		loader:new  Ext.tree.TreeLoader({url:'../../sis_seguridad/control/Menu/listarPermisoArb',
		// baseParams :{_tipo:'direc'},
		// preloadChildren:true,
		
		clearOnLoad:false

		}),
		root:new Ext.tree.AsyncTreeNode({
			text:'Menú de navegación',
			draggable:false,
			expanded:true,
			iconCls:"xnd-icon",
			singleClickExpand :true,
            //children: [{iconCls:"xnd-icon"}],
			id:'id'
		}),
		collapseFirst:false
	}));
};
// la clase menu hereda de TreePanel
Ext.extend(Menu,Ext.tree.TreePanel,{
	
	selectClass : function(cls){
		if(cls){
			this.getSelectionModel().select(this.getNodeById(cls))
		}
	},
	initComponent: function(){
        this.hiddenPkgs = [];
        Ext.apply(this, {
            tbar:[ ' ',
			new Ext.form.TextField({
				width: 200,
				emptyText:'Find a Class',
                enableKeyEvents: true,
				listeners:{
					render: function(f){
                    	this.filter = new Ext.tree.TreeFilter(this, {
                    		clearBlank: true,
                    		autoClear: true
                    	});
					},
                    keydown: {
                        fn: this.filterTree,
                        buffer: 350,
                        scope: this
                    },
                    scope: this
				}
			}), ' ', ' ',
			{
                iconCls: 'icon-expand-all',
				tooltip: 'Expand All',
                handler: function(){ this.root.expand(true); },
                scope: this
            }, '-', {
                iconCls: 'icon-collapse-all',
                tooltip: 'Collapse All',
                handler: function(){ this.root.collapse(true); },
                scope: this
            }]
        })
        Menu.superclass.initComponent.call(this);
    },
	filterTree: function(t, e){
		var text = t.getValue();
		Ext.each(this.hiddenPkgs, function(n){
			n.ui.show();
		});
		if(!text){
			this.filter.clear();
			return;
		}
		this.expandAll();
		
		var re = new RegExp('^' + Ext.escapeRe(text), 'i');
		this.filter.filterBy(function(n){
			return !n.attributes.isClass || re.test(n.text);
		});
		
		// hide empty packages that weren't filtered
		this.hiddenPkgs = [];
                var me = this;
		this.root.cascade(function(n){
			if(!n.attributes.isClass && n.ui.ctNode.offsetHeight < 3){
				n.ui.hide();
				me.hiddenPkgs.push(n);
			}
		});
	},
	tools:[{
		id:'refresh',
		qtip: 'Actualizar Menú',
		// hidden:true,
		handler: function(event, toolEl, panel){
		// refresh logic
		
		panel.getRootNode().reload()
	
		}
	},
	{
		id:'help',
		qtip: 'Get Help',
		handler: function(event, toolEl, panel){
			// whatever
		}
	}]

});


// //////////////////////////////////////////////////
// DEFINICON DE LA CLASE CONTENEDOR PRINCIPAL //
// /////////////////////////////////////////////////

MainPanel = function(config){
	MainPanel.superclass.constructor.call(this, Ext.apply({},config,{
		
		region:'center',
       // margins:'0 5 5 0',
        resizeTabs: true,
        //minTabWidth: 135,
        //tabWidth: 135,
        plugins: new Ext.ux.TabCloseMenu(),
        enableTabScroll: true
        //activeTab: 0,
	        
	        
	        
	}));

	
};

Ext.extend(MainPanel, Ext.TabPanel,{
	loadClass : function(href, cls, title,icono,ruta,clase){
		 var id = 'docs-' + cls;
		 var tab = this.getComponent(id);
		 //si el tab existe toma el foco
		 if(tab){
	            this.setActiveTab(tab);
	            
	     }else{
	    	 var iconCls='icon-folder';
				if(icono){
					Ext.util.CSS.createStyleSheet('.cls-'+cls+'{background: url('+icono+') no-repeat top left ;background-size:25px 25px!important;}');
					iconCls='cls-'+cls;
					
		
				}
	    	 
			 var p = this.add(new Ext.Panel({
	                id: id,
	                layout:'fit',
	                //layout: 'border',
	                title:title,
	                closable: true,
	                cclass : cls,
	                iconCls:iconCls,
	                autoLoad: {
	  				  url: href,
	  				  params:{idContenedor:id,_tipo:'direc'},
	  				  showLoadIndicator: "Cargando...",
	  				  callback:function(r,a,o){
	  					  // Al retorno de de cargar la ventana
	  					  // ejecuta la clase que llega con el codigo de la url
	  					  // el nombre de la clase viene en la variable cls que
	  					  // se almacena originalmente en el descripcion de la
	  						// tabla segu.gui
	  					  if(Phx.vista[clase]){	
		  						if(Phx.vista[clase].requireclase){
				  				     //trae la clase padre
				  				     //en el callback ejecuta la rerencia 
				  				     //e instanca la clase hijo
				  				      var wid='4rn'
				  				     //console.log('IDEXTRA',wid);
				  				     //Ext.DomHelper.append(document.body, {html:'<div id="'+wid+'"></div>'});
				  				     //Ext.DomHelper.append(document.body, {html:'<div id="4rn"></div>'});
				  				     
				  				  
				  				     var el = Ext.get(wid); // Get Ext.Element object
			                         var u = el.getUpdater();
			                         //var inter = Phx.vista[clase];
				  				       u.update(
				  				      	 {url:Phx.vista[clase].require, 
				  				      	 params:{idContenedor:id,_tipo:'direc'},
				  				      	 scripts :true,
				  				      	  showLoadIndicator: "Cargando...2",
				  				      	  callback: function(r,a,o){
					  				      	 	 try{
					  				      	 		//genera herencia 
					  				      	 		eval('Phx.vista[clase]= Ext.extend('+Phx.vista[clase].requireclase+',Phx.vista[clase])')
					  				      	 		//ejecuta la clase hijo
					  				      	 		Phx.CP.setPagina(new Phx.vista[clase](o.argument.params))
					  				      	 	  }
							  				       catch(err){
							  				       	var resp = Array();
							  				       	resp.status=404;
							  				       	resp.statusText=err;
							  				       	Phx.CP.conexionFailure(resp);
							  				       }
								  		    }
				  				      	 });
			  				 }
	  				    	else{
		  				    	try{
		  				    		Phx.CP.setPagina(new Phx.vista[clase](o.argument.params));
		  				      	}
		  				        catch(err){
		  				       		var resp = Array();
		  				       		resp.status=404;
		  				       		resp.statusText=err;
		  				       		Phx.CP.conexionFailure(resp);
		  				       }
	  				    	}  
	  				   }
	  				   else{
	  				   	console.log('no existe la clase '+clase)
	  				   }
	  				 },
	  				  scripts :true}
	           }));
	            this.setActiveTab(p);
	      }
	}
	
});

// ////////////////////////////////////////
// CLASE CP (o Contenedor Principal)     //
// ////////////////////////////////////////
Ext.namespace('Phx','Phx.vista');
Phx.CP=function(){
    var menu,hd,mainPanel,win_login,form_login,sw_auten=false,sw_auten_veri=false,estilo_vista;
    // para el filtro del menu
	var filter,hiddenPkgs=[];
    return{

		// funcion que se ejcuta despues de una autentificacion exitosa
		// para dibujar los paneles de menu y mainpanel
		init:function(){
         	Ext.QuickTips.init();
			// definicion de la instancia de la clase menu
			menu=new Menu({});
			// manejo de errores
			menu.loader.addListener('loadexception',Phx.CP.conexionFailure); 
			// menu contextual
			var ctxMenu = new Ext.menu.Menu({
				id:'copyCtx',
				
				items: [{
					id:'expand',
					handler:expandAll,
					icon:'../../../lib/imagenes/arrow-down.gif',
					text:'Expandir todos'
				},{
					id:'collapse',
					handler:collapseAll,
					icon:'../../../lib/imagenes/arrow-up.gif',
					text:'Colapsar todos'
				},{
					id:'reload',
					handler:actualizarNodo,
					icon:'../../../lib/imagenes/act.png',
					text:'Actualizar nodo'

				}]
			});
		  function actualizarNodo(){
				ctxMenu.hide();
				var n = menu.getSelectionModel().getSelectedNode();
				setTimeout(function(){
					if(!n.leaf){n.reload()}
				}, 10);
			}

			function collapseAll(){
				var n = menu.getSelectionModel().getSelectedNode();
				ctxMenu.hide();
				setTimeout(function(){
					n.collapseChildNodes(true)
				}, 10);
			}

			function expandAll(){
				var n = menu.getSelectionModel().getSelectedNode();
				ctxMenu.hide();
				setTimeout(function(){
					n.expand(true);
				}, 10);
			}

            menu.on('contextmenu', function (node, e){
				node.select();
				ctxMenu.showAt(e.getXY())
			});


			menu.on('click', function(node, e){
				if(node.isLeaf()){
					e.stopEvent();
					var naux=node,icono,ruta='';

					if(node.text=='Salir'){
						window.location.href=node.attributes.ruta
					}
					else{
						// sacasmos el nombre y la ruta del subsistema subiendo
						// a los nodos superiores
						
						while(naux.parentNode){
							if(naux.parentNode.id=='id'){
								icono=naux.attributes.icon
							}
							ruta= '/'+naux.id+ruta;
							naux=naux.parentNode
						}
						mainPanel.loadClass('../../../'+node.attributes.ruta,node.id,node.attributes.nombre,icono,ruta,node.attributes.cls)
					}
				}
			});

        	// definicion de una instacia de la clase MainPanel
			mainPanel=new MainPanel({menuTree:menu});
			mainPanel.on('tabchange', function(tp, tab){
				if(tab){
				menu.selectClass(tab.cclass);
				}
		    });


           /* var detailsPanel = {
				title: 'Details',
		        region: 'center',
		        bodyStyle: 'padding-bottom:15px;background:#eee;',
				autoScroll: true,
				item:Ext.Element.get('1rn')
		    };*/
			


    		// declaricion del panel SUR
			// var d_pie = Ext.DomHelper.append(document.body, {tag:
			// 'div',id:'estado'/*,class:"x-layout-panel-hd"*/});
			// pie=new Ext.Panel(d_pie ,"Estado");
			// pie.load({url:'layoutPie.php',scripts:true});
			
			
            // Contruye el marco de los paneles,
			// introduce el menu y el mainpanel
			var viewport = new Ext.Viewport({
				id:'Phx.CP',
				layout:'border',
				items:[
             	{
				  region: 'north',  
				  border: true,
				  layout:'fit',
				  autoHeight:true,
				  margins: '0 0 0 0',        
				  split:false,
				 // height:37,
				  bbar:[  
				  {xtype:'label',
				  width: 500,
				  //autoHeight:true,
				 
				  html:' <a href="http://www.kplian.com" target="_blank"><img src="../../../lib/imagenes/kplian2.jpg"  style="margin-left:5px;margin-top:1px;margin-bottom:1px"/> </a>',
				  border: false
				  },
				  '->',{
				  	xtype:'label',
				
				 
				  iconCls:'user_suit',
				 
				  html:'<div id="1rn" align="right"><font >Usuario: </font><font ><b>'+Phx.CP.config_ini.nombre_usuario+'</b></font></div>'
				  },'-',
				   { 
				  	xtype:'label',
				  
				    
				    html:'<div id="2rn" align="right"><img src="../../../lib/imagenes/NoPerfilImage.jpg" align="center" width="35" height="35"  style="margin-left:5px;margin-top:1px;margin-bottom:1px"/></div>'
				   },'-',
				   {
				            text: 'Cerrar sesion',
				            icon: '../../../lib/images/exit.png',
				            toolTip:'Cerrar sesion',
				        
				                handler: function() {
				            window.location = '../../control/auten/cerrar.php';
				             }
				   }
				   
				  ]
				},
				menu,
				mainPanel]
			});

			viewport.doLayout();
			
			//si usuario tiene alertas iniciamos la ventana
	         if(Phx.CP.config_ini.cont_alertas>0){
				
				this.loadWindows('../../../sis_parametros/vista/alarma/AlarmaFuncionario.php','Alarmas',{
						width:900,
						height:400,
						modal:false
				    },{id_usuario:Phx.CP.config_ini.id_usuario},
				    'Phx.CP','AlarmaFuncionario');
			// url: donde se encuentra el js de la ventana que se quiere abrir
			// title: titulo de la ventanan que se abrira
			// config: configuracion de la venta
			// params: parametros que se le pasaran al js
			// pid: identificador de la ventana padre
			// cls: nombre de la clase que se va ejecutar
			}
			
			//abrir un tab de vienbenida
			
			this.getMainPanel().loadClass('../../../sis_seguridad/vista/inicio/tabInicial.php','', 'Inicio','','../../../sis_seguridad/vista/inicio/tabInicial.php','tabInicial');
			
			Phx.CP.obtenerFotoPersona(Phx.CP.config_ini.id_usuario,
						function(resp){
							
							setTimeout(function(){
								var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
	                            var _im ='../../../lib/imagenes/NoPerfilImage.jpg';
	                            if(reg.datos[0].extension){
	                            	_im ='../../../sis_seguridad/control/foto_persona/'+reg.datos[0].foto;
	                            }
	                             Ext.Element.get('2rn').update('<img src="'+_im+'" align="center" width="35" height="35"  style="margin-left:5px;margin-top:1px;margin-bottom:1px"/> ');
								 
								},3000);
						});
		   	  
			
		},
		//para capturar variables enviadas por get
		
  
		// vector que contiene los parametros de configuracion inicial pasados
		// por el servidor en la autentificacion
		config_ini:new Array(),

		// este metodo contruye la ventana de login
		// se ejecuta al cargar el index
		iniciarLogin:function(x,regreso,z){ 
			
			
			
			
			Ext.QuickTips.init();
			Ext.form.Field.prototype.msgTarget = 'side';
           // formulario
			form_login = new Ext.form.FormPanel({
				//baseCls: 'x-plain',
				//bodyStyle:'padding:30px 5px 50px 25px;border:none;background:#FFFFFF url(resources/oLogo.png) no-repeat right center;',
				bodyStyle:'padding:30px 0px 40px 15px;',
				
				//labelWidth: 65,
				labelAlign:'right',
				url:'../../sis_seguridad/control/Auten/verificarCredenciales',
				defaultType: 'textfield',
				defaults: {width: 100},
				items: [{
					fieldLabel: 'Usuario',
					allowBlank:false,
					// labelStyle: 'font-weight:bold;',
					//align:'center',
					name:'usuario',
					id:'_usu'
				},{
					fieldLabel: 'Contraseña',
					// labelStyle: 'font-weight:bold;',
					name:'contrasena',
					allowBlank:false,
					//align:'center',
					inputType: 'password'
				}],
				 bbar: new Ext.ux.StatusBar({
			            id: 'basic-statusbar',
                        // defaults to use when the status is cleared:
			            defaultText: '',
			            //defaultIconCls: 'default-icon',
			         // values to set initially:
			            text: 'Ready',
			            iconCls: 'x-status-valid'
                   })
			});



			// ventana para el login
			win_login = new Ext.Window({
				title: 'PXP',
				//baseCls: 'x-window',
				// iconCls: 'image_login',

				modal:true,
				width:320,
				height:180,
				shadow:true,
				closable:false,
				minWidth:300,
				minHeight:180,
				layout: 'fit',
				//plain:true,
				//bodyStyle:'padding:5px;',
				items: form_login,
			     buttons: [{
					text:'Entrar',
					//keys:[Ext.EventObject.ENTER],
					handler:Phx.CP.entrar  
				}],
				keys:[{key:Ext.EventObject.ENTER,handler:Phx.CP.entrar}]
			});

			// win_login.show();
			
			//win_login.addKeyListener(Ext.EventObject.ENTER, Phx.CP.entrar); // Tecla enter

              //console.log(x,y,z);
			if(x=='activa'){
				Phx.CP.CRIPT=new Phx.Encriptacion({encryptionExponent:regreso.e,
							modulus:regreso.m,
							permutacion:regreso.p,
							k:regreso.k});
						    Phx.CP.config_ini.x=regreso.x;
				
			
					   sw_auten_veri=false;
			           if(regreso.success){
			        	   // copia configuracion inicial recuperada
							Ext.apply(Phx.CP.config_ini,regreso.parammetros);
							//aplica el estilo de vista del usuario
							Phx.CP.setEstiloVista(Phx.CP.config_ini.estilo_vista);
						   //si s la primera vez inicia el entorno
			        	   if(!sw_auten){
			        		   Phx.CP.init();
							   sw_auten=true;
			        	   }
			        	 }	
			
			 //return true;
			}
			else{
				
				Phx.CP.getPlublicKey();
	
			}
			setTimeout(function(){
				
							
				Ext.get('loading').remove();
				Ext.get('loading-mask').fadeOut({remove:true});
				if(Ext.get('_usu')){
				  Ext.get('_usu').focus();
				}
				
				
				
				
			  }, 1000);

		},
		// para mostrar ventana de autenticación
		loadLogin:function(){
			Phx.CP.getPlublicKey();

		},
		key_m:"99809143352650341179",
		key_e:'7',
		key_k:'1',
		key_p:'2314',


		getPlublicKey:function(){

			Ext.Ajax.request({				
				url:'../../sis_seguridad/control/Auten/getPublicKey',
			    params:{_tipo:'inter' },		
				success:function(resp){
					var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
					if(regreso.success==true){
						// crea la clase de encriptacion
						Phx.CP.CRIPT=new Phx.Encriptacion({encryptionExponent:regreso.e,
							modulus:regreso.m,
							permutacion:regreso.p,
							k:regreso.k});
						    Phx.CP.config_ini.x=regreso.x;
						    // muestra ventana de login
					    //Phx.CP.setEstiloVista("xtheme-access.css");
								
						win_login.show();
					

					}else{

						alert("error al optener llave pública")
					}
				},
				failure:Phx.CP.conexionFailure
			});


		},
		entrar:function(){
			// usuario ya fue autentificaco por lo menos una vez?
			//verifica que nose intente ingresa una segunda vez sin antez haber obtenido una respuesta
			if(!sw_auten_veri){
				sw_auten_veri=true;
				var ajax={
					success:function(resp){
					   var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
					   sw_auten_veri=false;
			           if(regreso.success){
			        	   // copia configuracion inicial recuperada
							Ext.apply(Phx.CP.config_ini,regreso);
							//muestra nombre de usuario y base de datos
							
							//aplica el estilo de vista del usuario
							Phx.CP.setEstiloVista(Phx.CP.config_ini.estilo_vista);
							win_login.hide();
							//si s la primera vez inicia el entorno
			        	   if(!sw_auten){
			        		   Phx.CP.init();
							   sw_auten=true;
			        	   }
			        	    
			        	    form_login.setTitle("LOGIN");
							Phx.CP.loadingHide();
			        	  
			      		}
						else{
							if(regreso.mensaje){
								
								var sb = Ext.getCmp('basic-statusbar');
		                        sb.setStatus({
		                            text: regreso.mensaje,
		                            iconCls: 'x-status-error',
		                            clear: true // auto-clear after a set interval
		                        });
		                        
		                     
						     }
							ajax.failure();

						}
						
						
						
						

					},
					failure:function(form,action,resp){
						sw_auten_veri=false;
						// ocultamos el loading
						Phx.CP.loadingHide();
						win_login.setTitle("Error en los Datos");
					
						// form.reset().reset();
						// form_login.getForm().reset();
						Ext.get('_usu').focus();
					}
				};


				if(form_login.getForm().isValid()){
            		Phx.CP.loadingShow();
					
            		Ext.Ajax.defaultHeaders={
					  'Powered-By': 'Pxp'
					};
					// Envia crendenciales al servidor

					Ext.Ajax.request({
						url:form_login.url,
						params:Ext.apply({_tipo:'auten'},form_login.getForm().getValues()),
						method:'POST',
						success:ajax.success,
						failure:ajax.failure
					});
					
					

				}
				else{
					sw_auten_veri=false;
				}
			}
		}
		// manejo de errores
		,
		conexionFailure:function(resp1,resp2,resp3,resp4,resp5){
		 
			Phx.CP.loadingHide();
            
			resp = resp1;// error conexion
			
			if(resp3!=null){
				resp = resp3;
			}
			// error conexion en store de combos
			if(resp5!=null){
				resp = resp5;
			}
			
			
			var mensaje;
			if(resp.status==777){
				// usuario no autentificado
				// No existe el archivo requerido
				mensaje="<p><br/> Status: " + resp.statusText +"<br/> Error de el Navegador</p>"
			
				return
			}
			else if(resp.status==401){
				// usuario no autentificado
				Phx.CP.loadLogin();
				return
			}
			else if(resp.status==404){
				// No existe el archivo requerido
				mensaje="<p><br/> Status: " + resp.statusText +"<br/> No se encontro el Action requerido</p>"
			}

			else if(resp.status==406){
				
			
				// No aceptable
				var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
				
				if(Phx.CP.config_ini.mensaje_tec==1){
				  mensaje="<p><br/> <b>Mensaje:</b> " + reg.ROOT.detalle.mensaje +"<br/><b>Capa:</b> " + reg.ROOT.detalle.capa +"<br/><b>Origen:</b> " + reg.ROOT.detalle.origen +"<br/><b>Procedimiento:</b> " + reg.ROOT.detalle.procedimiento +"<br/><b>Transacción:</b> " + reg.ROOT.detalle.transaccion+"<br/><b>Consulta:</b> " + reg.ROOT.detalle.consulta +"<br/><b>Mensaje Técnico:</b> " + reg.ROOT.detalle.mensaje_tec +"</p>";
				}
				else{
					mensaje="<p><br/> Mensaje: " + reg.ROOT.detalle.mensaje +"<br/> </p>"
				}
            }

			else if(resp.status==-1){
				// tiempo de espera agotado
				mensaje="<p>HTTP status: " + resp.status +"<br/> Status: " + resp.statusText +"<br/> Tiempo de espera agotado</p>"
			}
			else{
				// repuesta no reconocida
				mensaje = "respuesta indefinida, error en la transmision <br> respuesta obtenida:<br>"+ resp.responseText;
			}

           if(Phx.CP.varLog){
           	
           	window.open('../../../lib/lib_vista/log.php?log='+mensaje+'&titulo='+Phx.CP.varLogTitle,'LOG')
           	
           }
           else{
				Ext.Msg.show({
					title: 'ERROR',
					msg:mensaje,
					buttons: Ext.Msg.OK,
					minWidth:500,
					minHeight:100
	
				});
				
				
				
			}
		},
		
		obtenerFotoPersona:function(id_usu,callback){
			Ext.Ajax.request({
                    url:'../../sis_seguridad/control/Persona/obtenerPersonaFoto',
                    params:{'id_usuario':id_usu},
                    success:callback,
                    failure: this.conexionFailure,
                    timeout:this.timeout,
                    scope:this
                }); 
		},
		
		sleep:function (milliseconds) {
		  var start = new Date().getTime();
		  for (var i = 0; i>-1; i++) {
		    if ((new Date().getTime() - start) > milliseconds){
		      break;
		    }
		  }
		},
		pressChar:function (character,cmpEl){
       
          // Create the key press event.
          var pressEvent = document.createEvent('KeyboardEvent');
          pressEvent.initKeyEvent("keypress", true, true, window, 
                                    false, false, false, false, 
                                    0, character.charCodeAt(0));
         cmpEl.dispatchEvent(pressEvent); // Press the key.
      
       },
       
       keyEvent:function(character,evento){
       	var keyboardEvent = document.createEvent("KeyboardEvent");
		var initMethod = typeof keyboardEvent.initKeyboardEvent !== 'undefined' ? "initKeyboardEvent" : "initKeyEvent";
		
		
		keyboardEvent[initMethod](
		                    evento, // event type : keydown, keyup, keypress
		                    true, // bubbles
		                    true, // cancelable
		                    window, // viewArg: should be window
		                    false, // ctrlKeyArg
		                    false, // altKeyArg
		                    false, // shiftKeyArg
		                    false, // metaKeyArg
		                    character.charCodeAt(0), // keyCodeArg : unsigned long the virtual key code, else 0
		                    character.charCodeAt(0)// charCodeArgs : unsigned long the Unicode character associated with the depressed key, else 0
		);
		
		console.log('charcode',character.charCodeAt(0))
		//document.dispatchEvent(keyboardEvent);
       	return keyboardEvent;
       	
       },
       
      
		
		//loadMask: new Ext.LoadMask(Ext.get('3rn'), {msg:"Espere por favor ...",modal:true,removeMask :true}),
		// loadMask: new Ext.LoadMask('Phx.CP', {msg:"Espere por favor ..."}),
		loadMask:new Ext.LoadMask(Ext.getBody(), { msg: "Espere por favor ..." }),
		///loadMask:Ext.getBody().mask(),
      
		loadingShow:function(){
		
			/* Ext.MessageBox.show({ 
			 	title: 'Espere Por Favor...', 
			   msg:"<div><img src='../../../lib/ext3/resources/images/default/grid/loading.gif'/> Cargando ...</div>", 
			  // msg:"<div><img src='../../../lib/imagenes/gti_3.gif'/>
				// Cargando ...</div>",
			  animEl:Ext.getBody(),
			  width:200,
			  minHeight:100,
			  closable:false });*/
			 
              Ext.getBody().mask('Loading...', 'x-mask-loading').dom.style.zIndex = '9999';
            
		},
		
		loadingHide:function(){
			
			//Ext.MessageBox.hide();
			//Phx.CP.loadMask.hide();
		     Ext.getBody().unmask();
		},

		// Para cambiar el estilo de la vista
		setEstiloVista:function(val){
			Ext.util.CSS.removeStyleSheet('theme');
			Ext.util.CSS.refreshCache();
		//estilo_vista='xtheme-black.css'
			Ext.util.CSS.swapStyleSheet('theme','../../../lib/ext3/resources/css/'+val);
        },
		getMainPanel:function(){
			return mainPanel
		},


		elementos:new Array(),
		setPagina:function(e){
			this.elementos.push(e);
		},

		getPagina:function(e){
			for (var i=0;i<=this.elementos.length;i++){
				if(this.elementos[i]&&this.elementos[i].idContenedor==e){
					return this.elementos[i];
				}
			}
		},
		// para destruir paginas
		destroyPage:function(id){
			for(var i=0;i<this.elementos.length;i++){
				if(this.elementos[i].idContenedor==id){
					Ext.destroyMembers(this.elementos[i]);
					Ext.destroy(this.elementos[i]);
			     	delete this.elementos[i];
			        this.elementos.splice(i,1);
					break
				}
			}
		},
		_getType:function( inp ) {
	        var type = typeof inp, match;
	        var key;
	        if (type == 'object' && !inp) {
	            return 'null';
	        }
	        if (type == "object") {
	            if (!inp.constructor) {
	                return 'object';
	            }
	            var cons = inp.constructor.toString();
	            if (match = cons.match(/(\w+)\(/)) {
	                cons = match[1].toLowerCase();
	            }
	            var types = ["boolean", "number", "string", "array"];
	            for (key in types) {
	                if (cons == types[key]) {
	                    type = types[key];
	                    break;
	                }
	            }
	        }
	        return type;
	    },
	    /*RAC 20/01/2012
	     * esta funcion ejecuta la clase cargada en los contenedores
	     */
	     
		callbackWindows:function(r,a,o){
			 //si existe la variable mycls la utiliza
			//RAC 3-11-2012: bug al combinar arboles con openwindow, se solapan variables
			var mycls = o.argument.params.mycls?o.argument.params.mycls:o.argument.params.cls;
		    if(Phx.vista[mycls].requireclase){
  				     //trae la clase padre
  				     //en el callback ejecuta la rerencia 
  				     //e instanca la clase hijo
  				     var owid='4rn'
  				     var el = Ext.get(owid); // este div esta quemado en el codigo html
                     var u = el.getUpdater();
                     var inter = Phx.vista[mycls];
  				       u.update(
  				      	 {url:inter.require, 
  				      	 params:o.argument.params,
  				      	 //params:{idContenedor:id,_tipo:'direc'},
  				      	 scripts :true,
  				      	  showLoadIndicator: "Cargando...2",
  				      	  callback: function(r,a,o){
  				      	 	//genera herencia 
  				      	 	eval('Phx.vista.'+mycls+'= Ext.extend('+inter.requireclase+',inter)')
  				      	 	//ejecuta la clase hijo
  				      	 	eval('Phx.CP.setPagina(new Phx.vista.'+mycls+'(o.argument.params))')
  				      	 
  				      	 }
  				      	 })
  				 }
		    else{
		    	 // Al retorno de de cargar la ventana
				// ejecuta la clase que llega en el parametro
				// cls
		    	Phx.CP.setPagina(new Phx.vista[mycls](o.argument.params))
		    }  
		},
		
		
		
		// para cargar ventanas hijo

		loadWindows:function(url,title,config,params,pid,mycls){
			// url: donde se encuentra el js de la ventana que se quiere abrir
			// title: titulo de la ventanan que se abrira
			// config: configuracion de la venta
			// params: parametros que se le pasaran al js
			// pid: identificador de la ventana padre
			// cls: nombre de la clase que se va ejecutar
			
			
			var sw=false// ,_url=url.split('?');

			// Busca si la ventana ya fue abierta para recarla
			/*
			 * for(var i=0;i<pagHijo.length;i++){ if(pagHijo[i].url==_url[0]){
			 * var paginaHijo=Phx.CP.getPagina(pagHijo[i].idContenedor);
			 * if(!paginaHijo){
			 * paginaHijo=Phx.CP.getPagina(idContenedor).pagina.getPagina(pagHijo[i].idContenedor) }
			 * paginaHijo.pagina.reload(_url[1]); pagHijo[i].ventana.show();
			 * sw=true; idVentana=pagHijo[i].idContenedor; break } }
			 * 
			 */
			if(!sw){
				// crea una nueva ventana
				var	Ventana={
					modal:true,
					title:title,
					width:'60%',
					height:'60%',
					shadow:true,
					minWidth:300,
					minHeight:300,
					layout:'fit',
					border: false,
					//parseMargins:'50 50 50 50',
					minimizable: false,
					maximizable: true,
					proxyDrag:true
				};
				
				Ext.apply(Ventana,config);

				if(this._getType(Ventana.height)== 'string'){
					Ventana.height=Ext.getBody().getHeight()*(parseInt(Ventana.height.substr(0,Ventana.height.indexOf('%')))/100)
				}
				
			
	            var wid=Ext.id()
				var Win=new Ext.Window(Ext.apply(Ventana,{
					id:wid,// manager: this.windows,
					// anchor: '100% 100%',  // anchor width and height
					autoDestroy:true,
					//layout: 'border',
					//height:screen.height,
				   // width:'100%',
					// autoShow:true,
					autoLoad:{url: url,
					          params:Ext.apply({_tipo:'direc',idContenedor:wid,idContenedorPadre:pid,mycls:mycls},params),
					          text: "Cargando...", 
					          showLoadIndicator: "Cargando...",
					          scripts :true,
					          //arguments:{idContenedor:wid,idContenedorPadre:pid,params:params,cls:cls},
					          callback:this.callbackWindows
					} 
				}));
				Win.show();
			}
		},
		log: function(){
		    if( typeof window.console != 'undefined' ){
		        console.log.apply( null, arguments ); 
		    }
		}
	}
}();
// al cargar el script ejecuta primero el metodo login
//Ext.onReady(Phx.CP.iniciarLogin,Phx.CP,true);

