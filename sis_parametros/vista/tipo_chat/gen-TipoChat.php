<?php
/****************************************************************************************
*@package pXP
*@file gen-TipoChat.php
*@author  (admin)
*@date 05-06-2020 16:49:24
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema

HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                05-06-2020 16:49:24    admin            Creacion    
 #   

*******************************************************************************************/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoChat=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.TipoChat.superclass.constructor.call(this,config);
        this.init();
        this.load({params:{start:0, limit:this.tam_pag}})
    },
            
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_tipo_chat'
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
                filters:{pfiltro:'ttc.estado_reg',type:'string'},
                id_grupo:1,
                grid:true,
                form:false
		},
        {
            config:{
                name: 'codigo',
                fieldLabel: 'codigo',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
            	maxLength:255
            },
                type:'TextField',
                filters:{pfiltro:'ttc.codigo',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'grupo',
                fieldLabel: 'grupo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
            	maxLength:2
            },
                type:'TextField',
                filters:{pfiltro:'ttc.grupo',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'tabla',
                fieldLabel: 'tabla',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
            	maxLength:255
            },
                type:'TextField',
                filters:{pfiltro:'ttc.tabla',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'nombre_id',
                fieldLabel: 'nombre_id',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
            	maxLength:255
            },
                type:'TextField',
                filters:{pfiltro:'ttc.nombre_id',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'tipo_chat',
                fieldLabel: 'tipo_chat',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
            	maxLength:255
            },
                type:'TextField',
                filters:{pfiltro:'ttc.tipo_chat',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'nombre',
                fieldLabel: 'nombre',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
            	maxLength:255
            },
                type:'TextField',
                filters:{pfiltro:'ttc.nombre',type:'string'},
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
                name: 'usuario_ai',
                fieldLabel: 'Funcionaro AI',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
            	maxLength:300
            },
                type:'TextField',
                filters:{pfiltro:'ttc.usuario_ai',type:'string'},
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
                filters:{pfiltro:'ttc.fecha_reg',type:'date'},
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
                filters:{pfiltro:'ttc.id_usuario_ai',type:'numeric'},
                id_grupo:1,
                grid:false,
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
                filters:{pfiltro:'ttc.fecha_mod',type:'date'},
                id_grupo:1,
                grid:true,
                form:false
		}
    ],
    tam_pag:50,    
    title:'Tipo Chat',
    ActSave:'../../sis_parametros/control/TipoChat/insertarTipoChat',
    ActDel:'../../sis_parametros/control/TipoChat/eliminarTipoChat',
    ActList:'../../sis_parametros/control/TipoChat/listarTipoChat',
    id_store:'id_tipo_chat',
    fields: [
		{name:'id_tipo_chat', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'grupo', type: 'string'},
		{name:'tabla', type: 'string'},
		{name:'nombre_id', type: 'string'},
		{name:'tipo_chat', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
        
    ],
    sortInfo:{
        field: 'id_tipo_chat',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true
    }
)
</script>
        
        