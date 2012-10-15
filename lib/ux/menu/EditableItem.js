Ext.namespace("Ext.ux.menu");
Ext.ux.menu.EditableItem = Ext.extend(Ext.menu.BaseItem, {
    itemCls : "x-menu-item",
    hideOnClick: false,
    
    initComponent: function(){
    	this.addEvents({keyup: true});
		this.editor = this.editor || new Ext.form.TextField();
		if(this.text)
			this.editor.setValue(this.text);
    },
    
    onRender: function(container){
        var s = container.createChild({
        	cls: this.itemCls,
        	html: '<img src="' + (this.icon||Ext.BLANK_IMAGE_URL)+ '" class="x-menu-item-icon'+(this.iconCls?' '+this.iconCls:'')+'" style="margin: 3px 7px 2px 2px;" />'});
        
        Ext.apply(this.config, {width: 125});
        this.editor.render(s);
        
        this.el = s;
        this.relayEvents(this.editor.el, ["keyup"]);
		
		this.el.swallowEvent(['keydown','keypress']);
        Ext.each(["keydown", "keypress"], function (eventName) {
			this.el.on(eventName, function (e) {
				if (e.isNavKeyPress())
				  e.stopPropagation();
			}, this);
        }, this);
        
        if(Ext.isGecko) {
            s.setOverflow('auto');
            var containerSize = container.getSize();
            this.editor.getEl().setStyle('position', 'fixed');
            container.setSize(containerSize);
        }
			
        Ext.ux.menu.EditableItem.superclass.onRender.apply(this, arguments);
    },
    
    getValue: function(){
    	return this.editor.getValue();
    },
    
    setValue: function(value){
    	this.editor.setValue(value);
    },
    
    isValid: function(preventMark){
    	return this.editor.isValid(preventMark);
    }
});