<?php
/**
*@package pXP
*@file EstructuraUO.php
*@author KPLIAN (admin)
*@date 14-02-2011
*@description  Vista para registrar las estructura de las Unidades Organizacionales
	ISSUE		FECHA			AUTHOR				DESCRIPCION
 *  #26			26/6/2019		EGS					Se agrega los Cmp centro y orden centro
 *  #94         12/12/2019      APS                 Filtro de funcionarios por gestion y periodo
 *  #107        16/01/2020      JUAN                Quitar filtro gestión y periodo del organigrama, los filtro ponerlos en el detalles
 * */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>

    var v_id_gestion = 0;
    var v_periodo =0 ;
Phx.vista.EstructuraUo=function(config){



	   this.Atributos =[
	      //Primera posicion va el identificador de nodo
		{
			// configuracion del componente (el primero siempre es el
			// identificador)
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_estructura_uo'

			},
			type:'Field',
			form:true  

		},
	      
	      {
			// configuracion del componente (el primero siempre es el
			// identificador)
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_uo'

			},
			type:'Field',
			form:true  

		},
		 //En segunda posicion siempre va el identificador del nodo padre
			{
			// configuracin del componente
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name:'id_uo_padre'

			},
			type:'Field',
			form:true

		},
		{
			config:{
				fieldLabel: "Código",
				gwidth: 120,
				name: 'codigo',
				allowBlank:false,
				anchor:'100%'
				
			},
			type:'Field',
			id_grupo:0,
			form:true
		},
		
		{
			config:{
				name: 'id_nivel_organizacional',
				fieldLabel: 'Nivel Organizacional',
				allowBlank: false,
				emptyText:'Nivel...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_organigrama/control/NivelOrganizacional/listarNivelOrganizacional',
					id: 'id_nivel_organizacional',
					root: 'datos',
					sortInfo:{
						field: 'numero_nivel',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_nivel_organizacional','numero_nivel','nombre_nivel'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nivorg.numero_nivel#nivorg.nombre_nivel'}
				}),
				valueField: 'id_nivel_organizacional',
				displayField: 'nombre_nivel',
				gdisplayField:'nombre_nivel',
				hiddenName: 'id_nivel_organizacional',
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				anchor:"100%",
				gwidth:150,
				minChars:2,
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{numero_nivel}</p><p>{nombre_nivel}</p></div></tpl>',
				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_nivel']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'ofi.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		
		{
			config:{
				fieldLabel: "Nombre",
				gwidth: 120,
				name: 'nombre_unidad',
				allowBlank:false,
				anchor:'100%'
				
			},
			type:'TextField',
			id_grupo:0,
			form:true
		},
		{
			config:{
				fieldLabel: "Descripción",
				gwidth: 120,
				name: 'descripcion',
				allowBlank:false,
				anchor:'100%'
			},
			type:'Field',
			id_grupo:0,
			form:true
		},
	
		
		
		{
			config:{
				fieldLabel: "Cargo",
				gwidth: 120,
				name: 'nombre_cargo',
				allowBlank:false,
				anchor:'100%'
				
			},
			type:'TextField',
			id_grupo:0,
			form:true
		},
		{
			config:{
				fieldLabel: "Cargo Individual",
				gwidth: 120,
				name: 'cargo_individual',
				allowBlank:false,
				anchor:'100%',
				typeAhead: true,
				allowBlank:false,
	    		triggerAction: 'all',
	    		emptyText:'Seleccione una opcion...',
	    		selectOnFocus:true,
	   			mode:'local',
				/*store:new Ext.data.ArrayStore({
	        	fields: ['ID', 'valor'],
	        	data :	[['si','si'],	
	        			['no','no']]
	        				
	    		}),*/
				store:['si','no'],
				valueField:'ID'
				
			},
			type:'ComboBox',
			id_grupo:0,
			form:true
		},
		
		{   config:{
			name:'presupuesta',
			fieldLabel:'Presupuesta',
			typeAhead: true,
			allowBlank:false,
    		triggerAction: 'all',
    		emptyText:'Seleccione una opcion...',
    		selectOnFocus:true,
   			mode:'local',
			store:['si','no'],
			/*store:new Ext.data.ArrayStore({
	        	fields: ['ID', 'valor'],
	        	data :	[['si','si'],	
	        			['no','no']]
	        				
	    		}),*/
			valueField:'ID',
			width:150,			
				
			   },
			type:'ComboBox',
			id_grupo:0,
			form:true
		},
		{
			config:{
				name:'nodo_base',
				fieldLabel:'Nodo Base',
				typeAhead: true,
				allowBlank:false,
	    		triggerAction: 'all',
	    		emptyText:'Seleccione Opcion...',
	    		selectOnFocus:true,
				mode:'local',
				/*store:new Ext.data.ArrayStore({
	        	fields: ['ID', 'valor'],
	        	data :	[['si','si'],	
	        			['no','no']]
	        				
	    		}),*/
				store:['si','no'],
				valueField:'ID',
				displayField:'valor',
				width:150,			
				
			},
			type:'ComboBox',
			id_grupo:0,
			form:true
		},
		{
			config:{
				name:'correspondencia',
				fieldLabel:'Correspondencia',
				typeAhead: true,
				allowBlank:false,
	    		triggerAction: 'all',
	    		emptyText:'Seleccione Opcion...',
	    		selectOnFocus:true,
				mode:'local',
				/*store:new Ext.data.ArrayStore({
	        	fields: ['ID', 'valor'],
	        	data :	[['si','si'],	
	        			['no','no']]
	        				
	    		}),*/
				store:['si','no'],
				valueField:'ID',
				displayField:'valor',
				width:150,			
				
			},
			type:'ComboBox',
			id_grupo:0,
			form:true
		}
		,
		{
			config:{
				name:'gerencia',
				fieldLabel:'Gerencia',
				typeAhead: true,
				allowBlank:false,
	    		triggerAction: 'all',
	    		emptyText:'Seleccione Opcion...',
	    		selectOnFocus:true,
				mode:'local',
				/*store:new Ext.data.ArrayStore({
	        	fields: ['ID', 'valor'],
	        	data :	[['si','si'],	
	        			['no','no']]
	        				
	    		}),*/
				store:['si','no'],
				valueField:'ID',
				displayField:'valor',
				width:150,			
				
			},
			type:'ComboBox',
			id_grupo:0,
			form:true
		},
		{ //#26
                config:{
                       name:'centro',
                       fieldLabel:'Centro?',
                       allowBlank:true,
                       emptyText:'...',
                       typeAhead: true,
                       triggerAction: 'all',
                       lazyRender:true,
                       mode: 'local',                       
                       gwidth: 100,
                       store:new Ext.data.ArrayStore({
                    fields: ['ID', 'valor'],
                    data :    [['si','si'],    
                            ['no','no']]
                                
                    }),
                    valueField:'ID',
                    displayField:'valor',
                    //renderer:function (value, p, record){if (value == 1) {return 'si'} else {return 'no'}}
                   },
                 type:'ComboBox',
                 valorInicial: 'no',
                 id_grupo:0,                   
                 grid:true,
                 form:true
           },
		{ //#26
			config:{
				name: 'orden_centro',
				fieldLabel: 'Orden Centro',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
				type:'NumberField',
				id_grupo:0,
				grid:false,
				form:true
		},
		{
	       		config:{
	       			name:'vigente',
	       			fieldLabel:'Vigente',
	       			allowBlank:false,
	       			emptyText:'Vigente...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    gwidth: 100,
	       		    store:['si','no']
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       		         //pfiltro:'par.sw_movimiento',
	       				 options: ['si','no'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
		];
this.initButtons=[this.cmbTipo];
        Phx.vista.EstructuraUo.superclass.constructor.call(this,config);
		
        this.iniciarEventos();



		/*this.addButton('btnReporteFun',	{
				text: 'Funcionarios',
				//iconCls: 'bchecklist',
				disabled: false,
				handler: this.onBtnReporteFun,
				tooltip: '<b>Funcionarios</b><br/>Listado de funcionarios por unidad organizacional'
			}
		);*/
		
		this.addButton('btnCargo',	{
				text: 'Cargos',
				iconCls: 'bcargo',
				disabled: false,
				handler: this.onBtnCargos,
				tooltip: '<b>Cargos</b><br/>Listado de cargos por unidad organizacional'
			}
		);
		/******/
		
		this.cmbTipo.on('select',this.capturaFiltros,this);
		
		//coloca elementos en la barra de herramientas
		this.tbar.add('->');
   		this.tbar.add(' Filtrar:');
   		this.tbar.add(this.datoFiltro);
   		this.tbar.add('Inactivos:');
   		this.tbar.add(this.checkInactivos);
		
		//de inicio bloqueamos el botono nuevo
		//this.tbar.items.get('b-new-'+this.idContenedor).disable()
		this.init();
		
		this.loaderTree.baseParams={id_subsistema:this.id_subsistema,estado:this.cmbTipo.getValue()};
		
		
		this.rootVisible=false;
        v_id_gestion =0;

        this.loadValoresIniciales();

},



Ext.extend(Phx.vista.EstructuraUo,Phx.arbInterfaz,{
	
	cmbTipo:new Ext.form.ComboBox({
	       			name:'estado',
	       			fieldLabel:'Estado Asignaciones',
	       			allowBlank:false,
	       			emptyText:'Estado Asignaciones...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    value:'vigentes',
	       		    mode: 'local',
	       		    width: 70,
	       		    store:['vigentes','todos']
	       		}),
		datoFiltro:new Ext.form.Field({ 
		                        allowBlank:true,
		                        enableKeyEvents : true,
					       		width: 150}),
		checkInactivos:new Ext.form.Checkbox({ 
		                        width: 25}),
    	title:'Unidad Organizacionalsssss',
		ActSave:'../../sis_organigrama/control/EstructuraUo/guardarEstructuraUo',
		ActDel:'../../sis_organigrama/control/EstructuraUo/eliminarEstructuraUo',	
		ActList:'../../sis_organigrama/control/EstructuraUo/listarEstructuraUo',
	    enableDD:false,
		expanded:false,
		fheight:'80%',
		fwidth:'50%',
		textRoot:'Estructura Organizacional',
		id_nodo:'id_uo',
		id_nodo_p:'id_uo_padre',
		fields: [
		'id', //identificador unico del nodo (concatena identificador de tabla con el tipo de nodo)
		      //porque en distintas tablas pueden exitir idetificadores iguales
		'tipo_meta',
		'id_nivel_organizacional',
		'nombre_nivel',
		'tipo_meta',
		'id_estructura_uo',
		'id_uo',
		'id_uo_padre',
		'codigo',
		'descripcion',
		'nombre_unidad',
		'nombre_cargo',
		'presupuesta',
		'nodo_base','correspondencia','gerencia',
		'centro', //#26
		'orden_centro'//#26
		,'vigente'//#ETR-2026
		],
		
		sortInfo:{
			field: 'id',
			direction:'ASC'
		},
		onButtonAct:function(){
			
			this.sm.clearSelections();

            var dfil = this.datoFiltro.getValue();
			var dcheck = this.checkInactivos.getValue();
			if(dfil && dfil!=''){
				if (dcheck) {
                    this.loaderTree.baseParams={filtro:'activo',criterio_filtro_arb:dfil, p_activos : 'no',estado:this.cmbTipo.getValue()};
				}
				else{
                    this.loaderTree.baseParams={filtro:'activo',criterio_filtro_arb:dfil,estado:this.cmbTipo.getValue()};
                }
                this.root.reload();
			}
			else
			{
                 this.loaderTree.baseParams={filtro:'inactivo',criterio_filtro_arb:'',estado:this.cmbTipo.getValue()};
			     this.root.reload();
			}
			
			
			
			
		},
				
		/*onBtnReporteFun: function(){
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			Phx.CP.loadWindows('../../../sis_organigrama/vista/estructura_uo/RepFuncionarioUo.php',
					'Funcionarios',
					{
						width:1000,
						height:600
				    },
				    data,
				    this.idContenedor,
				    'RepFuncionarioUo'
			);
		},	*/
		
		onBtnCargos: function(){
			var node = this.sm.getSelectedNode();
			var data = node.attributes;

			Phx.CP.loadWindows('../../../sis_organigrama/vista/cargo/Cargo.php',
					'Cargos por Unidad',
					{
						width:1000,
						height:600
				    },
				    data,
				    this.idContenedor,
				    'Cargo'
			);
		},


		//sobrecarga prepara menu
		preparaMenu:function(n) {
            this.getBoton('btnCargo').enable();
            Phx.vista.EstructuraUo.superclass.preparaMenu.call(this,n);
		},
		liberaMenu : function () {
			this.getBoton('btnCargo').disable();
			Phx.vista.EstructuraUo.superclass.liberaMenu.call(this);
		},
		/*Sobre carga boton new */
		onButtonNew:function(){
			var nodo = this.sm.getSelectedNode();			
			Phx.vista.EstructuraUo.superclass.onButtonNew.call(this);			
			this.getComponente('vigente').setValue('si');
			this.getComponente('vigente').disable();
			},
		
		/*Sobre carga boton EDIT */
		onButtonEdit:function(){
	
			var nodo = this.sm.getSelectedNode();			
				this.getComponente('vigente').enable();		
			//this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
			
			/*if(nodo.attributes.tipo_dato=='interface'){		
				console.log(this.getComponente('nombre'))
				//componente 5 y tipo_dato son el mismo
				this.getComponente('tipo_dato').disable();				
				this.Componentes[5].setValue('interface');
				this.getComponente('ruta_archivo').enable();
				this.getComponente('icono').enable();
				this.getComponente('clase_vista').enable();
			}
			else{
				
				this.getComponente('tipo_dato').enable();
				this.getComponente('ruta_archivo').disable();
				this.getComponente('icono').disable();
				this.getComponente('clase_vista').disable();
			}	*/
			Phx.vista.EstructuraUo.superclass.onButtonEdit.call(this);
		},
		
	
		
		//estable el manejo de eventos del formulario

		iniciarEventos:function(m){
            this.maestro=m;

			this.datoFiltro.on('specialkey',function(field, e){
				if (e.getKey() == e.ENTER) {

                     this.onButtonAct();
                }
			},this)

			/*this.getComponente('tipo_dato').on('beforeselect',function(combo,record,index){
				if(record.json[0]=='interface'){

					this.getComponente('ruta_archivo').enable();
				    this.getComponente('icono').enable();
				    this.getComponente('clase_vista').enable();
				}
				else{
					this.getComponente('ruta_archivo').disable();
					this.getComponente('icono').disable();
					this.getComponente('clase_vista').disable();
				}
			},this)*/



        },

	/*
	 * south:{ url:'../../sis_legal/vista/representante/representante.php',
	 * title:'Representante', height:200 },
	 */	
		
     
	tabsouth:[
            {
			  url:'../../../sis_organigrama/vista/uo_funcionario/UOFuncionario.php',
			  title:'Asignacion de Funcionarios a Unidad', 
			  height:'50%',
			  cls:'uo_funcionario'
			 },
            {
              url:'../../../sis_organigrama/vista/uo_funcionario_ope/UoFuncionarioOpe.php',
			  title:'Asignaciones Operativas', 
			  qtip: 'Cuando el funcionario funcionalmente tiene otra dependencia diferente a la jerárquica',
              height:'50%',
              cls:'UoFuncionarioOpe'
            }
    
       ],	
		
		
		bdel:true,// boton para eliminar
		bsave:false,// boton para eliminar
		
		//DEFINIE LA ubicacion de los datos en el formulario
	Grupos:[{ 
			 layout: 'column',
			 items:[{
				    xtype:'fieldset',
                    layout: 'form',
                    border: true,
                    title: 'Datos principales',
                    bodyStyle: 'padding:0 10px 0;',
                    columnWidth: '1',
                    items:[],
		            id_grupo:0
                  }
                  
                  /*{  
                    xtype:'fieldset',
                    layout: 'form',
                    border: true,
                    title: 'Orden y rutas',
                    bodyStyle: 'padding:0 10px 0;',
                    columnWidth: '.5',
                    
                    items:[],
                    id_grupo:1
                 }*/] }],
                 
                 
                 
    capturaFiltros:function(combo, record, index){
		this.loaderTree.baseParams={estado:this.cmbTipo.getValue()};
		this.root.reload();
	}       


    }
)
</script>