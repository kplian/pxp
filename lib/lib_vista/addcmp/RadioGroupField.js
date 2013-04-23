/**
*@package pXP
*@file Usuario.php
*@author KPLIAN (RAC)
*@date 30-06-2011
*@description Componente extendido del combo para mas un trigguer adiconal para llamadas a una interfaz
*/
Ext.form.RadioGroupField =function(config){
	Ext.apply(this,config);
     Ext.form.RadioGroupField.superclass.constructor.call(this,config);  
  };

Ext.form.RadioGroupField = Ext.extend(Ext.form.RadioGroupField,Ext.form.RadioGroup,{
	setValue:function(val){
		var out = null;
        this.eachItem(function(item){
            if(item.inputValue==val){
                out=item;
                return false;
            }
        });
        if(out){
        	
        	out.setValue(true);
        }
	},
	 getValue : function(){
        var out = null;
        this.eachItem(function(item){
            if(item.checked){
                out=item;
                return false;
            }
        });
       return out.inputValue;
    }
	
})
