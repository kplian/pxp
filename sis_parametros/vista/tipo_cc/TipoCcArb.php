<?php
/**
*@package pXP
*@file TipoCcArb.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-02-2013 15:04:03
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 * 
 * 
 * COMENTARIOS:	 
  #33  ETR       18/07/2018        RAC KPLIAN       agregar opearativo si o no
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoCcArb=Ext.extend(Phx.arbGridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;		
    	//llama al constructor de la clase padre
		Phx.vista.TipoCcArb.superclass.constructor.call(this,config);		
		this.init();
		this.iniciarEventos();
		this.crearFormAuto();
		this.crearFormAutorizacion();
		
			this.addButton('btnAgrPla',{
              text: 'Agregar desde Plantilla',
              iconCls: 'bexport',
              //disabled: false,
              handler: this.agregarPlantilla,
              tooltip: '<b>Agregar desde Plantilla'
          });
        this.addButton('inserAuto',{
            text: 'Autorizaciones',
            iconCls: 'blist',
            //disabled: false,
            handler:
            this.mostarFormAuto,
            tooltip: '<b>Configurar autorizaciones</b>'});
     
		
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
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_cc_fk'
			},
			type:'Field',
			form:true 
		},
		
		{
			config:{
				name: 'codigo',
				fieldLabel: 'codigo',
				allowBlank: false,
				anchor: '80%',
				gwidth: 350,
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
        ///nuevo autoriazcion MMV
        {
            config:{
                name: 'autoriazcion',
                fieldLabel: 'Autorizacion',
                allowBlank: false,
                anchor: '80%',
                gwidth: 200,
                maxLength:30
            },
            type:'TextField',
            filters:{pfiltro:'tcc.autorizacion',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },
        ////
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
				name: 'momento_pres',
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
				name: 'mov_pres',
				qtip:'Si el presupeusto es de ignreso o egreso o ambos',
				fieldLabel: 'Ingreso / Egreso',
				anchor: '80%',
				gwidth: 120,
				allowBlank: false,	
       			typeAhead: true,
       		    triggerAction: 'all',
       		    lazyRender:true,
       		    mode: 'local',
       		    valueField: 'inicio', 
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
		{  //  #33 ++
			config:{
				name: 'operativo',
				qtip:'Si NO es operativo no  permite la imputaciones desde adquisiciones, tesorería, etc (NOTA: excepto contabilidad, donde siempre es permitido)',
				fieldLabel: 'Operativo',
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
		}
		
	],
	

	title:'Ordenes',
	ActSave:'../../sis_parametros/control/TipoCc/insertarTipoCcArb',
	ActDel:'../../sis_parametros/control/TipoCc/eliminarTipoCcArb',
	ActList:'../../sis_parametros/control/TipoCc/listarTipoCcArb',
	id_store:'id_tipo_cc',
	
	textRoot:'Ordenes de Costo',
    id_nodo:'id_tipo_cc',
    id_nodo_p:'id_tipo_cc_fk',
	
	fields:  [
	     'id',
        'tipo_meta',
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
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_inicio', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_final', type: 'date',dateFormat:'Y-m-d'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_ep','id_ep','operativo',{name:'autoriazcion', type: 'string'}
		
	],
	
	sortInfo:{
		field: 'id_tipo_cc',
		direction: 'ASC'
	},
	bdel: true,
	bsave: false,
	rootVisible: true,
	expanded: false,
	
	
    getDatosPadre: function(n) {
			var direc
			var padre = n.parentNode;
			var obj; 
            if (padre) {
				
					obj = {
				        id_ep: n.attributes.id_ep,
				        tipo: n.attributes.tipo,
				        fecha_inicio:n.attributes.fecha_inicio ,
				        fecha_final:n.attributes.fecha_final 
				       } 
					return obj;
				
			} else {
				return undefined;
			}
		},
		
	getTipoCuentaPadre: function(n) {
			var direc
			var padre = n.parentNode;
            if (padre) {
				if (padre.attributes.id != 'id') {
					return this.getTipoCuentaPadre(padre);
				} else {
					return n.attributes.tipo;
				}
			} else {
				return undefined;
			}
		},	
   
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
		Phx.vista.TipoCcArb.superclass.onButtonEdit.call(this);		
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
    		Phx.vista.TipoCcArb.superclass.onButtonNew.call(this);
	        var nodo = this.sm.getSelectedNode();
	        this.Cmp.id_ep.allowBlank = false;	        
	        if(nodo && nodo.attributes.id!='id'){	        	
	        	var obj = this.getDatosPadre(nodo);	        	        	
	        	//comentado temporalmente para evitar e bloqueo, al parecer existe un bug noidentificado
	        	//this.Cmp.tipo.disable();
	        	this.Cmp.tipo.setValue(obj.tipo);
	        	this.Cmp.id_ep.setValue(obj.id_ep);
	        	this.Cmp.fecha_inicio.setValue(obj.fecha_inicio);
	        	this.Cmp.fecha_final.setValue(obj.fecha_final);
	        }
	        else{	        	
	        	this.Cmp.tipo.enable();
	        }
    },
    agregarPlantilla:function(){
    	var nodo = this.sm.getSelectedNode();
    	//console.log(nodo);
    	//console.log(nodo.attributes.movimiento);
    	if (nodo.attributes.movimiento =='no') 
    	{			
				this.wAuto.show();
    		
    		}
    	 else{
    	 	
    	 	alert('El nodo escogido es transaccional no puede agregar plantilla');
    	 	this.liberaMenu();
    	 	
    	 };
   },

   	crearFormAuto:function(){
		 	 this.formAuto = new Ext.form.FormPanel({
            baseCls: 'x-plain',
            autoDestroy: true,
           
            border: false,
            layout: 'form',
             autoHeight: true,
           
    
            items: [
            	  {
		                name: 'id_tipo_cc_plantilla',
		                xtype:"combo",
		                fieldLabel: 'Plantilla',
		                allowBlank: false,
		                emptyText:'Elija una plantilla...',
		                store:new Ext.data.JsonStore(
		                {
		                    url: '../../sis_parametros/control/TipoCcPlantilla/listarTipoCcArbPlantillaPadre',
		                    id: 'id_tipo_cc_plantilla',
		                    root:'datos',
		                    sortInfo:{
		                        field:'codigo',
		                        direction:'ASC'
		                    },
		                    totalProperty:'total',
		                    fields: ['id_tipo_cc_plantilla','descripcion','codigo'],
		                    remoteSort: true,
		                }),
		                valueField: 'id_tipo_cc_plantilla',
		                hiddenValue: 'id_tipo_cc_plantilla',
		                displayField: 'codigo',
		                //gdisplayField:'nro_documento',
		                listWidth:'280',
		                forceSelection:true,
		                typeAhead: false,
		                triggerAction: 'all',
		                lazyRender:true,
		                mode:'remote',
		                pageSize:20,
		                queryDelay:500,
		                gwidth: 100,
		                minChars:2
		            },
   
       			{
       				name: 'codigo',
            		xtype: 'textfield',
            		fieldLabel: 'Codigo',
            		allowBlank: true,
					anchor: '80%',
					gwidth: 100,
            		qtip: 'Codigo'
       			}]
        });
	this.wAuto = new Ext.Window({
            title: 'Agregar',
            collapsible: true,
            maximizable: true,
            autoDestroy: true,
            width: 380,
            height: 280,
            layout: 'fit',
            plain: true,
            bodyStyle: 'padding:5px;',
            buttonAlign: 'center',
            items: this.formAuto,
            modal:true,
             closeAction: 'hide',
            buttons: [{
                text: 'Guardar',
                handler: this.saveAuto,
                scope: this
                
            },
             {
                text: 'Cancelar',
                handler: function(){ this.wAuto.hide() },
                scope: this
            }]
        });
        
         this.cmpDescripcion = this.formAuto.getForm().findField('id_tipo_cc_plantilla');
         this.cmpCodigo = this.formAuto.getForm().findField('codigo');
         
           
	},
	    saveAuto: function(){
		    var d = this.getSelectedData();
		    Phx.CP.loadingShow();
            Ext.Ajax.request({
                url: '../../sis_parametros/control/TipoCc/agregarPlantilla',
                params: { 
                	      id_tipo_cc_plantilla: this.cmpDescripcion.getValue(),
                	      codigo:this.cmpCodigo.getValue(),
                	       id_tipo_cc:d. id_tipo_cc
                	    
                	    },
                success: function(){
                	Phx.CP.loadingHide();
                	this.wAuto.hide();
               		this.onButtonAct(); 
                },
                failure: this.conexionFailure,
                timeout: this.timeout,
                scope: this
            });
		
	},
	
	preparaMenu: function(n) {
		
		var selectedNode = this.sm.getSelectedNode();
		
		var data = this.getSelectedData();
		var tb = this.tbar;
		Phx.vista.TipoCcArb.superclass.preparaMenu.call(this, n);

	    this.getBoton('btnAgrPla').enable();
        this.getBoton('inserAuto').enable();
		//Si es un nodo del tipo transaccional u hoja deshabilita boton de agregar plantilla
		
		if(selectedNode&&selectedNode.attributes&&selectedNode.attributes.movimiento =='no'){
			this.getBoton('btnAgrPla').enable();
		} else {
			
			this.getBoton('btnAgrPla').disable();
           // this.getBoton('inserAuto').disable();
		}
		return tb
	},

	liberaMenu: function() {
		var tb = Phx.vista.TipoCcArb.superclass.liberaMenu.call(this);
		var selectedNode = this.sm.getSelectedNode();
	

		//this.getBoton('btnAgrPla').disable();    
		return tb
	},



    /////INICIO-MMV-ASIGNAR-AUTORIZACION///
    mostarFormAuto:function(){
        var data = this.getSelectedData();
        if(data){
            this.cmpAuto.setValue(data.autoriazcion);
            this.ventanaAuto.show();
        }

    },
    crearFormAutorizacion:function(){
        var storeCombo = new Ext.data.JsonStore({
            url: '../../sis_parametros/control/Catalogo/listarCatalogoCombo',
            id: 'id_catalogo',
            root: 'datos',
            sortInfo:{
                field: 'descripcion',
                direction: 'ASC'
            },
            totalProperty: 'total',
            fields: ['id_catalogo','codigo','descripcion'],
            remoteSort: true,
            baseParams: {par_filtro: 'descripcion', cod_subsistema : 'PARAM',catalogo_tipo :'ttipo_cc'}
        });
        var combo = new Ext.form.AwesomeCombo({
            name:'autoriazcion',
            fieldLabel:'Autorizaciones',
            allowBlank : false,
            typeAhead: true,
            store: storeCombo,
            mode: 'remote',
            pageSize: 15,
            triggerAction: 'all',
            valueField : 'codigo',
            displayField : 'descripcion',
            forceSelection: true,
            allowBlank : false,
            anchor: '100%',
            resizable : true,
            enableMultiSelect: true
        });
        this.formAuto = new Ext.form.FormPanel({
            baseCls: 'x-plain',
            autoDestroy: true,
            border: false,
            layout: 'form',
            autoHeight: true,
            items: [combo]
        });
        this.ventanaAuto = new Ext.Window({
            title: 'Configuracion',
            collapsible: true,
            maximizable: true,
            autoDestroy: true,
            width: 380,
            height: 170,
            layout: 'fit',
            plain: true,
            bodyStyle: 'padding:5px;',
            buttonAlign: 'center',
            items: this.formAuto,
            modal:true,
            closeAction: 'hide',
            buttons: [{
                text: 'Guardar',
                handler: this.saveAutorizacion,
                scope: this},
                {
                    text: 'Cancelar',
                    handler: function(){ this.ventanaAuto.hide() },
                    scope: this
                }]
        });
        this.cmpAuto = this.formAuto.getForm().findField('autoriazcion');
    },
    saveAutorizacion: function(){
        var d = this.getSelectedData();
        Phx.CP.loadingShow();
        Ext.Ajax.request({
            url: '../../sis_parametros/control/TipoCc/asignarAutorizacion',
            params: {
                id_tipo_cc: d.id_tipo_cc,
                autorizacion: this.cmpAuto.getValue()
            },
            success: this.successSinc,
            failure: this.conexionFailure,
            timeout: this.timeout,
            scope: this
        });
    },
    successSinc:function(resp){
        Phx.CP.loadingHide();
        var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
        if(!reg.ROOT.error){
            if(this.ventanaAuto){
                this.ventanaAuto.hide();
            }
            var sn = this.sm.getSelectedNode();
            if (sn && sn.parentNode) {
                sn.parentNode.reload();
            } else {
                this.root.reload();
            }
        }else{
            alert('ocurrio un error durante el proceso')
        }
    }
  //////FIN-MMV-ASIGNAR-AUTORIZACION////
   
})
</script>