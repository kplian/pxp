/*
**********************************************************
Nombre de la clase:	    Paginaa   
Proposito:				clase abtracta  generica de interfaz 
Fecha de Creacion:		17 - 09 - 11
Version: 				0 
Autor:					Rensi Arteaga Copari
**********************************************************
*/ 

Ext.namespace('Phx','Phx.vista');
Phx.baseInterfaz=Ext.extend(Ext.util.Observable,{
	
	
	//Phx.baseInterfaz=function(){
    
    //return{
	// Componentes:NULL,
	title:'base-Interfaz',
	timeout:Phx.CP.config_ini.timeout,
	
	conexionFailure:Phx.CP.conexionFailure,
	ActDel:'',
	bsave:true,
	bnew:true,
	bedit:true,
	bdel:true,
	bact:true,
    bexcel:false,
	tipoInterfaz:'basedInterfaz',
	egrid:false,	
	fheight:'50%',
	fwidth:'50%',
	reload:true, // <-- habilita la reutilizacion de la interfaz
	argumentSave:{},
	fileUpload:false,
	// configura regiones
	south:false,
	west:false,
	east:false,
	
	/*para limpiar */
	configForm:{
		height:340,
		width:480,
		minWidth:150,
		minHeight:200,
		closable:true,
		titulo:'Formulario'
	},
	
	/*esta funcion se sobrecarga en el hijo
	 * aqui se colocan el codigo necesario para establecer el manejo de eventos 
	 * del formulario. Corre al iniciar la pagina
	 * */
	iniciarEventos:function(){
		
		
	},
	
	// funcion para adicionar boton en la barra de tareas
	addButton:function(id,param){



		var bconf={
			icon: '../../../lib/imagenes/a_xp.png',
			//cls: 'x-btn-icon',
			disabled :true,
			handler: function(){alert("sobrecargar handler")},
			scope:this
		};

		Ext.apply(bconf,param);
		bconf.id='b-'+id+'-'+this.idContenedor;



		this.tbar.addButton(bconf)
	},

	getBoton:function(id){

		// retorna el boton solicitado

		return this.tbar.items.get('b-'+id+'-'+this.idContenedor)

	},
	
		// Funcion nuevo del toolbar
	onButtonNew:function(){
		this.window.buttons[1].show();
		this.form.getForm().reset();
		this.loadValoresIniciales();
		this.window.show();
	},
	// Funcion editar del toolbar
	onButtonEdit:function(){
        this.window.show();
		this.loadForm(this.sm.getSelected())
		this.window.buttons[1].hide();
	},
	
	onButtonSave:function(){
		
		

	},
	
	onDeclinar:function(){
		this.window.hide()
	},
	
		// Funcion guardar del formulario
	onSubmit:function(o){
  	if(this.form.getForm().isValid()){

			Phx.CP.loadingShow();
    		// arma json en cadena para enviar al servidor
			
			Ext.apply(this.argumentSave,o.argument);

			//console.log(this.argumentSave,o.argument)
			if(this.fileUpload){
				
	              Ext.Ajax.request({
					form:this.form.getForm().getEl(),
					url:this.ActSave,
					params:this.getValForm,
					isUpload:this.fileUpload,
					success:this.successSaveFileUpload,
					argument:this.argumentSave,
					failure: function(r){console.log('falla upload',r)},
					timeout:this.timeout,
					scope:this
				})
	                     
			}
			else{			
					Ext.Ajax.request({
						url:this.ActSave,
						//params:this.form.getForm().getValues(),
						params:this.getValForm,
						isUpload:this.fileUpload,
						success:this.successSave,
						argument:this.argumentSave,
		
						failure: this.conexionFailure,
						timeout:this.timeout,
						scope:this
					});
			}


		}

	},
	// recorre todos los atributos y los setea los valores en el formulario
	loadForm:function(rec){
	    for(var i=0;i<this.Componentes.length;i++){
			if(this.Componentes[i]){
                 if((this.Atributos[i].type=='ComboBox' && this.Atributos[i].config.mode=='remote' ) || this.Atributos[i].type=='TrigguerCombo' || this.Atributos[i].type=='ComboRec'){
					var _id= this.Componentes[i].valueField;
					/*25nov11
					adicion variable _id_name: para mapear el valor del store origen que no necesariamente tiene el mismo nombre que el value_field
					*/
			        var _id_name=this.Componentes[i].name;
			        if(rec.data[_id_name]!=undefined && rec.data[_id_name]!= null && rec.data[_id_name]!='null'){
					        //nombre del atributo del combo que recibe el valor
							var _dis= this.Componentes[i].displayField;
							
							//define el origen del displayField en el grid
							var _df = this.Componentes[i].displayField;
							
							if(this.Atributos[i].config.gdisplayField){
								
								_df = this.Atributos[i].config.gdisplayField;
							}
		
							if(!this.Componentes[i].store.getById(rec.data[_id_name])){
								var recTem= new Array();
								recTem[_id]= rec.data[_id_name];
								recTem[_dis]=rec.data[_df];
		
								this.Componentes[i].store.add(new Ext.data.Record(recTem,rec.data[_id_name]));
		
								this.Componentes[i].store.commitChanges();
		                    }
					}
					this.Componentes[i].setValue(rec.data[_id_name])
				}
				else{
					
					if(this.Componentes[i].inputType=='file'){
						//console.log('file')
					}
					else{
						this.Componentes[i].setValue(rec.data[this.Componentes[i].mapeo?this.Componentes[i].mapeo:this.Componentes[i].name])
					  
					}
			    }

			}

		}

	},
	//llena los valores que fueron definidos por edefecto
	loadValoresIniciales:function(){
		for(var i=0;i<this.Componentes.length;i++){
			if(this.Atributos[i].valorInicial!=undefined){
				this.Componentes[i].setValue(this.Atributos[i].valorInicial)
			}
		}
	},
	
	agregarArgsExtraSubmit: function(){
		
	},
	
	agregarArgsBaseSubmit: function(){
		
	},
	

	//obtiene los valores de los componentes del formulario y los pones en un array
	//de esta forma se logra que los campos  deshabilitados regresen valores 
	getValForm:function(){		
		var resp ={};
		
        for(var i=0;i<this.Componentes.length;i++){        	
        	   var ac=this.Atributos[i];
        	   var cmp=this.Componentes[i]
	      	   //if(ac.form!=false && !this.Componentes[i].disabled){ 
	      	   	var swc = true;
				if(ac.vista){
					swc = false;
					  for (var _p in ac.vista) {
						   if(this.nombreVista==ac.vista[_p]){
						   	 swc = true;
						   	 break;
						   }
						}
				}
				
			
	      	   	if(ac.form!=false&&swc){
	      		//   console.log(ac.config.name,this.Componentes[i].getValue())
        	    //rac 12/09/2011
        	    if(cmp.getValue()!='' && ac.type=='DateField' && ac.config.format){
        	      resp[ac.config.name]=cmp.getValue().dateFormat(ac.config.format)
        	    }
        	    else{
        	    	
        	    	//rac 29/10/2011  codificacion de ampersand para su almacenamiento en base de datos
        	    	resp[ac.config.name]=cmp.getValue()	
        	    	//console.log('valores',cmp.getValue())
        	    	resp[ac.config.name] =String(resp[ac.config.name]).replace(/&/g, "%26");
        	    }
		      }
		}
        
    	//RCM 12/12/2011: Llamada a función para agregar parámetros
		this.agregarArgsExtraSubmit();
		this.agregarArgsBaseSubmit();
		Ext.apply(resp,this.argumentExtraSubmit);
		Ext.apply(resp,this.argumentBaseSubmit);
		
		
    	//FIN RCM

		return resp
	},
		//RAC 21092011
	//funcion especifica para procesa el resultado de upload file
	successSaveFileUpload:function(resp,a,b,c,d){
          var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
		if(reg.ROOT.error){
			resp.status=406;
			 this.conexionFailure(resp)
		}
		else{
		    this.successSave(resp);	
		}
	},
	
	successSave:function(resp){
		console.log('sobre cargar successSave')
	},
	getComponente:function(id){
		
		return this.form.getForm().findField(id);

	},
	getIndAtributo:function(name){
		for (var m in this.Atributos){
			if(this.Atributos[m].config.name==name){
				return m 
			}
		}
		return undefined;
	},
	
	onDestroy:function() 	{
		//Phx.baseInterfaz.superclass.destroy.call(this,c);

		if(this.window){
			this.window.destroy();
		}
		if(this.form){
		   this.form.destroy();	
		}
		
		Phx.CP.destroyPage(this.idContenedor);
		delete this;


	},
	onHide:function(){

	},
	onShow:function(){
		

	},
	init:function(){	// inicializacion de variables
		this.panel.doLayout();
		Ext.QuickTips.init();
		Ext.form.Field.prototype.msgTarget='under'; // muestra mensajes de error
													// en el formulario
		//si son ventanas hijo preguntar si el padre tiene un registro seleccionado para hacer reload
        //util en el caso de hijos en tappanel
     
	},
	getForm:function(){
		return this.form;
	},
	
	/*EJEMPLO GRUPO
		 * 
		 * 
		  Grupos: [
            {
                layout: 'column',
                border: false,
                defaults: {
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
					            title: 'Orden y rutas',
					            autoHeight: true,
					            items: [],
						        id_grupo:1
					        }]
					    }]
            }
        ]
		*******/

	
	pushGrupo:function (c,g,id){
		var pag =this;
		if(id){
				if(! pag.buscarGrupo(g,id,c)){
					pag.buscarGrupo(g,0,c)// .items.push(c)
				}
			}
			else{
				 pag.buscarGrupo(g,0,c)// .items.push(c)
			}
		},

	buscarGrupo:function (g,id,c){
			// preguntamos si estamos en el grupo que buscamos
			var j=0, pag =this;;
			while(j < g.length){
				if(g[j].id_grupo==id){
					g[j].items.push(c);
					return true
				}
				else{
					// si no buscamos el grupo en nuestros items hijos
					if(g[j].items && g[j].items.length>0){
						// alert("SI tiene items")
						if(pag.buscarGrupo(g[j].items,id,c)){
							// se encontro el items
							return true;
						}
					}
				}
				j++
			}
			return false;
		},
		
    setMetodoGrupo:function(idGrupo,Metodo,param)
    {
		eval('this.form.find(\'id_grupo\',idGrupo)[0].'+Metodo+'(param)');
	},
	ocultarComponente:function(componente)
	{
		componente.ant_disabled=componente.disabled;
		componente.reset();
		componente.disable();
		componente.hide();
		
	},
	mostrarComponente:function(componente)
	{
		if(componente.ant_disabled)
		{
			 componente.enable();
		}
		componente.show();
	},
	adminGrupo:function(con){
		for(var i=0;i<this.Atributos.length;i++){
			//mostrar grupo
			if(con.mostrar){
				
				for(var j=0;j<con.mostrar.length;j++){	
					if(this.Componentes[i]&&this.Atributos[i].id_grupo==con.mostrar[j]){
						this.mostrarComponente(this.Componentes[i]);
						//console.log('numero',con.mostrar[j])
						this.form.find('id_grupo',con.mostrar[j])[0].show();
					}
				}
			}
			
			//ocultamos grupos
			if(con.ocultar){
				for(var j=0;j<con.ocultar.length;j++){	
					if(this.Componentes[i]&&this.Atributos[i].id_grupo==con.ocultar[j]){
						this.ocultarComponente(this.Componentes[i]);
						this.form.find('id_grupo',con.ocultar[j])[0].hide();
						
					}
				}
		   }
		}
		/*if(con.mostrar){
			for(var j=0;j<con.mostrar.length;j++){
				this.form.find('id_grupo',con.mostrar[j])[0].show();
			}
		}
		if(con.ocultar){	
		  for(var j=0;j<con.ocultar.length;j++){	
		  	this.form.find('id_grupo',con.ocultar[j])[0].hide();
				
			}
		}*/
	},
	ocultarGrupo:function(idGrupo){
		//this.form.find('id_grupo',idGrupo)[0].disable()
		for(var i=0;i<this.Atributos.length;i++){
			if(this.Componentes[i]&&this.Atributos[i].id_grupo==idGrupo){
				this.ocultarComponente(this.Componentes[i]);
			}
		}
		
		this.form.find('id_grupo',idGrupo)[0].hide();
	},
	mostrarGrupo:function(idGrupo){
		//this.form.find('id_grupo',idGrupo)[0].enable();
		for(var i=0;i<this.Atributos.length;i++){
			if(this.Componentes[i]&&this.Atributos[i].id_grupo==idGrupo){
				this.mostrarComponente(this.Componentes[i]);
			}
		}
		this.form.find('id_grupo',idGrupo)[0].show();	
		
	},
		
		
		//inicia componentes de la barra de menu
    defineMenu:function(){
    	var cbuttons=[];
    	// definicion de la barra de menu
    	if(this.btriguerreturn)
    	{
    		cbuttons.push({
			id:'b-triguerreturn-'+this.idContenedor,
			//icon:'../../../lib/imagenes/save.jpg', // icons can also be
			//icon:'../../../lib/imagenes/icono_dibu/dibu_save.png', // icons can also be
			iconCls: 'bselect',										// specified inline
			text:'SELECCIONAR',
			tooltip: '<b>Seleccionar</b>',          // <-- Add the action directly
												// to a menu
			handler: this.onButtonTriguerreturn,
			scope:this
			})
    	}
    	
    	

		if(this.bsave){cbuttons.push({
			id:'b-save-'+this.idContenedor,
			//icon:'../../../lib/imagenes/save.jpg', // icons can also be
			//icon:'../../../lib/imagenes/icono_dibu/dibu_save.png', // icons can also be
			iconCls: 'bsave',										// specified inline
			
			tooltip: '<b>Guardar</b>',          // <-- Add the action directly
												// to a menu
			handler: this.onButtonSave,
			scope:this
		})}

		if(this.bnew){cbuttons.push({                   // <-- Add the action
														// directly to a toolbar
			// text: 'Action Menu',
			id:'b-new-'+this.idContenedor,
			//icon: '../../../lib/imagenes/nuevo.png', // icons can also be
			//icon: '../../../lib/imagenes/icono_dibu/dibu_new.png', // icons can also be
			iconCls: 'bnew',											// specified inline
			
			tooltip: '<b>Nuevo</b>',          // <-- Add the action directly
												// to a menu
			handler: this.onButtonNew,
			scope:this
		})}

		if(this.bedit){cbuttons.push({                   // <-- Add the
															// action directly
															// to a toolbar
			// text: 'Action Menu',
			id:'b-edit-'+this.idContenedor,
			//icon: '../../../lib/imagenes/editar.png', // icons can also be
			//icon: '../../../lib/imagenes/icono_dibu/dibu_edit.png', // icons can also be
			iconCls: 'bedit',										// specified inline
			
			disabled :true,
			tooltip: '<b>Editar</b>',          // <-- Add the action directly
												// to a menu
			handler: this.onButtonEdit,
			scope:this
		})}

		if(this.bdel){cbuttons.push({                   // <-- Add the action
														// directly to a toolbar
			// text: 'Action Menu',
			id:'b-del-'+this.idContenedor,
			//icon: '../../../lib/imagenes/eliminar.png', // icons can also be
			//icon: '../../../lib/imagenes/icono_dibu/dibu_eli.png', // icons can also be
			iconCls: 'bdel',											// specified inline
			
			disabled :true,
			tooltip: '<b>Eliminar</b>',          // <-- Add the action
													// directly to a menu
			handler: this.onButtonDel,
			scope:this
		})}


		if(this.bact){cbuttons.push({                   // <-- Add the action
														// directly to a toolbar
			// text: 'Action Menu',
			id:'b-act-'+this.idContenedor,
			//icon: '../../../lib/imagenes/actualizar.png', // icons can also be
			//icon: '../../../lib/imagenes/icono_dibu/dibu_act.png', // icons can also be
			iconCls: 'bact',												// specified inline
			
			tooltip: '<b>Actuallizar</b>',          // <-- Add the action
													// directly to a menu
			handler: this.onButtonAct,
			scope:this
		})}
		
		/*if(this.bexcel){cbuttons.push({                   // <-- Add the action directly to a toolbar
			//text: 'Action Menu',
			id:'b-excel-'+this.idContenedor,
			icon: '../../../lib/imagenes/excel4.png', // icons can also be specified inline
			cls: 'x-btn-icon',
			tooltip: '<b>Exportar</b>',          // <-- Add the action directly to a menu
			handler: this.onButtonExcel,
			scope:this
		})}*/
		
		//RCM 16/11/2011: Se cambia el boton de excel por un menbu de botones para exportar a excel y pdf
		if(this.bexcel){cbuttons.push({
			id:'b-excel-'+this.idContenedor,
			//icon: '../../../lib/imagenes/print.gif',
			//icon: '../../../lib/imagenes/icono_dibu/dibu_printer.png',
			iconCls: 'bexport',
			tooltip: '<b>Exportar</b>',
			
            xtype:'splitbutton',
            handler: this.onButtonExcel,
            argument:{'news':true,def:'reset'},
            scope:this,
            menu: [{text: 'CSV',iconCls:'bexcel',argument:{'news':true,def:'csv'},handler:this.onButtonExcel,scope:this},
                   {text: 'PDF',iconCls: 'bpdf',argument:{'news':true,def:'pdf'}, handler:this.onButtonExcel,scope:this}]
        })}
		//FIN RCM
	
		this.tbar= new Ext.Toolbar({defaults:{scale:'large'},items:cbuttons});

    },
    
    onButtonTriguerreturn:function(){
    	var data=this.getSelectedData();
    	this.comboTriguer.setValueRec(data);
    	Ext.getCmp(this.idContenedor).close();
    	
    	
    	
    },
    
    
    // Se ejecuta al seleccionar un evento de grid
	EnableSelect:function(n){
		
		var data = this.getSelectedData();
	
		this.preparaMenu(n);
	
		if(this.west){
			this.onEnablePanel(this.idContenedor+'-west',data,n)
		}else{
			if(this.tabwest){
				//si estan habilitadas la pestañas ejecuta el reload solo para la visible
				this.onEnablePanel(this.TabPanelWest.getActiveTab().getId(),data,n)	
			}
		}
		if(this.south){
			this.onEnablePanel(this.idContenedor+'-south',data,n)
		}
		else{
			if(this.tabsouth){
				//si estan habilitadas la pestañas ejecuta el reload solo para la visible
				this.onEnablePanel(this.TabPanelSouth.getActiveTab().getId(),data,n)	
			}
		}
		if(this.east){
			 this.onEnablePanel(this.idContenedor+'-east',data,n)		  
		}else{
			if(this.tabeast){
				//si estan habilitadas la pestañas ejecuta el reload solo para la visible
				this.onEnablePanel(this.TabPanelEast.getActiveTab().getId(),data,n)	
			}
		}
	},

	
	DisableSelect:function(n){
		
        this.liberaMenu(n)
        if(this.west){
          this.onDisablePanel(this.idContenedor+'-west');
		}else{
			if(this.tabwest){
				this.onDisablePanel(this.TabPanelWest.getActiveTab().getId())	
			}	
		}

		if(this.south){
		   this.onDisablePanel(this.idContenedor+'-south');
		}else{
			if(this.tabsouth){
				this.onDisablePanel(this.TabPanelSouth.getActiveTab().getId())	
			}	
		}

		if(this.east){
			 this.onDisablePanel(this.idContenedor+'-east');
		}else{
			if(this.tabeast){
				this.onDisablePanel(this.TabPanelEast.getActiveTab().getId())	
			}	
		}
     },
     
     onEnablePanel:function(idPanel,data){
     	var myPanel
      	if(typeof idPanel == 'object'){
      		myPanel=idPanel
     	}
     	else{
     	myPanel=Phx.CP.getPagina(idPanel);
       }
     	
     	if(idPanel&&myPanel){
     		
		if(myPanel.tipoInterfaz=='gridInterfaz'){
			 myPanel.desbloquearMenus()
		}
		if(myPanel.tipoInterfaz=='arbInterfaz'){
		   myPanel.treePanel.getTopToolbar().enable();
		}
		
		myPanel.onReloadPage(data); // recupera
		myPanel.liberaMenu();
	  } 
	  
	  delete myPanel;
	  
	},
	 onDisablePanel:function(idPanel){
	 	var myPanel
	 	
     	//console.log('>>>>> idPanel',idPanel)
      	if(typeof idPanel == 'object'){
      		myPanel=idPanel
      	}
      	else{
      		myPanel=Phx.CP.getPagina(idPanel);
      	}
	 	
	 	//console.log('panel:'+idPanel);
	 	
	 	
        if(idPanel&& myPanel){
	 		if(myPanel.tipoInterfaz=='gridInterfaz'){
        		myPanel.bloquearLimpiarMenus()
        	
 			}
			if(myPanel.tipoInterfaz=='arbInterfaz'){
				myPanel.root.removeAll();
				myPanel.treePanel.getTopToolbar().disable();
			}
	     }
	    delete myPanel;
	 },
	 
	 getSelectedData:function(){
	 	if(this.tipoInterfaz=='gridInterfaz'){
	 		if(this.sm.getSelected()){
	 		 return this.sm.getSelected().data
	 		}
	 			
	 	}
	 	if(this.tipoInterfaz=='arbInterfaz'){
	 		if(this.treePanel.getSelectionModel().getSelectedNode()){
	 		  return this.treePanel.getSelectionModel().getSelectedNode().attributes
	 		} 	
	 	}
	 	return undefined
	 },
	 
	 onTabChange:function(tp,panel){
	 	//si la pagiaesta contruida
	 	 if(Phx.CP.getPagina(panel.getId())){
	 	 //obtenemos el registro seleccionado en el padre y habilitamos el panel hijo
	 	 if(this.getSelectedData()){
	 	     this.onEnablePanel(panel.getId(),this.getSelectedData())
	 	    }
	 	    else{
	 	    this.onDisablePanel(panel.getId())		 	    	
	 	    }	 	 	
	 	 }
	 },

	// al seleccionar fila en el grid se habilitan o deshabilitan los botones
	// del menu

	preparaMenu:function(n){ 
		var tb =this.tbar;
		if(tb&&this.bedit){tb.items.get('b-edit-'+this.idContenedor).enable()}
		if(tb&&this.bdel){tb.items.get('b-del-'+this.idContenedor).enable()}
		return tb
	},

	// al seleccionar fila en el grid se habilitan o deshabilitan los botones
	// del menu

	liberaMenu:function(){
		var tb =this.tbar;
		if(tb&&this.bsave){tb.items.get('b-save-'+this.idContenedor).enable()}
		if(tb&&this.bnew){tb.items.get('b-new-'+this.idContenedor).enable()}
		if(tb&&this.bedit){tb.items.get('b-edit-'+this.idContenedor).disable()}
		if(tb&&this.bdel){tb.items.get('b-del-'+this.idContenedor).disable()}
		if(tb&&this.bact){tb.items.get('b-act-'+this.idContenedor).enable()}
		if(tb&&this.bexcel){tb.items.get('b-excel-'+this.idContenedor).enable()}
		return tb
	},
	
	//define los componentes del formulario 
    
    definirComponentes:function(){
    	
    	if(this.Atributos){
    	this.filters=[];
    	this.sw_filters=false;
    	
    	if(!this.Grupos){

			this.Grupos=new Array({

				xtype:'fieldset',
				border: false,
				// title: 'Checkbox Groups',
				//autowidth: true,
				layout: 'form',
				items:[],
				id_grupo:0
			});

		}
		// 
		//recorre todos los atributos de la pagina y va creando los
		// componentes para despues poder agregarlo al formulario de la pagina
		// Se prepara el contenido del store, formulario y grid
		//pone el nuemro de fila
		this.paramCM=[];
		this.paramCM.push(new Ext.grid.RowNumberer());
		if(this.CheckSelectionModel){
				this.paramCM.push(this.sm);
		}
		
		
		this.Componentes=[];
		this.ComponentesGrid=[];
		
    //inicia componetes
    
    	for(var i=0;i<this.Atributos.length;i++){
			var ac=this.Atributos[i],econfig;
			//para validar si el atributo  forma parte de la interfaz
			var swc = true;
			if(ac.vista){
				swc = false;
				  for (var _p in ac.vista) {
					   if(this.nombreVista==ac.vista[_p]){
					   	 swc = true;
					   	 break;
					   }
					}
			}
			
			//si el atributo forma parte de la interfaz
			if(swc){
				  // El atributo es parte del formulario
					if(ac.form!=false){
						//se crea el componente
						this.Componentes[i]=new Ext.form[ac.type](ac.config);
						if(ac.config.allowBlank==false)
						{
							this.Componentes[i].fieldLabel='*'+ac.config.fieldLabel;
							
						}
						
						this.pushGrupo(this.Componentes[i],this.Grupos,ac.id_grupo)
						//si el componente es del tipo combo preparamos el store para captura de errores
						if((ac.type=='ComboBox' && ac.config.mode=='remote'  ) || ac.type=='AwesomeCombo' || ac.type=='TrigguerCombo' || ac.type=='ComboRec'){
			 					
						   this.Componentes[i].store.on('exception',this.conexionFailure); 
					    }
					
					}
					if(this.tipoInterfaz=='gridInterfaz'){
		
							if(ac.grid){// SE MUESTRA EN EL GRID?
								//valores por defecto
								var tmpConf={
										 header:ac.config.fieldLabel,
										 align:ac.config.galign?ac.config.galign:'left',
										 width:ac.config.gwidth,
										 renderer:ac.config.renderer,
										 dataIndex:ac.config.name,
										 sortable:ac.config.sortable?ac.config.sortable:true,
										 dtype:ac.type,
										 gdisplayField:ac.config.gdisplayField
									}
							      if(ac.egrid){
									//si el grid es editable inicializamos componente
									this.ComponentesGrid[i]=new Ext.form[ac.type](ac.config);
									if((ac.type=='ComboBox' && ac.config.mode=='remote'  )|| ac.type=='TrigguerCombo' || ac.type=='ComboRec'){
			 					
						                 this.ComponentesGrid[i].store.on('exception',this.conexionFailure); 
					                }
									
									this.egrid=true;
							     	this.paramCM.push(Ext.apply(tmpConf,{
											header:'(e) '+ac.config.fieldLabel,
											editor: this.ComponentesGrid[i]
							     			}));
								}
								else{
									this.paramCM.push(tmpConf)
								}
								
							}
				
							// adiciona el filtro a columna de grid
							if(ac.filters){
				     			this.sw_filters=true;
								if(!ac.filters.dataIndex){
									ac.filters.dataIndex=ac.config.name
								}
								this.filters.push(ac.filters)
							}
					}
			}
		}// fin for componentes
      }
    },
    
    setFormSize:function(w,h){
    	h=this.calTamPor(h,Ext.getBody())
    	this.window.setSize(w,h);
    	//this.window.center()
    },
    setDefFormSize:function(){
    	this.window.setSize(this.fwidth,this.fheight);
    	//this.window.center()
    },
		
  definirFormularioVentana:function(){	
	
		//define la altura en porcentaje al repecto de body
		
		this.fheight=this.calTamPor(this.fheight,Ext.getBody())
		
		 
		//console.log(this.fheight,this.fwidth)
		this.form = new Ext.form.FormPanel({
			id:this.idContenedor+'_W_F',
			items:this.Grupos,
			fileUpload:this.fileUpload,
			autoDestroy:true,
			autoScroll:true
		});
		
		

		// Definicion de la ventana que contiene al formulario
		this.window = new Ext.Window({
			// id:this.idContenedor+'_W',
			title:this.title,
			modal:true,
			width:this.fwidth,
			height:this.fheight,
		    layout: 'fit',
			hidden:true,
			autoScroll:false,
			autoDestroy:true,
			maximizable: true,

			buttons:[{
				text: 'Guardar',
				arrowAlign:'bottom',
				handler:this.onSubmit,
				argument:{'news':false},
				scope:this

			},{
                xtype:'splitbutton',
                text: 'Guardar + Nuevo',
                handler:this.onSubmit,
                argument:{'news':true,def:'reset'},
                scope:this,
                menu: [{text: 'Guardar + reset',argument:{'news':true,def:'reset'},handler:this.onSubmit,scope:this},{text: 'Guardar + duplicar',argument:{'news':true,def:'dupli'}, handler:this.onSubmit,scope:this}]
            },{
				text: 'Declinar',
				handler:this.onDeclinar,

				scope:this
			}],
			items: this.form,
			// autoShow:true,
			autoDestroy:true,
			closeAction:'hide'
		});
    

    },
    //calcula el tamanho porcentual
    calTamPor:function(height,panel){
    	if(Phx.CP._getType(height)== 'string'){
			  height=panel.getHeight()*(parseInt(height.substr(0,height.indexOf('%')))/100);
			  return height;
			}
			return height
 	},
     definirRegiones:function(){
    	//si le regios sur esta habilitada
		if(this.south){
			var params = this.south.params;
		    //define la altura en porcentaje al repecto de this.panel
			this.south.height=this.calTamPor(this.south.height,this.panel);
			this.regiones.push(
			new  Ext.Panel({
				id:this.idContenedor+'-south',
				layout:'fit',
				autoDestroy:true,
				// autoShow:true,
				autoLoad:{url: this.south.url,
				          params:Ext.apply({cls:this.south.cls,_tipo:'direc',idContenedor:this.idContenedor+'-south',idContenedorPadre:this.idContenedor},params),
		                  text: "Cargando...", 
				          callback:Phx.CP.callbackWindows,
				          scope:this,
						  scripts :true},
                 region: 'south',
				 title:this.south.title,
				// collapsible: true,
				// autoShow:true,
				// forceLayout:true,
				height: this.south.height,
				//height:'80%',
				
				split: true,         // enable resizing
				//collapseMode:'mini',
		// floatable:true,
		     animCollapse:false,
				minSize: 75,
				collapsible:true         // defaults to 50
			} ))
		}
		else{
			if(this.tabsouth){
				var arrayTabs=new Array();
				//define la altura en porcentaje al repecto de body
		         this.tabsouth[0].height=this.calTamPor(this.tabsouth[0].height,this.panel);
				
				//console.log('tabs....',this.tabsouth)
				for(var i=0;i< this.tabsouth.length;i++){
					
					arrayTabs.push({
						title: this.tabsouth[i].title,
		                id:this.idContenedor+'-south-'+i,
						layout:'fit',
						 autoLoad:{
		                	url: this.tabsouth[i].url,
				            params:Ext.apply({cls:this.tabsouth[i].cls,_tipo:'direc',idContenedor:this.idContenedor+'-south-'+i,idContenedorPadre:this.idContenedor},params),
		                    text: "Cargando...",
		                    argument:{hola:'aaaaaa',indice:i} ,
				            callback:Phx.CP.callbackWindows,
				            scope:this,
						    scripts :true
						   }
				})
				 }
				
		          this.TabPanelSouth =  new Ext.TabPanel({
	                region: 'south', // a center region is ALWAYS required for border layout
	                height:this.tabsouth[0].height,
	                split: true,         // enable resizing
	                //deferredRender: false,
	               // layout:'fit',
	                activeTab: 0,     // first tab initially active
	                items: arrayTabs
	            })
	            
	           this.TabPanelSouth.on('tabchange',this.onTabChange,this);
	           //this.TabPanelSouth.on('afterrender',this.onTabChange);
	           
		      this.regiones.push(this.TabPanelSouth);
			}	
		}

		if(this.west){
			var params = this.west.params;
			this.regiones.push(
			new  Ext.Panel({
				id:this.idContenedor+'-west',
				layout:'fit',
				autoDestroy:true,
				// autoShow:true,
				autoLoad:{url: this.west.url,
				          params:Ext.apply({cls:this.west.cls,_tipo:'direc',idContenedor:this.idContenedor+'-west',idContenedorPadre:this.idContenedor},params),
	                      text: "Cargando...", 
	                      callback:Phx.CP.callbackWindows,
				          scope:this,
						  scripts :true},
				region: 'west',
				collapsible:true,
				title:this.west.title,
				// collapsible: true,
				// autoShow:true,
				// forceLayout:true,
				width: this.west.width,
				split: true,         // enable resizing
				//collapseMode:'mini',
		// floatable:true,
    		    animCollapse:false,
				minSize: 75        // defaults to 50

			} ))
		}else{
			if(this.tabwest){
				var arrayTabs=new Array();
				for(var i=0;i< this.tabwest.length;i++){
					arrayTabs.push({
						title: this.tabwest[i].title,
		                id:this.idContenedor+'-west-'+i,
						layout:'fit',
						 autoLoad:{
		                   url: this.tabwest[i].url,
				           params:Ext.apply({cls:this.tabwest[i].cls,_tipo:'direc',idContenedor:this.idContenedor+'-west-'+i,idContenedorPadre:this.idContenedor},params),
		                   text: "Cargando...",
		                   argument:{hola:'aaaaaa',indice:i} ,
		                   callback:Phx.CP.callbackWindows,
				           scope:this,
						   scripts :true
						   }
				})
			 }
				
		          this.TabPanelWest =  new Ext.TabPanel({
	                region: 'west', // a center region is ALWAYS required for border layout
	                width: this.tabwest[0].width,
	                split: true,         // enable resizing
	                activeTab: 0,     // first tab initially active
	                minSize: 75 ,      // defaults to 50
	                items: arrayTabs
	            })
	            
	           this.TabPanelWest.on('tabchange',this.onTabChange,this);
	           //this.TabPanelSouth.on('afterrender',this.onTabChange);
	           this.regiones.push(this.TabPanelWest);
			}
         }
		if(this.east){
			var params = this.east.params;
			
			this.regiones.push(
			new  Ext.Panel({
				id:this.idContenedor+'-east',
				layout:'fit',
				autoDestroy:true,
				// autoShow:true,
				autoLoad:{url: this.east.url,
				          params:Ext.apply({cls:this.east.cls,_tipo:'direc',idContenedor:this.idContenedor+'-east',idContenedorPadre:this.idContenedor},params),
                          text: "Cargando...", 
                          callback:Phx.CP.callbackWindows,
				          /*callback:function(r,a,o){
								  // Al retorno de de cargar la ventana
								  // ejecuta la clase que llega en el parametro
     							// cls
							 eval('Phx.CP.setPagina(new Phx.vista.'+this.east.cls+'(o.argument.params))')
						   },*/
						   scope:this,
				           scripts :true},

				region: 'east',
				title:this.east.title,
				collapsible:true,
				width: this.east.width,
				split: true,         // enable resizing
				//collapseMode:'mini',
		// floatable:true,
		     animCollapse:false,
				minSize: 75       // defaults to 50

			} ))
		}else{
			if(this.tabeast){
				var arrayTabs=new Array();
				for(var i=0;i< this.tabeast.length;i++){
					arrayTabs.push({
						title: this.tabeast[i].title,
		                id:this.idContenedor+'-east-'+i,
						layout:'fit',
						 autoLoad:{
		                	url: this.tabeast[i].url,
				            //params:Ext.apply({cls:this.tabeast[l.argument.indice].cls,_tipo:'direc',idContenedor:this.idContenedor+'-east-'+i,idContenedorPadre:this.idContenedor},params),
				            params:Ext.apply({cls:this.tabeast[i].cls,_tipo:'direc',idContenedor:this.idContenedor+'-east-'+i,idContenedorPadre:this.idContenedor},params),
		                    text: "Cargando...",
		                    argument:{hola:'aaaaaa',indice:i} ,
		                    callback:Phx.CP.callbackWindows,
				            /*callback:function(r,a,o,l){
				            //console.log(this,this.tabsouth,this.tabsouth[i].cls)
								  // Al retorno de de cargar la ventana
								  // ejecuta la clase que llega en el parametro
									// cls
							 eval('Phx.CP.setPagina(new Phx.vista.'+this.tabeast[l.argument.indice].cls+'(o.argument.params))')
						   },  */
						   scope:this,
						   scripts :true
						   }
				})
			 }
				
		          this.TabPanelEast =  new Ext.TabPanel({
	                region: 'east', // a center region is ALWAYS required for border layout
	                width: this.tabeast[0].width,
	                split: true,         // enable resizing
	                activeTab: 0,     // first tab initially active
	                minSize: 75 ,      // defaults to 50
	                items: arrayTabs
	            })
	            
	           this.TabPanelEast.on('tabchange',this.onTabChange,this);
	           //this.TabPanelSouth.on('afterrender',this.onTabChange);
	           this.regiones.push(this.TabPanelEast);
			}
         }
		//this.regiones.push();
		 
		this.BorderLayout =  new Ext.Container({
			region: 'center',
			split: true,
			
			//width: 200,
			
			plain:true,
			layout: 'border',
			items: this.regiones


		});

        
		this.panel.add(this.BorderLayout);
		//this.panel.add(this.treePanel);
		this.panel.on('beforedestroy',this.onDestroy,this);
		this.panel.on('beforehide',this.onHide,this);
		this.panel.on('beforeshow',this.onShow,this);
		
		
    },
   	onReloadPage:function(origen){
		alert("es necesario sobrecargar la funcion onReloadPage")
	},
	
	getIdContenedor: function()
	{
		//console.log('cont1:',this.idContenedor);
		return this.idContenedor;
	},
	
	/*
	 *  Inicia y contruye la interface tipo arbol 
	 *  con los parametros de la clase hija
	 * 
	 * */
	constructor: function(config){
		//inicia variable
		
		//array para que las interfases finales envien argumentos adicionales por el submit
		this.argumentExtraSubmit= {};
		//array para que las clases que heredan directo de baseInterfaz (gridInterfaz, frmInterfaz, etc.) envien argumentos por submit
		this.argumentBaseSubmit= {};
		
		
		
		//Copia la configuracion definida en la clases tipo Interfa-N
		if(config.comboTriguer)
		{
          this.btriguerreturn=true;
        }
        
		Phx.baseInterfaz.superclass.constructor.call(this,config);
		Ext.apply(this,config);
		delete config;
        this.panel=Ext.getCmp(this.idContenedor);
        
        //verifica si a ventana se abre desde un cobmo triguer para
        //inicar el boton para regreso de datos
       
        	
      
	},
	
		//cuendo una ventana es reutilizada hacemos un recargar de los datos para ahorrar tiempo de ejecucion y transferencia
	onReload:function(origen){
		alert("es necesario sobrecargar la funcion onReload")
	}
	

});


//}}
