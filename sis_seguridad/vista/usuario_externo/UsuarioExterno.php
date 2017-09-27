<?php
/**
*@package pXP
*@file gen-UsuarioExterno.php
*@author  (miguel.mamani)
*@date 27-09-2017 13:33:32
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.UsuarioExterno=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.UsuarioExterno.superclass.constructor.call(this,config);
		this.init();
        var dataPadre = Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
        if(dataPadre){
            this.onEnablePanel(this, dataPadre);
        }
        else
        {
            this.bloquearMenus();
        }
        this.addButton('aInterSis',{text:'Generar Amadeus',iconCls: 'blist',disabled:false,handler:this.generarUsuario,tooltip: '<b>Generar ususarios amadeus</b>'});


    },
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_usuario_externo'
			},
			type:'Field',
			form:true 
		},
        {
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_usuario'
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'usuario_externo',
				fieldLabel: 'Usuario Externo',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
				type:'TextField',
				filters:{pfiltro:'ueo.usuario_externo',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
        {
            config : {
                name : 'sistema_externo',
                fieldLabel : 'Sistema Externo',
                anchor : '90%',
                tinit : false,
                allowBlank : false,
                origen : 'CATALOGO',
                gdisplayField : 'descripcion',
                anchor: '80%',
                gwidth: 100,
                baseParams : {
                    cod_subsistema : 'SEGU',
                    catalogo_tipo : 'sistema_externo'
                },
                renderer:function(value, p, record){return String.format('{0}', record.data['sistema_externo']);}
            },
            type : 'ComboRec',
            id_grupo : 1,
            filters : {
                pfiltro : 'dos.glosa_empresa',
                type : 'string'
            },
            grid : true,
            form : true
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
				filters:{pfiltro:'ueo.estado_reg',type:'string'},
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
				filters:{pfiltro:'ueo.fecha_reg',type:'date'},
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
				filters:{pfiltro:'ueo.usuario_ai',type:'string'},
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
				name: 'id_usuario_ai',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'ueo.id_usuario_ai',type:'numeric'},
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
				filters:{pfiltro:'ueo.fecha_mod',type:'date'},
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
	title:'Usuario Externo',
	ActSave:'../../sis_seguridad/control/UsuarioExterno/insertarUsuarioExterno',
	ActDel:'../../sis_seguridad/control/UsuarioExterno/eliminarUsuarioExterno',
	ActList:'../../sis_seguridad/control/UsuarioExterno/listarUsuarioExterno',
	id_store:'id_usuario_externo',
	fields: [
		{name:'id_usuario_externo', type: 'numeric'},
		{name:'id_usuario', type: 'numeric'},
		{name:'usuario_externo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'sistema_externo', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_usuario_externo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,

    loadValoresIniciales:function(){
        Phx.vista.UsuarioExterno.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_usuario').setValue(this.maestro.id_usuario);
    },

    onReloadPage:function(m){
        this.maestro=m;
        this.store.baseParams={id_usuario:this.maestro.id_usuario};
        this.load({params:{start:0, limit:50}})
    },
    generarUsuario:function () {
        Ext.Ajax.request({
            url:'../../sis_seguridad/control/UsuarioExterno/generarUsuarioAmedeos',
            params:{id_usuario:this.maestro.id_usuario},
            success: function(resp){
                Phx.CP.loadingHide();
                var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                if (reg.ROOT.error) {
                    Ext.Msg.alert('Error','Validación no realizada: '+reg.ROOT.error)
                } else {
                    this.reload();
                    Ext.Msg.alert('Mensaje','Proceso ejecutado con éxito')
                }
            },
            failure: this.conexionFailure,
            timeout: this.timeout,
            scope:this
        });
    }
	}
)
</script>
		
		