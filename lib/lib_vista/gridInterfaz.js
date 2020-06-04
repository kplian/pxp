/*
**********************************************************
Nombre de la clase:	    Paginaa
Proposito:				clase generica de interfaz con grilla
Fecha de Creacion:		02 - 05 - 09
Version: 				0
Autor:					Rensi Arteaga Copari

    HISTORIAL DE MODIFICACIONES:

 ISSUE            FECHA:              AUTOR                 DESCRIPCION
  #0             02 - 05 - 09       RAC                 Creacion
  #24           17/06/2019          RAC                 Configuracion de palntillas de grilla
  #28           27/06/2019          RAC                 Exportar a PDF en hoja horizontal horizontal, titulo plantilla, y datos adicionales
  #51           20/08/2019          RAC                 Mandar el idContenedor en los listados de grilla a los controladores de listado
  #140          12/05/2020          RAC                 sobrecargar el nombre de la columnas por la que se ordena en grilla
**********************************************************
*/
Ext.namespace('Phx','Phx.vista');

Ext.override(Ext.grid.GridView, {
    scrollTop : function() {
        this.scroller.dom.scrollTop = 0;
        this.scroller.dom.scrollLeft = 0;
    },
    scrollToTop : Ext.emptyFn
});

Phx.gridInterfaz=Ext.extend(Phx.baseInterfaz,{
	// Componentes:NULL,
	title: 'Grid-Interfaz',
	stateful: true,
	gruposBarraTareas: [], //cantidad de grupo ...si no hay grupo no se muestra pestaña
	timeout: Phx.CP.config_ini.timeout,
	tam_pag: 50,//registro por paginas del grid
	agruparBarraTareas: 0, //cantidad de grupo ...si no hay grupo no se muestra pestaña
	tipoInterfaz:'gridInterfaz',
	fileUpload: false,
	// configura regiones
	south: false,
	west: false,
	east: false,
	colMaestro: '',
    //bonton excel habilitado por defecto
	bexcel: true,
	bottom_filter_fields : new Array(),
	bottom_filter_labels : new Array(),
	mainRegionPanel: false,
    loadMask : true,
    savePltGrid: false, //#24
    applyPltGrid: false, //#24

	//RCM: 29/03/2014 para grid con check
	checkGrid: false,

	//GroupingStore
	tipoStore: 'JsonStore',//GroupingStore o JsonStore
	groupField: undefined, //Grouping
	remoteGroup: undefined, //Parte del GroupingView
	viewGrid: undefined,	//Parte del GroupingView
	stripeRowsGrid: undefined, //Parte del GroupingView
	dblclickEdit: false,

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
			        	params:{_tipo:'matriz','row':String(Ext.util.JSON.encode(data))},

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

	eventFire:function (el, etype){
	  if (el.fireEvent) {
	    (el.fireEvent('on' + etype));
	  } else {
	    var evObj = document.createEvent('Events');
	    evObj.initEvent(etype, true, false);
	    el.dispatchEvent(evObj);
	  }
	},


	onButtonTest:function(){
		var self = this;
 	   //boton nuevo
 	    if(this.bnew){
	 	    this.getBoton("new").getEl().dom.click();
	 	    setTimeout(function(){self.initTestForm(0)},1000);
 	    }
 	    else{
 	    	//probar los filtros, y depues encadena la prueba de ordenacion
 	         this.probarFiltros();
 	    }
 	 },

    datosPrueba:{},

    setDatTest:function(cmp,name,typeField,vtype,indice){
    	var data='prueba';
    	var self = this;


    	if(typeField=='Field' || typeField=='TextField'|| typeField=='TextArea'){

    		if(vtype=='email'){

    			data='prueba@prueba.com'
    		}else{

    			data='prueba';
    		}
    	  cmp.setValue(this.datosPrueba[name]?this.datosPrueba[name]:data);
    	  cmp.fireEvent('change',cmp,cmp.getValue(),undefined);
    	  this.initTestForm(cmp.indice+1);
    	}

    	if(typeField=='NumberField' || typeField=='MoneyField'){

    		data=1;
    	    cmp.setValue(this.datosPrueba[name]?this.datosPrueba[name]:data);
    	    cmp.fireEvent('change',cmp,cmp.getValue(),undefined);
    	    this.initTestForm(cmp.indice+1);
    	}

    	if(typeField=='RadioGroupField'){

    	  cmp.setValue(cmp.items.items[0].inputValue);
    	  cmp.fireEvent('change',cmp,cmp.items.items[0]);
    	  this.initTestForm(cmp.indice+1);
    	}


    	if(typeField=='ComboBox' &&  cmp.mode=='local'){

    	    cmp.setValue(cmp.store.getAt(0).data[cmp.valueField?cmp.valueField:0]);
    	    cmp.fireEvent('select',cmp,cmp.store.getAt(0),0);
    	    setTimeout(function(){ self.initTestForm(cmp.indice+1)},500);
    	}

    	if((typeField=='ComboBox' || typeField=='ComboRec' || typeField=='TrigguerCombo'  || typeField=='AwesomeCombo')&&  cmp.mode=='remote'){


    	   //cmp.focus(false,800);
    	   //cmp.setRawValue('secreto')
    	    var params= {params:{start:0,limit:this.tam_pag},
	         callback : function (r) {
	       		if (r.length > 0 ) {
	    			cmp.setValue(r[0].data[cmp.valueField]);
	    		}
	    		cmp.fireEvent('select',cmp,r[0],0);
	    		setTimeout(function(){ self.initTestForm(cmp.indice+1)},500);

	    	}, scope : this
	       };

    	    cmp.store.load(Ext.apply(params,cmp.baseParams));
	       //cmp.doQuery('secreto',true);

    	}

    	if(typeField=='DateField'){

    	   cmp.setValue(cmp.minValue?new Date(cmp.minValue):new Date())
    	   cmp.fireEvent('change',cmp,cmp.getValue(),undefined);
	       setTimeout(function(){ self.initTestForm(cmp.indice+1)},1000);
    	}



    },

    initTestForm:function(indice){
    	var comp = this.getValidComponente(indice),
    	    me  = this;
    	if(comp){
	    	if(comp.isVisible()){

		    	var name = comp.name;
		   		var typeField=this.Atributos[comp.indice].type;
		   		var vtype=comp.vtype;
		    	this.setDatTest(comp,name,typeField,vtype);
	    	}
	    	else{
	    		this.initTestForm(comp.indice+1);
	    	}
    	}
    	else{
    		this.window.buttons[0].showMenu();
    	 	this.window.buttons[0].menu.items.items[1].getEl().dom.click();
    	 	this.window.buttons[1].getEl().dom.click();

    	 	//probar los filtros, y depues encadena la prueba de ordenacion
    	 	setTimeout(function(){ me.probarFiltros();},3000);


	    }
    },

    probarOrdenacion:function(iteracion){

    	if(iteracion){
    		iteracion = iteracion  - 1;
    	}
    	else{
    		console.log('inicia prueba de ordenacion')
    		iteracion = this.cm.config.length-1;
    	}

    	var me = this;
    	//for(var i=1;i<this.cm.config.length;i++){
    		if(this.cm.isSortable(iteracion)){
    			me.store.setDefaultSort( me.cm.getDataIndex(iteracion), 'desc' )
	    		//this.store.sort(this.cm.getDataIndex(i));
	    		this.load({
 	     			  scope:this,
 	     			  callback  :function(){
 	     			  	console.log('callback',iteracion)
 	     			  	if(iteracion!=0){
 	     			  		console.log('sort ',iteracion,me.cm.getDataIndex(iteracion) )
 	     			  		me.probarOrdenacion(iteracion)
 	     			  	}

 	     			 }
 	     		});


    	    }
    	    else{
    	    	if(iteracion!=0){
		  		console.log('sort ',iteracion)
		  		me.probarOrdenacion(iteracion)
 	     	    }

    	    }
    	//}
    },

    probarFiltros:function(iteracion,cont_fil){
    	this.log='';

    	Phx.CP.varLog=true;
    	Phx.CP.varLogTitle=this.title;

    	if(iteracion){
    		iteracion = iteracion  - 1;
    	}
    	else{
    		console.log('inicia prueba de filtros')
    		iteracion = this.Atributos.length-1;
    	}

    	if(!cont_fil){
    	  cont_fil=0;
    	}


		    this.gfilter.clearFilters();
 	        var ac = this.Atributos[iteracion];


 	     	if (ac.filters ){


 	     		var valor = 'Prueba';
 	     		if(ac.filters.type =="string"  ||  ac.filters.type =="list"){

 	     			valor = 'Prueba';
 	     		}
 	     		if(ac.filters.type == "numeric"){

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
		    	     }
		    	     else{
		    	     	 console.log('no es visible en la grilla',ac.config.name);
		    	     }
    		   }
    		   else{
    		   	 console.log('item NULO',ac.config.name);
    		   }
 	     		me = this;
 	     		this.load({
 	     			  scope:this,
 	     			  callback  :function(){
 	     			  	console.log('callback',iteracion)
 	     			  	if(iteracion!=0){
 	     			  		console.log('test ',iteracion)
 	     			  		me.probarFiltros(iteracion,cont_fil)
 	     			  	}
 	     			  	else{
 	     			  		 me.gfilter.clearFilters();
 	     			  		 this.probarOrdenacion()
 	     			  	}

 	     			 }
 	     		});
 	     		cont_fil++;

 	     	}
 	     	else{
 	     		if(iteracion!=0){
 	     		    this.probarFiltros(iteracion,cont_fil)
 	     		}
 	     		else{
 	     			me.gfilter.clearFilters();
 	     			this.probarOrdenacion()
 	     		}
 	     	}


    },

	// Funcion eliminar del toolbar
	onButtonDel:function(){
		if(confirm('¿Está seguro de eliminar el registro?')){
			//recupera los registros seleccionados
			var filas=this.sm.getSelections(),
			    data= {},aux={};
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

	initBottomFilter : function () {

		for (var i = 0; i < this.Atributos.length; i++) {
			var ac = this.Atributos[i];
			if ('bottom_filter' in ac && ac.bottom_filter == true) {

				if ('filters' in ac) {
					if ('pfiltro' in ac.filters) {
						this.bottom_filter_fields.push(ac.filters.pfiltro);
					} else {
						this.bottom_filter_fields.push(ac.config.name);
					}
				} else {
					this.bottom_filter_fields.push(ac.config.name);
				}

				this.bottom_filter_labels.push(ac.config.fieldLabel);

			}
		}

		// Si hay mas de un bottom_filter
		if (this.bottom_filter_fields.length > 0) {

			var configFilter = new Ext.ux.form.SearchField ({
					name: 'bottom_filter',
            		itemId : 'bottom_filter',
            		emptyText: 'Filtro rápido...',
            		maxLength: 200,
		        	qtip: 'Este filtro se aplica sobre las columnas: ' + this.bottom_filter_labels.toString()});

			if (this.tbarItems) {
				this.tbarItems.push('-');
				this.tbarItems.push(configFilter);

			} else {
				this.tbarItems = ['-',configFilter];
			}

		}
	},
	//#24
	initPltGrid : function() {
		var me = this;
		var extraButton = 	[];


		if(this.applyPltGrid) {
			var me = this;
			this.cmbPltGrid = new Ext.form.ComboBox ({
														name: 'id_plantilla_grilla_ori',
									            		emptyText: 'plantilla ...',
									            		maxLength: 200,
									            		store: new Ext.data.JsonStore({
															 url: '../../sis_parametros/control/PlantillaGrilla/listarPlantillaGrilla',
															 id: 'id_plantilla_grilla',
															 root: 'datos',
															 sortInfo:{
																field: 'codigo',
																direction: 'ASC'
															},
															totalProperty: 'total',
															fields: ['id_plantilla_grilla','codigo','nombre','configuracion','url_interface','desc_plantilla_grilla'],
															remoteSort: true,
															baseParams:{par_filtro:'nombre'}
														}),
														triggerAction: 'all',
										                lazyRender:true,
										 				mode:'remote',
													    valueField: 'id_plantilla_grilla',
													    displayField: 'desc_plantilla_grilla',
													    pageSize:50,
										 				queryDelay:1000,
										 				width:250,
														listWidth:'280',
									            	});

			this.tbarItems.push([
				                 '-',
				                 this.cmbPltGrid,
			                     {  text:'Aplicar Plantilla',
			                        handler: this.aplicarPltGrilla,
			                        scope: me
			                      }

			                 ]);

			 Ext.state.Manager.getProvider().on('statechange', function(obj, key, value){

			 	 console.log('--->', key,value)
			 });


		}

		if(this.savePltGrid) {
		  this.tbarItems.push({  text:'Guardar Plantilla',
	                             handler: this.guardarPltGrilla,
	                             scope: me });
	    }

		//this.tbarItems.add((extraButton);
	},
	setPltGrilla: function() { //#24
		var id_plt = Ext.state.Manager.getProvider().get(this.grid.stateId+'_id_plt');
		this.cmbPltGrid.store.load({params:{start:0,limit:this.tam_pag},
			                                   callback : function (r) {
			                                        this.cmbPltGrid.setValue(id_plt)
			                                    },
			                                    scope : this
			                       });


		Ext.state.Manager.getProvider().on('statechange', function(  key, value){
			console.log( 'state change.....', key, value)
		})


	},
	aplicarPltGrilla: function() {	//#24
		var selectPltValue = this.cmbPltGrid.getValue();
		if(selectPltValue){
			var recPlt = this.cmbPltGrid.getStore().getById(selectPltValue);
			var state = Ext.state.Manager.getProvider().decodeValue(recPlt.data.configuracion);
			Ext.state.Manager.set( this.grid.stateId, state );
			Ext.state.Manager.set( this.grid.stateId+'_id_plt', selectPltValue );
			location.reload(true);
		}
		else {
			alert('seleccione una plantilla primero');
		}


	},
	guardarPltGrilla: function() {//#24
		//recuperar estado de pantalla

		var state = Ext.state.Manager.getProvider().get(this.grid.stateId);
		var nombrePlt = prompt("Introduzca el nombre de la plantilla:", '');

		if( nombrePlt && nombrePlt != '') {
			Ext.Ajax.request({
					        	url: '../../sis_parametros/control/PlantillaGrilla/insertarPlantillaGrilla	',
					        	params:{ configuracion : Ext.state.Manager.getProvider().encodeValue(state),
					        		     codigo: this.grid.stateId,
					        		     nombre: nombrePlt,
					        		     url_interface: window.location.hash.substr(1)
					        		   },
								success:this.successSaveFileUpload,
								failure: this.conexionFailure,
								timeout:this.timeout,
								scope:this
					        });

		}

	},

	eventinitPltGrid : function () {//#24
				if(this.applyPltGrid) { //# se habilita si la plantilla de grilla en la intefaz esta en true
						this.cmbPltGrid.store.baseParams = {codigo:this.grid.stateId}; //aumenta el parametro codigo para la busqueda en el filtro
				}
	},

	eventBottomFilter : function () {
		// Si hay mas de un bottom_filter
		if (this.bottom_filter_fields.length > 0) {


	    	this.bottom_filter = this.grid.getBottomToolbar().getComponent('bottom_filter');

	    	this.bottom_filter.on('clearfield', function(f, e){

			        this.store.baseParams.bottom_filter_fields = this.bottom_filter_fields.toString();
			        this.store.baseParams.bottom_filter_value ='';
                	this.onButtonAct();

			},this);

	    	this.bottom_filter.on('initsearch', function(f, e){

			        this.store.baseParams.bottom_filter_fields = this.bottom_filter_fields.toString();
			        this.store.baseParams.bottom_filter_value = this.bottom_filter.getValue();
                	this.onButtonAct();

			},this);

			this.bottom_filter.on('blur', function(f, e){

			    this.store.baseParams.bottom_filter_fields = this.bottom_filter_fields.toString();
			    this.store.baseParams.bottom_filter_value = this.bottom_filter.getValue();

			},this);
		}
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
					   		if(this.cm.config[i].isColumn){

							   	col.push({
								   	   label:this.cm.config[i].header,
										name:this.cm.config[i].gdisplayField?this.cm.config[i].gdisplayField:this.cm.config[i].dataIndex,
										width:this.cm.config[i].width,
										type:this.cm.config[i].dtype,
										gdisplayField:this.cm.config[i].gdisplayField,
										value:(valores&&fila)?fila.data[this.cm.config[i].scope.gdisplayField?this.cm.config[i].gdisplayField:this.cm.config[i].scope.dataIndex]:undefined
									});
						   	}
						}
					}
				}

				if(extra){
					col=col.concat(extra);
				}
		console.log('col',col)
		return col
	},
	//#28 definir cabeceras
	setHeaderRep: function(params){
		if(this.cmbPltGrid){
			var selectPltValue = this.cmbPltGrid.getValue();
			if(selectPltValue){
				params.titulo = this.cmbPltGrid.getStore().getById(selectPltValue).data.nombre;
			}
		}

		return  params;
	},

	//RCM 16/11/2011: Funcion que exporta el formato de la grilla a un reporte pdf
	onButtonExcel:function(a,b,c,d){

		var mensaje = 'a formato CSV?',
			tipoReporte = 'excel_grid',
			me = this;
		if(a.argument.def == 'pdf'){
			mensaje = 'a formato PDF?';
			tipoReporte = 'pdf_grid';
		}

		//#28 considera pdf en hoja horizontal
		if(a.argument.def == 'pdf_h'){
			mensaje = 'a formato PDF?';
			tipoReporte = 'pdf_grid';
			this.pdfOrientacion = 'L';
		}




		Ext.Msg.confirm('Confirmación','¿Está seguro de exportar la grilla de datos '+mensaje,function(btn){
			if(btn=='yes'){
				var col = me.getColumnasVisibles(false,me.ExtraColumExportDet);
				//var ColMaestro;
				//si tiene padre
				if(me.idContenedorPadre) {
					var pagMaestreo=Phx.CP.getPagina(this.idContenedorPadre);
					if(pagMaestreo.tipoInterfaz=='gridInterfaz'){
					  me.colMaestro=pagMaestreo.getColumnasVisibles(true,me.ExtraColumExport);
				    }
				    if(pagMaestreo.tipoInterfaz=='arbInterfaz'){
				      me.colMaestro=pagMaestreo.getColumnasNodo();
				    }

				}

				me.colMaestro = me.addMaestro(me.colMaestro);

				var params={
					tipoReporte: tipoReporte,
					titulo: this.title1==undefined ? this.title:this.title1,  //#28
					titulo1: this.title2,
					titulo2: this.description,
					codReporte: this.codReporte==undefined ? '':this.codReporte,
					codSistema: this.codSistema==undefined ? 'PXP':this.codSistema,
					pdfOrientacion: this.pdfOrientacion==undefined ? 'P':this.pdfOrientacion,
					//RCM 16/11/2011: se aumenta condicional cuando getsorstate sea undefined
					//dir:this.store.getSortState().direction,
					dir: this.store.getSortState()==undefined ? 'ASC':this.store.getSortState().direction,
					//sort:this.store.getSortState().field,
					sort: this.store.getSortState()==undefined ? '':this.store.getSortState().field,
					totalCount: this.store.getTotalCount(),
					columnas: Ext.util.JSON.encode(col),
					maestro: this.colMaestro?Ext.util.JSON.encode(this.colMaestro):undefined,
					filaInicioEtiquetas: this.repFilaInicioEtiquetas==undefined ? 10:this.repFilaInicioEtiquetas,
					filaInicioDatos: this.repFilaInicioDatos==undefined ? 8:this.repFilaInicioDatos,
					desplegarMaestro: this.desplegarMaestro==undefined ? 'no':this.desplegarMaestro,
					fechaRep: this.fechaRep==undefined ? '':this.fechaRep
				}

				params = this.setHeaderRep(params);

				if(this.gfilter){
					params.filter = this.gfilter.buildQuery(this.gfilter.getFilterData()).filter;
				}

				Ext.apply(params,this.store.lastOptions.params)
				Ext.apply(params,this.store.baseParams)

				Phx.CP.loadingShow()

				Ext.Ajax.request({
					url:this.ActList,
					params:params,
					success:this.successExport,
					failure: this.conexionFailure,
					timeout:this.timeout,
					scope:this
				});
			}
		}, this);
	},
	//FIN RCM

	addMaestro: function(data){
		return data;
	},


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
			if(resp.argument.def == 'reset'){
			  //this.form.getForm().reset();
			  this.onButtonNew();
			}

			//this.loadValoresIniciales() //RAC 02/06/2017  esta funcion se llama dentro del boton NEW
		}
		else{
			this.window.hide();
		}

		this.reload();

	},
	load: function(p){
		Ext.apply(this.store.baseParams, {contenedor: this.idContenedor});//#51 manda el id contenedor
		var x= { params: { start:0, limit: this.tam_pag } };
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
			if(p&&p.callback){
				p.callback(r,opt,suc)
			}

		}

		this.store.load(x);
		if(this.gfilter){
			if(!this.gfilter.getFilterData()[0]){
		    	this.getBoton('act').setIconClass('bact') ;
		     }
	    }

	},
	reload:function(p){
	     var SelMod = this.sm;
	     SelMod.fireEvent('rowdeselect',SelMod); //RAC 06/06/2017 para que libere menu antes de acualizar
	     //tiene el filtro aplicado
	     if(this.gfilter){
		     if(!this.gfilter.getFilterData()[0]){
		    	this.getBoton('act').setIconClass('bact') ;
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
   CheckSelectionModel:false ,
   /* para justar el boton de tab para que no se baje */
   ajustarHeighTab:function(me){
   	/*
   	  this.tabtbar.items.each(function(item, index, length){item.setHeight(0);},this);
   	  this.tabtbar.setHeight(0);
   	  me.panel.doLayout();*/


   },

   onTabToolBarChange: function(tabpanel,tab){
		this.ajustarHeighTab(this);
		var grupovigente = tabpanel.getActiveTab().grupo;
		//recorrer todo lo botno y ocultar los que son de grupo diferente
		this.tbar.items.each(function(item, index, length){
			console.log(item);
			if(this.isInArray( grupovigente, item.grupo)){
				item.show()
			}
			else{
				item.hide()
			}
		},this);

		this.actualizarSegunTab(tabpanel.getActiveTab().name, grupovigente);

	},

	actualizarSegunTab: function(name, indice){

	},
	///////////////////
	//DEFINICON DEL CONSTRUCTOR
    ///////////////////


   constructor: function(config){
   	    var me = this;
      	Phx.gridInterfaz.superclass.constructor.call(this,config);
      	this.bottom_filter_fields = new Array();
		this.bottom_filter_labels = new Array();
		this.initBottomFilter();
		//#24inicia plantilla de grilla
		this.initPltGrid();

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
		if(this.checkGrid){
			this.selectionModelGridCheck = new Ext.grid.CheckboxSelectionModel({
												singleSelect: false});

			this.paramCM.unshift(this.selectionModelGridCheck);
			this.sm = this.selectionModelGridCheck;
		}


		this.cm = new Ext.grid.ColumnModel(this.paramCM);


		// //////////////////////
		this.cm.defaultSortable=true;
		// creacion del data store


		//this.store=new Ext.data.JsonStore({
		this.store=new Ext.data[this.tipoStore]({
			// load using script tags for cross domain, if the data in on the
			// same domain as
			// this page, an HttpProxy would be better

			url: me.ActList,
			id: me.id_store,
			root: 'datos',
			sortInfo: me.sortInfo,
			totalProperty: 'total',
			fields: me.fields,
			groupField: this.groupField,
			remoteGroup: this.remoteGroup,
			// turn on remote sorting
			remoteSort: true,
			reader: me.reader,
			autoLoad: false  //OJO TEST
		});


		this.store.on('loadexception',this.conexionFailure);

	    //inicia barra de menu
		this.defineMenu();


		// creacion del grid
		this.bbar = new Ext.PagingToolbar({
				pageSize:this.tam_pag,
				store:this.store,
				displayInfo: true,
				displayMsg: 'Registros {0} - {1} de {2}',
				emptyMsg: "No se tienen registros",
				items:this.tbarItems
		});

		var barragrid = this.tbar;
		if(this.gruposBarraTareas.length > 0){
			//tab pane de botones
			this.tabtbar = new Ext.TabPanel({
		        title: 'prueba',
		        resizeTabs: true, // turn on tab resizing
		        minTabWidth: 115,
		        buttonAlign: 'left',
		        tabPosition: 'bottom',
		        //tbar : this.tbar,
		        region: 'north',
		        tabWidth:135,
		        enableTabScroll:true,
		        autoScroll: false,
		        width: '100%',
		        height: 0,
		        autoHeight : false,
		        activeTab: 0,
		        defaults: { height:0, autoHeight : false},
		        items: this.gruposBarraTareas,
		        tbar:this.tbar
		    });

			this.tabtbar.on('tabchange',this.onTabToolBarChange,this);
			barragrid = this.tabtbar;

		}



		var param_grid={

			// title:this.title,
			store: me.store,
			cm: me.cm,
			trackMouseOver: false,
			preserveScrollOnRefresh : true,
			sm: me.sm ,
			loadMask: this.loadMask,
			region:  'center',
			margins: '3 3 3 0',
			//comentado por que al almances en cookies...  llegar a bloearce el servidor por grna tamaño que lega a tener
			stateId: me.stateId?me.stateId:this.myName(),
			stateful: this.stateful,
			stripeRows : me.stripeRowsGrid,
			view: me.viewGrid,
			stateEvents: ['columnmove', 'columnresize', 'sortchange', 'groupchange'],//#24
	        /*
			 * viewConfig: { forceFit:true },
			 */
			tbar: barragrid,
			bbar: this.bbar

			// renderTo:'grid-'+this.idContenedor,

		}

		param_grid.plugins = [];



		// si algun componente tiene filtro, lo aplica
		if(this.sw_filters){
			var Myobj = this;
			this.gfilter = new Ext.ux.grid.GridFilters({
				filters:this.filters,
				encode: true,
				updateBuffer:4000,
				autoReload:false,
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

		if(this.rowExpander){
				param_grid.plugins.push(this.rowExpander)
		}


		param_grid.region='center';


        if(this.egrid){
            this.grid = new Ext.grid.EditorGridPanel(param_grid);
		}
		else{
			this.grid = new Ext.grid.GridPanel(param_grid);
		}
		//#140
		this.store.on('beforeload',function(obj, sortInfo){
            if(sortInfo.params.sort && !sortInfo.params.sort.includes('.')) {
                var ind = me.getIndAtributoByDisplayField(sortInfo.params.sort);
                if(ind) {
                   sortInfo.params.sort = (me.Atributos[ind].config.sortField)?me.Atributos[ind].config.sortField : sortInfo.params.sort;
                }
            }
            return true;
        });

		this.grid.getBottomToolbar().remove(this.grid.getBottomToolbar().refresh);
		this.eventBottomFilter();
		// preparamos regiones


		this.regiones= new Array();
		//ubica el grid en la region central

		//westPanel define si se agregará un panel en alguna región
		if(this.mainRegionPanel){
			var panelConf = {
				id:this.idContenedor+'_main_subpanel_grid',
                layout:'fit',
                border:false,
                region:'west',
                width:350,
                split: true,
                collapsible: true
			};
			Ext.apply(panelConf,this.mainRegionPanel);
			var port = new Ext.Panel({
				id: this.idContenedor+'_main_panel_grid',
				region:'center',
				layout: 'border',
				items:[panelConf,this.grid]
			});
			this.regiones.push(port);
		} else {
			this.regiones.push(this.grid);
		}



		//si hay mas d eun grupo de tabs los agregamos


		/*arma los panles de ventanas hijo*/
		this.definirRegiones();



		this.grid.on('dblclick', function(e){
			if(this.dblclickEdit){
				this.onButtonEdit();
			}
		}, this);

		this.eventinitPltGrid();//#24 inicia los eventos para el combo de plantilla grilla
		if(this.applyPltGrid) { //#24 carga plantilla de grilla escogida si existe
			this.setPltGrilla()
		}

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
			var pw = Phx.CP.getPagina(this.idContenedor+'-west')
			if(pw){
				pw.store.removeAll();
				pw.bloquearMenus()
		   }
		}
		if(this.east){
			var pe=Phx.CP.getPagina(this.idContenedor+'-east');
			if(pe){
				pe.store.removeAll();
				pe.bloquearMenus()
		   }
		}
		if(this.south){
			var ps=Phx.CP.getPagina(this.idContenedor+'-south');
			if(ps){
				ps.store.removeAll();
				ps.bloquearMenus()
		   }
		}
	},
	ocultarColumna: function(dataIndex){
		this.grid.getColumnModel().setHidden(dataIndex, true)
	},

	mostrarColumna: function(dataIndex){
		this.grid.getColumnModel().setHidden(dataIndex, false)
	},

	ocultarColumnaByName: function(name){
		var dataIndex = this.getIndiceColumna(name);
		this.ocultarColumna(dataIndex);
	},

	mostrarColumnaByName: function(name){
		var dataIndex = this.getIndiceColumna(name);
		this.mostrarColumna(dataIndex);
	},

	getIndiceColumna: function(name){

		for(var i=1;i<this.cm.config.length;i++){
			if(this.cm.config[i] != undefined){
				//console.log('cm.config',this.cm.config)
				//console.log('cm.config.name',this.cm.config.name)
				if(this.cm.config[i].dataIndex == name){
			   	  	  break
			   	  }
			}
		}
		return i;

	}

});
