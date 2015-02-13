Ext.ns('Ext.ux.form');
Ext.ux.form.SearchField = Ext.extend(Ext.form.TriggerField, {
    
    constructor:function(config){
    	 //declaracion de eventos
        this.addEvents('clearfield');
        this.addEvents('initsearch');
        //llama al constructor de la clase padre
		Ext.ux.form.SearchField.superclass.constructor.call(this,config);
		
		this.on('specialkey', function(f, e){
						        	if(e.getKey() == e.ENTER){
								        	this.onTrigger2Click();
								            }
								        }, this);
    },
    initComponent : function(){
        Ext.ux.form.SearchField.superclass.initComponent.call(this);
        
    },

    
    trigger1Class:'x-form-clear-trigger',
    trigger2Class:'x-form-search-trigger',
    
    
    width: 180,
    
    initComponent : function(){
       Ext.ux.form.SearchField.superclass.initComponent.call(this);
	    this.triggerConfig = {
	        tag:'span', cls:'x-form-twin-triggers', cn:[
	        {tag: "img", src: Ext.BLANK_IMAGE_URL, alt: "", cls: "x-form-trigger " + this.trigger1Class},
	        {tag: "img", src: Ext.BLANK_IMAGE_URL, alt: "", cls: "x-form-trigger " + this.trigger2Class}
   		 ]};
	   	
	   
    },
    
    getTrigger : function(index){
        return this.triggers[index];
    },
    
    afterRender: function(){
        Ext.ux.form.SearchField.superclass.afterRender.call(this);
        var triggers = this.triggers,
            i = 0,
            len = triggers.length;
            triggers[0].hide();
    },
    
    initTrigger : function(){
        var ts = this.trigger.select('.x-form-trigger', true),
            triggerField = this;
            
        ts.each(function(t, all, index){
            var triggerIndex = 'Trigger'+(index+1);
            t.hide = function(){
                var w = triggerField.wrap.getWidth();
                this.dom.style.display = 'none';
                triggerField.el.setWidth(w-triggerField.trigger.getWidth());
                triggerField['hidden' + triggerIndex] = true;
            };
            t.show = function(){
                var w = triggerField.wrap.getWidth();
                this.dom.style.display = '';
                triggerField.el.setWidth(w-triggerField.trigger.getWidth());
                triggerField['hidden' + triggerIndex] = false;
            };
            this.mon(t, 'click', this['on'+triggerIndex+'Click'], this, {preventDefault:true});
            t.addClassOnOver('x-form-trigger-over');
            t.addClassOnClick('x-form-trigger-click');
        }, this);
        this.triggers = ts.elements;
    },	
     getTriggerWidth: function(){
        var tw = 0;
        Ext.each(this.triggers, function(t, index){
            var triggerIndex = 'Trigger' + (index + 1),
                w = t.getWidth();
            if(w === 0 && !this['hidden' + triggerIndex]){
                tw += this.defaultTriggerWidth;
            }else{
                tw += w;
            }
        }, this);
        return tw;
    },
    
    hasSearch: false,

    onTrigger1Click : function(){
        if(this.hasSearch){
            this.el.dom.value = '';
            this.triggers[0].hide();
            this.hasSearch = false;
            this.fireEvent('clearfield', this);
        }
    },

    onTrigger2Click : function(){
    	var v = this.getRawValue();
        if(v.length < 1){
            this.onTrigger1Click();
            return;
        }
        this.hasSearch = true;
        this.triggers[0].show();
        this.fireEvent('initsearch', this, v);
    }
});