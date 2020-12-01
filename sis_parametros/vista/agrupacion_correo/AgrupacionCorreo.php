<?php
/****************************************************************************************
*@package pXP
*@file gen-AgrupacionCorreo.php
*@author  (egutierrez)
*@date 26-11-2020 15:27:53
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema

HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                26-11-2020 15:27:53    egutierrez            Creacion    
 #   

*******************************************************************************************/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AgrupacionCorreo=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.AgrupacionCorreo.superclass.constructor.call(this,config);
        this.init();
        this.iniciarEventos();
        var dataPadre = Phx.CP.getPagina(this.idContenedorPadre).getSelectedData()
        if(dataPadre){
            this.onEnablePanel(this, dataPadre);
        } else {
            this.bloquearMenus();
        }

    },
    iniciarEventos:function(){
        let fecha =  new Date();
        this.Cmp.id_funcionario.store.baseParams.fecha =fecha = Ext.util.Format.date(fecha,'d/m/Y');
        this.ocultarComponente(this.Cmp.correo);
    },
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_agrupacion_correo'
            },
            type:'Field',
            form:true 
        },
        {
            //configuracion del componente
            config:{
                labelSeparator:'',
                inputType:'hidden',
                name: 'id_tipo_envio_correo'
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
                filters:{pfiltro:'cor.estado_reg',type:'string'},
                id_grupo:1,
                grid:true,
                form:false
		},
        {
            config:{
                name:'id_funcionario',
                hiddenName: 'id_funcionario',
                origen:'FUNCIONARIOCAR',
                fieldLabel:'Funcionario',
                allowBlank:true,
                gwidth:200,
                valueField: 'id_funcionario',
                gdisplayField: 'desc_funcionario',
                baseParams: {par_filtro: 'id_funcionario#desc_funcionario1'},
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario1']);}
            },
            type:'ComboRec',//ComboRec
            id_grupo:0,
            filters:{pfiltro:'fun.desc_funcionario1',type:'string'},
            bottom_filter:false,
            grid:true,
            form:true,
            bottom_filter:true //#20
        },
        {
            config:{
                name: 'correo',
                fieldLabel: 'correo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
            	maxLength:100,
                renderer:function(value, p, record){return String.format('{0}', record.data['email_empresa']);}
            },
                type:'TextField',
                filters:{pfiltro:'cor.correo',type:'string'},
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
                filters:{pfiltro:'cor.fecha_reg',type:'date'},
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
                filters:{pfiltro:'cor.id_usuario_ai',type:'numeric'},
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
                filters:{pfiltro:'cor.usuario_ai',type:'string'},
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
                filters:{pfiltro:'cor.fecha_mod',type:'date'},
                id_grupo:1,
                grid:true,
                form:false
		}
    ],
    tam_pag:50,    
    title:'Correos',
    ActSave:'../../sis_parametros/control/AgrupacionCorreo/insertarAgrupacionCorreo',
    ActDel:'../../sis_parametros/control/AgrupacionCorreo/eliminarAgrupacionCorreo',
    ActList:'../../sis_parametros/control/AgrupacionCorreo/listarAgrupacionCorreo',
    id_store:'id_agrupacion_correo',
    fields: [
		{name:'id_agrupacion_correo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'correo', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
        {name:'id_tipo_envio_correo', type: 'numeric'},
        {name:'desc_funcionario1', type: 'string'},
        {name:'email_empresa', type: 'string'},
        
    ],
    sortInfo:{
        field: 'id_agrupacion_correo',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true,

    onReloadPage: function(m) {
            this.maestro = m;
            this.Atributos[1].valorInicial = this.maestro.id_tipo_envio_correo;
            //Define the filter to apply for activos fijod drop down
            this.store.baseParams = {
                id_tipo_envio_correo: this.maestro.id_tipo_envio_correo,
            };
            this.load({
                params: {
                    start: 0,
                    limit: 50
                }
            });
    },
    },
)
</script>
        
        