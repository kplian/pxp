<?php
/**
*@package   pXP
*@file      Catalogo.php
*@author    (admin)
*@date      16-11-2012 17:01:40
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Catalogo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Catalogo.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_catalogo'
			},
			type:'Field',
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
			filters:{pfiltro:'cat.estado_reg',type:'string'},
			id_grupo:1,
			grid:false,
			form:false
		},
		{
            config:{                
                name:'tipo',
                fieldLabel:'Tipo',
                allowBlank:false,
                emptyText:'Tipo...',
                store: ['estado_ot','prioridad_ot','tipo_ot','prioridad_uc'],
                valueField: 'tipo',
                displayField: 'tipo',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',
                pageSize:10,
                width:270,               
                renderer:function(value, p, record){return String.format('{0}', record.data['tipo']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'tipo',
                type:'string'
            },
            grid:true,
            form:true
        },
		{
            config:{
                name:'id_subsistema',
                fieldLabel:'Subsistema',
                allowBlank:false,
                emptyText:'Subsistema...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_seguridad/control/Subsistema/listarSubsistema',
                    id: 'id_subsistema',
                    root: 'datos',
                    sortInfo:{
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_subsistema','nombre','codigo'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'nombre#codigo'}
                }),
                valueField: 'id_subsistema',
                displayField: 'nombre',
                gdisplayField: 'codigo',
                hiddenName: 'id_subsistema',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:270,
                minChars:2,
                enableMultiSelect:true,
            
                renderer:function(value, p, record){return String.format('{0}', record.data['nombre']);}

            },
            type:'ComboBox',
            id_grupo:0,
            filters:{
                   pfiltro:'nombre',
                   type:'string'
            },
            grid:true,
            form:true
        },
		{
            config:{
                name: 'codigo',
                fieldLabel: 'Codigo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:20
            },
            type:'TextField',
            filters:{pfiltro:'cat.codigo',type:'string'},
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
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'cat.descripcion',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'cat.fecha_reg',type:'date'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'cat.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Catalogo',
	ActSave:'../../sis_parametros/control/Catalogo/insertarCatalogo',
	ActDel:'../../sis_parametros/control/Catalogo/eliminarCatalogo',
	ActList:'../../sis_parametros/control/Catalogo/listarCatalogo',
	id_store:'id_catalogo',
	fields: [
		{name:'id_catalogo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'id_subsistema', type: 'numeric'},
		{name:'nombre',type:'string'},
		{name:'descripcion', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_catalogo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		