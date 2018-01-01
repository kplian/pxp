/**
*@package pXP
*@file Usuario.php
*@author KPLIAN (RAC)
*@date 30-06-2011
*@description Componente extendido del combo para mas un trigguer adiconal para llamadas a una interfaz
*/
Ext.form.TrigguerCombo = Ext.extend(Ext.form.ComboBox, {
	
	trigger1Class: 'x-form-clear-trigger',
	trigger2Class:'x-form-arrow-trigger',
    trigger3Class:'x-form-search-trigger',
    
    turl:'',
    tasignacion:false,//si la signacion es verdadera la ventana destno habilita un boton para asignar su resultado
    ttitle:'Ventana',
    tconfig:{width:900,height:400},
    tdata:{},
    tcls:'tcls',
    pid:'',
    tinit:true,//inicia trigguer adicional
   
	
	 initComponent : function(){
        Ext.form.TrigguerCombo.superclass.initComponent.call(this);
        this.triggerConfig = {tag:'span', cls:'x-form-twin-triggers', cn:[]};
        this.triggerConfig.cn.push({tag: 'img',src: Ext.BLANK_IMAGE_URL,alt: '',cls: 'x-form-trigger ' + this.trigger1Class});
		this.triggerConfig.cn.push({tag: "img", src: Ext.BLANK_IMAGE_URL, alt: "", cls: "x-form-trigger " + this.trigger2Class});	
		if(this.tinit){
	   	   this.triggerConfig.cn.push({tag: "img", src: Ext.BLANK_IMAGE_URL, alt: "", cls: "x-form-trigger " + this.trigger3Class});	
		}
	   	
	   this.addEvents(
		/**
		 * @event clear
		 * RAC 01112011
		 * se dipsra al limpiar los datos del combo
		 * @param {Ext.ux.AwesomeCombo} combo This combo box
		 */
		'clearcmb');
		
    },
    
    getTrigger : function(index){
        return this.triggers[index];
    },
    
    afterRender: function(){
        Ext.form.TrigguerCombo.superclass.afterRender.call(this);
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
    /*
     rac 22022012
     setea valor apartir de un record
     * */
    setValueRec:function(data){
    	var _id= this.valueField;
		var _id_name=this.name;
		var _df= this.displayField;
		if(this.tname){
			_id_name= this.tname;
		}
		if(this.tdisplayField){
		 _df= this.tdisplayField;
		}
		//nombre del atributo del combo que recibe el valor
		var _dis= this.displayField;
		if(!this.store.getById(data[_id_name])){
			var recTem= new Array();
			recTem[_id]= data[_id_name];
			recTem[_dis]=data[_df];
			this.store.add(new Ext.data.Record(recTem,data[_id_name]));
			this.store.commitChanges();
        }
        this.setValue(data[_id_name])
		//Disparo de evento para ser más fácilmente manipulable en las interfaxces
		
		this.fireEvent('select',this,{data: data});
		
    },
    onDestroy : function() {
        Ext.destroy(this.triggers);
        Ext.form.TwinTriggerField.superclass.onDestroy.call(this);
    },
    onTrigger2Click : function(){Ext.form.TrigguerCombo.superclass.onTriggerClick.call(this)},
    onTrigger3Click : function(){
    	
    	//manda el combo como parametro para que desde la vista destino 
    	//asignar un valor directamente
    	if(this.tasignacion)
    	{
    	  Ext.apply(this.tdata, { comboTriguer: this} );
    	} 
    	   	
    	Phx.CP.loadWindows(this.turl,this.ttitle,this.tconfig,this.tdata,this.pid,this.tcls);
    },
    // private
	onTrigger1Click: function() {
		if (this.readOnly || this.disabled) {
			return;
		}
		this.reset();
		this.validate();
		//RAC 01/11/11
		//aumenta el evento para cuando se limpia el contenido
		this.fireEvent('clearcmb', this);
		
		
	},
    
});
