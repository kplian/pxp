<?php
/**
*@package pXP
*@file gen-UsuarioGrupoEp.php
*@author  (admin)
*@date 22-04-2013 15:53:08
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.UsuarioGrupoEp=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.UsuarioGrupoEp.superclass.constructor.call(this,config);
		this.init();

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
					name: 'id_usuario_grupo_ep'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_usuario',
				    inputType:'hidden'
			},
			type:'Field',
			form:true
		},
		{
            config: {
                name: 'id_grupo',
                fieldLabel: 'Grupo EP',
                typeAhead: false,
                forceSelection: true,
                allowBlank: false,
                emptyText: 'EP\'s',
                store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/Grupo/listarGrupo',
                    id: 'id_grupo',
                    root: 'datos',
                    sortInfo: {
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_grupo', 'nombre', 'obs'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {par_filtro: 'nombre'}
                }),
                valueField: 'id_grupo',
                displayField: 'nombre',
                gdisplayField: 'desc_grupo',
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                anchor: '80%',
                minChars: 2,
                gwidth: 200,
                renderer: function(value, p, record) {
                    return String.format('{0}', record.data['desc_grupo']);
                }
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'gr.nombre',
                type: 'string'
            },
			//bottom_filter:true,
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
			filters:{pfiltro:'uep.fecha_reg',type:'date'},
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
            filters:{pfiltro:'uep.estado_reg',type:'string'},
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
			filters:{pfiltro:'uep.fecha_mod',type:'date'},
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
	
	title:'Usuario EP',
	ActSave:'../../sis_seguridad/control/UsuarioGrupoEp/insertarUsuarioGrupoEp',
	ActDel:'../../sis_seguridad/control/UsuarioGrupoEp/eliminarUsuarioGrupoEp',
	ActList:'../../sis_seguridad/control/UsuarioGrupoEp/listarUsuarioGrupoEp',
	id_store:'id_usuario_grupo_ep',
	fields: [
		{name:'id_usuario_grupo_ep', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario', type: 'numeric'},
		{name:'id_grupo', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_grupo'
		
	],
	onReloadPage:function(m){
        this.maestro=m;
        this.store.baseParams={id_usuario:this.maestro.id_usuario};
        this.load({params:{start:0, limit:50}})
    },
    loadValoresIniciales:function()
    {
        Phx.vista.UsuarioGrupoEp.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_usuario').setValue(this.maestro.id_usuario);       
    },
	sortInfo:{
		field: 'id_usuario_grupo_ep',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		