<?php
/**
*@package pXP
*@file gen-Wsmensaje.php
*@author  (favio.figueroa)
*@date 16-06-2017 21:47:08
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Wsmensaje=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Wsmensaje.superclass.constructor.call(this,config);
		this.init();

        this.Cmp.id_usuario.hide();

        this.Cmp.destino.on('select', function(combo, record, index){

            if(record.json[0] == 'Unico'){

                this.Cmp.id_usuario.show();

            }else{
                this.Cmp.id_usuario.hide();

            }
        },this);

		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_wsmensaje'
			},
			type:'Field',
			form:true 
		},

        {
            config: {
                name: 'destino',
                fieldLabel: 'Destino',
                allowBlank: false,
                emptyText: 'tipo...',
                typeAhead: true,
                triggerAction: 'all',
                lazyRender: true,
                mode: 'local',
                store: ['Unico', 'Todos los usuarios contectados'],
                width: 200
            },
            type: 'ComboBox',
            filters: {pfiltro: 'suc.estado', type: 'string'},
            id_grupo: 1,
            form: true,
            grid: true
        },

        {
            config: {
                name: 'tipo',
                fieldLabel: 'Tipo',
                allowBlank: false,
                emptyText: 'tipo...',
                typeAhead: true,
                triggerAction: 'all',
                lazyRender: true,
                mode: 'local',
                store: ['alert', 'notificacion','actualizar pagina'],
                width: 200
            },
            type: 'ComboBox',
            filters: {pfiltro: 'suc.estado', type: 'string'},
            id_grupo: 1,
            form: true,
            grid: true
        },
		{
			config: {
				name: 'id_usuario',
				fieldLabel: 'Usuario',
				allowBlank: true,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_seguridad/control/Usuario/listarUsuario',
					id: 'id_usuario',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_usuario', 'cuenta', 'desc_person'],
					remoteSort: true,
					baseParams: {par_filtro: 'USUARI.cuenta#PERSON.nombre_completo2',ws:'si'}
				}),
				valueField: 'id_usuario',
				displayField: 'desc_person',
				gdisplayField: 'desc_usuario',
				hiddenName: 'id_usuario',
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
					return String.format('{0}', record.data['desc_usuario']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'usu.nombre',type: 'string'},
			grid: true,
			form: true
		},

        {
            config:{
                name: 'titulo',
                fieldLabel: 'Titulo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'wsm.titulo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'mensaje',
                fieldLabel: 'Mensaje',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:500
            },
            type:'TextField',
            filters:{pfiltro:'wsm.mensaje',type:'string'},
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
				filters:{pfiltro:'wsm.estado_reg',type:'string'},
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
				filters:{pfiltro:'wsm.fecha_reg',type:'date'},
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
				filters:{pfiltro:'wsm.usuario_ai',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'wsm.id_usuario_ai',type:'numeric'},
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
				filters:{pfiltro:'wsm.fecha_mod',type:'date'},
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
	title:'WSMensaje',
	ActSave:'../../sis_parametros/control/Wsmensaje/insertarWsmensaje',
	ActDel:'../../sis_parametros/control/Wsmensaje/eliminarWsmensaje',
	ActList:'../../sis_parametros/control/Wsmensaje/listarWsmensaje',
	id_store:'id_wsmensaje',
	fields: [
		{name:'id_wsmensaje', type: 'numeric'},
		{name:'id_usuario', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'titulo', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'mensaje', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_wsmensaje',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		