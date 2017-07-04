/*
 **********************************************************
 Nombre de la clase:	arbGridInterfaz
 Proposito:				clase generica para manejo de interfaces tipo arbol y grilla
 Fecha de Creacion:		02 - 05 - 2015
 Version:				0
 Autor:					Rensi Arteaga Copari (kplian)
 **********************************************************
 */
Ext.namespace('Phx', 'Phx.vista');
Phx.arbGridInterfaz = Ext.extend(Phx.baseInterfaz, {

	enableGrid : false,
	encripForm : false,
	title : 'Arb-Interfaz',
	expanded : true, //el arbol incia expandido
	baseParams : {},
	ddParams : {},
	animate : true,
	enableDrag : false,
	enableDrop : false,
	enableDD : false,
	ddGroup : undefined,
	containerScroll : true,
	rootVisible : false,
	rootExpandable : true,
	rootDisabled : false,
	rootHidden : false,
	tipoInterfaz : 'arbGridInterfaz',
	oldParentNode : null,
	useArrows : false,
	dropConfig : {
		appendOnly : true
	},
	//parametros propios
	swBtn : undefined, //esta variables se utiliza para identificar el boton orpimido
	NodoCheck : false,
	paramsCheck : {},
	onButtonNew : function() {
		//Funcion nuevo del toolbar
		this.swBtn = 'new';
		this.window.buttons[0].show();
		this.form.getForm().reset();
		this.loadValoresIniciales();
		this.window.show();

		//setea el valor  del nodo selecionad, como el padre
		//del nuevo nodo, en el segundo componente (id_p)
		var nodo = this.sm.getSelectedNode();
		if (nodo != '' && nodo != undefined && nodo != null) {
			this.Cmp[this.id_nodo_p].setValue(nodo.attributes[this.id_nodo])
		} else {
			this.Cmp[this.id_nodo_p].setValue('id')
		}
	},
	onButtonEdit : function() {
		//Funcion editar del toolbar
		this.swBtn = 'edit';
		var nodo = this.sm.getSelectedNode();
		if (nodo.attributes && nodo.attributes.allowEdit) {
			this.window.show();
			//llenamos datos del formulario
			for (var i = 0; i < this.Atributos.length; i++) {
				var ac = this.Atributos[i];
				//iniciamos un componente del tipo "Atributos[i].tipo" con laconnfiguracion Atributos.config
				//fields.push({header:ac.fieldLabel,width:ac.gwidth,dataIndex:ac.name});
				ac.config.id = this.idContenedor + '-C-' + i;
				if (ac.form) {
					//El componente es parte del formulario
					if (ac.form) {
						if ((this.Atributos[i].type == 'ComboBox' && this.Atributos[i].config.mode == 'remote'  ) || this.Atributos[i].type == 'TrigguerCombo') {
							var _id = ac.config.valueField;
							//nombre del atributo del combo que recibe el valor
							var _dis = ac.config.displayField;
							//define el origen del displayField en el grid
							var _df = ac.config.displayField;
							if (this.Atributos[i].config.gdisplayField) {
								_df = ac.config.gdisplayField;
							}
							if (!this.Componentes[i].store.getById(nodo.attributes[_id])) {
								var recTem = new Array();
								recTem[_id] = nodo.attributes[_id];
								recTem[_dis] = nodo.attributes[_df];
								this.Componentes[i].store.add(new Ext.data.Record(recTem, nodo.attributes[_id]));
								this.Componentes[i].store.commitChanges();
							}
							//this.Componentes[i].setValue(rec.data[_id])
							this.Componentes[i].setValue(nodo.attributes[ac.config.name]);
						} else {
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
	loadValoresIniciales : function() {
		for (var i = 0; i < this.Componentes.length; i++) {
			if (this.Atributos[i].valorInicial != undefined) {
				this.Componentes[i].setValue(this.Atributos[i].valorInicial)
			}
		}
	},
	//Funcion eliminar del toolbar
	onButtonDel : function() {
		if (confirm('¿Esta seguro de eliminar el registro?')) {
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
			params[this.id_nodo] = this.sm.getSelectedNode().attributes[this.id_nodo];
			params[this.id_nodo_p] = this.sm.getSelectedNode().attributes[this.id_nodo_p];
			params['tipo_meta'] = this.sm.getSelectedNode().attributes.tipo_meta;

			Ext.Ajax.request({
				url : this.ActDel,
				success : this.successDel,
				failure : this.conexionFailure,
				params : params,
				argument : {
					'nodo' : this.sm.getSelectedNode().parentNode
				},
				timeout : this.timeout,
				scope : this
			});
			this.sm.clearSelections()
		}
	},

		
		
	
	
	//Funcion actualizar del toolbar
	onButtonAct : function() {
		this.sm.clearSelections();
		this.root.reload();
	},
	onButtonDet : function() {
		this.sm.clearSelections();
		this.root.reload();
	},
	//funcion que corre cuando se elimina con exito
	successDel : function(resp) {
		Phx.CP.loadingHide();
		resp.argument.nodo.reload()
	},
	//funcion que corre cuando se guarda con exito
	successSave : function(resp) {
		Phx.CP.loadingHide();
		if (resp.argument.news) {
			if (resp.argument.def == 'reset') {
				 this.onButtonNew()
			}
			//this.loadValoresIniciales()
			//this.form.getForm().reset();
			//this.loadValoresIniciales() //RAC 02/06/2017  esta funcion se llama dentro del boton NEW
			//del nuevo nodo, en el segundo componente (id_p)
			var nodo = this.sm.getSelectedNode();
			this.Cmp[this.id_nodo_p].setValue(nodo.attributes[this.id_nodo])
		} else {
			this.window.hide();
		}
		//actualiza el nodo padre
		if (this.swBtn == 'new') {
			var sno
			sno = this.sm.getSelectedNode();
			if (sno) {
				sno.reload();
			} else {
				//es el nodo raiz
				this.onButtonAct();
			}
		} else {
			if (resp.argument.btnCheck) {
				resp.argument.nodo.parentNode.reload()
			} else {
				var sn = this.sm.getSelectedNode();
				if (sn && sn.parentNode) {
					sn.parentNode.reload();
				} else {
					this.root.reload();
				}
			}
		}
	},
	// Abre ventana con el reporte generado en pdf
	successExport : function(resp) {
		Phx.CP.loadingHide();
		var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
		var nomRep = objRes.ROOT.detalle.archivo_generado;
		if (Phx.CP.config_ini.x == 1) {
			nomRep = Phx.CP.CRIPT.Encriptar(nomRep);
		}
		window.open('../../../lib/lib_control/Intermediario.php?r=' + nomRep+'&t='+new Date().toLocaleTimeString())
	},
	//Funcion declinar del formulario
	onCheckchange : function(nodo, logico) {
		Phx.CP.loadingShow();
		var params = {};
		params[this.id_nodo] = nodo.attributes[this.id_nodo];
		params[this.id_nodo_p] = nodo.attributes[this.id_nodo_p];
		params['tipo_meta'] = nodo.attributes.tipo_meta;
		params['checked'] = logico;

		Ext.apply(params, this.paramsCheck);

		Ext.Ajax.request({
			//form:this.form.getForm().getEl(),
			url : this.ActCheck,
			params : params,
			success : this.successSave,
			argument : {
				'nodo' : nodo,
				btnCheck : true
			},
			failure : this.conexionFailure,
			timeout : this.timeout,
			scope : this
		});

	},
	//se activa cuando un nodo es seleccionado o deseleccionado
	onChangeNodo : function(e, n) {
		if (n && n.isSelected()) {
			this.EnableSelect(n)
		} else {
			this.DisableSelect(n)
		}
	},
	onNodeDrop : function(o) {
		Phx.CP.loadingShow();
		var params = {
			point : o.point,
			id_nodo : o.dropNode.attributes[this.idNodoDD],
			id_old_parent : o.dropNode.attributes[this.idOldParentDD],
			id_target : o.target.attributes[this.idTargetDD]
		};
		
		Ext.apply(params, this.ddParams);
		
		/*
		 point ="above"
		 point ="below"
		 point ="append"
		 * */
		Ext.Ajax.request({
			url : this.ActDragDrop,
			params : params,
			success : this.successDragDrop,
			argument : {
				nodo : o.dropNode,
				target : o.target
			},
			failure : this.failureDragDrop,
			timeout : this.timeoutDragDrop,
			scope : this
		});
	},
	getColumnasNodo:function(extra){
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
		var nodo = this.sm.getSelectedNode();
		var col = new Array();
		//inicia componetes
        for (var i = 0; i < this.Atributos.length; i++) {
                var ac = this.Atributos[i];
                if(ac.config.inputType!='hidden'){
					   	col.push({ 
						   	    label:ac.config.fieldLabel,
								name:ac.config.name,
								width:ac.width,
								type:ac.type,
								gdisplayField:ac.config.gdisplayField,
								value:nodo.attributes[ac.config.name]
							});
					}		
				}
		if(extra){
			col.push(extra);
		}
		
		return col
	},
	
	
	onMoveNode : function(tree, node, oldParent, newParent, index) {
		this.oldParentNode = oldParent;
	},
	successDragDrop : function(resp, a, b, c, d) {
		Phx.CP.loadingHide();
		this.oldParentNode = null;
		resp.argument.target.reload();
	},
	failureDragDrop : function(resp, b, c, d) {
		Phx.CP.loadingHide();
		this.conexionFailure(resp, b, c, d);
		this.rollbackDragDrop(resp.argument.nodo, this.oldParentNode);
	},
	timeoutDragDrop : function(resp, b, c, d) {
		Phx.CP.loadingHide();
		this.timeout(resp, b, c, d);
		this.rollbackDragDrop(resp.argument.nodo, this.oldParentNode);
	},
	rollbackDragDrop : function(node, oldParentNode) {
		node.remove();
		oldParentNode.reload();
		oldParentNode = null;
	},
	actualizarNodo : function() {
		this.ctxMenu.hide();
		var n = this.treePanel.getSelectionModel().getSelectedNode();
		setTimeout(function() {
			if (!n.leaf) {
				n.reload()
			}
		}, 10);
	},
	collapseAll : function() {
		var n = this.treePanel.getSelectionModel().getSelectedNode();
		this.ctxMenu.hide();
		setTimeout(function() {
			n.collapseChildNodes(true)
		}, 10);
	},
	expandAll : function() {
		var n = this.treePanel.getSelectionModel().getSelectedNode();
		this.ctxMenu.hide();
		setTimeout(function() {
			n.expand(true);
		}, 10);
	},
	onBeforeLoad : function(treeLoader, node) {
		treeLoader.baseParams[this.id_nodo] = node.attributes[this.id_nodo];
	},

	/*
	 *  Inicia y contruye la interface tipo arbol
	 *  con los parametros de la clase hija
	 *
	 * */
	constructor : function(config) {
		Phx.arbGridInterfaz.superclass.constructor.call(this, config);
		//inicia formulario con todos sus componentes
		//si es tipo grilla editable tabien los inicia
		this.definirComponentes();
		//definir formulario tipo venatana
		this.definirFormularioVentana();
		//definicion de la barra de meno
		this.defineMenu();
		/*this.loaderTree = new Ext.tree.TreeLoader({
			url : this.ActList,
			baseParams : this.baseParams,
			clearOnLoad : true
		});*/
		
		this.loaderTree = new Ext.ux.tree.TreeGridLoader({
                url : this.ActList,
			    baseParams : this.baseParams,
			    clearOnLoad : true
            })
            
            
		this.loaderTree.on('beforeload', this.onBeforeLoad, this);
		// set the root node
		this.root = new Ext.tree.AsyncTreeNode({
			text : this.textRoot,
			draggable : false,
			allowDelete : false,
			allowEdit : false,
			collapsed : true,
			expanded : this.expanded,
			expandable : this.rootExpandable,
			disabled : this.rootDisabled,
			hidden : this.rootHidden,
			id : 'id'
		});

		//this.treePanel = new Ext.tree.TreePanel({
		/*this.treePanel = new Ext.ux.tree.TreeGrid
			region : 'center',
			scale : 'large',
			singleClickExpand : true,
			// collapsed:true,
			rootVisible : this.rootVisible,
			root : this.root,
			animate : true,
			singleExpand : false,
			useArrows : this.useArrows,
			//   containerScroll: true,
			autoScroll : true,
			loader : this.loaderTree,
			enableDD : this.enableDD,
			containerScroll : true,
			border : false,
			dropConfig : this.dropConfig,

			tbar : this.tbar
		});*/		
		this.treePanel = new Ext.ux.tree.TreeGrid({
	        
	        tbar : this.tbar,
	        dropConfig : this.dropConfig, 
	        region : 'center',
	        //scale : 'large',
	        //animate : true,
	        singleClickExpand : true,
	        
	        //rootVisible : this.rootVisible,
	        
	        //autoScroll : true,
	        loader : this.loaderTree,
	        root : this.root,
	        enableDD : this.enableDD,
			//border : false,
			columns:this.paramCM 
	    });
	    
	    //this.treePanel.setRootNode( this.root);

		// para capturar un error
		//this.loaderTree.on('loadexception', this.conexionFailure);
		//se recibe un error
		this.sm = this.treePanel.getSelectionModel();
		this.sm.on('selectionchange', this.onChangeNodo, this);
		//editar al hacer doble click sobre el nodo
		//this.treePanel.on('dblclick',function(){if(this.bedit){ this.onButtonEdit()}},this);

		if (this.enableDD) {
			this.treePanel.on('nodedrop', this.onNodeDrop, this);
			this.treePanel.on('movenode', this.onMoveNode, this);
		}

		if (this.NodoCheck) {
			this.treePanel.on('checkchange', this.onCheckchange, this);
		}

		this.ctxMenu = new Ext.menu.Menu({
			//id:'copyCtx_'+this.idContenedor,
			items : [{
				//id:'expand_'+this.idContenedor,
				handler : this.expandAll,
				icon : '../../../lib/imagenes/arrow-down.gif',
				text : 'Expandir todos',
				scope : this
			}, {
				//id:'collapse_'+this.idContenedor,
				handler : this.collapseAll,
				icon : '../../../lib/imagenes/arrow-up.gif',
				text : 'Colapsar todos',
				scope : this
			}, {
				//id:'reload_'+this.idContenedor,
				handler : this.actualizarNodo,
				icon : '../../../lib/imagenes/act.png',
				text : 'Actualizar nodo',
				scope : this

			}]
		});

		this.treePanel.on('contextmenu', function(node, e) {
			node.select();
			this.ctxMenu.showAt(e.getXY())
		}, this);

		this.regiones = new Array();
		//agrega el treePanel
		this.regiones.push(this.treePanel);
		/*arma los panles de ventanas hijo*/
		this.definirRegiones();
	},
	onDestroy : function() {
		this.ctxMenu.destroy();
		Phx.arbGridInterfaz.superclass.onDestroy.call(this);

	},
});
