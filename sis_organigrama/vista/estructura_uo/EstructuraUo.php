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
               config:{                                             //#94
                   name:'gestion',
                   fieldLabel: 'gestion',
               },
               type:'Field',
               id_grupo:0,
               grid:true,
               form:true
           },
           {
               config:{                                             //#94
                   name:'periodo',
                   fieldLabel: 'periodo',
               },
               type:'Field',
               id_grupo:0,
               grid:true,
               form:true
           }
		];

        this.initButtons=[this.cmbGestion, this.cmbPeriodo];                                //#94       -----> Inicializando dos combos: Gestion y Periodo.

        Phx.vista.EstructuraUo.superclass.constructor.call(this,config);

        this.iniciarEventos();
            this.cmbGestion.on('select', function(combo, record, index){                    //#94
            this.tmpGestion = record.data.gestion;                                          //#94
            this.cmbPeriodo.enable();                                                       //#94
            //this.cmbPeriodo.reset();                                                        //#94
            //this.store.removeAll();

            this.cmbPeriodo.store.baseParams = Ext.apply(this.cmbPeriodo.store.baseParams, {id_gestion: this.cmbGestion.getValue(),id_periodo:this.cmbPeriodo.getValue()});     //#94
            this.cmbPeriodo.modificado = true;                                              //#94
            this.capturaFiltros();                                                          //#94 <-----------------------------------------------
        },this);                                                                            //#94


        this.cmbPeriodo.on('select', function( combo, record, index){                       //#94
            this.tmpPeriodo = record.data.periodo;
            this.capturaFiltros();                                                          //#94
        },this);                                                                            //#94


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

		//coloca elementos en la barra de herramientas
		this.tbar.add('->');
   		this.tbar.add(' Filtrar:');
   		this.tbar.add(this.datoFiltro);
   		this.tbar.add('Inactivos:');
   		this.tbar.add(this.checkInactivos);
		
		//de inicio bloqueamos el botono nuevo
		//this.tbar.items.get('b-new-'+this.idContenedor).disable()
		this.init();
		
		this.loaderTree.baseParams={id_subsistema:this.id_subsistema,id_gestion:0,id_periodo:0};
		this.rootVisible=false;
        v_id_gestion =0;

        this.loadValoresIniciales();

},



