/*!
 * Ext JS Library 3.3.0
 * Copyright(c) 2006-2010 Ext JS, Inc.
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
Ext.ux.Portlet = Ext.extend(Ext.Panel, {
    anchor : '100%',
    frame : true,
    collapsible : true,
    draggable : true,
    maximizable : true,
    cls : 'x-portlet',
    //constrain : true,
    //constrainHeader : true,
    swInit: true,
    
    
    /**
     * A shortcut method for toggling between {@link #maximize} and {@link #restore} based on the current maximized
     * state of the window.
     * @return {Ext.Window} this
     */
    toggleMaximize : function(){
        
        return this[this.maximized ? 'restore' : 'maximize']();
        
    },
    
    /**
     * Fits the window within its current container and automatically replaces
     * the {@link #maximizable 'maximize' tool button} with the 'restore' tool button.
     * Also see {@link #toggleMaximize}.
     * @return {Ext.Window} this
     */
    maximize : function(){
    	
    	if(this.swInit){
    	    this.swInit = false;
    	    this.maximize();    	    
    	    this.restore();
    	    
    	    
    	    
    	}
    	
    	
        if(!this.maximized){
            this.expand(false);
            this.restoreSize = this.getSize();
            this.restorePos = this.getPosition(true);
            if (this.maximizable){
                this.tools.maximize.hide();
                this.tools.restore.show();
            }
            this.maximized = true;
            //this.el.disableShadow();

            if(this.dd){
                this.dd.lock();
            }
            if(this.collapsible){
                this.tools.toggle.hide();
            }
            this.el.addClass('x-window-maximized');
            this.container.addClass('x-window-maximized-ct');

            //this.setPosition(0, 0);
            this.beforeFitContainer();
            this.fitContainer();
            //this.fireEvent('maximize', this);
        }
       
        //this.doLayout();
        return this;
    },
    
    
    
    /**
     * Restores a {@link #maximizable maximized}  window back to its original
     * size and position prior to being maximized and also replaces
     * the 'restore' tool button with the 'maximize' tool button.
     * Also see {@link #toggleMaximize}.
     * @return {Ext.Window} this
     */
    restore : function(){
        if(this.maximized){
        	
        	
        
            var t = this.tools;
            this.el.removeClass('x-window-maximized');
            this.container.removeClass('x-window-maximized-ct');
            
            
            
            if(t.restore){
                t.restore.hide();
            }
            if(t.maximize){
                t.maximize.show();
            }
            this.setPosition(this.restorePos[0], this.restorePos[1]);
            this.setSize(this.restoreSize.width, this.restoreSize.height);
            delete this.restorePos;
            delete this.restoreSize;
            this.maximized = false;
            //this.el.enableShadow(true);

            if(this.dd){
                this.dd.unlock();
            }
            if(this.collapsible && t.toggle){
                t.toggle.show();
            }
            
			this.beforeDoConstrain();
            this.doConstrain();
            //this.doLayout();
           // this.fireEvent('restore', this);
        }
        
        return this;
    },
    
     onRender : function(ct, position){
        Ext.ux.Portlet.superclass.onRender.call(this, ct, position);

        
        if(this.maximizable){
            this.mon(this.header, 'dblclick', this.toggleMaximize, this);
        }
    },
    
     // private
    initTools : function(){
        if(this.minimizable){
            this.addTool({
                id: 'minimize',
                handler: this.minimize.createDelegate(this, [])
            });
        }
        if(this.maximizable){
            this.addTool({
                id: 'maximize',
                handler: this.maximize.createDelegate(this, [])
            });
            this.addTool({
                id: 'restore',
                handler: this.restore.createDelegate(this, []),
                hidden:true
            });
        }
        if(this.closable){
            this.addTool({
                id: 'close',
                //handler: this[this.closeAction].createDelegate(this, [])
                handler: function(e, target, panel){
	                panel.ownerCt.remove(panel, true);
	           }
            });
        }
    },
    initComponent : function(){
        this.initTools();
        this.manager = this.manager || Ext.WindowMgr;
        Ext.ux.Portlet.superclass.initComponent.call(this);
       
    },
    
    index: 0,
    maxIndex:999999,
    
    beforeFitContainer:function(){
    	this.getEl().setStyle('position', 'absolute')
        this.index = this.getEl().getStyle('z-index');        
        this.getEl().setStyle('z-index',this.maxIndex);    	
    },
    
    fitContainer : function(){   
    	var vs = this.ownerCt.container.getViewSize(false);
        this.setSize(vs.width, '100%');
    },
    
    beforeDoConstrain: function(){
    	this.getEl().setStyle('position', 'static')
    	this.getEl().setStyle('z-index',this.index);     	
    },
     // private
    doConstrain : function(){    	
    	if(this.constrain || this.constrainHeader){ 
            var offsets;
            if(this.constrain){
                offsets = {
                    right:this.el.shadowOffset,
                    left:this.el.shadowOffset,
                    bottom:this.el.shadowOffset
                };
            }else {
                var s = this.getSize();
                offsets = {
                    right:-(s.width - 100),
                    bottom:-(s.height - 25 + this.el.getConstrainOffset())
                };                
            }
            var xy = this.el.getConstrainToXY(this.container, true, offsets);
            if(xy){
                this.setPosition(xy[0], xy[1]);
            }
        }
    },
    
  
    onResize: function(adjWidth, adjHeight, rawWidth, rawHeight){ 
    	//if(this.maximized){
        //    this.fitContainer();
        //}
       // else{
        	Ext.ux.Portlet.superclass.onResize.call(this, adjWidth, adjHeight, rawWidth, rawHeight);
       // }
    	 
    }
    
    
});

Ext.reg('portlet', Ext.ux.Portlet);
