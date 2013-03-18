<?php
/**
*@package pXP
*@file gen-LaboresTipoProceso.php
*@author  (admin)
*@date 15-03-2013 16:08:41
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.LaboresTipoProceso=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.LaboresTipoProceso.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_labores_tipo_proceso'
			},
			type:'Field',
			form:true 
		},
		{
            config: {
                name: 'id_tipo_proceso',
                fieldLabel: 'Tipo Proceso',
                typeAhead: false,
                forceSelection: false,
                allowBlank: true,
                emptyText: 'Lista de tipos proceso...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_workflow/control/TipoProceso/listarTipoProceso',
                    id: 'id_tipo_proceso',
                    root: 'datos',
                    sortInfo: {
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_tipo_proceso', 'codigo', 'nombre'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {par_filtro: 'tipproc.nombre#tipproc.codigo'}
                }),
                valueField: 'id_tipo_proceso',
                displayField: 'nombre',
                gdisplayField: 'desc_tipo_proceso',
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                anchor: '80%',
                minChars: 2,
                gwidth: 200,
                renderer: function(value, p, record) {
                    return String.format('{0}', record.data['desc_tipo_proceso']);
                },
                tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p>Codigo: <strong>{codigo}</strong> </div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'tp.nombre',
                type: 'string'
            },
            grid: true,
            form: true
        },
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código Labor',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:15
			},
			type:'TextField',
			filters:{pfiltro:'labtproc.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'labtproc.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'labtproc.descripcion',type:'string'},
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
			filters:{pfiltro:'labtproc.estado_reg',type:'string'},
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
			filters:{pfiltro:'labtproc.fecha_reg',type:'date'},
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
			filters:{pfiltro:'labtproc.fecha_mod',type:'date'},
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
		}
	],
	
	title:'Definicion Labores x Proceso',
	ActSave:'../../sis_workflow/control/LaboresTipoProceso/insertarLaboresTipoProceso',
	ActDel:'../../sis_workflow/control/LaboresTipoProceso/eliminarLaboresTipoProceso',
	ActList:'../../sis_workflow/control/LaboresTipoProceso/listarLaboresTipoProceso',
	id_store:'id_labores_tipo_proceso',
	fields: [
		{name:'id_labores_tipo_proceso', type: 'numeric'},
		{name:'id_tipo_proceso', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_tipo_proceso', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_labores_tipo_proceso',
		direction: 'ASC'
	},
	south:{
          url:'../../../sis_workflow/vista/funcionario_tipo_estado/FuncionarioTipoEstado.php',
          title:'Funcionarios x Tipo Estado', 
          height: 400,
          cls:'FuncionarioTipoEstado'
        },
	bdel:true,
	bsave:true
	}
)
</script>
		
		