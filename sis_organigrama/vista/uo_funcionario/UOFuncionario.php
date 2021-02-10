<?php
/**
*@package pXP
*@file UOFuncionario.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para asociar los funcionarios a su correspondiente Unidad Organizacional
 *    HISTORIAL DE MODIFICACIONES:

 ISSUE            FECHA:              AUTOR                 DESCRIPCION

#0             17/10/2014          JRR KPLIAN            creacion
#32 ETR        18/07/2019          RAC KPLIAN            adcionar carga horaria
#80            06/11/2019          APS                   ORDENACION/LISTADO DE FUNCIONARIOS POR APELLIDO.
#81			   08.11.2019          MZM-KPLIAN		     Adicion de campo prioridad
#94            12/12/2019          APS                   Filtro de funcionarios por gestion y periodo
#107           16/01/2020          JUAN                  Quitar filtro gestión y periodo del organigrama, los filtro ponerlos en el detalles
#136 ETR	   21.04.2020		   MZM-KPLIAN		     Adicion de campo separar_contrato
#147 ETR       12.06.2020          RAC-KPLIAN            Agregar motivo de rescisión en las finalización de contrato
#ETR-1889	   20.11.2020		   MZM-KPLIAN
#ETR-2476      04.01.2021		   MZM-KPLIAN			 Adicion de motivo de finalizacion "incremento salarial", este no debe considerarse como movimiento de personal, pero si el cambio de cargo aunq no haya cambio de dependencia
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    var v_id_gestion=0; //#107
    var v_id_periodo=0; //#107
Phx.vista.uo_funcionario=Ext.extend(Phx.gridInterfaz,{
    Atributos:[
		{
			// configuracion del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_uo_funcionario'

			},
			type:'Field',
			form:true
		},

		{	config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_uo'
			},
			type:'Field',
			form:true
		},

		 {
			config:{
				fieldLabel: "Codigo",
				gwidth: 130,
				name: 'codigo',
				allowBlank:false,
				maxLength:150,
				minLength:5,
				anchor:'100%'
			},
			type:'TextField',
			filters:{pfiltro:'FUNCIO.codigo',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},

		{
			config:{
				name: 'tipo',
				fieldLabel: 'Tipo Asignación',
				allowBlank: false,
				emptyText:'Tipo...',
	       		typeAhead: true,
	       		triggerAction: 'all',
	       		lazyRender:true,
	       		mode: 'local',
				gwidth: 100,
				store:['oficial','funcional']
			},
				type:'ComboBox',
				filters:{
	       		         type: 'list',
	       				 options: ['oficial','funcional'],
	       		 	},
				id_grupo:1,
				grid:true,
				form:true
		},

		{
			config:{
				fieldLabel: "Fecha Asignacion",
				name: 'fecha_asignacion',
	   			allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				format: 'd/m/Y',
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			   },
			type:'DateField',
			filters:{pfiltro:'UOFUNC.fecha_asignacion',
					type:'date'
					},
			grid:true,
			form:true
		},

		  {
   			config:{
       		    name:'id_funcionario',
   				origen:'FUNCIONARIO',
   				gwidth: 300,
   				fieldLabel:'Funcionario',
   				allowBlank:false,
   				tinit:true,
   				valueField: 'id_funcionario',
   			    gdisplayField: 'desc_funcionario2',         //#80
      			renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario2']);} //#80
       	     },
   			type:'ComboRec',//ComboRec
   			id_grupo:0,
   			filters:{pfiltro:'funcio.desc_funcionario2',    //#80
				type:'string'
			},

   			grid:true,
   			form:true
   	      },

   	      {
			config: {
				name: 'id_cargo',
				fieldLabel: 'Cargo a Asignar',
				allowBlank: false,
				tinit:true,
   			    resizable:true,
   			    tasignacion:true,
   			    tname:'id_cargo',
		        tdisplayField:'nombre',
   				turl:'../../../sis_organigrama/vista/cargo/Cargo.php',
	   			ttitle:'Cargos',
	   			tconfig:{width:'80%',height:'90%'},
	   			tdata:{},
	   			tcls:'Cargo',
	   			pid:this.idContenedor,
				emptyText: 'Cargo...',
				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/Cargo/listarCargo',
					id: 'id_cargo',
					root: 'datos',
					sortInfo: {
						field: 'codigo',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_cargo', 'nombre', 'codigo','tipo_contrato','identificador','codigo_tipo_contrato'],
					remoteSort: true,
					baseParams: {par_filtro: 'cargo.nombre#cargo.codigo'}
				}),
				valueField: 'id_cargo',
				displayField: 'nombre',
				gdisplayField: 'desc_cargo',
				hiddenName: 'id_cargo',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 120,
				minChars: 2,
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Id: {identificador}--{codigo_tipo_contrato}</p><p>{codigo}</p><p>{nombre}</p> </div></tpl>',
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_cargo']);
				}
			},
			type: 'TrigguerCombo',
			id_grupo: 0,
			filters: {pfiltro: 'cargo.nombre#cargo.codigo#cargo.id_cargo',type: 'string'},
			grid: true,
			form: true
		},

		{
			config:{
				name: 'nro_documento_asignacion',
				fieldLabel: 'No Doc. Asignación',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
				type:'TextField',
				filters:{pfiltro:'UOFUNC.nro_documento_asignacion',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},

		{
		config:{
			fieldLabel: "Fecha Doc. Asignación",
			name: 'fecha_documento_asignacion',
   		    allowBlank: false,
			anchor: '80%',
			gwidth: 100,
			format: 'd/m/Y',
			renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
		},
		type:'DateField',
		filters:{pfiltro:'UOFUNC.fecha_documento_asignacion',
				type:'date'
				},
		grid:true,
		form:true
	},

       	{
			config:{
				fieldLabel: "CI",
				gwidth: 130,
				name: 'ci',
				allowBlank:false,
				maxLength:150,
				minLength:5,
				anchor:'100%'
			},
			type:'TextField',
			filters:{pfiltro:'FUNCIO.ci',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},

		{
		config:{
			fieldLabel: "Fecha Finalizacion",
			name: 'fecha_finalizacion',
   		    allowBlank: true,
			anchor: '80%',
			gwidth: 100,
			format: 'd/m/Y',
			renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
		},
		type:'DateField',
		filters:{pfiltro:'UOFUNC.fecha_finalizacion',
				type:'date'
				},
		grid:true,

		form:true
	},

	{
		config:{
			name: 'observaciones_finalizacion',
			fieldLabel: 'Motivo Finalización',
			allowBlank: false,
			emptyText:'Motivo...',
       		typeAhead: true,
       		triggerAction: 'all',
       		lazyRender:true,
       		mode: 'local',
			gwidth: 100,
			store:[['fin contrato','Conclusión contrato'],['retiro','Despido'],['renuncia','Renuncia'],['promocion','Promoción'],['transferencia','Transferencia'],['rescision','Rescisión contrato'],['licencia','Licencia'],['incremento_salarial','Incremento Salarial']] //ETR-1889   ETR-2476
			,renderer : function(value, p, record) { 
				switch (value){
				    case 'fin contrato':return 'Conclusión contrato';
				       break;
				    case 'retiro':return 'Despido';
				      break;
				    case 'renuncia':return 'Renuncia';
				      break;
				    case 'promocion':return 'Promoción';
				      break;
				    case 'transferencia':return 'Transferencia';
				      break;
				    case 'rescision':return 'Rescisión contrato';
				      break;
				    case 'licencia':return 'Licencia';
				      break;
				    case 'incremento_salarial':return 'Incremento salarial';
				      break;
				    
				    default:return '';
				      // default statements
				}
					
			}
		},
			type:'ComboBox',
			filters:{
       		         type: 'list',
       				 options: ['fin contrato','retiro','renuncia','promocion','transferencia','rescision','licencia','incremento_salarial'], //ETR-1889  ETR-2476
       		 	},
			id_grupo:1,
			
			grid:true,
			form:true
	},
	{
		config:{
			name: 'carga_horaria',
			fieldLabel: 'Carga Horaria Mensual',
			allowBlank: false,
			emptyText:'...',
       		typeAhead: true,
       		triggerAction: 'all',
       		lazyRender:true,
       		mode: 'local',
			gwidth: 100,
			store:['240','120']
		},
			type:'ComboBox',
			filters:{
       		         type: 'list',
       				 options: ['240','120'],
       		},
       		valorInicial: '240',
			id_grupo:1,
			grid:true,
			form:true
	},


	{
		config:{
			name:'estado_reg',
			fieldLabel:'Estado',
			gwidth:115,

		},
		type:'ComboBox',
		grid:true,
		form:false,
        grid:true
	},
	{ //#81
			config:{
				name: 'prioridad',
				fieldLabel: 'Prioridad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
				type:'NumberField',

				grid:true,
				form:true
	},
		{
		config:{
			name: 'separar_contrato',
			fieldLabel: 'Separar Contrato',
			allowBlank: false,
			emptyText:'Si existe continuidad con contrato previo, pero es necesario establecer como inicio para determinar primer contrato al cambio de ODT/planta o variacion de carga horaria',
       		typeAhead: true,
       		triggerAction: 'all',
       		lazyRender:true,
       		mode: 'local',
			gwidth: 100,
			store:['no','si']
		},
			type:'ComboBox',
			filters:{
       		         type: 'list',
       				 options: ['no','si'],
       		},
       		valorInicial: 'no',
			id_grupo:1,
			grid:true,
			form:true
	}
    ],



	title:'Asignar Cargo',
	fheight:350,
	fwidth:450,
	ActSave:'../../sis_organigrama/control/UoFuncionario/GuardarUoFuncionario',
	ActDel:'../../sis_organigrama/control/UoFuncionario/EliminarUoFuncionario',
	ActList:'../../sis_organigrama/control/UoFuncionario/ListarUoFuncionario',
	id_store:'id_uo_funcionario',
	fields: ['id_uo_funcionario',
             'id_uo',
             'id_funcionario',
             'codigo',
             'ci',
             'id_cargo',
             'desc_cargo',
             'observaciones_finalizacion',
             'nro_documento_asignacion',
             {name:'fecha_documento_asignacion', type: 'date',dateFormat:'Y-m-d'},
             'tipo',
             'desc_funcionario1',
             'desc_person',
             'num_doc',
             {name:'fecha_asignacion', type: 'date',dateFormat:'Y-m-d'},
             'estado_reg',
             {name:'fecha_finalizacion', type: 'date',dateFormat:'Y-m-d'},
             'fecha_reg',
             'fecha_mod','prioridad',//#81
             'USUREG',
             'USUMOD','correspondencia','carga_horaria', 'desc_funcionario2'//#80
             ,'separar_contrato'//#136
             ],

	sortInfo:{
		field: 'desc_funcionario2', //#80
		direction: 'ASC',
	},
	onButtonNew:function(){
		this.Cmp.id_funcionario.store.setBaseParam('tipo','oficial');
			this.Cmp.id_cargo.store.setBaseParam('tipo','oficial');
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		this.mostrarComponente(this.Cmp.id_cargo);
		this.mostrarComponente(this.Cmp.id_funcionario);
		this.mostrarComponente(this.Cmp.fecha_asignacion);
		this.mostrarComponente(this.Cmp.tipo);
		this.ocultarComponente(this.Cmp.fecha_finalizacion);
		this.ocultarComponente(this.Cmp.observaciones_finalizacion);
		this.mostrarComponente(this.Cmp.separar_contrato);//#136
		Phx.vista.uo_funcionario.superclass.onButtonNew.call(this);
		//seteamos un valor fijo que vienen de la vista maestro para id_gui

	},onButtonEdit:function(){ 
		
		
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		this.ocultarComponente(this.Cmp.id_cargo);
		this.ocultarComponente(this.Cmp.id_funcionario);
		this.ocultarComponente(this.Cmp.fecha_asignacion);
		this.ocultarComponente(this.Cmp.tipo);
		this.mostrarComponente(this.Cmp.fecha_finalizacion);
		this.mostrarComponente(this.Cmp.separar_contrato);//#136
		this.getComponente('fecha_finalizacion').visible=true;
		Phx.vista.uo_funcionario.superclass.onButtonEdit.call(this);

		if (this.Cmp.fecha_finalizacion.getValue() == '' || this.Cmp.fecha_finalizacion.getValue() == undefined) {

			this.Cmp.observaciones_finalizacion.reset();
			this.Cmp.observaciones_finalizacion.allowBlank = true;
			this.ocultarComponente(this.Cmp.observaciones_finalizacion);

			this.Cmp.fecha_finalizacion.reset();
			this.Cmp.fecha_finalizacion.allowBlank = true;
			//this.ocultarComponente(this.Cmp.fecha_finalizacion);

		} else {

			this.Cmp.observaciones_finalizacion.allowBlank = false;
			this.mostrarComponente(this.Cmp.observaciones_finalizacion);


		}
	},

	/*funcion corre cuando el padre cambia el nodo maestero*/
	onReloadPage:function(m){
		this.maestro=m;
        //console.log('--->',this.maestro.gestion,this.maestro.periodo);


		this.Atributos[1].valorInicial=this.maestro.id_uo;
		this.Cmp.id_cargo.tdata.id_uo = this.maestro.id_uo;
		this.Cmp.id_funcionario.tdata.id_uo = this.maestro.id_uo;
		this.Cmp.id_cargo.store.setBaseParam('id_uo',this.maestro.id_uo);
		this.Cmp.id_funcionario.store.setBaseParam('id_uo',this.maestro.id_uo);
        /*var x =this.maestro.gestion;                                                        //#94
        var y = null;                                                                       //#94
        if (this.maestro.periodo != undefined ){                                           //#94
            y = this.maestro.periodo;                                                       //#94
        }else{
            y =this.maestro.loader.baseParams.id_periodo;                                   //#94
        }*/

       if(m.id !== 'id'){
           /* if (Number(this.maestro.id_uo) != 0){                                           //#94
                console.log(x,y);  			//// REVISAR OJO                                //#94
                if (x == 0 && y != 0){                                                      //#94
                    alert('Seleccione la getion');                                          //#94
                }else{                                                                      //#94
                    this.store.baseParams={id_uo:this.maestro.id_uo,gestion:x,periodo:y};   //#94
                    this.load({params:{start:0, limit:50}})                                 //#94
                }                                                                           //#94

            }*/

       }
       else{
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable();
   		 this.store.removeAll();
       }

        this.store.baseParams={id_uo:this.maestro.id_uo,gestion:v_id_gestion,periodo:v_id_periodo};   //#107
        this.load({params:{start:0, limit:50}})

    },
	loadValoresIniciales:function()
    {
        this.Cmp.tipo.setValue('oficial');
        this.Cmp.tipo.fireEvent('select',this.Cmp.tipo);
        Phx.vista.uo_funcionario.superclass.loadValoresIniciales.call(this);
    },
	iniciarEventos : function () {

		this.Cmp.id_cargo.on('focus',function () {
			if (this.Cmp.fecha_asignacion.getValue() == '' || this.Cmp.fecha_asignacion.getValue() == undefined) {
				alert('Debe seleccionar la fecha de asignación');
				return false;
			} else {
				return true;
			}
		},this);

		this.Cmp.id_funcionario.on('focus',function () {
			if (this.Cmp.fecha_asignacion.getValue() == '' || this.Cmp.fecha_asignacion.getValue() == undefined) {
				alert('Debe seleccionar la fecha de asignación');
				return false;
			} else {
				return true;
			}
		},this);

		this.Cmp.tipo.on('select', function () {
			//Agregar al base params de funcionario y cargo
			this.Cmp.id_funcionario.store.setBaseParam('tipo',this.Cmp.tipo.getValue());
			this.Cmp.id_cargo.store.setBaseParam('tipo',this.Cmp.tipo.getValue());
			this.Cmp.id_cargo.tdata.tipo = this.Cmp.tipo.getValue();
			this.Cmp.id_funcionario.tdata.tipo = this.Cmp.tipo.getValue();

		},this);

		this.Cmp.fecha_finalizacion.on('blur', function () {
			//Habilitar y obligar a llenar observaciones de finalizacion si la fecha no es null
			if (this.Cmp.fecha_finalizacion.getValue() == '' || this.Cmp.fecha_finalizacion.getValue() == undefined) {
				this.Cmp.observaciones_finalizacion.reset();
				this.Cmp.observaciones_finalizacion.allowBlank = true;
				this.ocultarComponente(this.Cmp.observaciones_finalizacion);
			} else {
				this.Cmp.observaciones_finalizacion.allowBlank = false;
				this.mostrarComponente(this.Cmp.observaciones_finalizacion);
			}

		},this);

		this.Cmp.fecha_asignacion.on('blur', function () {
			this.Cmp.id_cargo.store.setBaseParam('fecha',this.Cmp.fecha_asignacion.getValue().dateFormat('d/m/Y'));
			this.Cmp.id_funcionario.store.setBaseParam('fecha',this.Cmp.fecha_asignacion.getValue().dateFormat('d/m/Y'));
			this.Cmp.id_cargo.tdata.fecha = this.Cmp.fecha_asignacion.getValue().dateFormat('d/m/Y');
			this.Cmp.id_funcionario.tdata.fecha = this.Cmp.fecha_asignacion.getValue().dateFormat('d/m/Y');
			this.Cmp.id_funcionario.modificado = true;
			this.Cmp.id_cargo.modificado = true;
			this.Cmp.separar_contrato.modificado = true;//#136
		},this);

		this.Cmp.id_cargo.on('select', function (c,r,i) {
			if (r.data) {
				var data = r.data;
			} else {
				var data = r;
			}
			//Mostrar fecha de finalizacion y obligar a llenar si no es de planta si es limpiar fecha_finalizacion, ocultar y habilitar null
			if(data.codigo_tipo_contrato == 'PLA') {
				this.Cmp.fecha_finalizacion.reset();
				this.Cmp.fecha_finalizacion.allowBlank = true;
				this.ocultarComponente(this.Cmp.fecha_finalizacion);
			} else {
				this.Cmp.fecha_finalizacion.allowBlank = false;
				this.mostrarComponente(this.Cmp.fecha_finalizacion);
			}

		},this);

        this.cmbPeriodo.setValue("Todos");//#107
        this.cmbPeriodo.fireEvent('select', 0);//#107

        this.cmbGestion.setValue("Todos");//#107
        this.cmbGestion.fireEvent('select', 0);//#107

        this.cmbGestion.on('select', function (cmb, dat) {//#107
            if(dat){
                v_id_gestion = dat.data.id_gestion;

            }else{
                v_id_gestion = 0;
            }
            v_id_periodo= 0;
            this.cmbPeriodo.reset();
            this.cmbPeriodo.store.baseParams = Ext.apply(this.cmbPeriodo.store.baseParams, {id_gestion: v_id_gestion});
            this.cmbPeriodo.modificado = true;

            this.cmbPeriodo.setValue('Todos');

            this.store.baseParams={id_uo:this.maestro.id_uo,gestion:v_id_gestion,periodo:v_id_periodo};   //#94
            this.load({params:{start:0, limit:50}})

        }, this);
        this.cmbPeriodo.on('select', function (cmb, dat) {//#107

            if(dat){
                v_id_periodo = dat.data.id_periodo;

            }else{
                v_id_periodo = 0;
            }

            this.store.baseParams={id_uo:this.maestro.id_uo,gestion:v_id_gestion,periodo:v_id_periodo};   //#94
            this.load({params:{start:0, limit:50}})

        }, this);


    },

	constructor: function(config){
		// configuracion del data store
		this.maestro=config.maestro;

        this.initButtons = [this.cmbGestion,this.cmbPeriodo];//#107

		//this.Atributos[1].valorInicial=this.maestro.id_gui;
		Phx.vista.uo_funcionario.superclass.constructor.call(this,config);
		txt_fecha_fin=this.getComponente('fecha_finalizacion');
		this.init();
		this.iniciarEventos();
		//deshabilita botones
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
        //console.log('maestra',this.maestro);

        this.cmbPeriodo.store.baseParams = Ext.apply(this.cmbPeriodo.store.baseParams, {id_gestion: 0});//#107
        this.cmbPeriodo.modificado = true;//#107



	},

	bdel:true,// boton para eliminar
	bsave:false,// boton para eliminar
	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.uo_funcionario.superclass.preparaMenu.call(this,tb);
	},
    cmbGestion: new Ext.form.ComboBox({ //#107
        fieldLabel: 'Gestion',
        allowBlank: true,
        emptyText: 'Gestion...',
        store: new Ext.data.JsonStore(
            {
                url: '../../sis_parametros/control/Gestion/listarGestionTodos',
                id: 'id_gestion',
                root: 'datos',
                sortInfo: {
                    field: 'gestion',
                    direction: 'DESC'
                },
                totalProperty: 'total',
                fields: ['id_gestion', 'gestion'],
                // turn on remote sorting
                remoteSort: true,
                baseParams: {par_filtro: 'gestion', _adicionar : 'si'}
            }),
        valueField: 'id_gestion',
        triggerAction: 'all',
        displayField: 'gestion',
        hiddenName: 'id_gestion',
        mode: 'remote',
        pageSize: 50,
        queryDelay: 500,
        listWidth: '280',
        width: 80,
        editable:false
    }),
    cmbPeriodo: new Ext.form.ComboBox({ //#107
        fieldLabel: 'Periodo',
        allowBlank: false,
        blankText : 'Mes',
        emptyText:'Periodo...',
        store:new Ext.data.JsonStore(
            {
                url: '../../sis_parametros/control/Periodo/listarPeriodoTodos',
                id: 'id_periodo',
                root: 'datos',
                sortInfo:{
                    field: 'periodo',
                    direction: 'ASC'
                },
                totalProperty: 'total',
                fields: ['id_periodo','periodo','id_gestion','literal'],
                // turn on remote sorting
                remoteSort: true,
                baseParams:{par_filtro:'gestion', _adicionar : 'si'}
            }),
        valueField: 'periodo',
        triggerAction: 'all',
        displayField: 'literal',
        hiddenName: 'id_periodo',
        mode:'remote',
        pageSize:50,
        disabled: true,
        queryDelay:500,
        listWidth:'280',
        width:80,
        editable:false
    })


  }
)
</script>