<?php
/**
*@package pXP
*@file Funcionario.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para registrar los datos de un funcionario
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
	       			maxLength:3,
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
				config: {
					name: 'id_oficina',
					fieldLabel: 'Oficina',
					allowBlank: true,
					emptyText: 'Elija una oficina...',
					store: new Ext.data.JsonStore({
						
						url: '../../sis_organigrama/control/Oficina/listarOficina',
						id: 'id_oficina',
						root: 'datos',
						sortInfo: {
							field: 'nombre',
							direction: 'ASC'
						},
						totalProperty: 'total',
						fields: ['id_oficina', 'nombre', 'codigo','nombre_lugar'],
						remoteSort: true,
						baseParams: {par_filtro: 'ofi.nombre#ofi.codigo#lug.nombre'}
					}),
					valueField: 'id_oficina',
					displayField: 'nombre',
					gdisplayField: 'desc_oficina',
					hiddenName: 'id_oficina',
					forceSelection: true,
					typeAhead: false,
					triggerAction: 'all',
					lazyRender: true,
					mode: 'remote',
					pageSize: 10,
					queryDelay: 1000,
					anchor: '100%',
					gwidth: 150,
					minChars: 2,
					resizable:true,
					listWidth:'263',
					style: 'color:green;',
					tpl: new Ext.XTemplate([
						'<tpl for=".">',
						'<div class="x-combo-list-item">',
						'<div class="awesomecombo-item {checked}">',
						'<p><b>Nombre: {nombre}</b></p>',
						'</div><p>Codigo:  <span style="color: green;">{codigo}</span> Lugar: <span style="color: green;">{nombre_lugar}</span></p>',
						'</div></tpl>'
					]),
					renderer: function (value, p, record) {

						return String.format('{0}', record.data['desc_oficina']);
					}
				},
				type: 'AwesomeCombo',
				id_grupo: 3,
				filters: {pfiltro: 'tof.nombre', type: 'string'},
				grid: true,
				form: true
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
			}
	       	
	       	
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
        argument: {imprimir: 'archivo'},
        text: '<i class="fa fa-thumbs-o-up fa-2x"></i> archivo', /*iconCls:'' ,*/
        disabled: false,
        handler: this.archivo
    });

        
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

	var txt_ci=this.getComponente('ci');	
	var txt_correo=this.getComponente('correo');	
	var txt_telefono=this.getComponente('telefono');	
	this.getComponente('id_persona').on('select',onPersona);

	function onPersona(c,r,e){
		txt_ci.setValue(r.data.ci);
		txt_correo.setValue(r.data.correo);
		txt_telefono.setValue(r.data.telefono);
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
	{name:'id_oficina', type: 'numeric'},
	{name:'id_biometrico', type: 'numeric'},
	{name:'desc_oficina', type: 'string'}
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
	
	preparaMenu:function()
    {	
        this.getBoton('btnCuenta').enable();      
        Phx.vista.funcionario.superclass.preparaMenu.call(this);
        this.getBoton('btnFunEspecialidad').enable();      
        Phx.vista.funcionario.superclass.preparaMenu.call(this);
    },
    liberaMenu:function()
    {	
        this.getBoton('btnCuenta').disable();       
        Phx.vista.funcionario.superclass.liberaMenu.call(this);
        this.getBoton('btnFunEspecialidad').disable();       
        Phx.vista.funcionario.superclass.liberaMenu.call(this);
    },

    archivo: function () {


        var rec = this.getSelectedData();

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
