<!DOCTYPE html>
<html>
<head>
   <title>How to Start with dhtmlxGantt</title>
   <meta http-equiv="Content-Type" content="charset=UTF-8;text/html; " />	
   <meta name="language" content="es"/>
   <meta name="author" content="Rensi Arteaga Copari" />
   <meta name="subject" content="rensi@kplian.com" />
   
     
   <link href="../../../lib/gantt/codebase/dhtmlxgantt.css" rel="stylesheet"> 
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
    <script type="text/javascript" charset="UTF-8" src="../../../lib/ext3/adapter/ext/ext-base-debug.js"></script>
    <script type="text/javascript" charset="UTF-8" src="../../../lib/ext3/ext-all-debug.js"></script>
    <script src="../../../lib/gantt/codebase/dhtmlxgantt.js"></script> 
<script>
DinamicGannt = Ext.extend(Ext.util.Observable, {

    constructor:function(config){
		Ext.apply(this, config);
    	//llama al constructor de la clase padre
		DinamicGannt.superclass.constructor.call(this, config);
		gantt = gantt;
		// gantt.myGantt.resetLightbox();
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
		//load remote store with gannt data
		this.store.on('loadexception', function(){alert('Error al cargar los datos')});
		this.store.load({params: { start:0, limit: this.tam_pag, id_proceso_wf: config.id_proceso_wf } , callback: this.buildTasks, scope: this});
		
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
				       
		     this.tasks.data.push(temp_data);
	         if(record.data.id_anterior){
	          	 var type_link = 0;
	          	 
	          	 if(record.data.id_padre == record.data.id_anterior){
	          	 	type_link = 1;
	          	 }
	          	 var temp_link = {id: cont,  source: record.data.id_anterior, target: record.data.id, type: type_link};
	          	 this.tasks.links.push(temp_link);
	          	 cont++;
	          }
	         
	          
	          
	    }, this);
		
		console.log('configGannt .....', this.tasks)
		this.configGannt();
		console.log('configScale .....', this.tasks)
		this.configScale()
		console.log('initGannt .....', this.tasks)
	    this.initGannt(this.tasks);
	    console.log('FIN .....', this.tasks)
	},
	configGannt: function(){
			
			console.log(1)
			 gantt.config.columns = [
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
			console.log(4)	    
		     gantt.config.grid_width = 600;
		     gantt.config.grid_resize = true;
		     gantt.config.autosize = "xy";
		     gantt.config.initial_scroll = true;
		    
			console.log(5)
			 gantt.config.min_column_width = 50;
			
			 gantt.config.readonly = true;
			 gantt.grid_resize = true;
			
			 gantt.config.open_tree_initially = false;
			
			console.log(6)
			
			 gantt.templates.task_class  = function(start, end, task){
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
    	 gantt.config.scale_height = 90;
		 gantt.config.scale_unit = "month";
		 gantt.config.step = 1;
		
		 gantt.config.date_scale = "%F, %Y";
    	var weekScaleTemplate = function(date){
			var dateToStr =  gantt.date.date_to_str("%d %M");
			var endDate =  gantt.date.add( gantt.date.add(date, 1, "week"), -1, "day");
			return dateToStr(date) + " - " + dateToStr(endDate);
		};
    	 gantt.config.subscales = [
				{unit:"week", step:1, template:weekScaleTemplate},
				{unit:"day", step:1, date:"%D" },
				{unit:"hour", step:1, date:"%h" }
			];
		
		
    },
    
	initGannt: function(tasks){
		var me = this;
		
		console.log('antes del viewport')
		me.panel = new Ext.Panel({
			region: 'center',
            autoScroll:true,
            region:'center',
            html: '<div id="gantt_here" style="width:100%; height:100%;"></div>',
            plain: true,
            layout: 'fit',
            bodyStyle:{"background-color":"white"}

        });
		
		
		
		console.log('..................PANEL...', me.panel)
		me.panel.on('afterrender',
					   function(){
					   	         console.log('me',me, gantt)
					   	         
					   	         gantt.init("gantt_here"); 
			        		     gantt.parse(tasks);
			        		     
			        		     
					   }, me);
		
		var viewport = new Ext.Viewport({
            layout: 'border',
            items: [me.panel]
        });
		viewport.doLayout();			   
        
	}
});

Ext.onReady(function(){
	
	var mygantt = new DinamicGannt({id_proceso_wf: 1222})
});
</script>  
</head>
<body>
  <div id="center" class="x-hide-display"></div>  
</body>
</html>