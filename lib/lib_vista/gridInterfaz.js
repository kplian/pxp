/*
**********************************************************
Nombre de la clase:	    Paginaa   
Proposito:				clase generica de interfaz con grilla
Fecha de Creacion:		02 - 05 - 09
Version: 				0 
Autor:					Rensi Arteaga Copari
**********************************************************
*/ 

Ext.namespace('Phx','Phx.vista');


Phx.gridInterfaz=Ext.extend(Phx.baseInterfaz,{
	// Componentes:NULL,
	title:'Grid-Interfaz',
	timeout:Phx.CP.config_ini.timeout,
	tam_pag:50,//registro por paginas del grid
	
	
	tipoInterfaz:'gridInterfaz',
	
	fileUpload:false,
	// configura regiones

	south:false,
	west:false,
	east:false, 
    //bonton excel habilitado por defecto
	bexcel:true,

	// Funcion guardar del toolbar
	onButtonSave:function(o){
	
		var filas=this.store.getModifiedRecords();		
	 	if(filas.length>0){	
			
			if(confirm("Está seguro de guardar los cambios?")){
				//prepara una matriz para guardar los datos de la grilla
				var data={};
						for(var i=0;i<filas.length;i++){
							 //rac 29/10/11 buscar & para remplazar por su valor codificado
							 data[i]=filas[i].data;
							 //captura el numero de fila
							 data[i]._fila=this.store.indexOf(filas[i])+1
							 //RCM 12/12/2011: Llamada a función para agregar parámetros
							this.agregarArgsExtraSubmit(filas[i].data);
							Ext.apply(data[i],this.argumentExtraSubmit);
						    //FIN RCM
							 
							}
					Phx.CP.loadingShow();
					
					
					
			        Ext.Ajax.request({
			        	// form:this.form.getForm().getEl(),
			        	url:this.ActSave,
			        	params:{_tipo:'matriz','row':String(Ext.util.JSON.encode(data)).replace(/&/g, "%26")},
					
						isUpload:this.fileUpload,
						success:this.successSaveFileUpload,
						//argument:this.argumentSave,
						failure: this.conexionFailure,
						timeout:this.timeout,
						scope:this
			        });
		  }
			
		}
		
		
		

	},
	
	
	onButtonTest:function(){
 	    console.log('inicia la prueba Grilla');
 	    
 	    //probar los filtro y ordenaciones
 	    this.probarFiltros();
 	    //probar ordenacion
 	    this.probarOrdenacion();
 	    //reportes
 	    /*
 	    this.onButtonExcel(
 	                      {argument: {
		                        'news': true,
		                        def: 'pdf'
                   			}});
 	   
 	    this.onButtonExcel(
 	                      {argument: {
		                        'news': true,
		                        def: 'csv'
                   			}});*/

 	
    },
    
    datosPrueba:{},
    
    probarOrdenacion:function(){
    	//console.log(this.cm)
    	for(var i=1;i<this.cm.config.length;i++){
    		if(this.cm.isSortable(i)){
	    		//console.log(this.cm.config[i])
	    		//console.log(this.cm.getDataIndex(i))
	    	    this.store.sort(this.cm.getDataIndex(i));
    	    }
    	}
    	
    	
    },
    
    probarFiltros:function(){
    	this.log='';
    	
    	Phx.CP.varLog=true;
    	Phx.CP.varLogTitle=this.title;
    	
    	//console.log(this.gfilter.filters.items.length,this.gfilter.filters.items);
    	//console.log(this.Atributos.length);
		
			var cont_fil =0;
    	 
 	     for (var i = 0; i < this.Atributos.length; i++) {
 	     	//removeAll		
		    this.gfilter.clearFilters();
 	      var ac = this.Atributos[i];
 	     	
 	     	
 	     	if (ac.filters ){
 	     		
 	     		
 	     		var valor = 'Prueba';
 	     		if(ac.filters.type =="string"  ||  ac.filters.type =="list"){
 	     			
 	     			valor = 'Prueba';
 	     		}
 	     		if(ac.filters.type =="numeric"){
 	     			
 	     			valor = 1;
 	     		}
 	     		if(ac.filters.type =="date"){ 
 	     			valor = new Array();
 	     			//var vdate  = new Date();
 	     			valor.on =   new Date();//vdate.dateFormat(ac.config.format?ac.config.format: 'd-m-Y');
 	     			//var vdate  = new Date();
 	     			
 	     		}
 	     		if(this.gfilter.filters.items[cont_fil]){
 	     			
 	     			if (ac.grid!=false){
		 	     		this.gfilter.filters.items[cont_fil].setValue(valor,true);
		    		    this.gfilter.filters.items[cont_fil].setActive(true);
		    		    console.log('Filtro para', ac.config.name)
		    	     }
		    	     else{
		    	     	 console.log('no es visible en la grilla',ac.config.name);
		    	     }
    		   }
    		   else{
    		   	 console.log('item NULO',ac.config.name);
    		   	
    		   }
 	     		
 	     		this.load();
 	     		cont_fil++;
 	     		
 	     	}
 	     	
           
        }
        
          this.gfilter.clearFilters();
    	
    	
    },

	// Funcion eliminar del toolbar
	onButtonDel:function(){
		if(confirm('¿Está seguro de eliminar el registro?')){
			//recupera los registros seleccionados
			var filas=this.sm.getSelections();
			var data= {},aux={};
			//console.log(filas,i)
			
            //arma una matriz de los identificadores de registros que se van a eliminar
            this.agregarArgsExtraSubmit();
            
			for(var i=0;i<this.sm.getCount();i++){
				aux={};
				aux[this.id_store]=filas[i].data[this.id_store];
				
				data[i]=aux;
				data[i]._fila=this.store.indexOf(filas[i])+1
				//rac 22032012
				
				Ext.apply(data[i],this.argumentExtraSubmit);
				
				
			}
			
	
		
			Phx.CP.loadingShow();
			
			//llama el metodo en la capa de control para eliminación
			Ext.Ajax.request({
				url:this.ActDel,
				success:this.successDel,
				failure:this.conexionFailure,
				//params:this.id_store+"="+this.sm.getSelected().data[this.id_store],
				params:{_tipo:'matriz','row':Ext.util.JSON.encode(data)},
				//argument :{'foo':'xxx'},
				timeout:this.timeout,
				scope:this
			})
		}
	},
	onButtonAct:function(){
		this.store.rejectChanges();
		Phx.CP.varLog=false;
		//this.store.removeAll()
		this.reload();
	
	},
	
	getColumnasVisibles:function(valores,extra){
		/*extra: formato
		 * 
		 * { 
		   	    label:'Funcionario',
				name:'desc_funcionario',
				width:'200',
				type:'string',
				gdisplayField:'desc_funcionario',
				value:'Rensi Arteaga Copari'
			}
		 * 
		 * 
		 */
		 
		
		var fila;
		if(valores){
			fila=this.sm.getSelected();
		}
		
		var col = new Array();
		for(var i=1;i<this.cm.config.length;i++){

					if(this.cm.config[i]!=undefined){ 
						// adicionado OCT11, para ventanas hijo que tienen referencia en hidden
						//if(!this.cm.isHidden(i)){
					   if(!this.cm.config[i].scope.hidden){
					   	//if verifico el tipo del compoente
					   	//console.log(this.cm.config[i].scope)
					   	col.push({ 
						   	   label:this.cm.config[i].scope.header,
								name:this.cm.config[i].scope.gdisplayField?this.cm.config[i].scope.gdisplayField:this.cm.config[i].scope.dataIndex,
								width:this.cm.config[i].scope.width,
								type:this.cm.config[i].scope.dtype,
								gdisplayField:this.cm.config[i].scope.gdisplayField,
								value:(valores&&fila)?fila.data[this.cm.config[i].scope.gdisplayField?this.cm.config[i].scope.gdisplayField:this.cm.config[i].scope.dataIndex]:undefined
							});
							
							
						}
					}
				}
				if(extra){
						col.push(extra);
				}
		
		return col
	},
	
	//RCM 16/11/2011: Funcion que exporta el formato de la grilla a un reporte pdf
	onButtonExcel:function(a,b,c,d){
		
		var mensaje = 'a formato CSV?';
		var tipoReporte='excel_grid';
		if(a.argument.def=='pdf'){
			mensaje = 'a formato PDF?';
			tipoReporte='pdf_grid';
		}
		
		
		
		Ext.Msg.confirm('Confirmación','¿Está seguro de exportar la grilla de datos '+mensaje,function(btn){
			if(btn=='yes'){
				var col = this.getColumnasVisibles(false);
				var ColMaestro;
				//si tiene padre
				if(this.idContenedorPadre){
					var pagMaestreo=Phx.CP.getPagina(this.idContenedorPadre);
					if(pagMaestreo.tipoInterfaz=='gridInterfaz'){
					  ColMaestro=pagMaestreo.getColumnasVisibles(true,this.ExtraColumExport);
				    }
				    if(pagMaestreo.tipoInterfaz=='arbInterfaz'){
				      ColMaestro=pagMaestreo.getColumnasNodo();
				    }
				
				}
				var params={
					tipoReporte:tipoReporte,
					titulo:this.title,
					codReporte:this.codReporte==undefined ? '':this.codReporte,
					codSistema:this.codSistema==undefined ? 'PXP':this.codSistema,
					pdfOrientacion:this.pdfOrientacion==undefined ? 'P':this.pdfOrientacion,
					//RCM 16/11/2011: se aumenta condicional cuando getsorstate sea undefined
					//dir:this.store.getSortState().direction,
					dir:this.store.getSortState()==undefined ? 'ASC':this.store.getSortState().direction,
					//sort:this.store.getSortState().field,
					sort:this.store.getSortState()==undefined ? '':this.store.getSortState().field,
					totalCount:this.store.getTotalCount(),
					columnas:Ext.util.JSON.encode(col),
					maestro:Ext.util.JSON.encode(ColMaestro)
				}
				
				if(this.gfilter){
					params.filter=this.gfilter.buildQuery(this.gfilter.getFilterData()).filter;
				}
				
				//console.log(this.store.baseParams);
				Ext.apply(params,this.store.lastOptions.params)
				Ext.apply(params,this.store.baseParams)
				
				Phx.CP.loadingShow()
				
				//console.log('pasaa params',params,this.ActList);
				Ext.Ajax.request({
					url:this.ActList,
					params:params,			
					success:this.successExport,
					failure: this.conexionFailure,
					timeout:this.timeout,
					scope:this
				});
			}
		}, this)
		
		
	
	
	},
	//FIN RCM
	
	// funcion que corre cuando se elimina con exito
	successDel:function(resp){
		//console.log(resp)
		Phx.CP.loadingHide();
		//this.sm.fireEvent('rowdeselect',this.sm);
		this.reload();
		
	},

	// funcion que corre cuando se guarda con exito
	successSave:function(resp){
		this.store.rejectChanges();
		Phx.CP.loadingHide();
		if(resp.argument && resp.argument.news){
			if(resp.argument.def=='reset'){
			  this.form.getForm().reset();
			}
			
			this.loadValoresIniciales()
		}
		else{
			this.window.hide();
		}

		this.reload();

	},
	// Abre ventana con reporte en pdf
	successExport:function(resp){
		Phx.CP.loadingHide();
        var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
        var nomRep=objRes.ROOT.detalle.archivo_generado;
        if(Phx.CP.config_ini.x==1){  			
        	nomRep=Phx.CP.CRIPT.Encriptar(nomRep);
        }        
		window.open('../../../lib/lib_control/Intermediario.php?r='+nomRep)
	},

	load:function(p){
		var x={params:{start:0,limit:this.tam_pag}};
		var SelMod = this.sm;
		Ext.apply(x,p);
		
		x.callback = function(r,opt,suc){
			if(suc){
				if(SelMod.hasSelection()){
					SelMod.fireEvent('rowselect',SelMod);
				}
				else
				{    
					SelMod.fireEvent('rowdeselect',SelMod);
				    
				}
			}
		}
		
		this.store.load(x);
		if(this.gfilter){
			if(!this.gfilter.getFilterData()[0]){
		    	this.getBoton('act').setIconClass('bact') ;
		    	//reinicia paginacion
		    	// this.store.lastOptions.params.start = 0;
	            
		     }
	    }
	    

	},
	reload:function(p){
	    var SelMod = this.sm;
	    //tiene el filtro aplicado 
	     if(this.gfilter){
		     if(!this.gfilter.getFilterData()[0]){
		    	this.getBoton('act').setIconClass('bact') ;
		    	//reinicia  paginacion
		    	// this.store.lastOptions.params.start = 0;
	            
		     }
	     }
	    
		
		this.store.lastOptions.scope= this;
		this.store.lastOptions.callback = function(r,opt,suc){
			if(suc){
				if(SelMod.hasSelection()){
					SelMod.fireEvent('rowselect',SelMod);
				}
				else
				{    
					SelMod.fireEvent('rowdeselect',SelMod);
				    
				}
				
			}
		}
		
		this.store.reload();
    },
	
   //NORMAL, CHECK
   CheckSelectionModel:false,    
 
	
	///////////////////
	//DEFINICON DEL CONSTRUCTOR
    ///////////////////
	constructor: function(config){
      	Phx.gridInterfaz.superclass.constructor.call(this,config);
      	
      	//console.log('id contenedor',this.idContenedor)
    	
    	// creacion del selection model
		
		
		if(!this.CheckSelectionModel){
			
			if(this.CellSelectionModel){
				this.sm=new Ext.grid.CellSelectionModel({
					singleSelect:false,
					listeners:{cellselect:this.EnableSelect,
							   selectionchange :this.DisableSelect,
							   scope:this}
					});	
			}
			else{
			    this.sm=new Ext.grid.RowSelectionModel({
					singleSelect:false,
					listeners:{rowselect:this.EnableSelect,
							   rowdeselect:this.DisableSelect,
							   scope:this}
					});	
			}
				  
		}else{
			this.sm=new Ext.grid.CheckboxSelectionModel({
						singleSelect:false,
						listeners:{rowselect:this.EnableSelect,
								   rowdeselect:this.DisableSelect,
								   scope:this}
						});
        }
    	
    	//inicia formulario con todos sus componentes
    	//si es tipo grilla editable tabien los inicia
    	this.definirComponentes();
    	//definir formulario tipo venatana
    	this.definirFormularioVentana();
	
		// creacion del colummodel
		
		this.cm=new Ext.grid.ColumnModel(this.paramCM);
		
	
		// //////////////////////
		this.cm.defaultSortable=true;
		// creacion del data store
		this.store=new Ext.data.JsonStore({
			// load using script tags for cross domain, if the data in on the
			// same domain as
			// this page, an HttpProxy would be better
			url: this.ActList,
			id: this.id_store,
			root: 'datos',
			sortInfo:this.sortInfo,
			totalProperty: 'total',
			fields:this.fields,
			// turn on remote sorting
			remoteSort: true
		});


		this.store.on('loadexception',this.conexionFailure);

	
		//inicia barra de menu
		this.defineMenu();
		
		// creacion del grid
		
		var param_grid={

			// title:this.title,
			store: this.store,
			cm: this.cm,
			trackMouseOver:false,
			sm:this.sm ,
			loadMask: true,
			region: 'center',
			margins:'3 3 3 0',
			
         	/*
			 * viewConfig: { forceFit:true },
			 */
			tbar:this.tbar,
			bbar: new Ext.PagingToolbar({
				pageSize:this.tam_pag,
				store:this.store,
				displayInfo: true,
				displayMsg: 'Registros {0} - {1} de {2}',
				emptyMsg: "No se tienen registros"
			})

			// renderTo:'grid-'+this.idContenedor,

		}
		
		param_grid.plugins = []


		// si algun componente tiene filtro, lo aplica
		if(this.sw_filters){
			var Myobj = this;
			this.gfilter = new Ext.ux.grid.GridFilters({
				filters:this.filters,encode:true,
				updateBuffer:4000,autoReload:false,
				//RAC 12/1/2012
			    //cambia el icono  de actualizacion si existen filtros
			     onCheckChange : function (item, value) {
	    	            this.getMenuFilter().setActive(value);
	    	            if(this.getFilterData()[0]){
	    	               Myobj.getBoton('act').setIconClass('bactfil') ;	
	    	               //reinicia paginacion
	    	               this.store.lastOptions.params.start = 0;
	    	            }
	    	          
    	           }
				})
			
			
			
			
			param_grid.plugins.push(this.gfilter)
			
			
			
			
		              		                	
		}
		if(this.plugingGroup){
				
				param_grid.plugins.push(this.plugingGroup)
				
			}



		if(this.egrid){

			this.grid = new Ext.grid.EditorGridPanel(param_grid);
			
		}
		else{
			
			this.grid = new Ext.grid.GridPanel(param_grid);
		}
		
		
		this.grid.getBottomToolbar().remove(this.grid.getBottomToolbar().refresh);

		// preparamos regiones


		this.regiones= new Array();
		//ubica el grid en la region central
		this.regiones.push(this.grid);
		/*arma los panles de ventanas hijo*/
		this.definirRegiones()
		
	},
	

	//rac 16092011
	bloquearOrdenamientoGrid :function() {
		var j=0;
			// creacion de componentes
        for(var i=0;i<this.Atributos.length;i++){
			var ac=this.Atributos[i];
			//si el componente es del tipo combo preparamos el store para captura de errores
			if (ac.grid) {
				this.grid.getColumnModel().getColumnById(this.grid.getColumnModel().getColumnId(j++)).sortable = false;
				
			}
		}
	},
	desbloquearOrdenamientoGrid :function() {
		var j=0;
		for(var i=0;i<this.Atributos.length;i++){
			var ac=this.Atributos[i];
			if (ac.grid){
				j++
				if (ac.config.sortable!=false) {
					 this.grid.getColumnModel().getColumnById(this.grid.getColumnModel().getColumnId(j)).sortable = true;
				}
			}
		}
	},
	bloquearMenus:function(){ 
		this.grid.getBottomToolbar().disable();
		this.tbar.disable();
		this.bloquearOrdenamientoGrid();
		
	},
	desbloquearMenus:function(){
		this.grid.getBottomToolbar().enable();
		this.tbar.enable();
		this.desbloquearOrdenamientoGrid();
		
	},
	bloquearLimpiarMenus:function(){
		this.store.removeAll();
		this.bloquearMenus();
		this.bloquearMenusHijo();
		
	},
	/*
	 Cambia las cabecera del header en la columna especificada
	 * */
	
	setColumnHeader:function(dataIndex,name_header){
		var col = this.cm.findColumnIndex(dataIndex);
		this.cm.setColumnHeader(  col, name_header );
	},
	
	bloquearMenusHijo:function(){
		if(this.west){
			Phx.CP.getPagina(this.idContenedor+'-west').store.removeAll();
			Phx.CP.getPagina(this.idContenedor+'-west').bloquearMenus()
		}
		if(this.east){
			Phx.CP.getPagina(this.idContenedor+'-east').store.removeAll();
			Phx.CP.getPagina(this.idContenedor+'-east').bloquearMenus()
		}
		if(this.south){
			Phx.CP.getPagina(this.idContenedor+'-south').store.removeAll();
			Phx.CP.getPagina(this.idContenedor+'-south').bloquearMenus()
		}
	}

});
