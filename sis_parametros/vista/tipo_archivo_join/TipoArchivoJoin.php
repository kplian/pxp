<?php
/**
*@package pXP
*@file gen-TipoArchivoJoin.php
*@author  (favio.figueroa)
*@date 09-08-2017 20:03:38
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoArchivoJoin=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoArchivoJoin.superclass.constructor.call(this,config);
		this.init();
		//this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_archivo_join'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_archivo'
			},
			type:'Field',
			form:true
		},

        {
            config: {
                name: 'tipo',
                fieldLabel: 'Tipo',
                allowBlank: false,
                emptyText: 'Tipo...',
                typeAhead: true,
                triggerAction: 'all',
                lazyRender: true,
                mode: 'local',
                store: ['inner'],
                width: 200
            },
            type: 'ComboBox',
            filters: {pfiltro: 'tajoin.tipo', type: 'string'},
            id_grupo: 1,
            form: true,
            grid: true
        },

        {
            config:{
                name: 'tabla',
                fieldLabel: 'tabla',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'tajoin.tabla',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },

        {
            config:{
                name: 'alias',
                fieldLabel: 'Alias',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'tajoin.alias',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },

		{
			config:{
				name: 'condicion',
				fieldLabel: 'condicion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
				type:'TextField',
				filters:{pfiltro:'tajoin.condicion',type:'string'},
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
				filters:{pfiltro:'tajoin.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: '',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'tajoin.id_usuario_ai',type:'numeric'},
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
				filters:{pfiltro:'tajoin.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
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
				filters:{pfiltro:'tajoin.usuario_ai',type:'string'},
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
				filters:{pfiltro:'tajoin.fecha_mod',type:'date'},
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
		}
	],
	tam_pag:50,	
	title:'Join',
	ActSave:'../../sis_parametros/control/TipoArchivoJoin/insertarTipoArchivoJoin',
	ActDel:'../../sis_parametros/control/TipoArchivoJoin/eliminarTipoArchivoJoin',
	ActList:'../../sis_parametros/control/TipoArchivoJoin/listarTipoArchivoJoin',
	id_store:'id_tipo_archivo_join',
	fields: [
		{name:'id_tipo_archivo_join', type: 'numeric'},
		{name:'tipo', type: 'string'},
		{name:'condicion', type: 'string'},
		{name:'tabla', type: 'string'},
		{name:'id_tipo_archivo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'alias', type: 'string'},

	],
	sortInfo:{
		field: 'id_tipo_archivo_join',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
    preparaMenu: function (tb) {
        // llamada funcion clace padre
        Phx.vista.TipoArchivoJoin.superclass.preparaMenu.call(this, tb)

    },
    onButtonNew: function () {
        Phx.vista.TipoArchivoJoin.superclass.onButtonNew.call(this);

        this.getComponente('id_tipo_archivo').setValue(this.maestro.id_tipo_archivo);
    },
    onReloadPage: function (m) {
        this.maestro = m;
        console.log(this.maestro);

        this.store.baseParams = {id_tipo_archivo: this.maestro.id_tipo_archivo};


        this.load({params: {start: 0, limit: 50}})
    },

	}
)
</script>
		
		