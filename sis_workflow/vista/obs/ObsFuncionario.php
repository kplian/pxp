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
Phx.vista.ObsFuncionario=Ext.extend(Phx.gridInterfaz,{
    constructor:function(config){
		this.maestro=config.maestro;

		this.tbarItems = ['-',{
            text: 'Ver todas las observaciones',
            enableToggle: true,
            pressed: false,
            toggleHandler: function(btn, pressed) {

                if(pressed){
                    this.store.baseParams.estado = 'todos';

                }
                else{
                   this.store.baseParams.estado = 'abierto';
                }

                this.onButtonAct();
             },
            scope: this
           }];


    	//llama al constructor de la clase padre
		Phx.vista.ObsFuncionario.superclass.constructor.call(this, config);

		//this.addButton('diagrama_gantt',{grupo:[0,1,2,3], text:'Diagrama Gantt',iconCls: 'bgantt',disabled:true,handler:this.diagramGantt,tooltip: '<b>Diagrama Gantt de proceso macro</b>'});
        //this.addButton('btnChequeoDocumentos',{grupo:[0,1,2,3], text: 'Documentos',iconCls: 'bchecklist',disabled: true,handler: this.loadCheckDocumentosSol,tooltip: '<b>Documentos del Proceso</b><br/>Subir los documetos requeridos en el proceso seleccionada.'});



		this.init();

		this.addButton('btnCerrar', {
			text : 'Cerrar',
			iconCls : 'block',
			disabled : true,
			handler : this.cerrarObs,
			tooltip : '<b>Cerrar</b><br>Si la obligación ha sido resuelta es necesario cerrarla para continuar con el trámite'
		});





		this.store.baseParams = {  estado: 'abierto'};
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
		},{
			config:{
				name: 'nro_tramite',
				fieldLabel: 'Trámite',
				allowBlank: false,
				anchor: '80%',
				gwidth: 150,
				maxLength:100,
				renderer: function(value, p, record) {
					datos = record.data;
					console.log('datos',datos);

					if(datos.id_usuario_reg == datos.usr_actual)
						return String.format('<div ext:qtip="Observación Realizadas"><b><font color="green">{0}</font></b><br></div>', value);
					else
						return String.format('<div ext:qtip="Observación Recibidas"><b><font color="red">{0}</font></b><br></div>', value);
				}
			},
				type:'TextField',
				filters:{pfiltro:'pwf.nro_tramite',type:'string'},
				bottom_filter: true,
				id_grupo:1,
				grid:true,
				form:false
		},
		{
		config: {
			name: 'obs_resuelta',
			fieldLabel: 'Dias en Observación',
			allowBlank: true,
			anchor: '100%',
			gwidth: 120,
			maxLength: 100,
			renderer: function(value, p, record) {
				var datos = record.data;
				fecha = new Date();
				final = new Date(fecha.getFullYear()+'/'+fecha.getMonth()+'/'+fecha.getDate());
				inicial = new Date(datos.fecha_reg.getFullYear()+'/'+datos.fecha_reg.getMonth()+'/'+datos.fecha_reg.getDate());
				var dias = (((final-inicial)/86400)/1000);

				return String.format('{0}', "<div style='text-align:center'><img title='Reclamo Pendiente de Asignacion'  src = '../../../lib/images/numeros/"+dias+".png' align='center' width='24' height='24'/></div>");
			}
		},
		type: 'Checkbox',
		id_grupo:1,
		grid: true,
		form: false
		},

		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado Obs',
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
				fieldLabel:'Funcionario Observado',
				allowBlank: false,
				gwidth: 200,
				valueField: 'id_funcionario',
				gdisplayField:'desc_funcionario',//mapea al store del grid
				anchor: '80%',
				gwidth: 200,
				renderer: function (value, p, record){return String.format('{0}', record.data['desc_funcionario']);},
				tpl:'<tpl for="."><div class="x-combo-list-item"><p ><b>{desc_person}</b></p><p >CI:<span style="color: green">{ci}</span></p><p style="color: green">{codigo} - Sis: {codigo_sub} </p></div></tpl>'
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
				name:'id_funcionario_cc',
				origen:'FUNCIONARIO',
				tinit: false,
				qtip: 'Funcionario al cual se le envia un correo CC',
				fieldLabel:'Correo CC',
				allowBlank: true,
				gwidth: 200,
				valueField: 'id_funcionario',
				gdisplayField:'desc_funcionario',//mapea al store del grid
				anchor: '80%',
				gwidth: 200,
				renderer: function (value, p, record){return String.format('{0}', record.data['desc_funcionario_cc']);},
				tpl:'<tpl for="."><div class="x-combo-list-item"><p ><b>{desc_person}</b></p><p >CI:<span style="color: green">{ci}</span></p><p style="color: green">{codigo} - Sis: {codigo_sub} </p></div></tpl>'
			},
			type:'ComboRec',
			id_grupo:0,
			filters:{
				pfiltro:'FUN.desc_funcionario1::varchar',
				type:'string'
			},

			grid:false,
			form:true
		},

		{
			config:{
				name: 'id_fun_obs',
				fieldLabel: 'Funcionario Observador',
				allowBlank: true,
				anchor: '80%',
				gwidth: 180,
				maxLength:100,
				renderer: function (value, p, record){return String.format('{0}', record.data['desc_fun_obs']);}
			},
			type:'TextField',
			//filters:{pfiltro:'obs.titulo',type:'string'},
			//bottom_filter: true,
			id_grupo:0,
			grid:true,
			form:false
		},

		{
			config:{
				name: 'titulo',
				fieldLabel: 'Título',
				allowBlank: false,
				anchor: '80%',
				gwidth: 180,
				maxLength:100
			},
				type:'TextField',
				filters:{pfiltro:'obs.titulo',type:'string'},
				bottom_filter: true,
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
				bottom_filter: true,
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'nombre_tipo_proceso',
				fieldLabel: 'Proceso Wf',
				allowBlank: true,
				anchor: '80%',
				gwidth: 320,
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
				bottom_filter: true,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha Ini',
				allowBlank: true,
				anchor: '80%',
				gwidth: 125,
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
				gwidth: 125,
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
				gwidth: 125,
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
				bottom_filter: true,
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
	title:'Observaciones Funcionario',
	ActSave:'../../sis_workflow/control/Obs/insertarObs',
	ActDel:'../../sis_workflow/control/Obs/eliminarObs',
	ActList:'../../sis_workflow/control/Obs/listarObsFuncionario',
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
		'desc_funcionario','codigo_tipo_estado',
		'nombre_tipo_estado','nombre_tipo_proceso','nro_tramite',
		'id_estado_wf','id_proceso_wf',
		{name:'usr_actual', type: 'numeric'},
		'desc_fun_obs',
		'numero',
		'num_tramite','email_empresa',
		'desc_funcionario_cc'

	],

	rowExpander: new Ext.ux.grid.RowExpander({
	        tpl : new Ext.Template(
	            '<br>',
	            '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Título:&nbsp;&nbsp;</b> {titulo}</p>',
	            '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Descripción:&nbsp;&nbsp;</b> {descripcion}</p>',
	            '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Creado por:&nbsp;&nbsp;</b> {usr_reg}</p><br><br>'
	        )
    }),

    arrayDefaultColumHidden:['fecha_mod','usr_reg','usr_mod','descripcion','usuario_ai','estado_reg'],

	 onButtonNew:function(){


            Phx.vista.ObsFuncionario.superclass.onButtonNew.call(this);
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
            Phx.vista.ObsFuncionario.superclass.onButtonEdit.call(this);
            this.Cmp.id_funcionario_resp.disable()



    },

     loadCheckDocumentosSol:function() {
            var rec=this.sm.getSelected();
            Phx.CP.loadWindows(
            	     '../../../sis_workflow/vista/documento_wf/DocumentoWf.php',
                    'Documentos del trámite '+rec.data.nro_tramite,
                    {
                        width:'90%',
                        height:500

                    },
                    rec.data,
                    this.idContenedor,
                    'DocumentoWf');
    },

    diagramGantt:function(){

		  Phx.CP.loadingShow();
            var data = this.sm.getSelected().data.id_proceso_wf;
            Ext.Ajax.request({
                url:'../../sis_workflow/control/ProcesoWf/diagramaGanttTramite',
                params:{'id_proceso_wf':data},
                success:this.successExport,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });
     },
     preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;

        Phx.vista.ObsFuncionario.superclass.preparaMenu.call(this,n);
        //this.getBoton('btnChequeoDocumentos').enable();
        //this.getBoton('diagrama_gantt').enable();
        this.getBoton('btnCerrar').enable();
        return tb
     },
     liberaMenu:function(){
        var tb = Phx.vista.ObsFuncionario.superclass.liberaMenu.call(this);
        //this.getBoton('btnChequeoDocumentos').disable();
        //this.getBoton('diagrama_gantt').disable();
        this.getBoton('btnCerrar').disable();
        return tb
    },


    cerrarObs: function(){
	    //Phx.CP.loadingShow();

		var d = this.sm.getSelected().data;

		if(d.id_usuario_reg == d.usr_actual){
			Ext.Ajax.request({
				url:'../../sis_workflow/control/Obs/cerrarObs',
				params: { id_obs: d.id_obs },
				success: function (resp) {
					Phx.CP.loadingHide();
					var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
					if(!reg.ROOT.error){
						this.reload();
					}
				},
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope: this
			});
			Phx.CP.getPagina(this.idContenedorPadre).reload();
		}else{
			Phx.CP.loadWindows('../../../sis_workflow/vista/obs/correoObs.php',
				'Observaciones de Solicitudes',
				{
					width: '55%',
					height: '75%'
				}, d,
				this.idContenedor,
				'correoObs'
			);
		}


	},

	sortInfo:{
		field: 'id_obs',
		direction: 'ASC'
	},
	bedit: false,
	bnew:  true,
	bdel:  false,
	bsave: false,
	btest: false
	}
)
</script>