Ext.extend(Phx.vista.EstructuraUo,Phx.arbInterfaz,{
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
		'orden_centro',//#26
        'gestion',                              //#94   --------------------------->variables para manejar los datos gesttion y periodo
        'periodo',                              //#94

		],
		sortInfo:{
			field: 'id',
			direction:'ASC'
		},
		onButtonAct:function(){
			
			this.sm.clearSelections();
            var id_gestion= this.cmbGestion.getValue();                 //#94
            var id_periodo= this.cmbPeriodo.getValue();                 //#94
            //console.log('gestion',id_gestion,'periodo',id_periodo);     //#94
            this.Cmp.periodo.setValue(id_periodo);                      //#94
            this.Cmp.gestion.setValue(id_gestion);                      //#94

            var dfil = this.datoFiltro.getValue();
			var dcheck = this.checkInactivos.getValue();
			if(dfil && dfil!=''){
				if (dcheck) {
					this.loaderTree.baseParams={filtro:'activo',criterio_filtro_arb:dfil, p_activos : 'no',id_gestion:id_gestion, id_periodo:id_periodo,periodo:0};     //#94 --> id_gestion e id_periodo
                    this.root.reload();
				} else {
					this.loaderTree.baseParams={filtro:'activo',criterio_filtro_arb:dfil,id_gestion:id_gestion, id_periodo:id_periodo,periodo:0};                       //#94 --> id_gestion e id_periodo
                    this.root.reload();                                 //#94
				}
				this.root.reload();
			}
			else
			{
				this.loaderTree.baseParams={filtro:'inactivo',criterio_filtro_arb:'',id_gestion:id_gestion, id_periodo:id_periodo,periodo:0};                               //#94 --> id_gestion e id_periodo
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
			//this.getComponente('id_uo_padre').setValue('');
			//this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
			},
		
		/*Sobre carga boton EDIT */
		onButtonEdit:function(){
	
			var nodo = this.sm.getSelectedNode();			
						
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
            //console.log('Combo Perioooooodo: ', cmbPeriodo.getValue());

            var d = new Date();
            this.cmbGestion.store.baseParams.query = d.getFullYear();           //#94
            //recorrer el combo de la gestion para seleccionar la gestion acttual
            this.cmbGestion.store.load({params:{start:0,limit:this.tam_pag},    //#94
                callback : function (r) {
                    if (r.length > 0 ) {
                        this.cmbGestion.setValue(r[0].data.id_gestion);         //#94
                        v_id_gestion = r[0].data.id_gestion;                    //#94
                        this.loaderTree.baseParams = {id_gestion: v_id_gestion, id_periodo:  this.cmbPeriodo.getValue()};       //#94
                        this.root.reload();                                     //#94
                        this.cargaPeriodo();                                    //#94
                    }else{
                        this.cmbGestion.reset();                                //#94
                    }
                }, scope : this
            });                                                                 //#94
            this.cmbGestion.setValue(this.v_id_gestion);                        //#94
            this.cmbPeriodo.store.baseParams.query = d.getMonth()+1;            //#94
            this.loaderTree.baseParams = {id_gestion: 0, id_periodo:0};         //#94
            this.Cmp.gestion.setValue(this.cmbGestion.getValue());              //#94
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
        cargaPeriodo:function (){                                                       //#94
            this.cmbPeriodo.store.baseParams.id_gestion = v_id_gestion;                 //#94
            this.cmbPeriodo.store.load({params:{start:0,limit:this.tam_pag},            //#94
                callback : function (r) {                                               //#94
                    if (r.length > 0 ) {                                                //#94
                        this.cmbPeriodo.setValue(r[0].data.id_periodo);                 //#94
                    }else{
                        this.cmbPeriodo.reset();                                        //#94
                    }
                    this.loaderTree.baseParams = {id_gestion: v_id_gestion, id_periodo: r[0].data.id_periodo};      //#94

                }, scope : this
            });
            if(this.cmbPeriodo.getValue()==null){                                       //#94
                this.cmbPeriodo.disable(true);                                          //#94
            }
            this.Cmp.periodo.setValue(this.cmbPeriodo.getValue());                      //#94
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




        cmbGestion: new Ext.form.ComboBox({                                    //#94
            fieldLabel: 'Gestion',
            allowBlank: false,
            emptyText:'Gestion...',
            blankText: 'Año',
            //grupo:[0,1,2,3,4],
            store:new Ext.data.JsonStore(
                {
                    url: '../../sis_parametros/control/Gestion/listarGestion',
                    id: 'id_gestion',
                    root: 'datos',
                    sortInfo:{
                        field: 'gestion',
                        direction: 'DESC'
                    },
                    totalProperty: 'total',
                    fields: ['id_gestion','gestion'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'ges.id_gestion#ges.gestion', start:0,limit:50}
                }),
            valueField: 'id_gestion',
            triggerAction: 'all',
            displayField: 'gestion',
            hiddenName: 'id_gestion',
            mode:'remote',
            pageSize:50,
            queryDelay:500,
            listWidth:'280',
            width:80
        }),                                                                     //#94

        cmbPeriodo: new Ext.form.ComboBox({                                     //#94
            fieldLabel: 'Periodo',
            allowBlank: false,
            blankText : 'Mes',
            emptyText:'Periodo...',
            //grupo:[0,1,2,3,4],
            store:new Ext.data.JsonStore(
                {
                    url: '../../sis_parametros/control/Periodo/listarPeriodo',
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
                    baseParams:{par_filtro:'per.periodo',start:0,limit:20}
                }),
            valueField: 'id_periodo',
            triggerAction: 'all',
            displayField: 'literal',
            hiddenName: 'id_periodo',
            mode:'remote',
            pageSize:50,
            disabled: false,
            queryDelay:500,
            listWidth:'280',
            width:80
        }),                                                                     //#94


        capturaFiltros:function(combo, record, index){                          //#94

            if(this.validarFiltros()){                                          //#94
                //console.log("GEstionnnnnnnnnnnn:  ", this.cmbGestion.getValue());
                this.loaderTree.baseParams = {id_gestion: this.cmbGestion.getValue(), id_periodo: this.cmbPeriodo.getValue()};      //#94
                this.onButtonAct();                                             //#94
            }
        },

        validarFiltros:function(){
            if(this.cmbGestion.validate() && this.cmbPeriodo.validate()){       //#94
                return true;                                                    //#94
            }
            else{
                return false;                                                   //#94
            }
        },

    }
)
</script>