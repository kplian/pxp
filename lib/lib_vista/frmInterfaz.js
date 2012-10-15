/*
**********************************************************
Nombre de la clase:	    Paginaa
Proposito:				clase generica de interfaz con grilla
Fecha de Creacion:		02 - 05 - 09
Version:				0
Autor:					Rensi Arteaga Copari
**********************************************************
*/ 
Ext.namespace('Phx','Phx.vista');
Phx.frmInterfaz=Ext.extend(Phx.baseInterfaz,{ 
	// Componentes:NULL,
	title:'Frm-Interfaz',
	ActSave:'',
	topBar:false,//barra de herramientas
	botones:true,//Botones del formulario
	tipoInterfaz:'frmInterfaz',		
	argumentSave:{},
	
	//Banderas para definir que botones serán visibles
	bsubmit:true,
	breset:true,
	bcancel:false,
	borientacion:false,
	bformato:false,
	btamano:false,
	
	tipo:'proceso',
	mensajeExito:'Proceso generado!',
	//Para los botones de la barra de herramientas
	labelSubmit:'Guardar',
	labelReset:'Reset',
	labelCancel:'Declinar',
	tooltipSubmit:'<b>Guardar</b>',
	tooltipReset:'<b>Reset</b>',
	tooltipCancel:'<b>Declinar</b>',
	iconSubmit:'../../../lib/imagenes/print.gif',
	iconReset:'../../../lib/imagenes/act.png',
	iconCancel:'../../../lib/imagenes/cancel.png',
	clsSubmit:'bsave',
	clsReset:'breload2',
	clsCancel:'bcancel',

	// Funcion declinar del formulario
	onReset:function(){
		this.form.getForm().reset();
		this.loadValoresIniciales();
	},
	
	//RCM 17/11/2011: se crea nuevo toolbar con los botones basicos de submit, reset y cancel
    defineMenu: function(){
    	var cbuttons=[];
    	// definicion de la barra de menu
    	if(this.bsubmit){
    		
    		//cbuttons.push(['Impirmir']);
    		
			cbuttons.push({
				id:'b-print-'+this.idContenedor,
				//cls:'x-btn-text-icon bmenu',
				//cls: 'x-btn-icon',
				icon:this.iconSubmit, // icons can also be specified inline
				tooltip: this.tooltipSubmit,          // <-- Add the action directly to a menu
				handler: this.onSubmit,
				text:this.labelSubmit,
				scope:this,
				iconCls:this.clsSubmit
			});
    	}

    	if(this.breset){
			cbuttons.push({
				id:'b-reset-'+this.idContenedor,
				//cls:'x-btn-text-icon bmenu',
				//cls: 'x-btn-icon',
				icon: this.iconReset,
				tooltip: this.tooltipReset,
				handler: this.onReset,
				text:this.labelReset,
				scope:this,
				iconCls:this.clsReset
			});
    	}
		
    	if(this.bcancel){
			cbuttons.push({
				id:'b-cancel-'+this.idContenedor,
				//cls:'x-btn-text-icon bmenu',
				//cls: 'x-btn-icon',
				icon: this.iconCancel,
				tooltip: this.tooltipCancel,
				handler: this.onDeclinar,
				text:this.labelCancel,
				scope:this,
				iconCls:this.clsCancel
			});
    	}
    	
    	//Para aumentar texto por delante
    	//cbuttons.push('Orientación');
    	if(this.borientacion){
	    	cbuttons.push({
				id:'b-orientacion-'+this.idContenedor,
				xtype:'combo',
				store: new Ext.data.ArrayStore({
					id:0,
					fields: ['codigo','nombre'],
					data: [['L','Horizontal'],['P','Vertical']]
					}
				),
				valueField:'codigo',
				displayField:'nombre',
				typeAhead:true,
				triggerAction: 'all',
				emptyText:'Orientación...',
				mode: 'local',
				width:100,
				value:'P'
			});
    	}
    	
    	if(this.bformato){
	    	cbuttons.push({
				id:'b-formato-'+this.idContenedor,
				xtype:'combo',
				store: new Ext.data.ArrayStore({
					id:0,
					fields: ['codigo','nombre'],
					data: [['pdf','PDF'],['excel','CSV']]
					}
				),
				valueField:'codigo',
				displayField:'nombre',
				typeAhead:false,
				triggerAction: 'all',
				emptyText:'Formato...',
				mode: 'local',
				width:75,
				value:'pdf'
			});
    	}
    	
    	if(this.btamano){
	    	cbuttons.push({
				id:'b-tamano-'+this.idContenedor,
				xtype:'combo',
				store:['Carta','Oficio'],
				store: new Ext.data.ArrayStore({
					id:0,
					fields: ['codigo','nombre'],
					data: [['Letter','Carta'],['A4','Oficio']]
					}
				),
				valueField:'codigo',
				displayField:'nombre',
				typeAhead:false,
				triggerAction: 'all',
				emptyText:'Tamaño...',
				mode: 'local',
				width:80,
				value:'Letter'
			});
    	}

		
		this.tbar= new Ext.Toolbar({defaults:{scale:'large',cls:'x-btn-text-icon bmenu'},items:cbuttons});
    },
    //Evento para cerrar el panel
	onDeclinar:function(){
		this.panel.destroy()
	},
	successSave:function(resp){
		if(this.tipo=='reporte'){
			Phx.CP.loadingHide();
	        var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
	        var nomRep=objRes.ROOT.detalle.archivo_generado;
	        if(Phx.CP.config_ini.x==1){  			
	        	nomRep=Phx.CP.CRIPT.Encriptar(nomRep);
	        }        
			window.open('../../../lib/lib_control/Intermediario.php?r='+nomRep);
		} else{
			Phx.CP.loadingHide();
			Ext.Msg.alert('Información',this.mensajeExito);
		}
	},
	
	agregarArgsBaseSubmit: function(){
		this.argumentBaseSubmit={};
		if(this.borientacion){
			var cmbOrientacion=Ext.getCmp('b-orientacion-'+this.idContenedor);
			this.argumentBaseSubmit.orientacion=cmbOrientacion.getValue();
		}
		if(this.bformato){
			var cmbFormato=Ext.getCmp('b-formato-'+this.idContenedor);
			this.argumentBaseSubmit.tipoReporte=cmbFormato.getValue();
		}
		if(this.btamano){
			var cmbTamano=Ext.getCmp('b-tamano-'+this.idContenedor);
			this.argumentBaseSubmit.tamano=cmbTamano.getValue();
		}
	},
	
    //FIN RCM

	
	
	///////////////////
	//DEFINICON DEL CONSTRUCTOR
    ///////////////////
	constructor: function(config){
		
		Phx.frmInterfaz.superclass.constructor.call(this,config);
    
		// recorre todos los atributos de la pagina y va creando los
		// componentes para despues poder agregarlo al formulario de la pagina
		// Se prepara el contenido del store, formulario y grid
       
    	this.definirComponentes();
    	
    	//definicion de la barra de meno
    	if(this.topBar){
    		this.defineMenu();
    	}
    	
    	//RCM 17/11/2011:Verifica si se crearán los botones del formulario
    	var arrayBotones=[];
    	if(this.botones){
    		arrayBotones.push({
				text: this.labelSubmit,
				handler:this.onSubmit,
				argument:{'news':false},
				scope:this});
    		arrayBotones.push({
				text: this.labelReset,
				handler:this.onReset,
				scope:this});
    		arrayBotones.push({
				text: this.labelCancel,
				handler:this.onDeclinar,
				scope:this});

    	}
    	//FIN RCM

		//crea formulario
    	this.form = new Ext.form.FormPanel({
			id:this.idContenedor+'_W_F',
			autoShow:true,
			//frame:true,
			layout: 'form',
			region: 'center',
			//labelWidth:80,
			fileUpload:this.fileUpload,
			
			items:this.Grupos,
			//bodyStyle: 'padding:0 10px 0;',
			//autoWidth:true,
			autoDestroy:true,
			autoScroll:true,
			autoDestroy:true,
			tbar:this.tbar,
			buttons:arrayBotones
		});
		// preparamos regiones
     	this.regiones= new Array();
		this.regiones.push(this.form);
	    this.definirRegiones();
    }

});
