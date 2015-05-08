<?php
/**
*@package pXP
*@file gen-EstructuraEstado.php
*@author  (FRH)
*@date 21-02-2013 15:25:45
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.EstructuraEstadoHijo=Ext.extend(Phx.gridInterfaz,{

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
    	//llama al constructor de la clase padre
		Phx.vista.EstructuraEstadoHijo.superclass.constructor.call(this,config);
		this.init();
		this.bloquearMenus();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_estructura_estado'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_estado_padre'
			},
			type:'Field',
			form:true 
		}
		,
		{
			config: {
				name: 'id_tipo_estado_hijo',
				fieldLabel: 'Estado Hijo',
				typeAhead: false,
				forceSelection: false,
				allowBlank: false,
				emptyText: 'Lista de Estados...',
				store: new Ext.data.JsonStore({
					url: '../../sis_workflow/control/TipoEstado/listarTipoEstado',
					id: 'id_tipo_estado',
					root: 'datos',
					sortInfo: {
						field: 'tipes.codigo',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_estado', 'nombre_estado', 'inicio','codigo_estado','disparador','fin','desc_tipo_proceso'],
                    // turn on remote sorting
					remoteSort: true,
					baseParams: {par_filtro: 'tipes.nombre_estado'}
				}),
				valueField: 'id_tipo_estado',
				displayField: 'nombre_estado',
				gdisplayField: 'desc_tipo_estado_hijo',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				anchor: '100%',
				minChars: 2,
				gwidth: 200,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_tipo_estado_hijo']);
				},
			    tpl: '<tpl for="."><div class="x-combo-list-item"><p>({codigo_estado})- {nombre_estado}</p>Inicio: <strong>{inicio}</strong>, Fin: <strong>{fin} <p>Tipo Proceso: {desc_tipo_proceso}</p></strong> </div></tpl>'
            },
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'teh.nombre_estado',
				type: 'string'
			},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'prioridad',
				fieldLabel: 'Prioridad',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			valorInicial:1,
			filters:{pfiltro:'estes.prioridad',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
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
			filters:{pfiltro:'estes.regla',type:'string'},
			id_grupo:1,
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
			filters:{pfiltro:'estes.estado_reg',type:'string'},
			id_grupo:1,
			grid:false,
			form:false
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
			filters:{pfiltro:'estes.fecha_reg',type:'date'},
			id_grupo:1,
			grid:false,
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
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:false,
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
			filters:{pfiltro:'estes.fecha_mod',type:'date'},
			id_grupo:1,
			grid:false,
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
			grid:false,
			form:false
		}
	],
	
	title:'Estrutura de estados',
	ActSave:'../../sis_workflow/control/EstructuraEstado/insertarEstructuraEstado',
	ActDel:'../../sis_workflow/control/EstructuraEstado/eliminarEstructuraEstado',
	ActList:'../../sis_workflow/control/EstructuraEstado/listarEstructuraEstado',
	id_store:'id_estructura_estado',
	fields: [
		{name:'id_estructura_estado', type: 'numeric'},
		{name:'id_tipo_estado_padre', type: 'numeric'},
		{name:'id_tipo_estado_hijo', type: 'numeric'},
		{name:'prioridad', type: 'numeric'},
		{name:'regla', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_tipo_estado_padre', type: 'string'},
		{name:'desc_tipo_estado_hijo', type: 'string'}
		
	],
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_tipo_estado_padre:this.maestro.id_tipo_estado};
		this.load({params:{start:0, limit:50}})
		this.getComponente('id_tipo_estado_hijo').store.baseParams.id_tipo_proceso =this.maestro.id_tipo_proceso;		
	    this.getComponente('id_tipo_estado_hijo').modificado=true;
	},
	loadValoresIniciales:function()
	{
		Phx.vista.EstructuraEstadoHijo.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_tipo_estado_padre').setValue(this.maestro.id_tipo_estado);		
	},
	sortInfo:{
		field: 'id_estructura_estado',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	fheight: '80%',
    fwidth: '80%'
	}
)
</script>
		
		