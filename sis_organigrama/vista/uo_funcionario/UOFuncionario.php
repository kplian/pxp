<?php
/**
*@package pXP
*@file UOFuncionario.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para asociar los funcionarios a su correspondiente Unidad Organizacional
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
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
   			    gdisplayField: 'desc_funcionario1',
      			renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario1']);}
       	     },
   			type:'ComboRec',//ComboRec
   			id_grupo:0,
   			filters:{pfiltro:'funcio.desc_funcionario1',
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
   		    allowBlank: false,
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
				store:['fin contrato','retiro','renuncia','promocion','transferencia']
			},
				type:'ComboBox',
				filters:{	
	       		         type: 'list',
	       				 options: ['fin contrato','retiro','renuncia','promocion','transferencia'],
	       		 	},
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
             'fecha_mod',
             'USUREG',
             'USUMOD','correspondencia'],
	sortInfo:{
		field: 'desc_funcionario1',
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
		Phx.vista.uo_funcionario.superclass.onButtonNew.call(this);
		//seteamos un valor fijo que vienen de la vista maestro para id_gui 
		
		
	},onButtonEdit:function(){
		//llamamos primero a la funcion new de la clase padre por que reseta el valor los componentes
		this.ocultarComponente(this.Cmp.id_cargo);
		this.ocultarComponente(this.Cmp.id_funcionario);
		this.ocultarComponente(this.Cmp.fecha_asignacion);
		this.ocultarComponente(this.Cmp.tipo);
		this.mostrarComponente(this.Cmp.fecha_finalizacion);
		this.getComponente('fecha_finalizacion').visible=true;
		Phx.vista.uo_funcionario.superclass.onButtonEdit.call(this);
		
		if (this.Cmp.fecha_finalizacion.getValue() == '' || this.Cmp.fecha_finalizacion.getValue() == undefined) {
			this.Cmp.observaciones_finalizacion.reset();
			this.Cmp.observaciones_finalizacion.allowBlank = true;
			this.ocultarComponente(this.Cmp.observaciones_finalizacion);
		} else {
			this.Cmp.observaciones_finalizacion.allowBlank = false;
			this.mostrarComponente(this.Cmp.observaciones_finalizacion);
		}
	},
	
	/*funcion corre cuando el padre cambia el nodo maestero*/
	onReloadPage:function(m){       
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_uo;
		this.Cmp.id_cargo.tdata.id_uo = this.maestro.id_uo;
		this.Cmp.id_funcionario.tdata.id_uo = this.maestro.id_uo;
		this.Cmp.id_cargo.store.setBaseParam('id_uo',this.maestro.id_uo);
		this.Cmp.id_funcionario.store.setBaseParam('id_uo',this.maestro.id_uo);
 
       if(m.id != 'id'){	

		this.store.baseParams={id_uo:this.maestro.id_uo};
		this.load({params:{start:0, limit:50}})
       
       }
       else{
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll(); 
    	   
       }


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
		
		
	},
	
	constructor: function(config){
		// configuracion del data store		
		this.maestro=config.maestro;		
		//this.Atributos[1].valorInicial=this.maestro.id_gui;
		Phx.vista.uo_funcionario.superclass.constructor.call(this,config);
		txt_fecha_fin=this.getComponente('fecha_finalizacion');			
		this.init();
		this.iniciarEventos();
		//deshabilita botones
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();	

	},
	
	bdel:true,// boton para eliminar
	bsave:false,// boton para eliminar
	// sobre carga de funcion
	preparaMenu:function(tb){
		// llamada funcion clace padre
		Phx.vista.uo_funcionario.superclass.preparaMenu.call(this,tb)
	}
	

  }
)
</script>