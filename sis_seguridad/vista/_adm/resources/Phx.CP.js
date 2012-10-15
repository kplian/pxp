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

    passwordText : 'Las contraseñas no son iguales'
});
//FIN RCM


// /////////////////////////////////
// DEFINICON DE LA CLASE MANU //
// ////////////////////////////////
Menu=function(config){
	Menu.superclass.constructor.call(this,Ext.apply({},config,{
		region:'west',
		layout: 'accordion',
	
		split:true,
		width: 300,
		minSize: 175,
		maxSize: 500,
		collapsible: true,
		collapseMode:'mini',
		// floatable:true,
		animCollapse:false,
        // animate: false,
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
					Ext.util.CSS.createStyleSheet('.cls-'+cls+'{background-image: url('+icono+')!important;}');
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
	  						if(Phx.vista[clase].requireclase){
			  				     //trae la clase padre
			  				     //en el callback ejecuta la rerencia 
			  				     //e instanca la clase hijo
			  				      var wid='4rn'
			  				     //console.log('IDEXTRA',wid);
			  				     //Ext.DomHelper.append(document.body, {html:'<div id="'+wid+'"></div>'});
			  				    // Ext.DomHelper.append(document.body, {html:'<div id="4rn"></div>'});
			  				     
			  				  
			  				     var el = Ext.get(wid); // Get Ext.Element object
		                         var u = el.getUpdater();
		                        // var inter = Phx.vista[clase];
			  				       u.update(
			  				      	 {url:Phx.vista[clase].require, 
			  				      	 params:{idContenedor:id,_tipo:'direc'},
			  				      	 scripts :true,
			  				      	  showLoadIndicator: "Cargando...2",
			  				      	  callback: function(r,a,o){
			  				      	 	//genera herencia 
			  				      	 	eval('Phx.vista[clase]= Ext.extend('+Phx.vista[clase].requireclase+',Phx.vista[clase])')
			  				      	 	//ejecuta la clase hijo
			  				      	 	Phx.CP.setPagina(new Phx.vista[clase](o.argument.params))
			  				      	 
			  				      	 }
			  				      	 })
			  				 }
	  				    else{
	  				    	Phx.CP.setPagina(new Phx.vista[clase](o.argument.params));
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
					border: false,
					layout:'fit',
					region:'north',
					cls: 'docs-header',
					height:39
				},
				menu,
				mainPanel]
			});

			viewport.doLayout();
			
			//si usuario tiene alertas iniciamos la ventana
	         if(Phx.CP.config_ini.cont_alertas>0){
				
				this.loadWindows('/web/sis_parametros/vista/alarma/AlarmaFuncionario.php','Alarmas',{
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
							
							//aplica el estilo de vista del usuario
							Phx.CP.setEstiloVista(Phx.CP.config_ini.estilo_vista);
							win_login.hide();
							//si s la primera vez inicia el entorno
			        	   if(!sw_auten){
			        		   Phx.CP.init();
							   sw_auten=true;
			        	   }
			        	    form_login.setTitle("ENDESIS");
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
					  'Powered-By': 'Phx'
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
			if(resp.status==401){
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


			Ext.Msg.show({
				title: 'ERROR',
				msg:mensaje,
				buttons: Ext.Msg.OK,
				minWidth:500,
				minHeight:100

			});
		},
		loadMask: new Ext.LoadMask(Ext.getBody(), {msg:"Espere por favor ...",modal:true}),
		// loadMask: new Ext.LoadMask('Phx.CP', {msg:"Espere por favor ..."}),
		
		
      
		loadingShow:function(){
		
		
			 Ext.MessageBox.show({ title: 'Espere Por Favor...', 
			   msg:"<div><img src='../../../lib/ext3/resources/images/default/grid/loading.gif'/> Cargando ...</div>", 
			  // msg:"<div><img src='../../../lib/imagenes/gti_3.gif'/>
				// Cargando ...</div>",
			  width:200,
			  minHeight:100,
			  closable:false });
		
								 
			// Phx.CP.loadMask.show()
		},
		
		loadingHide:function(){
			
			Ext.MessageBox.hide();
		    // Phx.CP.loadMask.hide();
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
			var cls = o.argument.params.cls;
		    if(Phx.vista[cls].requireclase){
  				     //trae la clase padre
  				     //en el callback ejecuta la rerencia 
  				     //e instanca la clase hijo
  				     var owid='4rn'
  				     var el = Ext.get(owid); // este div esta quemado en el codigo html
                     var u = el.getUpdater();
                     var inter = Phx.vista[cls];
  				       u.update(
  				      	 {url:inter.require, 
  				      	 params:o.argument.params,
  				      	 //params:{idContenedor:id,_tipo:'direc'},
  				      	 scripts :true,
  				      	  showLoadIndicator: "Cargando...2",
  				      	  callback: function(r,a,o){
  				      	 	//genera herencia 
  				      	 	eval('Phx.vista.'+cls+'= Ext.extend('+inter.requireclase+',inter)')
  				      	 	//ejecuta la clase hijo
  				      	 	eval('Phx.CP.setPagina(new Phx.vista.'+cls+'(o.argument.params))')
  				      	 
  				      	 }
  				      	 })
  				 }
		    else{
		    	 // Al retorno de de cargar la ventana
				// ejecuta la clase que llega en el parametro
				// cls
		    	Phx.CP.setPagina(new Phx.vista[cls](o.argument.params))
		    }  
		},
		// para cargar ventanas hijo

		loadWindows:function(url,title,config,params,pid,cls){
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
					          params:Ext.apply({_tipo:'direc',idContenedor:wid,idContenedorPadre:pid,cls:cls},params),
					          text: "Cargando...", 
					          showLoadIndicator: "Cargando...",
					          scripts :true,
					          //arguments:{idContenedor:wid,idContenedorPadre:pid,params:params,cls:cls},
					          callback:this.callbackWindows
					} 
				}));
				Win.show();
			}
		}
	}
}();
// al cargar el script ejecuta primero el metodo login
//Ext.onReady(Phx.CP.iniciarLogin,Phx.CP,true);

