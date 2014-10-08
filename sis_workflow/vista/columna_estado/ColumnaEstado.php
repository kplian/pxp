<?php
/**
*@package pXP
*@file gen-ColumnaEstado.php
*@author  (admin)
*@date 07-05-2014 21:41:18
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ColumnaEstado=Ext.extend(Phx.gridInterfaz,{

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
		Phx.vista.ColumnaEstado.superclass.constructor.call(this,config);
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_columna_estado'
			},
			type:'Field',
			form:true 
		},
		
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_columna'
			},
			type:'Field',
			form:true 
		},
		{
            config: {
                name: 'id_tipo_estado',
                fieldLabel: 'Estado',
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
                    baseParams: {par_filtro: 'tipes.nombre_estado#tipes.codigo'}
                }),
                valueField: 'id_tipo_estado',
                displayField: 'nombre_estado',
                gdisplayField: 'nombre_estado',
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                anchor: '80%',
                minChars: 2,
                gwidth: 200,
                renderer: function(value, p, record) {
                    return String.format('{0}', record.data['nombre_estado']);
                },
                tpl: '<tpl for="."><div class="x-combo-list-item"><p>({codigo_estado})- {nombre_estado}</p>Inicio: <strong>{inicio}</strong>, Fin: <strong>{fin} <p>Tipo Proceso: {desc_tipo_proceso}</p></strong> </div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'colest.desc_tipo_estado',
                type: 'string'
            },
            grid: true,
            form: true
        },
		
		{
            config:{
                name: 'momento',
                fieldLabel: 'Momento',
                allowBlank: false,
                anchor: '80%',
                gwidth: 70,
                maxLength:50,
                emptyText:'momento...',                
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                valueField: 'momento',                  
                store:['registrar','exigir','mostrar_formulario','calcular','preregistro','ninguno']
            },
            type:'ComboBox',
            //filters:{pfiltro:'des.momento',type:'string'},
            id_grupo:1,
            filters:{   
                         type: 'list',
                         pfiltro:'colest.momento',
                         options: ['registrar','exigir','mostrar_formulario','calcular','preregistro','ninguno'],   
                    },
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
				filters:{pfiltro:'colest.estado_reg',type:'string'},
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
				type:'NumberField',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
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
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'colest.fecha_reg',type:'date'},
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
				filters:{pfiltro:'colest.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Estados',
	ActSave:'../../sis_workflow/control/ColumnaEstado/insertarColumnaEstado',
	ActDel:'../../sis_workflow/control/ColumnaEstado/eliminarColumnaEstado',
	ActList:'../../sis_workflow/control/ColumnaEstado/listarColumnaEstado',
	id_store:'id_columna_estado',
	fields: [
		{name:'id_columna_estado', type: 'numeric'},
		{name:'id_tipo_estado', type: 'numeric'},
		{name:'nombre_estado', type: 'string'},
		{name:'id_tipo_columna', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'momento', type: 'string'},
		{name:'regla', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_columna_estado',
		direction: 'ASC'
	},
	bdel:true,	
	onReloadPage:function(m){
        this.maestro=m;
        this.store.baseParams={id_tipo_columna:this.maestro.id_tipo_columna};        
        this.load({params:{start:0, limit:10}});
    },
    loadValoresIniciales:function()
    {
        Phx.vista.ColumnaEstado.superclass.loadValoresIniciales.call(this);
        this.Cmp.id_tipo_columna.setValue(this.maestro.id_tipo_columna); 
        this.Cmp.id_tipo_estado.store.baseParams.id_tipo_proceso=this.maestro.id_tipo_proceso;
        this.Cmp.id_tipo_estado.modificado=true;
        this.Cmp.id_tipo_estado.reset();            
    }
	}
)
</script>
		
		