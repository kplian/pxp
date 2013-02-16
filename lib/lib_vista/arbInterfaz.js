/*
**********************************************************
Nombre de la clase:	    arbInterfaz
Proposito:				clase generica para manejo de interfaces tipo arbol
Fecha de Creacion:		21 - 11 - 09
Version:				0
Autor:					Rensi Arteaga Copari
**********************************************************
*/
Ext.namespace('Phx','Phx.vista');
Phx.arbInterfaz=Ext.extend(Phx.baseInterfaz,{

	//Componentes:NULL,
	enableGrid:false,
	encripForm:false,
	title:'Arb-Interfaz',
	expanded:true,	//el arbol inciia expandido
	baseParams:{},
	animate:true,
	enableDrag:false,// <----
	enableDrop:false, // <----
	enableDD:false, // <----
	ddGroup:undefined,
    containerScroll:true,
    rootVisible:false, // <----
    rootExpandable:true,
    rootDisabled:false,
    rootHidden:false,  
    tipoInterfaz:'arbInterfaz', 
    
    //////////////////rac 01/03/2012
    useArrows:false,
    dropConfig: {appendOnly:true},
    reloadOnDrag:false,//sobrecarga despies de un drag el nodo padre
    
    
  	
	//para definir datos basicos que se manejan en todos los nodos
		
	//parametros propios
	
	swBtn:undefined,//esta variables se utiliza para identificar el boton orpimido
	NodoCheck:false,
	paramsCheck:{},
 
	//Funcion nuevo del toolbar
	onButtonNew:function(){
		
		this.swBtn='new';
		//alert(nodo.attributes.id_p+"--");
		this.window.buttons[0].show();		
		this.form.getForm().reset();
		this.loadValoresIniciales();
		this.window.show();
		
		//setea el valor  del nodo selecionad, como el padre 
		//del nuevo nodo, en el segundo componente (id_p)		
		var nodo = this.sm.getSelectedNode();
		
		if(nodo!='' && nodo!=undefined && nodo!=null){
			this.getComponente(this.id_nodo_p).setValue(nodo.attributes[this.id_nodo])
		}else{
			this.getComponente(this.id_nodo_p).setValue('id')
		}
	},
	//Funcion editar del toolbar
	onButtonEdit:function(){

		this.swBtn='edit';
		var nodo = this.sm.getSelectedNode();
		
	
		if(nodo.attributes && nodo.attributes.allowEdit){
			
			this.window.show();
			//llenamos datos del formulario
	
			for(var i=0;i<this.Atributos.length;i++){
					var ac=this.Atributos[i];
					//iniciamos un componente del tipo "Atributos[i].tipo" con laconnfiguracion Atributos.config
					//fields.push({header:ac.fieldLabel,width:ac.gwidth,dataIndex:ac.name});
		
					ac.config.id=this.idContenedor+'-C-'+i;
		
		
					//alert('contenedor de entrada' +ac.config.id)
		
					if(ac.form){
						//El componente es parte del formulario
						if(ac.form){
							
							if((this.Atributos[i].type=='ComboBox' && this.Atributos[i].config.mode=='remote'  )|| this.Atributos[i].type=='TrigguerCombo'){
			                    var _id= ac.config.valueField;
						        //nombre del atributo del combo que recibe el valor
								var _dis= ac.config.displayField;					
								//define el origen del displayField en el grid
								var _df = ac.config.displayField;					
								if(this.Atributos[i].config.gdisplayField){						
									_df = ac.config.gdisplayField;						
								}
			                    if(!this.Componentes[i].store.getById(nodo.attributes[_id])){
									var recTem= new Array();
									recTem[_id]= nodo.attributes[_id];
									recTem[_dis]=nodo.attributes[_df];
			                        this.Componentes[i].store.add(new Ext.data.Record(recTem,nodo.attributes[_id]));
			                        this.Componentes[i].store.commitChanges();
			                    }
			                    //this.Componentes[i].setValue(rec.data[_id])
			                    this.Componentes[i].setValue(nodo.attributes[ac.config.name]);
							}
							else{
							   this.Componentes[i].setValue(nodo.attributes[ac.config.name]);
							}	
		     
						}
					}

		}//fin for componentes
		
		
		
		this.form.getForm().loadRecord(nodo.attributes);
		
		
		this.window.buttons[0].hide();
		
		
		//this.sm.clearSelections()
		
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
	
	//Funcion eliminar del toolbar
	onButtonDel:function(){ 
		if(confirm('¿Esta seguro de eliminar el registro?')){
		
			Phx.CP.loadingShow();
			//para identificar un node dentro un arbol enviamos
			//el identificador  del nodo (id) y el identificador del padre (id_p)
			//y el tipo de nodo 
			/*var params ={
					id :  this.sm.getSelectedNode().attributes['id'],
					id_p: this.sm.getSelectedNode().attributes['id_p'],
					tipo_dato: this.sm.getSelectedNode().attributes['tipo_dato']					
			};*/
			
			var params = {}; 
			params[this.id_nodo]=this.sm.getSelectedNode().attributes[this.id_nodo];
			params[this.id_nodo_p]=this.sm.getSelectedNode().attributes[this.id_nodo_p];
			params['tipo_meta']=this.sm.getSelectedNode().attributes.tipo_meta;
			
			Ext.Ajax.request({
				url:this.ActDel,
				success:this.successDel,
				failure:this.conexionFailure,
				params:params,
				argument :{'nodo':this.sm.getSelectedNode().parentNode},
				timeout:this.timeout,
				scope:this
			});
			this.sm.clearSelections()		
		}
	},
	
	//Funcion actualizar del toolbar
	onButtonAct:function(){
		
		this.sm.clearSelections();
		this.root.reload();
	},
	
	
	onButtonDet:function(){
		
		this.sm.clearSelections();
		this.root.reload();
	},


	//funcion que corre cuando se elimina con exito
	successDel:function(resp){
		Phx.CP.loadingHide();
		resp.argument.nodo.reload()
		
		
	},
	//funcion que corre cuando se guarda con exito
	successSave:function(resp){ 
		Phx.CP.loadingHide();
		if(resp.argument.news){
			
			if(resp.argument.def=='reset'){
			  this.form.getForm().reset();
			}
			
			//this.loadValoresIniciales()
			//this.form.getForm().reset();
			
			//RAC ENDE 1/09/2011
			this.loadValoresIniciales()
			//del nuevo nodo, en el segundo componente (id_p)		
			var nodo = this.sm.getSelectedNode();
			this.getComponente(this.id_nodo_p).setValue(nodo.attributes[this.id_nodo])
		
		}
		else{
			this.window.hide();
		}
		//actualiza el nodo padre
		
	
		if(this.swBtn=='new'){
			var sno
			sno =this.sm.getSelectedNode();
			if(sno){
				sno.reload();	
			}
			else{
				//es el nodo raiz
				this.onButtonAct();
				
			}
		}
		else{
			if(resp.argument.btnCheck){
				resp.argument.nodo.parentNode.reload()
			}
			else{
				var sn = this.sm.getSelectedNode();
				if(sn && sn.parentNode){
			       sn.parentNode.reload();
			   }
			    else{
			    	this.root.reload();
			    }
			    
			}
		}
		
		
	},
	// Abre ventana con el reporte generado en pdf
	successExport:function(resp) {
		Phx.CP.loadingHide();
        var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
        var nomRep=objRes.ROOT.detalle.archivo_generado;
        if(Phx.CP.config_ini.x==1){
        	console.log("entra");
        	nomRep=Phx.CP.CRIPT.Encriptar(nomRep);
        }        
		window.open('../../../lib/lib_control/Intermediario.php?r='+nomRep)
	},
	//Funcion declinar del formulario


	onCheckchange:function(nodo,logico){
		
		Phx.CP.loadingShow();
		var params = {}; 
		params[this.id_nodo]=nodo.attributes[this.id_nodo];
		params[this.id_nodo_p]=nodo.attributes[this.id_nodo_p];
		params['tipo_meta']=nodo.attributes.tipo_meta;
		params['checked']=logico;
		
		Ext.apply(params,this.paramsCheck);
		
		Ext.Ajax.request({
					//form:this.form.getForm().getEl(),
					url:this.ActCheck,
					params:params,
					success:this.successSave,
					argument:{'nodo':nodo,btnCheck:true},
					failure: this.conexionFailure,
					timeout:this.timeout,
					scope:this
			});
	
	
	
	},
	

	//se activa cuando un nodo es seleccionado o deseleccionado
	onChangeNodo:function(e,n){
		if(n && n.isSelected()){
		    this.EnableSelect(n)
		}
		else{
			this.DisableSelect(n)
		}
		
	},
	
	onDragDrop:function(o){
		/*
		* tree - The TreePanel
	    * target - The node being targeted for the drop
	    * data - The drag data from the drag source
	    * point - The point of the drop - append, above or below
	    * source - The drag source
	    * rawEvent - Raw mouse event
	    * dropNode - Drop node(s) provided by the source OR you can supply node(s) to be inserted by setting them on this object.
	    * cancel - Set this to true to cancel the drop.
	    * dropStatus - If the default drop action is cancelled but the drop is valid, setting this to true will prevent the animated 'repair' from appearing.

		 * */
		console.log(o);
		var params ={
		     point:o.point,
		     id_nodo:o.dropNode.attributes[this.id_nodo],
			 id_olp_parent:o.dropNode.attributes[this.id_nodo_p],  
			 id_target:o.target.attributes[this.id_nodo]
		};
		/*
			  point ="above"
			  point ="below"
			  point ="append"
		
		* */
		Ext.Ajax.request({
					//form:this.form.getForm().getEl(),
					url:this.ActDragDrop,
					params:params,
					success:this.successDragDrop,
					argument:{nodo:o.dropNode,target:o.target},
					failure: this.failureDragDrop,
					timeout:this.timeout,
					scope:this
			});
	},
	successDragDrop:function(resp,a,b,c,d){
		
		console.log(resp)
		var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
		if(this.reloadOnDrag){
				resp.argument.target.reload();
		}
		else{
			//actualiza el id del nodo padre
			console.log(resp.argument.nodo.attributes,reg.ROOT.datos)
			Ext.apply(resp.argument.nodo.attributes,reg.ROOT.datos)
			
		}
		
		
	},
	failureDragDrop:function(a,b,c,d){
		
		this.conexionFailure(a,b,c,d)
		
	},
	
	  actualizarNodo:function(){
		  	this.ctxMenu.hide();
				var n = this.treePanel.getSelectionModel().getSelectedNode();
				setTimeout(function(){
					if(!n.leaf){n.reload()}
				}, 10);
	},

	 collapseAll:function(){
		  	var n = this.treePanel.getSelectionModel().getSelectedNode();
				this.ctxMenu.hide();
				setTimeout(function(){
					n.collapseChildNodes(true)
				}, 10);
	},

     expandAll:function(){
		  	var n = this.treePanel.getSelectionModel().getSelectedNode();
				this.ctxMenu.hide();
				setTimeout(function(){
					n.expand(true);
				}, 10);
	},



      onBeforeLoad:function(treeLoader, node) {
			
			treeLoader.baseParams[this.id_nodo] = node.attributes[this.id_nodo];
			
	 },

	
	/*
	 *  Inicia y contruye la interface tipo arbol 
	 *  con los parametros de la clase hija
	 * 
	 * */
	constructor: function(config){
	
		Phx.arbInterfaz.superclass.constructor.call(this,config);
		
         //inicia formulario con todos sus componentes
    	//si es tipo grilla editable tabien los inicia
    	this.definirComponentes();
    	//definir formulario tipo venatana
    	this.definirFormularioVentana();
		
		//definicion de la barra de meno
		this.defineMenu();
		
		this.loaderTree = new Ext.tree.TreeLoader({
			url:this.ActList,
		    baseParams:this.baseParams,
		    clearOnLoad:true
		}); 	

		this.loaderTree.on('beforeload', this.onBeforeLoad, this);
		 
		
	    // set the root node
        this.root = new Ext.tree.AsyncTreeNode({
            text:this.textRoot,
            draggable:false,
            allowDelete:false,
            allowEdit:false,
            collapsed:true,
            expanded:this.expanded,
            expandable:this.rootExpandable,
            disabled:this.rootDisabled,
            hidden:this.rootHidden,
            id:'id' 
        });
		
		 this.treePanel = new Ext.tree.TreePanel({
		 	     region: 'center', 
		 	     scale: 'large',
		 	    singleClickExpand:true,
		 	   // collapsed:true,
		 	    rootVisible:this.rootVisible, 
		 	    root:this.root,
		 	    animate:true, 
		 	    singleExpand:false,
		 	    useArrows: this.useArrows,
		 	  //   containerScroll: true,
                autoScroll:true,
                loader: this.loaderTree,
                enableDD:this.enableDD,
                containerScroll: true,
                border: false,
                dropConfig:this.dropConfig,
                
                tbar:this.tbar
            });
            

        // para capturar un error
		this.loaderTree.on('loadexception',this.conexionFailure); //se recibe un error
		this.sm =this.treePanel.getSelectionModel();
		this.sm.on('selectionchange',this.onChangeNodo,this);		
		//editar al hacer doble click sobre el nodo
		//this.treePanel.on('dblclick',function(){if(this.bedit){ this.onButtonEdit()}},this);
		
		if(this.enableDD){
			this.treePanel.on('beforenodedrop',this.onDragDrop,this);
		}
	
		/*jrr*/
		if(this.NodoCheck){
			this.treePanel.on('checkchange',this.onCheckchange,this);
		}
		
		//rac 05/03/2012
		this.ctxMenu = new Ext.menu.Menu({
				//id:'copyCtx_'+this.idContenedor,
				items: [{
					//id:'expand_'+this.idContenedor,
					handler:this.expandAll,
					icon:'../../../lib/imagenes/arrow-down.gif',
					text:'Expandir todos',
					scope:this
				},{
					//id:'collapse_'+this.idContenedor,
					handler:this.collapseAll,
					icon:'../../../lib/imagenes/arrow-up.gif',
					text:'Colapsar todos',
					scope:this
				},{
					//id:'reload_'+this.idContenedor,
					handler:this.actualizarNodo,
					icon:'../../../lib/imagenes/act.png',
					text:'Actualizar nodo',
					scope:this

				}]
			});
		 
            this.treePanel.on('contextmenu', function (node, e){
				node.select();
				this.ctxMenu.showAt(e.getXY())
			},this);

		
		
		
		///

		this.regiones = new Array();
		//agrega el treePanel
		this.regiones.push(this.treePanel);
		/*arma los panles de ventanas hijo*/
	    this.definirRegiones();
	},
	  onDestroy: function() {
        this.ctxMenu.destroy();
        Phx.arbInterfaz.superclass.onDestroy.call(this);
        

    },
});
