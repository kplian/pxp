/**
*@package pXP
*@file Usuario.php
*@author KPLIAN (RAC)
*@date 30-06-2011
*@description Componente extendido del combo para mas un trigguer adiconal para llamadas a una interfaz
*/
Ext.form.ComboMultiple = Ext.extend(Ext.form.ComboBox, {
	
	trigger1Class:'x-form-arrow-trigger',
    trigger2Class:'x-form-search-trigger',
    turl:'',
    ttitle:'Ventana',
    tconfig:{width:900,height:400},
    tdata:{},
    tcls:'tcls',
    pid:'',
	
	 initComponent : function(){
         Ext.form.ComboMultiple.superclass.initComponent.call(this);

    this.triggerConfig = {
        tag:'span', cls:'x-form-twin-triggers', cn:[
        {tag: "img", src: Ext.BLANK_IMAGE_URL, alt: "", cls: "x-form-trigger " + this.trigger1Class},
        {tag: "img", src: Ext.BLANK_IMAGE_URL, alt: "", cls: "x-form-trigger " + this.trigger2Class}
    ]};
    },
    
    onRender : function(ct, position){
        if(!this.el){
            this.defaultAutoCreate = {
                tag: "textarea",
                style:"width:100px;height:60px;",
                autocomplete: "off"
            };
        }
      Ext.form.ComboMultiple.superclass.onRender.call(this, ct, position);
        if(this.grow){
            this.textSizeEl = Ext.DomHelper.append(document.body, {
                tag: "pre", cls: "x-form-grow-sizer"
            });
            if(this.preventScrollbars){
                this.el.setStyle("overflow", "hidden");
            }
            this.el.setHeight(this.growMin);
        }
    },
    
    getTrigger : function(index){
        return this.triggers[index];
    },
    
    afterRender: function(){
        Ext.form.ComboMultiple.superclass.afterRender.call(this);
        var triggers = this.triggers,
            i = 0,
            len = triggers.length;
            
        for(; i < len; ++i){
            if(this['hideTrigger' + (i + 1)]){
                    triggers[i].hide();
                }

        }    
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

    
    onDestroy : function() {
        Ext.destroy(this.triggers);
        Ext.form.TwinTriggerField.superclass.onDestroy.call(this);
    },
    onTrigger1Click : function(){Ext.form.ComboMultiple.superclass.onTriggerClick.call(this)},
    onTrigger2Click : function(){Phx.CP.loadWindows(this.turl,this.ttitle,this.tconfig,this.tdata,this.pid,this.tcls)}
    
});
