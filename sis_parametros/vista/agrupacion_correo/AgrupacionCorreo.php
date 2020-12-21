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
                name : 'funcionario',
                fieldLabel : 'Funcionario o Depto ??',
                allowBlank: false,
                items: [
                    {boxLabel: 'Si', name: 'funcionario', inputValue: 'si', checked: true},
                    {boxLabel: 'No', name: 'funcionario', inputValue: 'no'}

                ],
            },
            type : 'RadioGroupField',
            id_grupo : 1,
            form : true,
            grid:false
        },

        {
            config:{
                name:'id_funcionario',
                hiddenName: 'id_funcionario',
                origen:'FUNCIONARIOCAR',
                fieldLabel:'Funcionario',
                allowBlank:false,
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
                name:'id_depto',
                hiddenName: 'id_depto',
                url: '../../sis_parametros/control/Depto/listarDeptoFiltradoXUsuario',
                origen: 'DEPTO',
                allowBlank: false,
                fieldLabel: 'Depto',
                disabled: true,
                width: '80%',
                baseParams:{par_filtro:'id_depto#deppto.nombre#deppto.codigo', estado:'activo'},
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_depto']);}
            },
            type:'ComboRec',
            id_grupo: 1,
            form:true,
            grid:true
        },
        {
            config:{
                name: 'cargo',
                fieldLabel: 'Cargo',
                allowBlank: false,
                emptyText: 'Elegir ...',
                tinit:false,
                resizable:true,
                tasignacion:false,
                store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/Catalogo/listarCatalogoCombo',
                    id : 'id_catalogo',
                    root: 'datos',
                    sortInfo:{
                        field: 'orden',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_catalogo','codigo','descripcion'],
                    remoteSort: true,
                    baseParams:{par_filtro:'descripcion',cod_subsistema : 'PARAM',catalogo_tipo : 'tdepto_usuario_cargo'}
                }),
                tpl:'<tpl for="."><div class="x-combo-list-item" ><div class="awesomecombo-item {checked}"><p><b>{codigo}</b></p></div></div></tpl>',
                valueField: 'codigo',
                displayField: 'codigo',
                gdisplayField: 'codigo',
                hiddenName: 'codigo',
                forceSelection:true,
                typeAhead: false,
                triggerAction: 'all',
                listWidth:500,
                //resizable:true,
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width: 250,
                enableMultiSelect:true,
                gwidth:250,
                minChars:2,
                anchor:'80%',
                qtip:'Procesos de solicitutes de compra',
                renderer:function(value, p, record){return String.format('{0}', record.data['cargo']);}
            },
            type:'AwesomeCombo',
            id_grupo:1,
            grid:true,
            form:true
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
        {name:'funcionario', type: 'string'},
        {name:'id_depto', type: 'numeric'},
        {name:'desc_depto', type: 'string'},
        {name:'cargo', type: 'string'},

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

    onButtonNew: function() {
        this.ocultarComponente(this.Cmp.id_depto);
        this.ocultarComponente(this.Cmp.cargo);
        Phx.vista.AgrupacionCorreo.superclass.onButtonNew.call(this);

        this.Cmp.id_depto.enable();
        this.Cmp.funcionario.on('change', function(cmp, check){

            if( check.getRawValue() =='no' ){
                this.ocultarComponente(this.Cmp.id_funcionario);
                this.mostrarComponente(this.Cmp.id_depto);
                this.Cmp.id_funcionario.reset();
                this.Cmp.id_funcionario.allowBlank = true;
                this.Cmp.id_depto.allowBlank = false;
                this.Cmp.id_depto.enable();
                this.mostrarComponente(this.Cmp.cargo);
            }
            else{
                ///depto
                this.mostrarComponente(this.Cmp.id_funcionario);
                this.ocultarComponente(this.Cmp.id_depto);
                this.Cmp.id_depto.reset();
                this.Cmp.id_depto.allowBlank = true;
                this.Cmp.id_funcionario.allowBlank = false;
                this.Cmp.id_depto.enable();
                this.ocultarComponente(this.Cmp.cargo);
                this.Cmp.cargo.reset();
            }

        }, this);
    },
    onButtonEdit: function() {
        var data = this.getSelectedData();
        Phx.vista.AgrupacionCorreo.superclass.onButtonEdit.call(this);

        this.Cmp.funcionario.on('change', function(cmp, check){
            if(check.getRawValue() =='no'){
                this.ocultarComponente(this.Cmp.id_funcionario);
                this.mostrarComponente(this.Cmp.id_depto);
                this.Cmp.id_funcionario.reset();
                this.Cmp.id_funcionario.allowBlank = true;
                this.Cmp.id_depto.allowBlank = false;
                this.mostrarComponente(this.Cmp.cargo);

            }
            else{
                this.mostrarComponente(this.Cmp.id_funcionario);
                this.ocultarComponente(this.Cmp.id_depto);
                this.Cmp.id_depto.reset();
                this.Cmp.id_depto.allowBlank = true;
                this.Cmp.id_funcionario.allowBlank = false;
                this.ocultarComponente(this.Cmp.cargo);
                this.Cmp.cargo.reset();
                this.Cmp.cargo.allowBlank = true;
            }

        }, this);

        if( data.id_funcionario != null ){
            console.log('r',this.Cmp.funcionario);
            this.Cmp.funcionario.setValue('si');
            this.Cmp.id_funcionario.store.baseParams.query =  data.id_funcionario;
            this.Cmp.id_funcionario.store.load({params:{start:0,limit:this.tam_pag},
                callback : function (r) {
                    if (r.length > 0 ) {

                        this.Cmp.id_funcionario.setValue(r[0].data.id_funcionario);
                    }

                }, scope : this
            });

            this.Cmp.id_funcionario.enable();

        }else{
            this.Cmp.funcionario.setValue('no');
            this.Cmp.id_depto.store.baseParams.query =  data.id_depto;
            this.Cmp.id_depto.store.load({params:{start:0,limit:this.tam_pag},
                callback : function (r) {
                    if (r.length > 0 ) {

                        this.Cmp.id_depto.setValue(data.id_depto);
                    }

                }, scope : this
            });

            this.Cmp.id_depto.enable();

        }
    },


    },
)
</script>
        
        