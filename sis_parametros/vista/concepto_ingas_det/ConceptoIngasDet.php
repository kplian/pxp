<?php
/**
*@package pXP
*@file gen-ConceptoIngasDet.php
*@author  (admin)
*@date 22-07-2019 14:37:28
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
  ISSUE			AUTHOR			FECHA				DESCRIPCION
 * #39 ETR		EGS				31/07/2019			Creacion
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ConceptoIngasDet=Ext.extend(Phx.gridInterfaz,{
    nombreVista: 'ConceptoIngasDet',
	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ConceptoIngasDet.superclass.constructor.call(this,config);
		this.init();
		this.bloquearMenus();

	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_concepto_ingas_det'
			},
			type:'Field',
			form:true 
		},
        {
            //configuracion del componente
            config:{
                labelSeparator:'',
                inputType:'hidden',
                name: 'id_concepto_ingas'
            },
            type:'Field',
            form:true
        },

		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 350,
				maxLength:1000
			},
				type:'TextField',
				filters:{pfiltro:'coind.nombre',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1000
			},
				type:'TextField',
				filters:{pfiltro:'coind.descipcion',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
        {
            config: {
                name: 'id_concepto_ingas_det_fk',
                fieldLabel: 'Agrupador',
                allowBlank: true,
                emptyText: 'Elija una opción...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/ConceptoIngasDet/listarConceptoIngasDet',
                    id: 'id_concepto_ingas_det',
                    root: 'datos',
                    sortInfo: {
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_concepto_ingas_det', 'nombre', 'codigo'],
                    remoteSort: true,
                    baseParams: {par_filtro: 'nombre#codigo',start: 0, limit: 50, agrupador:'si'}
                }),
                valueField: 'id_concepto_ingas_det',
                displayField: 'nombre',
                gdisplayField: 'nombre',
                hiddenName: 'id_concepto_ingas_det',
                forceSelection: true,
                typeAhead: false,
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 15,
                queryDelay: 1000,
                anchor: '100%',
                gwidth: 150,
                minChars: 2,
                renderer : function(value, p, record) {
                    return String.format('{0}', record.data['desc_agrupador']);
                }
            },
            type: 'ComboBox',
            id_grupo: 0,
            grid: false,
            form: true
        },
        {
            config:{
                name: 'desc_agrupador',
                fieldLabel: 'Agrupador',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:10
            },
            type:'TextField',
            id_grupo:1,
            grid:true,
            form:false
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
            filters:{pfiltro:'coind.estado_reg',type:'string'},
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
				filters:{pfiltro:'coind.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'coind.id_usuario_ai',type:'numeric'},
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
				type:'TextField',
				filters:{pfiltro:'coind.usuario_ai',type:'string'},
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
				filters:{pfiltro:'coind.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
        {
            //configuracion del componente
            config:{
                labelSeparator:'',
                inputType:'hidden',
                name: 'agrupador'
            },
            type:'Field',
            form:true
        },
	],
	tam_pag:50,	
	title:'Concepto Ingreso/gasto Detalle',
	ActSave:'../../sis_parametros/control/ConceptoIngasDet/insertarConceptoIngasDet',
	ActDel:'../../sis_parametros/control/ConceptoIngasDet/eliminarConceptoIngasDet',
	ActList:'../../sis_parametros/control/ConceptoIngasDet/listarConceptoIngasDet',
	id_store:'id_concepto_ingas_det',
	fields: [
		{name:'id_concepto_ingas_det', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'descipcion', type: 'string'},
		{name:'id_concepto_ingas', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
        {name:'agrupador', type: 'string'},
        {name:'id_concepto_ingas_det_fk', type: 'numeric'},
        {name:'desc_agrupador', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_concepto_ingas_det',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
    onReloadPage: function (m) {
        this.maestro = m;
        this.Atributos[this.getIndAtributo('id_concepto_ingas')].valorInicial = this.maestro.id_concepto_ingas;
        this.store.baseParams = {id_concepto_ingas: this.maestro.id_concepto_ingas};
        this.load({params: {start: 0, limit: 50, nombreVista:this.nombreVista}})
    },


    },
)
</script>
		
		