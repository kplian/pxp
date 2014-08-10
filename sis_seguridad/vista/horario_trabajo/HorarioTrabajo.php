<?php
/**
*@package pXP
*@file HorarioTrabajo.php
*@author KPLIAN (JRR)
*@date 14-02-2011
*@description  Vista para registrar los horarios laborales
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.horario_trabajo=Ext.extend(Phx.gridInterfaz,{



	Atributos:[
	{
		// configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_horario_trabajo'

		},
		type:'Field',
		form:true 
		
	},
	 {config:{
	       			name:'dia_semana',
	       			fieldLabel:'Dia de la Semana',
	       			allowBlank:false,
	       			emptyText:'Dia de la Semana...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    
	       		   	store: new Ext.data.ArrayStore({
        					id: 0,
        					fields: ['ID',
            						'text'
        					],
        				data: [['1','Domingo'],['2','Lunes'],['3','Martes'],['4','Miercoles'],['5','Jueves'],['6','Viernes'],['7','Sabado']]
        				
    				}),

	       		    valueField: 'ID',
	       		   	displayField: 'text', 	
	       		  
	       		    renderer:function (value, p, record){
	       		    	if(value==1){
	       		    		return 'Domingo';
	       		    	}
	       		    	else{
	       		    		if(value==2)
	       		    			return String.format('{0}', 'Lunes');
	       		    		else{
	       		    			if(value==3)
	       		    			return String.format('{0}', 'Martes');
	       		    			else{
	       		    				if(value==4)
	       		    				return String.format('{0}', 'Miercoles');
	       		    				else{
	       		    					if(value==5)
	       		    					return String.format('{0}', 'Jueves');
	       		    					else{
	       		    						if(value==6)
	       		    						return String.format('{0}', 'Viernes');
	       		    						else
	       		    						return String.format('{0}', 'Sabado');
	       		    					}
	       		    				}
	       		    			}
	       		    		}
	       			
	       		    	}
	       		    },
	       		     
	       		    
	       		},
	       		       		
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 dataIndex: 'size',
	       				 options: ['1','2','3','4','5','6','7'],	
	       		 	},
	       		grid:true,
	       		form:true
	},
	 {
		config:{
				name:'hora_ini',
	       			fieldLabel:'Hora Inicio',
	       			allowBlank:false,
	       			emptyText:'Hora Inicio...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    
	       		    valueField: 'hora_ini',
	       		   format:'H:i:s'
	       		    
	       		},// format:"g:i A",altFormats:"g:ia|g:iA|g:i a|g:i
					// A|h:i|g:i|H:i|ga|ha|gA|h a|g a|g A|gi|hi|gia|hia|g|H|gi
					// a|hi a|giA|hiA|gi A|hi
					// A",increment:15,mode:"local",triggerAction:"all",typeAhead:false,initDate:"1/1/2008",initDateFormat:"j/n/Y",initComponent:function(){if(Ext.isDefined(this.minValue)){this.setMinValue(this.minValue,true)}if(Ext.isDefined(this.maxValue)){this.setMaxValue(this.maxValue,true)}if(!this.store){this.generateStore(true)}Ext.form.TimeField.superclass.initComponent.call(this)},setMinValue:function(b,a){this.setLimit(b,true,a);return
					// this},setMaxValue:function(b,a){this.setLimit(b,false,a);return
					// this},generateStore:function(b){var c=this.minValue||new
					// Date(this.initDate).clearTime(),a=this.maxValue||new
					// Date(this.initDate).clearTime().add("mi",(24*60)-1),d=[];while(c<=a){d.push(c.dateFormat(this.format));c=c.add("mi",this.increment)}this.bindStore(d,b)},setLimit:function(b,g,a){var
					// e;if(Ext.isString(b)){e=this.parseDate(b)}else{if(Ext.isDate(b)){e=b}}if(e){var
					// c=new
					// Date(this.initDate).clearTime();c.setHours(e.getHours(),e.getMinutes(),e.getSeconds(),e.getMilliseconds());this[g?"minValue":"maxValue"]=c;if(!a){this.generateStore()}}},getValue:function(){var
					// a=Ext.form.TimeField.superclass.getValue.call(this);return
					// this.formatDate(this.parseDate(a))||""},setValue:function(a){return
					// Ext.form.TimeField.superclass.setValue.call(this,this.formatDate(this.parseDate(a)))},validateValue:Ext.form.DateField.prototype.validateValue,formatDate:Ext.form.DateField.prototype.formatDate,parseDate:function(h){if(!h||Ext.isDate(h)){return
					// h}var k=this.initDate+" ",g=this.initDateFormat+"
					// ",b=Date.parseDate(k+h,g+this.format),c=this.altFormats;if(!b&&c){if(!this.altFormatsArray){this.altFormatsArray=c.split("|")}for(var
					// e=0,d=this.altFormatsArray,a=d.length;e<a&&!b;e++){b=Date.parseDate(k+h,g+d[e])}}return
					// b}});Ext.reg("timefield",Ext.form.TimeField);Ext.form.SliderField=Ext.extend(Ext.form.Field,{useTips:true,tipText:null,actionMode:"wrap",initComponent:function(){var
					// b=Ext.copyTo({id:this.id+"-slider"},this.initialConfig,["vertical","minValue","maxValue","decimalPrecision","keyIncrement","increment","clickToChange","animate"]);if(this.useTips){var
					// a=this.tipText?{getText:this.tipText}:{};b.plugins=[new
					// Ext.slider.Tip(a)]}this.slider=new
					// Ext.Slider(b);Ext.form.SliderField.superclass.initComponent.call(this)},onRender:function(b,a){this.autoCreate={id:this.id,name:this.name,type:"hidden",tag:"input"};Ext.form.SliderField.superclass.onRender.call(this,b,a);this.wrap=this.el.wrap({cls:"x-form-field-wrap"});this.resizeEl=this.positionEl=this.wrap;this.slider.render(this.wrap)},onResize:function(b,c,d,a){Ext.form.SliderField.superclass.onResize.call
	       		type:'TimeField',
	       		id_grupo:0,
	       		
	       		grid:true,
	       		form:true
	},{
		config:{
				name:'hora_fin',
	       			fieldLabel:'Hora Fin',
	       			allowBlank:false,
	       			emptyText:'Hora Fin...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    
	       		    valueField: 'hora_fin',
	       		   format:'H:i:s'
	       		    
	       		},// format:"g:i A",altFormats:"g:ia|g:iA|g:i a|g:i
					// A|h:i|g:i|H:i|ga|ha|gA|h a|g a|g A|gi|hi|gia|hia|g|H|gi
					// a|hi a|giA|hiA|gi A|hi
					// A",increment:15,mode:"local",triggerAction:"all",typeAhead:false,initDate:"1/1/2008",initDateFormat:"j/n/Y",initComponent:function(){if(Ext.isDefined(this.minValue)){this.setMinValue(this.minValue,true)}if(Ext.isDefined(this.maxValue)){this.setMaxValue(this.maxValue,true)}if(!this.store){this.generateStore(true)}Ext.form.TimeField.superclass.initComponent.call(this)},setMinValue:function(b,a){this.setLimit(b,true,a);return
					// this},setMaxValue:function(b,a){this.setLimit(b,false,a);return
					// this},generateStore:function(b){var c=this.minValue||new
					// Date(this.initDate).clearTime(),a=this.maxValue||new
					// Date(this.initDate).clearTime().add("mi",(24*60)-1),d=[];while(c<=a){d.push(c.dateFormat(this.format));c=c.add("mi",this.increment)}this.bindStore(d,b)},setLimit:function(b,g,a){var
					// e;if(Ext.isString(b)){e=this.parseDate(b)}else{if(Ext.isDate(b)){e=b}}if(e){var
					// c=new
					// Date(this.initDate).clearTime();c.setHours(e.getHours(),e.getMinutes(),e.getSeconds(),e.getMilliseconds());this[g?"minValue":"maxValue"]=c;if(!a){this.generateStore()}}},getValue:function(){var
					// a=Ext.form.TimeField.superclass.getValue.call(this);return
					// this.formatDate(this.parseDate(a))||""},setValue:function(a){return
					// Ext.form.TimeField.superclass.setValue.call(this,this.formatDate(this.parseDate(a)))},validateValue:Ext.form.DateField.prototype.validateValue,formatDate:Ext.form.DateField.prototype.formatDate,parseDate:function(h){if(!h||Ext.isDate(h)){return
					// h}var k=this.initDate+" ",g=this.initDateFormat+"
					// ",b=Date.parseDate(k+h,g+this.format),c=this.altFormats;if(!b&&c){if(!this.altFormatsArray){this.altFormatsArray=c.split("|")}for(var
					// e=0,d=this.altFormatsArray,a=d.length;e<a&&!b;e++){b=Date.parseDate(k+h,g+d[e])}}return
					// b}});Ext.reg("timefield",Ext.form.TimeField);Ext.form.SliderField=Ext.extend(Ext.form.Field,{useTips:true,tipText:null,actionMode:"wrap",initComponent:function(){var
					// b=Ext.copyTo({id:this.id+"-slider"},this.initialConfig,["vertical","minValue","maxValue","decimalPrecision","keyIncrement","increment","clickToChange","animate"]);if(this.useTips){var
					// a=this.tipText?{getText:this.tipText}:{};b.plugins=[new
					// Ext.slider.Tip(a)]}this.slider=new
					// Ext.Slider(b);Ext.form.SliderField.superclass.initComponent.call(this)},onRender:function(b,a){this.autoCreate={id:this.id,name:this.name,type:"hidden",tag:"input"};Ext.form.SliderField.superclass.onRender.call(this,b,a);this.wrap=this.el.wrap({cls:"x-form-field-wrap"});this.resizeEl=this.positionEl=this.wrap;this.slider.render(this.wrap)},onResize:function(b,c,d,a){Ext.form.SliderField.superclass.onResize.call
	       		type:'TimeField',
	       		id_grupo:0,
	       		
	       		grid:true,
	       		form:true
	},{
		// configuraci�n del componente
		config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'num_dia'

		},
		type:'Field',
		form:true 
		
	}
	],



	title:'horario_trabajo',
	ActSave:'../../sis_seguridad/control/HorarioTrabajo/GuardarHorarioTrabajo',
	ActDel:'../../sis_seguridad/control/HorarioTrabajo/EliminarHorarioTrabajo',
	ActList:'../../sis_seguridad/control/HorarioTrabajo/ListarHorarioTrabajo',
	id_store:'id_horario_trabajo',
	fields: [
	{name:'id_horario_trabajo'},
	{name:'dia_semana'},
	{name:'dia_literal', type: 'string'},
	{name:'hora_ini', mapping: 'hora_ini', type: 'otro', dateFormat: 'g:i'},
	{name:'hora_fin', mapping: 'hora_fin', type: 'otro', dateFormat: 'g:i'},
	{name:'num_dia'}
	/*
	 * {name:'operacion', type: 'string'} ,'cantidad_intentos',
	 * 'periodo_intentos', 'tiempo_bloqueo', 'email'
	 */
	],
	sortInfo:{
		field: 'dia_semana',
		direction: 'ASC'
	},
	onButtonNew:function(){
	    
		Phx.vista.horario_trabajo.superclass.onButtonNew.call(this);
		
		
	},
	onButtonEdit:function(){
	    var sel=this.sm.getSelected().data;
	    var cant_filas=this.sm.getSelections();
	    if(cant_filas!=0){
	    	
	    	Phx.vista.horario_trabajo.superclass.onButtonEdit.call(this);
	    	var txt_num_dia=this.getComponente('num_dia');
	    	txt_num_dia.setValue(sel.dia_semana);
	    }else{
	    	alert('Antes debe seleccionar un item');
	    }
		//
		
		
	},
	/*
	 * onReloadPage:function(m){ this.maestro=m;
	 * //this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);
	 * this.store.baseParams={}; this.load({params:{start:0, limit:50}}) },
	 */
	constructor: function(config){
		

		Phx.vista.horario_trabajo.superclass.constructor.call(this,config);


		this.init();
		
		var txt_dia_semana=this.getComponente('dia_semana');	
		var txt_num_dia=this.getComponente('num_dia');
		txt_num_dia.setValue(txt_dia_semana.getValue());
		
		this.load({params:{start:0, limit:50, id_funcion: this.id_funcion}})
		
		
		txt_dia_semana.on('select',onPersona);
		
		
		function onPersona(c,r,e){
			txt_dia_semana.setValue(r.data.ID);
			txt_num_dia.setRawValue(r.data.ID);
		}
		
		
	},
	
	bdel:true,// boton para eliminar
	bsave:false,// boton para eliminar


	// sobre carga de horario_trabajo
	preparaMenu:function(tb){
		// llamada horario_trabajo clace padre
		Phx.vista.horario_trabajo.superclass.preparaMenu.call(this,tb)
	}

	/*
	 * Grupos:[{
	 * 
	 * xtype:'fieldset', border: false, //title: 'Checkbox Groups', autoHeight:
	 * true, layout: 'form', items:[], id_grupo:0 }],
	 */


  }
)
</script>