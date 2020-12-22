<?php
/****************************************************************************************
*@package pXP
*@file gen-TipoAgrupacionCorreo.php
*@author  (egutierrez)
*@date 26-11-2020 15:26:10
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema

HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                26-11-2020 15:26:10    egutierrez            Creacion    
 #   

*******************************************************************************************/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoEnvioCorreo=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.TipoEnvioCorreo.superclass.constructor.call(this,config);
        this.init();
        this.inciarEventos();
        this.load({params:{start:0, limit:this.tam_pag}})
        this.addButton('btnPlaMen',
            {
                text: 'Plantilla de Correo',
                iconCls: 'bchecklist',
                disabled: true,
                handler: this.formPlantilleMensaje,
                tooltip: '<b>Plantilla de Correo</b><br/>Personaliza los correos enviados en alertas en tipo de estado seleccionado.'
            }
        );
    },
    inciarEventos: function(){
        this.ocultarComponente(this.Cmp.script);
        this.Cmp.script.allowBlank=true;

        this.Cmp.script_habilitado.on('select',function(combo,record,index){

            if(record.data.valor =='si'){
                this.mostrarComponente(this.Cmp.script);
                this.Cmp.script.allowBlank=false;
                this.ocultarComponente(this.Cmp.columna_llave);
                this.ocultarComponente(this.Cmp.tabla);
                this.Cmp.columna_llave.reset();
                this.Cmp.tabla.reset();

            }else{
                this.ocultarComponente(this.Cmp.script);
                this.Cmp.script.reset();
                this.mostrarComponente(this.Cmp.columna_llave);
                this.mostrarComponente(this.Cmp.tabla);
                this.Cmp.columna_llave.allowBlank=false;
                this.Cmp.tabla.allowBlank=false;




            }
        },this)
    },
    Atributos:[
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
                filters:{pfiltro:'grc.estado_reg',type:'string'},
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
            	maxLength:20
            },
                type:'TextField',
                filters:{pfiltro:'grc.codigo',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'descripcion',
                fieldLabel: 'descripcion',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
            	maxLength:500
            },
                type:'TextField',
                filters:{pfiltro:'grc.descripcion',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'dias_envio',
                fieldLabel: 'Dias envio',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
            	maxLength:500
            },
                type:'TextField',
                filters:{pfiltro:'grc.dias_envio',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'dias_consecutivo',
                fieldLabel: 'Dias consecutivo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
            	maxLength:2
            },
                type:'NumberField',
                filters:{pfiltro:'grc.dias_consecutivo',type:'string'},
                id_grupo:1,
                grid:true,
                form:true
		},
        {
            config:{
                name: 'dias_vencimiento',
                fieldLabel: 'Dias vencimiento',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:500
            },
            type:'NumberField',
            filters:{pfiltro:'grc.dias_envio',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name:'habilitado',
                fieldLabel:'Habilitado',
                allowBlank:false,
                emptyText:'...',
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                gwidth: 100,
                store:new Ext.data.ArrayStore({
                    fields: ['ID', 'valor'],
                    data :    [['si','si'],
                        ['no','no']]

                }),
                valueField:'ID',
                displayField:'valor',
                //renderer:function (value, p, record){if (value == 1) {return 'si'} else {return 'no'}}
            },
            type:'ComboBox',
            valorInicial:'no',
            id_grupo:0,
            grid:true,
            form:true
        },
        {
            config:{
                name:'script_habilitado',
                fieldLabel:'script?',
                allowBlank:false,
                emptyText:'...',
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode: 'local',
                gwidth: 100,
                store:new Ext.data.ArrayStore({
                    fields: ['ID', 'valor'],
                    data :    [['si','si'],
                        ['no','no']]

                }),
                valueField:'ID',
                displayField:'valor',
                //renderer:function (value, p, record){if (value == 1) {return 'si'} else {return 'no'}}
            },
            type:'ComboBox',
            valorInicial: 'no',
            id_grupo:0,
            grid:false,
            form:true
        },

        {
            config:{
                name: 'script',
                fieldLabel: 'script',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength:200
            },
            type:'TextField',
            id_grupo:0,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'columna_llave',
                fieldLabel: 'Columna Llave',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength:20
            },
            type:'TextField',
            id_grupo:0,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'tabla',
                fieldLabel: 'Tabla',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength:20
            },
            type:'TextField',
            id_grupo:0,
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
                filters:{pfiltro:'grc.fecha_reg',type:'date'},
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
                filters:{pfiltro:'grc.id_usuario_ai',type:'numeric'},
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
                filters:{pfiltro:'grc.usuario_ai',type:'string'},
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
                filters:{pfiltro:'grc.fecha_mod',type:'date'},
                id_grupo:1,
                grid:true,
                form:false
		}
    ],
    tam_pag:50,    
    title:'Grupos de Correo',
    ActSave:'../../sis_parametros/control/TipoEnvioCorreo/insertarTipoEnvioCorreo',
    ActDel:'../../sis_parametros/control/TipoEnvioCorreo/eliminarTipoEnvioCorreo',
    ActList:'../../sis_parametros/control/TipoEnvioCorreo/listarTipoEnvioCorreo',
    id_store:'id_tipo_envio_correo',
    fields: [
		{name:'id_tipo_envio_correo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'dias_envio', type: 'string'},
		{name:'dias_consecutivo', type: 'string'},
		{name:'habilitado', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
        {name:'dias_vencimiento', type: 'numeric'},
        {name:'script', type: 'string'},'plantilla_mensaje_asunto','plantilla_mensaje',
        {name:'script_habilitado', type: 'string'},
        {name:'columna_llave', type: 'string'},
        {name:'tabla', type: 'string'}


    ],
    sortInfo:{
        field: 'id_tipo_envio_correo',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true,
    tabsouth: [
        {
            url:'../../../sis_parametros/vista/agrupacion_correo/AgrupacionCorreo.php',
            title:'Correos',
            height:'50%',
            cls:'AgrupacionCorreo'
        }],

    formPlantilleMensaje:function(wizard,resp){
        var rec=this.sm.getSelected();
        Phx.CP.loadWindows('../../../sis_parametros/vista/tipo_envio_correo/PlantillaMensaje.php',
            'Estado de Wf',
            {
                modal:true,
                width:'80%',
                height:400
            }, {data:rec.data},
            this.idContenedor,
            'PlantillaMensaje'
        )

    },
    preparaMenu:function(n){
        var rec=this.sm.getSelected();
        Phx.vista.TipoEnvioCorreo.superclass.preparaMenu.call(this,n);
        console.log('rec',rec.data.script_habilitado);
        if(rec.data.script_habilitado == 'si'){
            this.getBoton('btnPlaMen').disable();
        }
        else{
            this.getBoton('btnPlaMen').enable();
        }


        return this.tbar;
    },

    liberaMenu:function(){
        var tb = Phx.vista.TipoEnvioCorreo.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('btnPlaMen').disable();
        }
        return tb
    },
    onButtonEdit:function(){
        //llamamos primero a la funcion new de la clase padre por que reseta el valor los componentesSS
        Phx.vista.TipoEnvioCorreo.superclass.onButtonEdit.call(this);
        var data = this.getSelectedData();

        if (data.script_habilitado =='si' ){
            this.mostrarComponente(this.Cmp.script);
            this.ocultarComponente(this.Cmp.columna_llave);
            this.ocultarComponente(this.Cmp.tabla);
            this.Cmp.columna_llave.reset();
            this.Cmp.tabla.reset();

        }else{
            this.ocultarComponente(this.Cmp.script);
            this.Cmp.script.reset();
            this.mostrarComponente(this.Cmp.columna_llave);
            this.mostrarComponente(this.Cmp.tabla);

        }

    }


    },

)
</script>
        
        