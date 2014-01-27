<?php
/**
*@package pXP
*@file MonitorSistema.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar eventos del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.monitor_sistema=function(config){
	this.renderColor=function(value,p,record){
    		
    		if(record.data.tipo_log=='ERROR_WEB' || record.data.tipo_log=='INYECCION' ||record.data.tipo_log=='SESION'
    			|| record.data.tipo_log=='ERROR_TRANSACCION' || record.data.tipo_log=='ERROR_PERMISOS' || record.data.tipo_log=='ERROR_ACCESO'||
    			record.data.tipo_log=='ERROR_BD'){
    			return '<FONT COLOR="red"> '+value+' </FONT>';
    		}
    		else if(record.data.tipo_log=='ERROR_CONTROLADO_PHP' || record.data.tipo_log=='ERROR_CONTROLADO_BD'|| record.data.tipo_log=='ERROR_BLOQUEO'){
    			return '<FONT COLOR="orange"> '+value+' </FONT>';
    		}
    		else{
    			return value
    		}
    	}
	
	this.Atributos=[
	{
		//configuracion del componente
		config:{
			fieldLabel:'Identificador',
			gwidth: 100,
			name: 'identificador',
			renderer:{
					    fn:this.renderColor,
					    scope:this
					}

		},
		type:'TextField',
		form:true,
		filters:{	pfiltro:'logg.id_log',
					type:'numeric'},
		grid:true 
		
	},
	{
		config:{
			fieldLabel: "PID WEB",
			gwidth: 90,
			name: 'pidweb',
			renderer:{
					    fn:this.renderColor,
					    scope:this
					}
			
		},
		type:'TextField',
		filters:{	pfiltro:'logg.pid_web',
					type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "PID BD",
			gwidth: 90,
			name: 'piddb',
			renderer:{
					    fn:this.renderColor,
					    scope:this
					}			
		},
		type:'TextField',
		filters:{	pfiltro:'logg.pid_db',
					type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Tipo",
			gwidth: 110,
			name: 'tipo_log',
			renderer:{
					    fn:this.renderColor,
					    scope:this
					}
			
		},
		type:'TextField',
		filters:{ type: 'list',
	       		  dataIndex: 'tipo_log',
	       		  options: ['ERROR_WEB','ERROR_CONTROLADO_PHP','INYECCION',
	       		  			'SESION','ERROR_TRANSACCION_BD','ERROR_CONTROLADO_BD',
	       		  			'ERROR_PERMISOS','ERROR_BLOQUEO','ERROR_ACCESO','LOG_TRANSACCION',
	       		  			'LOG_REPORTE','LOG_BD','ERROR_BD']
					},
		grid:true,
		form:false
	},	
	 {
		config:{
			fieldLabel: "Usuario",
			gwidth: 100,
			name: 'cuenta_usuario',
			renderer:{
					    fn:this.renderColor,
					    scope:this
					}
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	
	{
		config:{
			fieldLabel: "Usuario BD",
			gwidth: 100,
			name: 'usuario_base',
			renderer:{
					    fn:this.renderColor,
					    scope:this
					}
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "IP",
			gwidth: 100,
			name: 'ip_maquina',
			renderer:{
					    fn:this.renderColor,
					    scope:this
					}
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	
	{
		config:{
			fieldLabel: "Fecha/Hora",
			gwidth: 130,
			renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
   		    name: 'fecha_reg'
			
		},
		type:'DateField',
		filters:{pfiltro:'logg.fecha_reg',
				type:'date'
				},
		grid:true,
		form:false
	},
	
	
	{
		config:{
			fieldLabel: "Sistema",
			gwidth: 110,
			name: 'codigo_subsistema'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Transaccion",
			gwidth: 110,
			name: 'transaccion'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Mensaje",
			gwidth: 120,
			name: 'descripcion'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Descripción Transacción",
			gwidth: 120,
			name: 'descripcion_transaccion'
			
		},
		type:'TextField',
		filters:{pfiltro:'proce.descripcion',
				type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Consulta",
			gwidth: 250,
			name: 'consulta'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Tiempo Ejec.(ms)",
			gwidth: 80,
			name: 'tiempo_ejecucion'
			
		},
		type:'TextField',
		filters:{type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Procedimientos",
			gwidth: 150,
			name: 'procedimientos'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	
	{
		config:{
			fieldLabel: "Codigo Error",
			gwidth: 100,
			name: 'codigo_error'
			
		},
		type:'TextField',
		filters:{type:'string'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "SID BD-WEB",
			gwidth: 110,
			name: 'sidweb'
			
		},
		type:'TextField',
		filters:{	pfiltro:'logg.sid_web',
					type:'string'},
		grid:true,
		form:false
	}
	
	];

	Phx.vista.monitor_sistema.superclass.constructor.call(this,config);
	this.init();
	
	
	this.combo_segundos = new Ext.form.ComboBox({
	        store:['detener','5','8','10','15','30','45','60'],
	        typeAhead: true,
	        mode: 'local',
	        triggerAction: 'all',
	        emptyText:'Periodo...',
	        selectOnFocus:true,
	        width:135
	    });
	    
	    
    	this.grid.getTopToolbar().addField(this.combo_segundos);
    	this.grid.getTopToolbar().doLayout();
    	this.combo_segundos.on('select',evento_combo,this);
    	this.combo_segundos.setValue('5');
    	
 		this.timer_id=Ext.TaskMgr.start({
		    run: Ftimer,
		    interval:parseInt(this.combo_segundos.getValue())*1000,
		    scope:this
		});

    	this.load({params:{start:0, limit:50}});
    	
    	function evento_combo(){
    		Ext.TaskMgr.stop(this.timer_id);
    		if(this.combo_segundos.getValue()!='detener'){
	    		this.timer_id=Ext.TaskMgr.start({
			    	run: Ftimer,
			    	interval:parseInt(this.combo_segundos.getValue())*1000,
			    	scope:this
				});
    		}  		
    	}
    	function Ftimer(){
    		this.reload();
    	}
    	
	
}
Ext.extend(Phx.vista.monitor_sistema,Phx.gridInterfaz,{
	
	title:'Log',
	ActList:'../../sis_seguridad/control/Log/listarLogMonitor',
	id_store:'identificador',
	fields: [
	{name:'identificador'},
	{name:'id_usuario'},
	{name:'cuenta_usuario', type: 'string'},
	{name:'mac_maquina', type: 'string'},
	{name:'ip_maquina', type: 'string'},
	{name:'tipo_log', type: 'string'},
	{name:'fecha_reg', type:'date',dateFormat: 'Y-m-d H:i:s'},
	{name:'procedimientos', type: 'string'},
	{name:'transaccion', type: 'string'},
	{name:'descripcion', type: 'string'},
	{name:'consulta', type: 'string'},
	{name:'usuario_base', type: 'string'},
	{name:'tiempo_ejecucion'},
	{name:'pidweb'},
	{name:'piddb'},
	{name:'sidweb', type: 'string'},
	{name:'codigo_error', type: 'string'},
	{name:'descripcion_transaccion', type: 'string'},
	{name:'codigo_subsistema', type: 'string'}
	],
	sortInfo:{
		field: 'logg.fecha_reg',
		direction: 'DESC'
	},
	bdel:false,//boton para eliminar
	bsave:false,//boton para eliminar
	bnew:false,//boton para eliminar
	bedit:false,//boton para eliminar


	onDestroy:function(){
		Ext.TaskMgr.stop(this.timer_id);
		Phx.vista.monitor_sistema.superclass.onDestroy.call(this);
	},
	onHide:function(){
		Ext.TaskMgr.stop(this.timer_id);
		Phx.vista.monitor_sistema.superclass.onHide.call(this);
	},
	onShow:function(){
		if(this.combo_segundos.getValue()!='detener'){
	    		this.timer_id=Ext.TaskMgr.start({
			    	run:this.reload,
			    	interval:parseInt(this.combo_segundos.getValue())*1000,
			    	scope:this
				});
    	}
		Phx.vista.monitor_sistema.superclass.onShow.call(this);
	}
	
}
)
</script>