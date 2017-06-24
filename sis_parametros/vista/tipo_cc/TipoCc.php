<?php
/**
*@package pXP
*@file gen-TipoCc.php
*@author  (admin)
*@date 26-05-2017 10:10:19
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoCc=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoCc.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
		this.iniciarEventos();
	},
	
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_cc'
			},
			type:'Field',
			form:true 
		},
		
		{
	   		config:{
	   				name:'id_tipo_cc_fk',
	   				qtip: 'Tipo de centro de costos, cada tipo solo puede tener un centro por gestión',	   				
	   				origen:'TIPOCC',
	   				fieldLabel:'Tipo Centro Padre',
	   				gdisplayField: 'descripcion_tccp',
	   				url:'../../sis_parametros/control/TipoCc/listarTipoCcAll',	
	   				baseParams: {movimiento:'no'} ,  				
	   				allowBlank:true,
	   				width:250,
	   				gwidth:250,
	   				renderer:function (value, p, record){return String.format('({0}) {1}', record.data['codigo_tccp'],  record.data['descripcion_tccp']);}
	   				
	      		},
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'cec.codigo_tcc#cec.descripcion_tcc',type:'string'},
   		    grid:true,
   			form:true
	    },
		
		
		{
			config:{
				name: 'codigo',
				fieldLabel: 'codigo',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
				type:'TextField',
				id_grupo:1,
				grid:true,
				form:true
		},
		
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 450,
				maxLength:400
			},
				type:'TextArea',
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'tipo',
				fieldLabel: 'Tipo de Aplicacion?',
				anchor: '80%',
				gwidth: 70,
				allowBlank: false,	
				emptyText:'tipo...',       			
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    valueField: 'inicio',    
       		    store:['centro','edt','orden','estadistica']
			},
			type:'ComboBox',
			id_grupo:1,
	        valorInicial:'estadistica',
			grid:true,
			form:true
		},
		
		{
			config:{
				name: 'movimiento',
				qtip:'los nodos transaccionales no tienen hijos, son lo que se peuden convertir en centros de costo',
				fieldLabel: 'Transaccional',
				anchor: '80%',
				gwidth: 70,
				allowBlank: false,
				maxLength:2,
				emptyText:'si/no...',       			
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    valueField: 'inicio', 
       		    forcSselect:true,     
       		    store:['si','no']
			},
			type:'ComboBox',
			id_grupo:1,
			grid:true,
			form:true
		},
		
		{
			config:{
				name: 'control_techo',
				qtip:'Si es Techo el presupuestario  se valida a este nivel',
				fieldLabel: 'Techo Presupeustario',
				allowBlank: false,
				anchor: '80%',
				gwidth: 70,
				maxLength:2,
				emptyText:'si/no...',       			
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    valueField: 'inicio', 
       		    forcSselect:true,    
       		    store:['si','no']
			},
			type:'ComboBox',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'control_partida',
				qtip:'Controlar el presupesuto por partidas',
				fieldLabel: 'Controlar Partida',
				allowBlank: false,  
				anchor: '80%', 
				gwidth: 70,   			
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    valueField: 'inicio', 
       		    forcSselect:true, 
       		    store:['si','no']
			},
			type:'ComboBox',
			id_grupo:1,
			valorInicial:'si',
			grid:true,
			form:true
		},
		{
			config:{
				name: 'momento_pres_str',
				qtip:'Que momento se controla con este presupeusto',
				fieldLabel: 'Momentos',
				anchor: '80%',
				allowBlank: false,	    			
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    valueField: 'inicio', 
       		    forcSselect:true,
                enableMultiSelect: true,    
       		    store:['formulado','comprometido','ejecutado','pagado']
			},
			type:'AwesomeCombo',
			id_grupo:1,
			valorInicial:'formulado,comprometido,ejecutado,pagado',
			grid:false,
			form:true
		},
		{
			config:{
				name: 'mov_pres_str',
				qtip:'Si el presupeusto es de ignreso o egreso o ambos',
				fieldLabel: 'Ingreso / Egreso',
				anchor: '80%',
				gwidth: 120,
				allowBlank: false,	
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    forcSselect:true,
                enableMultiSelect: true,     
       		    store:['ingreso','egreso']
			},
			type:'AwesomeCombo',
			id_grupo:1,
			valorInicial:'ingreso,egreso',
			grid:true,
			form:true
		},
		
		{
	   		config:{
	   				name:'id_ep',
	   				origen:'EP',
	   				anchor: '80%',
	   				gwidth: 200,
	   				fieldLabel:'EP',
	   				allowBlank:true,
	   				gdisplayField:'desc_ep',//mapea al store del grid	   			   
	   			    renderer:function (value, p, record){return String.format('{0}', record.data['desc_ep']);}
	      		},
   			type:'ComboRec',
   			id_grupo:0,
   		    grid:true,
   			form:true
	    },
		
		{
			config:{
				name: 'fecha_inicio',
				fieldLabel: 'Fecha Inicio',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			id_grupo:1,
			grid:false,
			form:true
		},
		
		
		{
			config:{
				name: 'fecha_final',
				fieldLabel: 'Fecha Final',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'tcc.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'tcc.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'tcc.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'tcc.usuario_ai',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title: 'Tipo Centro de Costo',
	ActSave: '../../sis_parametros/control/TipoCc/insertarTipoCcArb',
	ActDel: '../../sis_parametros/control/TipoCc/eliminarTipoCcArb',
	ActList: '../../sis_parametros/control/TipoCc/listarTipoCc',
	id_store: 'id_tipo_cc',
	fields: [
		{name:'id_tipo_cc', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'control_techo', type: 'string'},
		{name:'mov_pres', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'movimiento', type: 'string'},
		{name:'id_ep', type: 'numeric'},
		{name:'id_tipo_cc_fk', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'control_partida', type: 'string'},
		{name:'momento_pres', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_inicio', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_final', type: 'date',dateFormat:'Y-m-d'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'desc_ep', 'id_ep', 'codigo_tccp', 
		'descripcion_tccp','mov_pres_str','momento_pres_str'
		
	],
	sortInfo:{
		field: 'id_tipo_cc',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	bnew: false,
	iniciarEventos: function(){
   	    
   	        this.Cmp.control_techo.on('select',function(combo,record,index){				
				if(combo.getValue() == 'no'){
					this.ocultarComponente(this.Cmp.momento_pres);
					this.ocultarComponente(this.Cmp.control_partida);
					this.ocultarComponente(this.Cmp.mov_pres);					
				} else{
					this.mostrarComponente(this.Cmp.momento_pres);
					this.mostrarComponente(this.Cmp.control_partida);
					this.mostrarComponente(this.Cmp.mov_pres);
				} 
			},this);			
			
			this.Cmp.movimiento.on('select',function(combo,record,index){				
				if(combo.getValue() == 'no'){					
					this.Cmp.id_ep.allowBlank = true;
				} else{					
					this.Cmp.id_ep.allowBlank = false;					
				} 
			},this);
   	
   },
   
   onButtonEdit:function(n){		
		Phx.vista.TipoCc.superclass.onButtonEdit.call(this);				
	    if(this.Cmp.control_techo.getValue() == 'si'){
			this.mostrarComponente(this.Cmp.momento_pres);
			this.mostrarComponente(this.Cmp.control_partida);
			this.mostrarComponente(this.Cmp.mov_pres);
			
		} else{
			this.ocultarComponente(this.Cmp.momento_pres);
			this.ocultarComponente(this.Cmp.control_partida);
			this.ocultarComponente(this.Cmp.mov_pres);			
		}
		
		if(this.Cmp.movimiento.getValue() == 'si'){			
			this.Cmp.id_ep.allowBlank = false;
		} else{			
			this.Cmp.id_ep.allowBlank = true;
		} 
	},
	
    onButtonNew:function(n){    		
    		Phx.vista.TipoCc.superclass.onButtonNew.call(this);	       
	        this.Cmp.id_ep.allowBlank = false;	        
	        this.Cmp.tipo.enable();
	      
    },
   
   
})
</script>
		
		