<?php
/**
*@package pXP
*@file gen-Grupo.php
*@author  (admin)
*@date 22-04-2013 14:20:57
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Grupo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Grupo.superclass.constructor.call(this,config);
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
					name: 'id_grupo'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 180,
				maxLength:400
			},
			type:'TextField',
			filters:{pfiltro:'gru.nombre',type:'string'},
			id_grupo:1,
            bottom_filter:true,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'obs',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'gru.obs',type:'string'},
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
            filters:{pfiltro:'gru.estado_reg',type:'string'},
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
			filters:{pfiltro:'gru.fecha_reg',type:'date'},
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'gru.fecha_mod',type:'date'},
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
	
	title:'Grupos de EP',
	ActSave:'../../sis_parametros/control/Grupo/insertarGrupo',
	ActDel:'../../sis_parametros/control/Grupo/eliminarGrupo',
	ActList:'../../sis_parametros/control/Grupo/listarGrupo',
	id_store:'id_grupo',
	fields: [
		{name:'id_grupo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'obs', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
        {name:'id_usuario', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_grupo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,

    tabeast:[
        {
            url:'../../../sis_parametros/vista/grupo_ep/GrupoEp.php',
            title:'Roles',
            width:400,
            cls:'GrupoEp'
        },
        {
            url:'../../../sis_parametros/vista/usuarios_ep/UsuariosEp.php',
            title:'Usuarios',
            width:400,
            cls:'UsuariosEp'
        }
    ]

    })
</script>
		
		