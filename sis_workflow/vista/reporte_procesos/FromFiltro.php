<?php
/**
 *@package pXP
 *@file    FormFiltro.php
 *@author  Miguel Alejandro Mamani Villegas
 *@date    20-03-2017
 *@description permite filtrar varios campos antes de mostrar el contenido de una grilla
 */
header("content-type: text/javascript; charset=UTF-8");
?>

<script>
    Phx.vista.FormFiltro=Ext.extend(Phx.frmInterfaz,{
        constructor:function(config)
        {
            this.panelResumen = new Ext.Panel({html:''});
            this.Grupos = [{

                xtype: 'fieldset',
                border: false,
                autoScroll: true,
                layout: 'form',
                items: [],
                id_grupo: 0

            },
                this.panelResumen
            ];

            Phx.vista.FormFiltro.superclass.constructor.call(this,config);
            this.init();

            Ext.Ajax.request({
                url:'../../sis_gestion_materiales/control/Solicitud/getDatos',
                params:{id_usuario: 0},
                success:function(resp){
                    var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                    console.log('funcionarios',reg);
                    this.Cmp.id_funcionario.setValue(reg.ROOT.datos.id_funcionario);
                    this.Cmp.id_funcionario.setRawValue(reg.ROOT.datos.nombre_completo1);
                },
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });

        },

        Atributos:[


            {
                config:{
                    name:'id_funcionario',
                    hiddenName: 'id_funcionario',
                    origen:'FUNCIONARIOCAR',
                    fieldLabel:'Funcionario',
                    allowBlank:true,
                    gwidth:100,
                    anchor: '97%',
                    valueField: 'id_funcionario',
                    gdisplayField: 'desc_funcionario',
                    tpl:'<tpl for="."><div class="x-combo-list-item"><p style="color:#000000">{desc_funcionario1}</p><p style="color:#0000bf">{nombre_cargo}<br>{email_empresa}</p><p style="color:green">{oficina_nombre} - {lugar_nombre}</p></div></tpl>',

                    renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario']);}
                },
                type:'ComboRec',//ComboRec
                id_grupo:0,
                filters:{pfiltro:'fun.desc_funcionario1',type:'string'},
                bottom_filter:true,
                grid:true,
                form:true
            },
            {
                config:{
                    name: 'desde',
                    fieldLabel: 'Desde',
                    allowBlank: true,
                    format: 'd/m/Y',
                    width: 150,
                    anchor: '97%'
                },
                type: 'DateField',
                id_grupo: 0,
                form: true
            },
            {
                config:{
                    name: 'hasta',
                    fieldLabel: 'Hasta',
                    allowBlank: true,
                    format: 'd/m/Y',
                    width: 150,
                    anchor: '97%'
                },
                type: 'DateField',
                id_grupo: 0,
                form: true
            },
            {
                config: {
                    name: 'id_tipo_proceso',
                    fieldLabel: 'Procesos' ,
                    allowBlank: true,
                    emptyText: 'Elija una opción...',
                    store: new Ext.data.JsonStore({
                        url: '../../sis_workflow/control/BitacorasProcesos/listarBitacorasProceso',
                        id: 'id_tipo_proceso',
                        root: 'datos',
                        sortInfo: {
                            field: 'nombre',
                            direction: 'ASC'
                        },
                        totalProperty: 'total',
                        fields: ['id_tipo_proceso', 'nombre', 'codigo'],
                        remoteSort: true,
                        baseParams: {par_filtro: 't.nombre#t.codigo'}
                    }),
                    valueField: 'id_tipo_proceso',
                    displayField: 'nombre',
                    //gdisplayField: 'desc_orden',
                    tpl: '<tpl for="."><div class="x-combo-list-item"><p><b>{nombre}</b></p>Codigo: <strong>{codigo}</strong> </div></tpl>',
                    // hiddenName: 'id_matricula',
                    forceSelection: true,
                    typeAhead: false,
                    triggerAction: 'all',
                    lazyRender: true,
                    mode: 'remote',
                    pageSize: 20,
                    queryDelay: 1000,
                    anchor: '97%',
                    gwidth: 250,
                    minChars: 2,
                    listWidth:'240',
                    renderer : function(value, p, record) {
                        return String.format('{0}', record.data['nombre']);
                    }
                },
                type: 'ComboBox',
                id_grupo: 0,
                filters: {pfiltro: 't.nombre',type: 'string'},
                grid: true,
                form: true,

            }

        ],
        labelSubmit: '<i class="fa fa-check"></i> Aplicar Filtro',
        east: {
            url: '../../../sis_workflow/vista/reporte_procesos/DetallleProceso.php',
            title: 'Detalle Ejecucion',
            width: '75%',
            cls: 'DetallleProceso'
        },
        /*south: {
         url: '../../../sis_workflow/vista/reporte_procesos/DetallleProceso.php',
         title: 'Detalle Ejecucion',
         height: '70%',
         cls: 'DetallleProceso'
         },*/

        title: 'Filtros Para el Reporte de Ejecución',
        // Funcion guardar del formulario
        onSubmit: function(o) {
            var me = this;
            if (me.form.getForm().isValid()) {
                var parametros = me.getValForm();
                console.log('parametros ....', parametros);
                this.onEnablePanel(this.idContenedor + '-east', parametros)
            }
        }

    })
</script>