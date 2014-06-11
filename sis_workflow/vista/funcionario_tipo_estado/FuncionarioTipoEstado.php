<?php
/**
*@package pXP
*@file gen-FuncionarioTipoEstado.php
*@author  (admin)
*@date 15-03-2013 16:19:04
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FuncionarioTipoEstado=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
	    
	    
	    this.Grupos= [
                   {
                    layout:'column',
                    width:'100%',
                    autoScroll:true,
                    items: [
                           {id: config.idContenedor+'-card-0',
                            width:'45%',
                            xtype: 'fieldset',
                            title: 'Datos principales',
                            autoHeight: true,
                            border:false,
                            margin:'5 5 5 5',
                            items: [],
                            id_grupo:0
                           },
                           {
                               xtype:'panel',
                               //margin:'5 5 5 5',
                               width:'45%',
                               html:'Es posible hacer una llamada a una funcion con las siguientes variables:<br/>wf.f_mi_funcion(p_id_usuario, p_id_proceso_wf, p_id_estado_anterior, p_id_tipo_estado_actual) El retorno debe ser FALSE o TRUE<br/>---------<b><h2>Variables WF, para las reglas</h2></b> <br> PROCESO_MACRO<br>TIPO_PROCESO<br>NUM_TRAMITE<br>USUARIO_PREVIO<br>ESTADO_ANTERIOR<br>OBS<br>ESTADO_ACTUAL<br>CODIGO_ANTERIOR<br><br>CODIGO_ACTUAL<br>FUNCIONARIO_PREVIO<br>DEPTO_PREVIO<br><br>** Verificar que las variables que referencian a la tabla existan  EJM {$tabla.desc_proveedor}'
                               
                           }]
                }
            
            ];
	    
	    
		this.maestro=config.maestro;
		var mm = this.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.FuncionarioTipoEstado.superclass.constructor.call(this,config);
		this.init();
		//this.bloquearMenus();
		//this.load({params:{start:0, limit:this.tam_pag}})
		//si la interface es pestanha este código es para iniciar 
          var dataPadre = Phx.CP.getPagina(this.idContenedorPadre).getSelectedData()
          if(dataPadre){
             this.onEnablePanel(this, dataPadre);
          }
          else
          {
             this.bloquearMenus();
          }
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_funcionario_tipo_estado'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_tipo_estado',
				inputType:'hidden',
                },
            type: 'Field',
            form: true
        },
		{
            config:{
                name:'id_funcionario',
                origen:'FUNCIONARIO',
                tinit:true,
                fieldLabel:'Funcionario',
                allowBlank:true,
                gwidth:200,
                valueField: 'id_funcionario',
                gdisplayField:'desc_funcionario1',//mapea al store del grid
                anchor: '100%',
                gwidth:200,
                 renderer:function (value, p, record){return String.format('{0}', record.data['desc_funcionario1']);}
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
                name:'id_depto',
                origen:'DEPTO',
                tinit:true,
                fieldLabel:'Departamento',
                gdisplayField:'desc_depto',//mapea al store del grid
                anchor: '100%',
                gwidth:200,
                 renderer:function (value, p, record){return String.format('{0}', record.data['desc_depto']);}
             },
            type:'ComboRec',
            id_grupo:0,
            filters:{   
                pfiltro:'DEPTO.nombre',
                type:'string'
            },
           
            grid:true,
            form:true
        },
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'functest.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
        {
            config: {
                name: 'id_labores_tipo_proceso',
                fieldLabel: 'Labores',
                typeAhead: false,
                forceSelection: false,
                allowBlank: true,
                emptyText: 'Lista de labores...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_workflow/control/LaboresTipoProceso/listarLaboresTipoProceso',
                    id: 'id_labores_tipo_proceso',
                    root: 'datos',
                    sortInfo: {
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_labores_tipo_proceso', 'nombre', 'descripcion'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {par_filtro: 'labtproc.nombre#labtproc.descripcion', funcionario_te: '1'}
                }),
                valueField: 'id_labores_tipo_proceso',
                displayField: 'nombre',
                gdisplayField: 'desc_labores',
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                anchor: '80%',
                minChars: 2,
                gwidth: 200,
                renderer: function(value, p, record) {
                    return String.format('{0}', record.data['desc_labores']);
                },
                tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p>Descripción: <strong>{descripcion}</strong> </div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'ltp.nombre',
                type: 'string'
            },
            grid: true,
            form: true
        },
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'functest.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
        {
            config:{
                name: 'regla',
                fieldLabel: 'Regla (función a llamar)',
                allowBlank: true,
                anchor: '100%',
                gwidth: 300,
                maxLength:1000
            },
            type:'TextArea',
            filters:{pfiltro:'functest.regla',type:'string'},
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
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
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
			type:'NumberField',
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
			filters:{pfiltro:'functest.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Funcionarios x Tipo Estado',
	ActSave:'../../sis_workflow/control/FuncionarioTipoEstado/insertarFuncionarioTipoEstado',
	ActDel:'../../sis_workflow/control/FuncionarioTipoEstado/eliminarFuncionarioTipoEstado',
	ActList:'../../sis_workflow/control/FuncionarioTipoEstado/listarFuncionarioTipoEstado',
	id_store:'id_funcionario_tipo_estado',
	fields: [
		{name:'id_funcionario_tipo_estado', type: 'numeric'},
		{name:'id_labores_tipo_proceso', type: 'numeric'},
		{name:'id_tipo_estado', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'id_depto', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_funcionario1', type: 'string'},
		{name:'desc_depto', type: 'string'},
		{name:'desc_labores', type: 'string'},'regla'
	],
	sortInfo:{
		field: 'id_funcionario_tipo_estado',
		direction: 'ASC'
	},
	onReloadPage:function(m){
        this.maestro=m;
        this.store.baseParams={id_tipo_estado:this.maestro.id_tipo_estado};        
        this.load({params:{start:0, limit:50}})
    },
    loadValoresIniciales:function()
    {
        Phx.vista.FuncionarioTipoEstado.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_tipo_estado').setValue(this.maestro.id_tipo_estado);
        this.getComponente('id_labores_tipo_proceso').store.baseParams.id_tipo_estado=this.maestro.id_tipo_estado;      
    },
	bdel:true,
	bsave:true
	}
)
</script>
		
		