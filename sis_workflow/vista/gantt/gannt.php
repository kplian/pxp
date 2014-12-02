<?php
/**
*@package pXP
*@file gen-Obs.php
*@author  (admin)
*@date 20-11-2014 18:53:55
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<style type="text/css" media="screen">
		    html, body{
		        margin:0px;
		        padding:0px;
		        height:100%;
		        overflow:hidden;
		    }  
		    
		    
		    html, body{ height:100%; padding:0px; margin:0px; overflow: hidden;}

    .proceso{
        border:2px solid #5858FA;
        color: #5858FA;
        background: #5858FA;
    }
    .procesos .gantt_task_progress{
        background: #db2536;
    }

    .estado{
        border:2px solid #34c461;
        color:#34c461;
        background: #34c461;
    }
    .estado .gantt_task_progress{
        background: #23964d;
    }

    .obs{
        border:2px solid #FE2E2E;
        color:#FE2E2E;
        background: #FE2E2E;
    }
    .obs .gantt_task_progress{
        background: #FE2E2E;
    } 
    
    .estado_final{
        border:2px solid #FACC2E;
        color:#FACC2E;
        background: #FACC2E;
    }
    .estado_final .gantt_task_progress{
        background: #FACC2E;
    } 
    </style>
<script>
Phx.vista.DinamicGannt = Ext.extend(Ext.util.Observable, {

    constructor:function(config){
		Ext.apply(this, config);
    	//llama al constructor de la clase padre
		Phx.vista.DinamicGannt.superclass.constructor.call(this, config);
		this.objGantt = gantt;
		// this.objGantt.myGantt.resetLightbox();
		this.store = new Ext.data.JsonStore({
			url: '../../sis_workflow/control/ProcesoWf/listarGantWf',
			id: 'id',
			root: 'datos',
			fields:[
				{name:'id', type: 'numeric'},
				{name:'id_proceso_wf', type: 'numeric'},
				{name:'id_estado_wf', type: 'numeric'},
				{name:'tipo', type: 'string'},
				{name:'nombre', type: 'string'},
				{name:'fecha_ini', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
				{name:'fecha_fin', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
				{name:'descripcion', type: 'string'},
				{name:'tramite', type: 'string'},
				{name:'codigo', type: 'string'},
				{name:'id_funcionario', type: 'numeric'},
				{name:'funcionario', type: 'numeric'},
				{name:'id_usuario', type: 'numeric'},
				{name:'cuenta', type: 'string'},
				{name:'id_depto', type: 'numeric'},
				{name:'depto', type: 'string'},
				'nombre_usuario_ai',
				'arbol',
				'id_padre',
				'id_obs','id_siguiente','id_anterior'
			],
		});
		
		this.store.on('loadexception', Phx.CP.conexionFailure);
		this.store.load({params: { start:0, limit: this.tam_pag, id_proceso_wf: config.id_proceso_wf } , callback: this.buildTasks, scope: this});
		
		//todo load remote store with gannt data
		/*
		var tasks = {
				    data:[
				        {id: 1, users: 'xxxx', text: "Project xxxxxxxxxx xxxxxxxxxx xxxxxxxxx #1",   start_date: "01-04-2013", duration:11,progress: 0.6, open: true},
				        {id: 2, users: 'xxxx yyy  yyyy', text: "Task #1",   start_date: "03-04-2013", duration: 5, progress: 1,   open: true, parent:1},
				        {id: 3, users: 'xxxx  zzzz  zz', text: "Task #2",   start_date: "02-07-2013",  duration: 7, progress: 0.5, open: true, parent:1},
				        {id: 4, users: 'xxxx zzz  zzzz', text: "Task #2.1", start_date: "03-09-2013",  duration: 2, progress: 1,   open: true, parent:3},
				        {id: 5, users: 'xxxx', text: "Task #2.2", start_date: "04-04-2013", duration: 3, progress: 0.8, open: true, parent:3},
				        {id: 6, users: 'xxxx', text: "Task #2.3", start_date: "05-04-2013", duration: 4, progress: 0.2, open: true, parent:3}
				    ],
				    links:[
				        {id:1, source:1, target:2, type:"1"},
				        {id:2, source:1, target:3, type:"1"},
				        {id:3, source:3, target:4, type:"1"},
				        {id:4, source:4, target:5, type:"0"},
				        {id:5, source:5, target:6, type:"0"}
				    ]
				};*/
		   
	       
		
		
	},
	
	clone: function(obj) {
	    if (null == obj || "object" != typeof obj) return obj;
	    var copy = obj.constructor();
	    for (var attr in obj) {
	        if (obj.hasOwnProperty(attr)) copy[attr] = obj[attr];
	    }
	    return copy;
   },
	
	buildTasks: function(){
		//build task array
		this.tasks = {
				    data:[],
				    links:[]
				};
		var cont = 1;
		this.store.each(function(record){
			console.log('record....',record)
			var descripcion = record.data.descripcion;
			
			if (record.data.tipo == 'estado' ){
				descripcion = record.data.nombre + '('+ record.data.cuenta +')';
			}
			
			if (record.data.tipo == 'obs'){
				descripcion = 'OBS: '+record.data.nombre + '('+ record.data.cuenta +')';
			}
			var no_end = false;
			if(record.data.tipo == 'estado_final'){
				no_end = true;
			}
			
			var temp_data = {
				              id: record.data.id, 
				              users: record.data.funcionario, 
				              text: descripcion,   
				              start_date: record.data.fecha_ini, 
				              end_date: record.data.fecha_fin,
				              parent: (record.data.id_padre >0)?record.data.id_padre:undefined,
				              tipo: record.data.tipo,
				              rendered_type: (record.data.tipo=='proceso')?'project':'task',
				              no_end: no_end,
				              //duration:11, 
				              open: true
				          };
				       
		      console.log('temp_data', temp_data)
	          this.tasks.data.push(temp_data);
	          console.log('SIGUEINTE', record.data.id_siguiente)
	         
             if(record.data.id_anterior){
	          	 var type_link = 0;
	          	 console.log('LINK...',record.data.id_padre,  record.data.id_anterior,  record.data.id  )
	          	 
	          	 if(record.data.id_padre == record.data.id_anterior){
	          	 	type_link = 1;
	          	 }
	          	 var temp_link = {id: cont,  source: record.data.id_anterior, target: record.data.id, type: type_link};
	          	 this.tasks.links.push(temp_link);
	          	 cont++;
	          }
	         
	          
	          
	    }, this);
		
		console.log('TEAREAS .....', this.tasks)
		this.configGannt();
		this.configScale()
	    this.initGannt(this.tasks);
	},
	configGannt: function(){
			
			console.log('OBJETO GANTT ...', this.objGantt)
			 this.objGantt.config.columns = [
				        {name:"text", label:"Task name", tree:true, width:"400", resize:true },
				        
				        {name:"assigned", label:"Responsable", align: "center", resize: true,  width:'300',
				            template: function(item) {
				            	console.log('item ......  ',item)
				            	
				                if (!item.users) return "Nobody";
				                return item.users
				            }
				       },
				       {name:"duration", label:"Duracion", resize:true,  width:'40' },
				       {name:"start_date", label:"Inicio", resize:true,  width:'100' },
				    ];
				    
		     this.objGantt.config.grid_width = 600;
		     this.objGantt.config.grid_resize = true;
		     this.objGantt.config.autosize = "xy";
		     this.objGantt.config.initial_scroll = true;
		    
			
			 this.objGantt.config.min_column_width = 50;
			
			 this.objGantt.config.readonly = true;
			 this.objGantt.grid_resize = true;
			
			 this.objGantt.config.open_tree_initially = false;
			
			
			
			 this.objGantt.templates.task_class  = function(start, end, task){
			   console.log('clase estilo..', task)
			   switch (task.tipo){
				case "estado":
					return "estado";
					break;
				case "proceso":
					return "proceso";
					break;
				case "obs":
					return "obs";
					break;
			   }
		    };
		    
		
			
		
    },
    configScale:function(){
    	 var me = this;
    	 me.objGantt.config.scale_height = 90;
		 me.objGantt.config.scale_unit = "month";
		 me.objGantt.config.step = 1;
		
		 me.objGantt.config.date_scale = "%F, %Y";
    	var weekScaleTemplate = function(date){
			var dateToStr =  me.objGantt.date.date_to_str("%d %M");
			var endDate =  me.objGantt.date.add( me.objGantt.date.add(date, 1, "week"), -1, "day");
			return dateToStr(date) + " - " + dateToStr(endDate);
		};
    	 me.objGantt.config.subscales = [
				{unit:"week", step:1, template:weekScaleTemplate},
				{unit:"day", step:1, date:"%D" }
			];
		
		
    },
    
	initGannt: function(tasks){
		var me = this;
		me.panel = Ext.getCmp(me.idContenedor);
		
		console.log('PANEL .....',  me.panel)
		
		me.BorderLayout = new Ext.Container({
            split: true,
            flex:1,
            autoScroll:true,
            region:'center',
            html: '<div id="gantt_here" style="width:100%; height:100%;"></div>',
            plain: true,
            layout: 'fit',
             bodyStyle:{"background-color":"white"},

        });
		console.log('ANTES DE INICIAR......')
		
	    me.BorderLayout.on('afterrender',
					   function(){
					   	         console.log('me',me, me.objGantt)
					   	         
					   	         me.objGantt.init("gantt_here"); 
			        		     me.objGantt.parse(tasks);
			        		     
			        		     
					   }, me);
					   
        me.panel.add(me.BorderLayout);
        
		me.panel.doLayout();
	}
});
</script>
		
		