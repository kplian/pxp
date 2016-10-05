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
//Ext.BLANK_IMAGE_URL = '../../resources/images/default/s.gif';

function resizeIframe(obj) {
    obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
}

Ext.example = function(){
    var msgCt;

    function createBox(t, s){
    	alert('hora')
    	console.log('....')
        return ['<div class="msg">',
                '<div class="x-box-tl"><div class="x-box-tr"><div class="x-box-tc"></div></div></div>',
                '<div class="x-box-ml"><div class="x-box-mr"><div class="x-box-mc"><h3>', t, '</h3>', s, '</div></div></div>',
                '<div class="x-box-bl"><div class="x-box-br"><div class="x-box-bc"></div></div></div>',
                '</div>'].join('');
    }
    return {
        msg : function(title, format){
            if(!msgCt){
                msgCt = Ext.DomHelper.insertFirst(document.body, {id:'msg-div'}, true);
            }
            msgCt.alignTo(document, 't-t');
            var s = String.format.apply(String, Array.prototype.slice.call(arguments, 1));
            var m = Ext.DomHelper.append(msgCt, {html:createBox(title, s)}, true);
            m.slideIn('t').pause(1).ghost("t", {remove:true});
            console.log('se ejecuta')
        },

        init : function(){
            /*
            var t = Ext.get('exttheme');
            if(!t){ // run locally?
                return;
            }
            var theme = Cookies.get('exttheme') || 'aero';
            if(theme){
                t.dom.value = theme;
                Ext.getBody().addClass('x-'+theme);
            }
            t.on('change', function(){
                Cookies.set('exttheme', t.getValue());
                setTimeout(function(){
                    window.location.reload();
                }, 250);
            });*/

            var lb = Ext.get('lib-bar');
            if(lb){
                lb.show();
            }
        }
    };
}();

Ext.example.shortBogusMarkup = '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel,Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna. urna.';
Ext.example.bogusMarkup = '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.<br/><br/>Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit.</p>';
Ext.example.test = '<iframe src="http://docs.google.com/present/embed?id=dcn37mcz_22cmnwnwf8"></iframe>';
Ext.example.test2 = '<iframe src="http://www.w3schools.com"></iframe>';
//Ext.example.test3 = '<iframe src="../../../sis_seguridad/widgets/usuarios_login/" height = "340" width = "100%" align="center" frameborder="0"></iframe>';
Ext.example.test3 = '<iframe src="../../../sis_seguridad/widgets/usuarios_login/"  scrolling="no" width = "100%" align="center" frameborder="0" onload="resizeIframe(this)"></iframe>';
//Ext.example.test3 = "<iframe src='../../../sis_seguridad/widgets/usuarios_login/'  height = '360' scrolling='no' width = '100%' align='center' frameborder='0' ></iframe>";




Ext.onReady(Ext.example.init, Ext.example);



// old school cookie functions
var Cookies = {};
Cookies.set = function(name, value){
     var argv = arguments;
     var argc = arguments.length;
     var expires = (argc > 2) ? argv[2] : null;
     var path = (argc > 3) ? argv[3] : '/';
     var domain = (argc > 4) ? argv[4] : null;
     var secure = (argc > 5) ? argv[5] : false;
     document.cookie = name + "=" + escape (value) +
       ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
       ((path == null) ? "" : ("; path=" + path)) +
       ((domain == null) ? "" : ("; domain=" + domain)) +
       ((secure == true) ? "; secure" : "");
};

Cookies.get = function(name){
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	var j = 0;
	while(i < clen){
		j = i + alen;
		if (document.cookie.substring(i, j) == arg)
			return Cookies.getCookieVal(j);
		i = document.cookie.indexOf(" ", i) + 1;
		if(i == 0)
			break;
	}
	return null;
};

Cookies.clear = function(name) {
  if(Cookies.get(name)){
    document.cookie = name + "=" +
    "; expires=Thu, 01-Jan-70 00:00:01 GMT";
  }
};

Cookies.getCookieVal = function(offset){
   var endstr = document.cookie.indexOf(";", offset);
   if(endstr == -1){
       endstr = document.cookie.length;
   }
   return unescape(document.cookie.substring(offset, endstr));
};


