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
<script>
Phx.vista.Obs=Ext.extend(Phx.gridInterfaz,{
    constructor:function(config){
		this.maestro=config.maestro;
		if(config.hasOwnProperty('idContenedorPadre')){
            this.paginaMaestro = Phx.CP.getPagina(config.idContenedorPadre);
        } else {
            this.paginaMaestro = undefined;
        }
         
		this.tbarItems = ['-',{
            text: 'Ver todas las observaciones',
            enableToggle: true,
            pressed: false,
            toggleHandler: function(btn, pressed) {
               
                if(pressed){
                    this.store.baseParams.todos = 1;
                     
                }
                else{
                   this.store.baseParams.todos = 0;
                }
                
                this.onButtonAct();
             },
            scope: this
           }];
           
           
    	//llama al constructor de la clase padre
		Phx.vista.Obs.superclass.constructor.call(this, config);
		this.init();
		this.addButton('btnCerrar', {
                text : 'Cerrar',
                iconCls : 'block',
                disabled : true,
                handler : this.cerrarObs,
                tooltip : '<b>Cerrar</b><br>Si la obligación ha sido resuelta es necesario cerrarla para continuar con el trámite'
        });
        
        
		this.on('closepanel',function () {
		    this.paginaMaestro.reload();
		}, this);
		this.store.baseParams = {  todos: 0, id_proceso_wf: config.id_proceso_wf, id_estado_wf: config.id_estado_wf, num_tramite: config.num_tramite}; 
        this.load({params: { start:0, limit: this.tam_pag } })
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_obs'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_estado_wf'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'obs.estado',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
            config:{
                name:'id_funcionario_resp',
                origen:'FUNCIONARIO',
                tinit: false,
                qtip: 'Funcionario responsable  de cumplir o hacer cumplir la observación',
                fieldLabel:'Funcionario Resp.',
                allowBlank: false,
                gwidth: 200,
                valueField: 'id_funcionario',
                gdisplayField:'desc_funcionario',//mapea al store del grid
                anchor: '100%',
                gwidth: 200,
                renderer: function (value, p, record){return String.format('{0}', record.data['desc_funcionario']);}
             },
            type:'ComboRec',
            id_grupo:0,
            filters:{   
                pfiltro:'FUN.desc_funcionario1::varchar',
                type:'string'
            },
           
            grid:true,
            form:true
        },
		{
			config:{
				name: 'titulo',
				fieldLabel: 'Título',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
				type:'TextField',
				filters:{pfiltro:'obs.titulo',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: false,
				anchor: '80%',
				gwidth: 250,
				maxLength:2000
			},
				type:'TextArea',
				filters: { pfiltro: 'obs.descripcion', type:'string' },
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'nombre_tipo_estado',
				fieldLabel: 'Estado Wf',
				allowBlank: true,
				anchor: '80%',
				gwidth: 150,
				maxLength:300
			},
				type:'Field',
				filters:{pfiltro:'te.nombre_estado',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'nombre_tipo_proceso',
				fieldLabel: 'Proceso Wf',
				allowBlank: true,
				anchor: '80%',
				gwidth: 300,
				maxLength: 300
			},
				type:'Field',
				filters: { pfiltro: 'tp.nombre', type: 'string' },
				id_grupo: 1,
				grid: true,
				form: false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha Ini',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'obs.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_fin',
				fieldLabel: 'Fecha Fin',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters: { pfiltro: 'obs.fecha_fin', type: 'date' },
				id_grupo:1,
				grid:true,
				form:false
		},
		
		{
			config:{
				name: 'desc_fin',
				fieldLabel: 'Desc fin',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-100
			},
				type: 'TextField',
				filters: { pfiltro: 'obs.desc_fin', type: 'string' },
				id_grupo: 1,
				grid: false,
				form: false
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength: 10
			},
				type:'TextField',
				filters: { pfiltro: 'obs.estado_reg', type:'string' }, 
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
				filters:{pfiltro:'obs.fecha_mod',type:'date'},
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
				filters:{pfiltro:'obs.id_usuario_ai',type:'numeric'},
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
				type:'Field',
				filters:{pfiltro:'obs.usuario_ai',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Observaciones',
	ActSave:'../../sis_workflow/control/Obs/insertarObs',
	ActDel:'../../sis_workflow/control/Obs/eliminarObs',
	ActList:'../../sis_workflow/control/Obs/listarObs',
	id_store:'id_obs',
	fields: [
		{name:'id_obs', type: 'numeric'},
		{name:'fecha_fin', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'estado_reg', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'id_funcionario_resp', type: 'numeric'},
		{name:'titulo', type: 'string'},
		{name:'desc_fin', type: 'string'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'desc_funcionario','codigo_tipo_estado','nombre_tipo_estado','nombre_tipo_proceso'
		
	],
	
	 onButtonNew:function(){  
	 	
	 	      
            Phx.vista.Obs.superclass.onButtonNew.call(this);
            //agrega un filtro para que se liste el funcionario del usuario y sea el primero que se cargue
            
            /*this.Cmp.id_funcionario_resp.store.load({params:{start:0,limit:this.tam_pag, tipo_filtro: 'usuario' }, 
		       callback : function (r) {
		       		if (r.length == 1 ) {	       				
		    			this.Cmp.id_funcionario_resp.setValue(r[0].data.id_funcionario);
		    		}    
		    			    		
		    	}, scope : this
		    });*/
	            
            
            this.Cmp.id_estado_wf.setValue( this.id_estado_wf );

        
    },
    
    onButtonEdit:function(){ 
    	
    	     //todo validar ...solo de pueden editar observaciones del mismo proceso y estado seleccionado   
            Phx.vista.Obs.superclass.onButtonEdit.call(this);
            this.Cmp.id_funcionario_resp.disable()
            
            
     
    },
     preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
       
        Phx.vista.Obs.superclass.preparaMenu.call(this,n);
        
        if(this.store.baseParams.todos == 1){
        	
        	this.getBoton('new').disable();
        	this.getBoton('edit').disable();
        	this.getBoton('del').disable();
        	this.getBoton('btnCerrar').disable();
        }
        else{
        	if(data.estado == 'abierto'){
        	   this.getBoton('btnCerrar').enable();	
        	}
        	else{
        	   this.getBoton('btnCerrar').disable();	
        	}
        }
        return tb 
     }, 
     liberaMenu:function(){
        var tb = Phx.vista.Obs.superclass.liberaMenu.call(this);
        this.getBoton('btnCerrar').disable();
        return tb
    },
    
    
    cerrarObs: function(){
	    Phx.CP.loadingShow();
	    var d = this.sm.getSelected().data;
        Ext.Ajax.request({
            url:'../../sis_workflow/control/Obs/cerrarObs',
            params: { id_obs: d.id_obs },
            success: this.successObs,
            failure: this.conexionFailure,
            timeout: this.timeout,
            scope: this
        }); 
	    
	},
	successObs: function(resp){
       Phx.CP.loadingHide();
       var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
       if(!reg.ROOT.error){
         this.reload();
       }
    },
	
	
	sortInfo:{
		field: 'id_obs',
		direction: 'ASC'
	},
	bdel: true,
	bsave: false
	}
)
</script>
		
		