<?php
/**
 *@package pXP
 *@file gen-Depto.php
 *@author  )
 *@date 24-11-2011 15:52:20
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
function resizeIframe(obj) {
    obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
}

Ext.namespace('Phx','Phx.vista.widget');
Ext.define('Phx.vista.Dashboard',{		
	extend: 'Ext.util.Observable',
	
	constructor: function(config) {
		
		Ext.apply(this, config);
		var me = this;		
		this.callParent(arguments);
		
	    
	    this.panel = Ext.getCmp(this.idContenedor);
	    this.tb = new Ext.Toolbar({
				        items:[{
						            text: 'New',
						            iconCls: 'album-btn',
						            scope: this,
						            handler: this.newDasboard
				            
				          },
				          {
				            text: 'Edit',
				            iconCls: 'album-btn',
				            scope: this,
				            handler: function(){
				            	
				                this.sm = this.treeMenu.getSelectionModel();
				                var node = this.sm.getSelectedNode();
				                if(node){
				                	
					                 this.ge.editNode = node;
					                 this.ge.startEdit(node.ui.textNode);
				                	
				                }
				                else{
				                	alert('seleccione un dashboard')
				                }
				                
				            }
				          },
				          {
						            text: 'Delete',
						            iconCls: 'album-btn',
						            scope: this,
						            handler: this.deleteDasboard
				            
				          }
				          
				          
				          ]
				        });
				        
				        
		this.tbDash = new Ext.Toolbar({
			            region:'north',
				        items:['->',{
					            text: 'Insertar Widget',
					            iconCls: 'album-btn',
					            scope: this,
					            handler: this.loadWindowsWidget, 
					            
					          },{
					            text: 'Guardar',
					            iconCls: 'album-btn',
					            scope: this,
					            handler: this.guardarPosiciones, 
					            
					          }]
				        });	
       var newIndex = 3;
       
       this.loaderTree = new Ext.tree.TreeLoader({
			url : '../../sis_parametros/control/Dashboard/listarDashboard',
			baseParams : {foo:'bar'},
			clearOnLoad : true
		});
	    
	    
	    // set up the Album tree
	    this.treeMenu = new Ext.tree.TreePanel({
	         // tree
	         animate:true,
	         //maskDisabled:false,
	         containerScroll: true,
	         rootVisible:false,
	         region:'west',
	         width:200,
	         split:true,	         
	         autoScroll:true,
	         tbar: this.tb,
	         loader : this.loaderTree,
	         margins: '5 0 5 5'
	    });
	    
	    this.root = new Ext.tree.AsyncTreeNode({
			text : this.textRoot,
			draggable : false,
			allowDelete : true,
			allowEdit : true,
			collapsed : true,
			expanded : true,
			expandable : true,
			hidden : false,
			id : 'id'
		});
	
	     this.treeMenu.setRootNode(this.root);
	
	    // add an inline editor for the nodes
	    this.ge = new Ext.tree.TreeEditor(this.treeMenu, {/* fieldconfig here */ }, {
	        allowBlank:false,
	        blankText:'A name is required',
	        selectOnFocus:true
	    });
	    
	    this.ge.on('complete', this.editDashboard, this);
	    
	    
	    this.PanelDash = new Ext.ux.Portal({
	            region:'center',
	            margins: '5 0 5 5',
	            tbar:this.tbDash,
	            items:[{
		                columnWidth:.33,
		                style:'padding:10px 0 10px 10px',
		                items:[]
		            },{
		                columnWidth:.33,
		                style:'padding:10px 0 10px 10px',
		                items:[]
		            },{
		                columnWidth:.33,
		                style:'padding:10px 0 10px 10px',
		                items:[]
		            }]
		    
		    });
	    
	    this.Border = new Ext.Container({
	        layout:'border',
	        items:[  this.treeMenu, this.PanelDash]
	    });	    
	    
	    this.panel.add(this.Border);
	    this.panel.doLayout();
	    this.addEvents('init');	    
	    
	    this.treeMenu.on('click', function(node, e){
				if(node.isLeaf()){
					if (e != undefined) {
						e.stopEvent();
					}
					console.log('node',node)
					this.iniciarDashboard(node);
				}
			}, this);
			
		 // create some portlet tools using built in Ext tool ids
	    this.toolsportlet = [{
	        id:'gear',
	        handler: function(){
	            Ext.Msg.alert('Message', 'The Settings tool was clicked.');
	        }
	    },{
	        id:'close',
	        handler: function(e, target, panel){
	            panel.ownerCt.remove(panel, true);
	        }
	    }];	
			
			
	},
	nodoActual: null,
	
	
	iniciarDashboard:function(nodo){
		
		//es diferente del nodo actual
		if(nodo != this.nodoActual){
			
			//limpiar widget
		    this.limpiarDashboard();
			
			this.nodoActual = nodo;
			//extraer datos de los widget configurados
			
			Ext.Ajax.request({
					url : '../../sis_parametros/control/Dashdet/listarDashdetalle',
					success : this.cargarDashboard,
					failure : Phx.CP.conexionFailure,
					params : {id_dashboard: nodo.attributes.id_dashboard},
					arguments: {nodo: nodo},
					scope : this
				});
			
			
		}
		
	},
	cargarDashboard:function(response,arg,b){
		
		console.log('regreso', response,arg,b)
		
		console.log('responseText',response.responseText)
		
					
		//crear objetos 	
		var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(response.responseText)).datos;	
		
		var me = this;
		regreso.forEach(function(entry) {			 
			 me.insertarWidget(entry);		      	
		});
		
		me.PanelDash.doLayout();
		
		
	},
	
	insertarWidget:function(entry){
		var me = this;
		var wid = Ext.id()+'-Widget', item ;
		console.log('entry',entry.columna);		
		var indice = entry.columna?entry.columna:0;
		var tmp = new Ext.ux.Portlet({
				                id: wid,
				                layout: 'fit',
				                title: entry.nombre,
				                closable: true,
				                maximizable : true,
				                autoShow: true,
				                autoScroll: false,
				                autoHeight : false,
				                autoDestroy: true,
				                widget: entry,
				                forceLayout:true,
				                autoLoad: {
						  				url: '../../../'+entry.ruta,
						  				params:{ idContenedor: wid, _tipo: 'direc', mycls: entry.clase},
						  				showLoadIndicator: "Cargando...",
						  				arguments: {config: entry},
						  				callback: me.callbackWidget,
						  				text: 'Loading...',
						  				scope: me,
						  				scripts :true 
						  			}
				          });
		
		me.PanelDash.items.items[indice].add(tmp);
		//tmp.show()
	
	
	},
	
	callbackWidget: function(a,o,c,d){		
		 var xx = new Phx.vista.widget[d.arguments.config.clase](d.params);
		  xx.init();		 
	},
	
	limpiarDashboard:function(){
		var me = this;
		
		for(var i=0; i<=2 ;i++){
	    	var aux = 0; 	    	
	    	me.PanelDash.items.items[i].removeAll(true)
         }       
         this.nodoActual = undefined;
	},
	
	newDasboard: function(){
		Phx.CP.loadingShow();
		Ext.Ajax.request({
				url : '../../sis_parametros/control/Dashboard/insertarDashboard',
				success : this.successNewDash,
				failure : Phx.CP.conexionFailure,
				params : {foo: 'bar'},
				scope : this
			});
			
			
	},
	
	deleteDasboard: function(){
		 
		 
		this.sm = this.treeMenu.getSelectionModel();
		var node = this.sm.getSelectedNode();
		
		if(confirm('¿Está seguro de eliminar el Dashboard?')){
					
					Phx.CP.loadingShow();
					Ext.Ajax.request({
							url : '../../sis_parametros/control/Dashboard/eliminarDashboard',
							success : this.successDelDash,
							failure : Phx.CP.conexionFailure,
							params : { id_dashboard: node.attributes.id_dashboard },
							scope : this
						});
			
		}	
	},
	
	editDashboard:function(obj, value, startValue,o){	
		var node =obj.editNode;		
		if(value != startValue){
			Ext.Ajax.request({
					url : '../../sis_parametros/control/Dashboard/insertarDashboard',
					success : this.successNewDash,
					failure : Phx.CP.conexionFailure,
					params : {nombre: value, id_dashboard: node.attributes.id_dashboard},
					scope : this
				});	
		}
		
	},
	
	successDelDash:function(){
		Phx.CP.loadingHide();		
		this.limpiarDashboard();
		this.root.reload();
		
	},
	successNewDash:function(){
		Phx.CP.loadingHide();
		this.root.reload();
		
	},
	
	loadWindowsWidget:function(){		
		var me = this;
		
		if(this.nodoActual)	{                
			    Phx.CP.loadWindows('../../../sis_parametros/vista/widget/WidgetDash.php',
		            'Estado de Wf',
		            {   modal: true,
		                width: '70%',
		                height: '50%'
		            }, 
		            { foo: 'foo' }, 
		            me.idContenedor,'WidgetDash',
		            {  config:[{
		                          event: 'selectwidget',
		                          delegate: me.onSelectwidget,
		                       }],
		               scope:me
		           }); 
       }   
       else {        	
       	  alert('Primero seleccione el dashboard')
       }       
	},
	
	onSelectwidget: function(win, rec){	
		 var me = this;	
		 console.log('selectwidget', rec)
		 win.panel.close();
		 
		 me.insertarWidget(rec.data);		      	
		 me.PanelDash.doLayout();
	},
	
	
	getPosiciones: function(){
    	
    	var position = [], me = this;
    	for(var i=0; i<=2 ;i++){
	    	var aux = 0; 
	    	  	
	    	me.PanelDash.items.items[i].items.items.forEach(function(entry) {
	    	       position.push({  columna: i, 
	    			             fila:aux, 
	    			             id_widget: entry.widget.id_widget?entry.widget.id_widget:0, 
	    			             id_dashdet: entry.widget.id_dashdet?entry.widget.id_dashdet:0,
	    			             id_dashboard: entry.widget.id_dashboard ?entry.widget.id_dashboard:0
	    			          
	    			         });
	    		aux++;
	    	})
    	
       }
       
       return position
    
    },
    
    guardarPosiciones:function(){
    	
    	if(this.nodoActual)	{   
    		console.log(this.getPosiciones());
	    	Phx.CP.loadingShow();
	        Ext.Ajax.request({
	            url:'../../sis_parametros/control/Dashdet/guardarPosiciones',
	            params:{
	            	    id_dashboard_activo:  this.nodoActual.attributes.id_dashboard,
	            	    json_procesos:  Ext.util.JSON.encode(this.getPosiciones()),
	                },
	            success: this.successNewDash,
	            failure: Phx.CP.conexionFailure, 
	            scope: this
	        });
	    }
	    else{
	    	alert('Primero seleccion un dashboard');
	    }	
    }
	
});
</script>