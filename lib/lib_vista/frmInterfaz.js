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
	title: 'Frm-Interfaz',
	ActSave:'',
	topBar: false,//barra de herramientas
	bottomBar: false,//barra de herramientas en la parte inferior
	botones: true,//Botones del formulario
	tipoInterfaz: 'frmInterfaz',
	argumentSave: {},

	//Banderas para definir que botones serán visibles
	bsubmit: true,
	breset: true,
	bcancel: false,
	borientacion: false,
	bformato: false,
	btamano: false,

	tipo: 'proceso',
	mensajeExito: 'Proceso generado!',
	//Para los botones de la barra de herramientas
	labelSubmit: '<i class="fa fa-check"></i> Guardar',
	labelReset: '<i class="fa fa-times"></i> Reset',
	labelCancel: '<i class="fa fa-times"></i> Declinar',
	tooltipSubmit: '<b>Guardar</b>',
	tooltipReset: '<b>Reset</b>',
	tooltipCancel: '<b>Declinar</b>',
	iconSubmit: '../../../lib/imagenes/print.gif',
	iconReset: '../../../lib/imagenes/act.png',
	iconCancel: '../../../lib/imagenes/cancel.png',
	clsSubmit: 'bsave',
	clsReset:  'breload2',
	clsCancel: 'bcancel',


	// Funcion declinar del formulario
	onReset:function(){
		this.form.getForm().reset();
		this.loadValoresIniciales();
	},

	//RCM 17/11/2011: se crea nuevo toolbar con los botones basicos de submit, reset y cancel
    defineMenu: function(){
    	var cbuttons=[], me = this;
    	// definicion de la barra de menu
    	if(me.bsubmit){

    		//cbuttons.push(['Impirmir']);

			cbuttons.push({
				id: 'b-print-' + me.idContenedor,
				icon: me.iconSubmit, // icons can also be specified inline
				tooltip: me.tooltipSubmit,          // <-- Add the action directly to a menu
				handler: me.onSubmit,
				text: me.labelSubmit,
				scope: me,
				iconCls: me.clsSubmit
			});
    	}

    	if(me.breset){
			cbuttons.push({
				id: 'b-reset-' + me.idContenedor,
				//cls:'x-btn-text-icon bmenu',
				//cls: 'x-btn-icon',
				icon: me.iconReset,
				tooltip: me.tooltipReset,
				handler: me.onReset,
				text: me.labelReset,
				scope: me,
				iconCls: me.clsReset
			});
    	}

    	if(me.bcancel){
			cbuttons.push({
				id:'b-cancel-' + me.idContenedor,
				//cls:'x-btn-text-icon bmenu',
				//cls: 'x-btn-icon',
				icon: me.iconCancel,
				tooltip: me.tooltipCancel,
				handler: me.onDeclinar,
				text: me.labelCancel,
				scope: me,
				iconCls: me.clsCancel
			});
    	}

    	//Para aumentar texto por delante
    	//cbuttons.push('Orientación');
    	if(me.borientacion){
	    	cbuttons.push({
				id:'b-orientacion-' + me.idContenedor,
				xtype: 'combo',
				store: new Ext.data.ArrayStore({
					id: 0,
					fields: ['codigo','nombre'],
					data: [['L','Horizontal'],['P','Vertical']]
					}
				),
				valueField: 'codigo',
				displayField: 'nombre',
				typeAhead: true,
				triggerAction: 'all',
				emptyText: 'Orientación...',
				mode: 'local',
				width: 100,
				value: 'P'
			});
    	}

    	if(me.bformato){
	    	cbuttons.push({
				id:'b-formato-' + me.idContenedor,
				xtype:'combo',
				store: new Ext.data.ArrayStore({
					id:0,
					fields: ['codigo','nombre'],
					data: [['pdf','PDF'],['excel','CSV']]
					}
				),
				valueField: 'codigo',
				displayField: 'nombre',
				typeAhead: false,
				triggerAction: 'all',
				emptyText: 'Formato...',
				mode: 'local',
				width: 75,
				value:'pdf'
			});
    	}

    	if(me.btamano){
	    	cbuttons.push({
				id:'b-tamano-' + me.idContenedor,
				xtype:'combo',
				store: ['Carta','Oficio'],
				store: new Ext.data.ArrayStore({
					id:0,
					fields: ['codigo','nombre'],
					data: [['Letter','Carta'],['A4','Oficio']]
					}
				),
				valueField: 'codigo',
				displayField: 'nombre',
				typeAhead: false,
				triggerAction: 'all',
				emptyText: 'Tamaño...',
				mode: 'local',
				width: 80,
				value:' Letter'
			});
    	}


		me.tbar= new Ext.Toolbar({defaults:{scale:'large',cls:'x-btn-text-icon bmenu'}, items:cbuttons});
    },
    //Evento para cerrar el panel
	onDeclinar:function(){
		this.panel.destroy();
		delete this;
		Phx.CP.destroyPage(this.idContenedor);
        delete this;
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


	iniciarArrayBotones:function(){
		//RCM 17/11/2011:Verifica si se crearán los botones del formulario
    	var me = this;
    	me.arrayBotones=[];

		if(me.bsubmit){
			me.arrayBotones.push({
				text:  me.labelSubmit,
				handler: me.onSubmit,
				argument: { 'news': false },
				scope: me});
		}

		if(me.breset){
			me.arrayBotones.push({
				text: me.labelReset,
				handler: me.onReset,
				scope: me});
		}

		if(me.bcancel){
			me.arrayBotones.push({
				text: me.labelCancel,
				handler: me.onDeclinar,
				scope: me});
		}

		if(!me.botones){

			me.arrayBotones.unshift('->')
			me.toolBar = new Ext.Toolbar(
                          { height: 30,
                            defaults: { scale:'small',
                            cls: 'x-btn-text-icon bmenu'},
                            items: me.arrayBotones
                          });
        }

    	//FIN RCM
	},
	///////////////////
	//DEFINICON DEL CONSTRUCTOR
    ///////////////////
    layout : 'form',
    autoScroll: false,
	constructor: function(config){
        var me = this;
		Phx.frmInterfaz.superclass.constructor.call(me,config);

		// recorre todos los atributos de la pagina y va creando los
		// componentes para despues poder agregarlo al formulario de la pagina
		// Se prepara el contenido del store, formulario y grid

    	me.definirComponentes();

    	//definicion de la barra de meno
    	if(me.topBar){
    		me.defineMenu();
    	}

    	if(me.botones){
    		me.iniciarArrayBotones();
    	}


		//crea formulario
    	me.form = new Ext.form.FormPanel({
			id: me.idContenedor+'_W_F',
			autoShow: true,
			layout: me.layout,
			region: 'center',
			fileUpload: me.fileUpload,
			padding: me.paddingForm,
            bodyStyle: me.bodyStyleForm,
            border: me.borderForm,
            frame: me.frameForm,
			items: me.Grupos,
			autoDestroy: true,
			autoScroll: me.autoScroll,
			tbar: me.tbar,
			buttons:  me.botones?me.arrayBotones: undefined
		});
		// preparamos regiones
		me.prepararRegion();

		this.loadValoresIniciales();

   },
   // preparamos regiones
   prepararRegion: function(){
   		this.regiones= new Array();
		this.regiones.push(this.form);

		this.addRegiones();

	    this.definirRegiones();
   },
   addRegiones: function(){

   }

});