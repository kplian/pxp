<?php
/**
*@package pXP
*@file MonitorRecursos.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para mostrar los recursos de sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

Phx.vista.monitor_recursos=function(config){
	
	
	this.Atributos=[
	{
		//configuracion del componente
		config:{
			fieldLabel:'Usuario BD',
			gwidth: 100,
			name: 'usuario_bd'

		},
		type:'TextField',
		form:false,
		filters:{type:'string'},
		grid:true 
		
	},
	{
		//configuracion del componente
		config:{
			fieldLabel:'Transacción',
			gwidth: 100,
			name: 'transaccion_actual'

		},
		type:'TextField',
		form:false,
		filters:{type:'string'},
		grid:true 
		
	},
	{
		//configuracion del componente
		config:{
			fieldLabel:'Procedimiento',
			gwidth: 100,
			name: 'funcion_actual'

		},
		type:'TextField',
		form:false,
		filters:{type:'string'},
		grid:true 
		
	},
	{
		//configuracion del componente
		config:{
			fieldLabel:'Consulta',
			gwidth: 200,
			name: 'consulta'

		},
		type:'TextField',
		form:false,
		filters:{type:'string'},
		grid:true 
		
	},
	{
		//configuracion del componente
		config:{
			fieldLabel:'Hora Ini. Proc.',
			gwidth: 100,
			name: 'hora_inicio_proceso'

		},
		type:'TextField',
		form:false,
		grid:true 
		
	},
	{
		config:{
			fieldLabel: "PID BD",
			gwidth: 90,
			name: 'pid_bd',
					
		},
		type:'NumberField',
		filters:{	pfiltro:'logg.pid_db',
					type:'numeric'},
		grid:true,
		form:true
	},
	{
		config:{
			fieldLabel: "PID WEB",
			gwidth: 90,
			name: 'pid_web',
					
		},
		type:'NumberField',
		filters:{	pfiltro:'logg.pid_web',
					type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "% CPU BD",
			gwidth: 90,
			name: 'pcpu_bd',
					
		},
		type:'NumberField',
		filters:{	type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "% MEM BD",
			gwidth: 90,
			name: 'pmem_bd',
					
		},
		type:'NumberField',
		filters:{	type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "VIRT BD KB",
			gwidth: 95,
			name: 'vmstat_bd',
					
		},
		type:'NumberField',
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "% CPU WEB",
			gwidth: 90,
			name: 'pcpu_web',
					
		},
		type:'NumberField',
		filters:{	type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "% MEM WEB",
			gwidth: 90,
			name: 'pmem_web',
					
		},
		type:'TextField',
		filters:{	type:'numeric'},
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "VIRT WEB KB",
			gwidth: 95,
			name: 'vmstat_web',
					
		},
		type:'TextField',
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Nombre Proceso BD",
			gwidth: 105,
			name: 'comando_bd',
					
		},
		type:'TextField',
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Nombre Proceso WEB",
			gwidth: 105,
			name: 'comando_web',
					
		},
		type:'TextField',
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "SID WEB",
			gwidth: 105,
			name: 'sid_web',
					
		},
		type:'TextField',
		grid:true,
		form:false
	},
	
	{
		config:{
			fieldLabel: "Usuario Proceso BD",
			gwidth: 100,
			name: 'usuario_pbd',
					
		},
		type:'TextField',
		grid:true,
		form:false
	},
	{
		config:{
			fieldLabel: "Usuario Proceso WEB",
			gwidth: 100,
			name: 'usuario_web',
					
		},
		type:'TextField',
		grid:true,
		form:false
	}	
	];

	Phx.vista.monitor_recursos.superclass.constructor.call(this,config);
	this.init();
	this.store.setBaseParam('tipo_log','bd');
	
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
    	this.combo_segundos.setValue('10');
    	
 		this.timer_id=Ext.TaskMgr.start({
		    run: Ftimer,
		    interval:parseInt(this.combo_segundos.getValue())*1000,
		    scope:this
		});

    	this.load({params:{start:0, limit:10000}});
    	
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
Ext.extend(Phx.vista.monitor_recursos,Phx.gridInterfaz,{
	
	title:'Log',
	ActList:'../../sis_seguridad/control/Log/listarMonitorRecursos',
	id_store:'pid_bd',
	fields: [
	{name:'pid_bd'},
	{name:'pcpu_bd'},
	{name:'pmem_bd'},
	{name:'pid_web'},
	{name:'pcpu_web'},
	{name:'pmem_web'},
	{name:'usuario_bd', type: 'string'},
	{name:'usuario_pbd', type: 'string'},
	{name:'usuario_web', type: 'string'},
	{name:'consulta', type: 'string'},
	{name:'comando_bd', type: 'string'},
	{name:'comando_web', type: 'string'},
	{name:'hora_inicio_proceso', type: 'string'},
	{name:'hora_inicio_consulta', type: 'string'},
	{name:'vmstat_bd', type: 'string'},
	{name:'vmstat_web', type: 'string'},
	{name:'sid_web', type: 'string'},
	{name:'transaccion_actual', type: 'string'},
	{name:'funcion_actual', type: 'string'}
	
	],
	sortInfo:{
		field: 'pcpu_bd',
		direction: 'DESC'
	},
	bdel:false,//boton para eliminar
	bsave:false,//boton para eliminar
	bnew:false,//boton para eliminar
	bedit:false,//boton para eliminar
	bexcel:false,


	onDestroy:function(){
		Ext.TaskMgr.stop(this.timer_id);
		Phx.vista.monitor_recursos.superclass.onDestroy.call(this);
	},
	onHide:function(){
		Ext.TaskMgr.stop(this.timer_id);
		Phx.vista.monitor_recursos.superclass.onHide.call(this);
	},
	onShow:function(){
		if(this.combo_segundos.getValue()!='detener'){
	    		this.timer_id=Ext.TaskMgr.start({
			    	run:this.reload,
			    	interval:parseInt(this.combo_segundos.getValue())*1000,
			    	scope:this
				});
    	}
		Phx.vista.monitor_recursos.superclass.onShow.call(this);
	}
	
}
)
</script>