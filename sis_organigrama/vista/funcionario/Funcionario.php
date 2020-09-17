<?php
/**
*@package pXP
*@file Funcionario.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para registrar los datos de un funcionario
 * 
    HISTORIAL DE MODIFICACIONES:
       
 ISSUE            FECHA:              AUTOR                 DESCRIPCION  
  #0            14-02-2011        RAC                 Creacion
  #24           17/06/2019        RAC                 Configuracion de palntillas de grilla
  #31           16/07/2019        RAC                 Adciona codigo rcaiva, profesion y fecha quinquenio
  #51           20/08/2019        RAC                 solucion de bug al seleccionar funcionario
  #60   ETR     10/09/2019        MMV              	  Histórico código de empleado
  #89	ETR		04.12.2019		  MZM				  Habilitacion de catalogo profesiones en funcionario
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.funcionario=function(config){



	this.Atributos=[
	       	{
	       		// configuracion del componente
	       		config:{
	       			labelSeparator:'',
	       			inputType:'hidden',
	       			name: 'id_funcionario'
	       		}, 
	       		type:'Field',
	       		form:true  
	       		
	       	},

	    	{
	   			config:{
	       		    name:'id_persona',
	   				origen:'PERSONA',
	   				tinit:true,
	   				fieldLabel:'Nombre funcionario',
	   				gdisplayField:'desc_person',//mapea al store del grid
	   				anchor: '100%',
	   			    gwidth:200,
		   			 renderer:function (value, p, record){return String.format('{0}', record.data['desc_person']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			bottom_filter : true,
	   			filters:{	
			        pfiltro:'PERSON.nombre_completo2',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
			},

	       	{
	       		config:{
	       			fieldLabel: "Código",
	       			gwidth: 120,
	       			name: 'codigo',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{pfiltro:'FUNCIO.codigo',type:'string'},
	       		bottom_filter : true,
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
	       	{
	       		config:{
	       			name:'estado_civil',
	       			fieldLabel:'Estado Civil',
	       			allowBlank:true,
	       			emptyText:'Estado...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    store:['soltero','casado','divorciado','viudo']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['soltero','casado','divorciado','viudo']
	       		 	},
	       		grid:true,	       		
	       		form:true
	       	},
	       	
	       	{
	       		config:{
	       			name:'genero',
	       			fieldLabel:'Genero',
	       			allowBlank:true,
	       			emptyText:'Genero...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    store:['masculino','femenino']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['masculino','femenino']
	       		 	},
	       		grid:true,       		
	       		form:true
	       	},
	       	
	       	{
	       		config:{
	       			fieldLabel: "Fecha de Nacimiento",
	       			gwidth: 120,
	       			name: 'fecha_nacimiento',
	       			allowBlank:false,	
	       			maxLength:100,
	       			minLength:1,
	       			format:'d/m/Y',
	       			anchor:'100%',
	       			renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
				},
	       		type:'DateField',
	       		filters:{type:'date'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
	       	{
			config:{
				name: 'id_lugar',
				fieldLabel: 'Lugar Nacimiento',
				allowBlank: false,
				emptyText:'Lugar...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_parametros/control/Lugar/listarLugar',
					id: 'id_lugar',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_lugar','id_lugar_fk','codigo','nombre','tipo','sw_municipio','sw_impuesto','codigo_largo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'lug.nombre',es_regional:'si'}
				}),
				valueField: 'id_lugar',
				displayField: 'nombre',
				gdisplayField:'nombre_lugar',
				hiddenName: 'id_lugar',
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				anchor:"100%",
				gwidth:150,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_lugar']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'lug.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
			{
	       		config:{
	       			fieldLabel: "Nacionalidad",
	       			gwidth: 120,
	       			name: 'nacionalidad',
	       			allowBlank:false,	
	       			maxLength:200,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		bottom_filter : true,
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
		{
	       		config:{
	       			name:'discapacitado',
	       			fieldLabel:'Discapacitado',
	       			allowBlank:false,
	       			emptyText:'Discapacitado...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',	       		    
	       		    store:['no','si']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options:['no','si']
	       		 	},
	       		grid:true,       		
	       		form:true
	       	},
	       	
	       	{
	       		config:{
	       			fieldLabel: "Carnet Discapacitado",
	       			gwidth: 120,
	       			name: 'carnet_discapacitado',
	       			allowBlank:true,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%',
					hidden:true
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		bottom_filter : true,
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
	       	{
	       		config:{
	       			fieldLabel: "CI",
	       			gwidth: 120,
	       			name: 'ci',
	       			allowBlank:false,	
	       			maxLength:20,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{pfiltro:'PERSON.ci',
	       				type:'string'},
	       		id_grupo:0,
	       		bottom_filter : true,
	       		grid:true,
	       		form:false
	       	},
	       	
	       	{
	       		config:{
	       			fieldLabel: "Antiguedad Anterior (meses)",
	       			gwidth: 120,
	       			name: 'antiguedad_anterior',
	       			allowBlank:true,	
	       			maxLength:4,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'NumberField',
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
	       	{	
	       		config:{
	       			fieldLabel: "Correo Empresarial",
	       			gwidth: 120,
	       			name: 'email_empresa',
	       			allowBlank:true,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		bottom_filter : true,
	       		grid:true,
	       		form:true
	       	},
	       	{
	       		config:{
	       			name: 'telefono_ofi',
	       			fieldLabel: "Telf. Oficina",
	       			gwidth: 120,
	       			allowBlank:true,	
	       			maxLength:50,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
	       	{
	       		config:{
	       			fieldLabel: "Interno",
	       			gwidth: 120,
	       			name: 'interno',
	       			allowBlank:true,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	       	},
	       		{
	       		config:{
	       			fieldLabel: "Teléfono Domicilio",
	       			gwidth: 120,
	       			name: 'telefono1',
	       			allowBlank:true,	
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'NumberField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:true,
	       		form:false
	       	},
	       		{
	       		config:{
	       			fieldLabel: "Celular",
	       			gwidth: 120,
	       			name: 'celular1',
	       			allowBlank:true,	
	       			
	       			maxLength:100,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'NumberField',
	       		filters:{type:'string'},
	       		id_grupo:0,
	       		grid:true,
	       		form:false
	       	},
	       	{
	       		config:{
	       			fieldLabel: "Correo",
	       			gwidth: 120,
	       			name: 'correo',
	       			allowBlank:true,	
	       			vtype:'email',	
	       			maxLength:50,
	       			minLength:1,
	       			anchor:'100%'
	       		},
	       		type:'TextField',
	       		filters:{
	       			pfiltro: 'person.correo',
	       			type:'string'
	       			},
	       		id_grupo:0,
	       		bottom_filter : true,
	       		grid:true,
	       		form:false
	       	},
	       	{
				config:{
					name: 'fecha_reg',
					fieldLabel: 'Fecha creación',
					allowBlank: true,
					anchor: '80%',
					gwidth: 100,
					format:'d/m/Y',
					renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				},
				type:'DateField',				
				filters:{pfiltro:'ins.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
			},
			{
	       		config:{
	       			name:'estado_reg',
	       			fieldLabel:'Estado',
	       			allowBlank:false,
	       			emptyText:'Estado...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'estado_reg',
	       		   // displayField: 'descestilo',
	       		    store:['activo','inactivo']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       		         pfiltro:'FUNCIO.estado_reg',
	       				 dataIndex: 'size',
	       				 options: ['activo','inactivo'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
			{
				config:{
					name: 'id_biometrico',
					fieldLabel: 'ID Biométrico',
					allowBlank: true,
					anchor: '100%',
					disabled: true,
					style: 'color: blue; background-color: yellow;',
					gwidth: 100,
					maxLength:15
				},
				type:'NumberField',
				filters:{pfiltro:'FUNCIO.id_biometrico',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
			},
			{//#89 //#156
                config : {
                    name:'codigo_profesion',
                    qtip:'Profesion',
                    fieldLabel : 'Profesion:',
                    resizable:true,
                    allowBlank:true,
                    emptyText:'Seleccione un catálogo...',
                    store: new Ext.data.JsonStore({
                        url: '../../sis_parametros/control/Catalogo/listarCatalogoCombo',
                        id: 'id_catalogo',
                        root: 'datos',
                        sortInfo:{
                            field: 'orden',
                            direction: 'ASC'
                        },
                        totalProperty: 'total',
                        fields: ['id_catalogo','codigo','descripcion'],
                        // turn on remote sorting
                        remoteSort: true,
                        baseParams: {par_filtro:'descripcion',cod_subsistema:'ORGA',catalogo_tipo:'tfuncionario_profesion'}
                    }),
                    enableMultiSelect:true,
                    valueField:'codigo',
                    displayField: 'descripcion',
                    gdisplayField:'profesion',
                    hiddenName: 'codigo_profesion',
                    forceSelection:true,
                    typeAhead: false,
                    triggerAction: 'all',
                    lazyRender:true,
                    mode:'remote',
                    queryDelay:1000,
                    width:180,
                    minChars:2,
                    anchor:"100%",
                    pageSize:150,
					gwidth:150,
					renderer:function(value, p, record){return String.format('{0}', record.data['profesion']);}
                },
                type:'ComboBox',
                filters:{pfiltro:'funcio.profesion',type:'string'},
                id_grupo:0,
                grid:true,
                form:true
            },
			
			
			
			{//#31
				config:{
					name: 'codigo_rciva',
					fieldLabel: 'Codigo RC-IVA',
					qtip:'Codigo para la acumulación de RC-IVA',
					allowBlank: true,
					anchor: '100%',
					gwidth: 100,
					maxLength:50
				},
				type:'TextField',
				filters:{pfiltro:'FUNCIO.codigo_rciva',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
			},
	       	
	       	{//#31
	       		config:{
	       			fieldLabel: "Fecha Quinquenio",
	       			qtip:'Fecha del último quinquenio pagado',
	       			gwidth: 120,
	       			name: 'fecha_quinquenio', 
	       			allowBlank:true,	
	       			maxLength:100,
	       			minLength:1,
	       			format:'d/m/Y',
	       			anchor:'100%',
	       			renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
				},
	       		type:'DateField',
	       		filters:{type:'date'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
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
				type:'TextField',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
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
					renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				},
				type:'DateField',
				filters:{pfiltro:'ins.fecha_mod',type:'date'},
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
				type:'TextField',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
			},
			{
   			config:{
	   				sysorigen:'sis_contabilidad',
	       		    name:'id_auxiliar',
	   				origen:'AUXILIAR',
	   				allowBlank:true,
	   				fieldLabel:'Auxiliar',
	   				gdisplayField:'desc_auxiliar',//mapea al store del grid
	   				gwidth:200,
	   				width: 380,
	   				listWidth: 380,
	   				//anchor: '80%',
		   			renderer:function (value, p, record){return String.format('{0}', record.data['desc_auxiliar']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'au.codigo_auxiliar#au.nombre_auxiliar',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
		   	},
		       	
	       	
	       	];
	       	
	Phx.vista.funcionario.superclass.constructor.call(this,config);
	this.addButton('btnCuenta',
        {
            text: 'Cuenta Bancaria',
            iconCls: 'blist',
            disabled: true,
            handler: this.onBtnCuenta,
            tooltip: 'Cuenta Bancaria del Empleado'
        });
        
    this.addButton('btnFunEspecialidad',
        {
            text: 'Especialidad',
            iconCls: 'blist',
            disabled: true,
            handler: this.onBtnFunEspe,
            tooltip: 'Especialidad del Empleado'
        });


	this.addButton('archivo', {
		text: 'Archivos Func.',
		iconCls: 'bfolder',
		disabled: false,
		handler: this.archivo,
		tooltip: '<b>Archivos Funcionario</b><br><b>Nos permite visualizar los archivos de un funcionario.</b>'
	});
//#41 (I)
     this.addButton('btnDependientes',
        {
            text: 'Dependientes',
            iconCls: 'bcargo',
            disabled: false,
            handler: this.onBtnDependientes,
            tooltip: 'Dependientes del Empleado'
        });   //#41 (F)
    //#60(I)
    this.addButton('btnCodigoFuncionario',
        {
            text: 'Codigos Funcionario',
            iconCls: 'bfolder',
            disabled: false,
            handler: this.onBtnCodigoFuncionario,
            tooltip: 'Historico codigo funcionario'
        });   //#60 (F)
	this.init();

	//f.e.a(eventos recientes)
	//begin
	this.getComponente('genero').on('select',function (combo, record, index ) {
		if(combo.value == 'masculino'){
			this.getComponente('nacionalidad').setValue('BOLIVIANO');
		}else{
			this.getComponente('nacionalidad').setValue('BOLIVIANA');
		}
	}, this);

	this.getComponente('fecha_nacimiento').on('beforerender',function (combo) {
		var fecha_actual = new Date();
		fecha_actual.setMonth(fecha_actual.getMonth() - 216);
		this.getComponente('fecha_nacimiento').setMaxValue(fecha_actual);
	}, this);

	this.getComponente('discapacitado').on('select',function (combo, record, index ) {
		if(combo.value == 'si'){
			this.getComponente('carnet_discapacitado').setVisible(true);
		}else{
			this.getComponente('carnet_discapacitado').setVisible(false);
		}
	}, this);
	//end
	
	this.getComponente('id_persona').on('select',onPersona, this);

    //#51 soluciona  BUG
	function onPersona(c,r,e){		
		if(this.Cmp.ci){
			this.Cmp.ci.setValue(r.data.ci);
		}
		if(this.Cmp.correo){
			this.Cmp.correo.setValue(r.data.correo);
		}
		if(this.Cmp.telefono){
			this.Cmp.telefono.setValue(r.data.telefono);
		}
	}
	if (config.fecha) {
        this.store.baseParams.fecha = config.fecha;
    } 
    if (config.tipo) {
        this.store.baseParams.tipo = config.tipo;
    } 
    
    if (config.id_uo) {
        this.store.baseParams.id_uo = config.id_uo;
    }   
	this.load({params:{start:0, limit:50}});	
	
}

Ext.extend(Phx.vista.funcionario,Phx.gridInterfaz,{
	savePltGrid: true, //#24configura el manejo de plantilla para la grilla
    applyPltGrid: true, //#24
    bottom_filter: true,//#24
    tipoStore: 'GroupingStore',//GroupingStore o JsonStore #24
    remoteGroup: true,//#24
    groupField: 'nacionalidad',//#24
    viewGrid: new Ext.grid.GroupingView({
            forceFit:false,
            //groupTextTpl: '{text} ({[values.rs.length]} {[values.rs.length > 1 ? "Items" : "Item"]})'
        }), //#24
    
    
	title:'Funcionarios',
	ActSave:'../../sis_organigrama/control/Funcionario/guardarFuncionario',
	ActDel:'../../sis_organigrama/control/Funcionario/eliminarFuncionario',
	ActList:'../../sis_organigrama/control/Funcionario/listarFuncionario',
	id_store:'id_funcionario',
	fields: [
	{name:'id_funcionario'},
	{name:'id_persona'},
	{name:'id_lugar', type: 'numeric'},
	{name:'desc_person',type:'string'},
	{name:'genero',type:'string'},
	{name:'estado_civil',type:'string'},
	{name:'nombre_lugar',type:'string'},
	{name:'nacionalidad',type:'string'},
	{name:'discapacitado',type:'string'},
	{name:'carnet_discapacitado',type:'string'},
	{name:'codigo',type:'string'},
	{name:'antiguedad_anterior',type:'numeric'},

	{name:'estado_reg', type: 'string'},

	{name:'ci', type:'string'},
	{name:'documento', type:'string'},
	{name:'correo', type:'string'},
	{name:'celular1'},
	{name:'telefono1'},
	{name:'email_empresa'},
	'interno',
	{name:'fecha_ingreso', type: 'date', dateFormat:'Y-m-d'},
	{name:'fecha_nacimiento', type: 'date', dateFormat:'Y-m-d'},
	{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d'},
	{name:'id_usuario_reg', type: 'numeric'},
	{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d'},
	{name:'id_usuario_mod', type: 'numeric'},
	{name:'usr_reg', type: 'string'},
	{name:'usr_mod', type: 'string'},
	'telefono_ofi',
	'horario1',
	'horario2',
	'horario3',
	'horario4',
	'id_auxiliar',
	'desc_auxiliar',
	{name:'id_biometrico', type: 'numeric'},
	'profesion','codigo_rciva',
	{name:'fecha_quinquenio', type: 'date', dateFormat:'Y-m-d'},
	'codigo_profesion'
	],
	sortInfo:{
		field: 'PERSON.nombre_completo1',
		direction: 'ASC'
	},
	
	
	// para configurar el panel south para un hijo
	
	/*
	 * south:{
	 * url:'../../../sis_seguridad/vista/usuario_regional/usuario_regional.php',
	 * title:'Regional', width:150
	 *  },
	 */	
	bdel:true,
	bsave:false,
	fwidth: 500,
	fheight: 480,
	onBtnCuenta: function(){
			var rec = {maestro: this.sm.getSelected().data} 
						      
            Phx.CP.loadWindows('../../../sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php',
                    'Cuenta Bancaria del Empleado',
                    {
                        width:700,
                        height:450
                    },
                    rec,
                    this.idContenedor,
                    'FuncionarioCuentaBancaria');
	},
	
	onBtnFunEspe: function(){
			var rec = {maestro: this.sm.getSelected().data} 
						      
            Phx.CP.loadWindows('../../../sis_organigrama/vista/funcionario_especialidad/FuncionarioEspecialidad.php',
                    'Especialidad del Empleado',
                    {
                        width:700,
                        height:450
                    },
                    rec,
                    this.idContenedor,
                    'FuncionarioEspecialidad');
	},
	//#41 (I)
	onBtnDependientes: function(){
			var rec = {maestro: this.sm.getSelected().data} 
						      
            Phx.CP.loadWindows('../../../sis_seguridad/vista/persona_relacion/PersonaRelacion.php',
                    'Dependientes del Empleado',
                    {
                        width:700,
                        height:450
                    },
                    rec,
                    this.idContenedor,
                    'PersonaRelacion');
	},//#41 (F)
    // #60 (I)
	onBtnCodigoFuncionario: function(){
			var rec = {maestro: this.sm.getSelected().data} ;
            Phx.CP.loadWindows('../../../sis_organigrama/vista/codigo_funcionario/CodigoFuncionario.php',
                    'Codigos Funcionario',
                    {
                        width:700,
                        height:450
                    },
                    rec,
                    this.idContenedor,
                    'CodigoFuncionario');
	},//#60 (F)
		
	preparaMenu:function()
    {	
        this.getBoton('btnCuenta').enable();
        this.getBoton('btnFunEspecialidad').enable();      
        this.getBoton('archivo').enable();
        this.getBoton('btnCodigoFuncionario').enable();
        Phx.vista.funcionario.superclass.preparaMenu.call(this);
    },
    liberaMenu:function()
    {	
        this.getBoton('btnCuenta').disable();
        this.getBoton('btnFunEspecialidad').disable();       
        this.getBoton('archivo').disable();
        this.getBoton('btnCodigoFuncionario').disable();
        Phx.vista.funcionario.superclass.liberaMenu.call(this);
    },

    archivo: function () {


        var rec = this.getSelectedData();
		console.log(rec);
        //enviamos el id seleccionado para cual el archivo se deba subir
        rec.datos_extras_id = rec.id_funcionario;
        //enviamos el nombre de la tabla
        rec.datos_extras_tabla = 'orga.tfuncionario';
        //enviamos el codigo ya que una tabla puede tener varios archivos diferentes como ci,pasaporte,contrato,slider,fotos,etc
        rec.datos_extras_codigo = '';

        //esto es cuando queremos darle una ruta personalizada
        //rec.datos_extras_ruta_personalizada = './../../../uploaded_files/favioVideos/videos/';

        Phx.CP.loadWindows('../../../sis_parametros/vista/archivo/Archivo.php',
            'Archivo',
            {
                width: 900,
                height: 400
            }, rec, this.idContenedor, 'Archivo');

    },

		  
		  
		  
		  
		 
})
</script>