Ext.namespace('Phx','Phx.vista.widget');
	
Ext.define('Phx.vista.Dashboard',{		
	extend: 'Ext.util.Observable',
	
	constructor: function(config) {
		
		Ext.apply(this, arguments[0]);
				
		this.callParent(arguments);
		
	    
	    this.panel = Ext.getCmp(this.idContenedor);
	    console.log('this.panel',this.panel);
	    
	    
	    
	    this.tb = new Ext.Toolbar({
				        items:[{
				            text: 'New',
				            iconCls: 'album-btn',
				            scope: this,
				            handler: this.newDasboard, 
				            
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
	    
	    // create some portlet tools using built in Ext tool ids
	    var tools = [{
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
		  
	   
	    this.PanelDash = new Ext.ux.Portal({
	            region:'center',
	            margins:'35 5 5 0',
	            items:[{
		                columnWidth:.33,
		                style:'padding:10px 0 10px 10px',
		                items:[
		                   {
		                       title: 'Another Panel 1',
		                       tools: tools,
		                       html: Ext.example.shortBogusMarkup
		                   }]
		            },{
		                columnWidth:.33,
		                style:'padding:10px 0 10px 10px',
		                items:[
		                {
		                    title: 'Another Panel 3',
		                    tools: tools,
		                    html: Ext.example.test
		                },{
		                    title: 'Another Panel 4',
		                    tools: tools,
		                    html:  Ext.example.test2
		                }
		                
		                
		                
		               ]
		            },{
		                columnWidth:.33,
		                style:'padding:10px 0 10px 10px',
		                items:[{
				                    title: 'Another Panel 4',
				                    tools: tools,
				                    autoHeight: true,
				                    autoScroll : true,
				                    html:  Ext.example.test3
				                }
		                
		                
		                ]
		            }]
	        })
	   
	    this.Border = new Ext.Container({
	        layout:'border',
	        items:[this.treeMenu, this.PanelDash]
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
			
			
	    
	

	
	},
	nodoActual: null,
	
	
	iniciarDashboard:function(nodo){
		
		//es diferente del nodo actual
		if(nodo != this.nodoActual){
			
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
		//limpiar widget
		this.limpiarDashboard();
			
		//crear objetos si no existen
		
		//Phx.vista.widget
		
		var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(response.responseText)).datos;	
		
		console.log('regreso', regreso)
		
		
		// create some portlet tools using built in Ext tool ids
	    var tools = [{
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
		
		var me = this;
		regreso.forEach(function(entry) {
		      

			
			 var wid = Ext.id(), item;
			 console.log('entry......',entry, wid,entry.ruta); 
			 
			 
		     me.PanelDash.items.items[0].add(new Ext.ux.Portlet({
				                id: wid,
				                layout: 'fit',
				                tools: tools,
				                title: 'prueba',
				                closable: true,
				                autoShow: true,
				                autoScroll: false,
				                autoHeight : false,
				                autoDestroy: true,
				                autoLoad: {
						  				url: '../../../'+entry.ruta,
						  				params:{ idContenedor: wid, _tipo: 'direc', mycls: entry.clase},
						  				showLoadIndicator: "Cargando...",
						  				arguments: {config: entry},
						  				callback: me.callbackWidget,
						  				scope: me,
						  				scripts :true 
						  			}
				           }));
		      	
		});
		
		me.PanelDash.doLayout();
		
		
			
		//cargar objetos en panel	
		
	},
	
	insertarWidget:function(){
		
	
	
	},
	
	callbackWidget: function(a,o,c,d){
		
		
		 console.log('---------------',a,o,c,d)
		  console.log('d.arguments.config.clase  .....',d.arguments.config.clase)
		 
		 
		  var xx = new Phx.vista.widget[d.arguments.config.clase](d.params);
		  xx.init();
		 
		
	},
	
	
	
	limpiarDashboard:function(){
		console.log('limpiar dashboard')
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
	
	editDashboard:function(obj, value, startValue){		
		var node = this.sm.getSelectedNode();
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
	successNewDash:function(){
		Phx.CP.loadingHide();
		this.root.reload();
		
	}
	
	
	
});

</script>