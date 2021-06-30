<?php
/****************************************************************************************
 * @package pXP
 * @file Notificaciones.php
 * @author  (valvarado)
 * @date 30-03-2021 15:12:35
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 *
 * HISTORIAL DE MODIFICACIONES:
 * #ISSUE                FECHA                AUTOR                DESCRIPCION
 * #0                30-03-2021 15:12:35    valvarado            Creacion
 * #
 *******************************************************************************************/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Notificaciones = Ext.extend(Phx.gridInterfaz, {

            constructor: function (config) {
                this.maestro = config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.Notificaciones.superclass.constructor.call(this, config);
                this.init();
                this.load({params: {start: 0, limit: this.tam_pag}})
            },

            Atributos: [
                {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'id'
                    },
                    type: 'Field',
                    form: true
                },
                {
                    config: {
                        name: 'enviado',
                        fieldLabel: 'enviado',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: -5
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'noti.enviado', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'desc_fun_emisor',
                        fieldLabel: 'desc_fun_emisor',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: -5
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'fun_emisor.desc_fun_emisor', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'desc_fun_receptor',
                        fieldLabel: 'desc_fun_receptor',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: -5
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'fun_receptor.desc_fun_receptor', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'modulo',
                        fieldLabel: 'modulo',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: -5
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'noti.modulo', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'esquema',
                        fieldLabel: 'esquema',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: -5
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'noti.esquema', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'nombre_vista',
                        fieldLabel: 'nombre_vista',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: -5
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'noti.nombre_vista', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'id_estado_wf',
                        fieldLabel: 'Estado WF',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'noti.id_estado_wf', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'id_proceso_wf',
                        fieldLabel: 'Proceso WF',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'noti.id_proceso_wf', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'estado_reg',
                        fieldLabel: 'Estado Reg.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 10
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'noti.estado_reg', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'id_funcionario_emisor',
                        hiddenName: 'id_funcionario_emisor',
                        origen: 'FUNCIONARIO',
                        fieldLabel: 'Funcionario Emisor',
                        allowBlank: false,
                        width: '100%',
                        anchor: '100%',
                        valueField: 'id_funcionario_emisor',
                        gdisplayField: 'desc_funcionario',
                        baseParams: {par_filtro: 'FUNCIO.id_funcionario_emisor#desc_funcionario1'},
                        renderer: function (value, p, record) {
                            return String.format('{0}', record.data['desc_funcionario']);
                        }
                    },
                    type: 'ComboRec',
                    id_grupo: 2,
                    filters: {pfiltro: 'fun_ad.desc_funcionario1', type: 'string'},
                    bottom_filter: true,
                    grid: false,
                    form: true
                },
                {
                    config: {
                        name: 'id_funcionario_receptor',
                        hiddenName: 'id_funcionario_receptor',
                        origen: 'FUNCIONARIO',
                        fieldLabel: 'Funcionario receptor',
                        allowBlank: false,
                        width: '100%',
                        anchor: '100%',
                        valueField: 'id_funcionario_receptor',
                        gdisplayField: 'desc_funcionario',
                        baseParams: {par_filtro: 'FUNCIO.id_funcionario_receptor#desc_funcionario1'},
                        renderer: function (value, p, record) {
                            return String.format('{0}', record.data['desc_funcionario']);
                        }
                    },
                    type: 'ComboRec',
                    id_grupo: 2,
                    filters: {pfiltro: 'fun_ad.desc_funcionario1', type: 'string'},
                    bottom_filter: true,
                    grid: false,
                    form: true
                },
                {
                    config: {
                        name: 'usr_reg',
                        fieldLabel: 'Creado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'usu1.cuenta', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'fecha_reg',
                        fieldLabel: 'Fecha creación',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y H:i:s') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'noti.fecha_reg', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'id_usuario_ai',
                        fieldLabel: 'Fecha creación',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'noti.id_usuario_ai', type: 'numeric'},
                    id_grupo: 1,
                    grid: false,
                    form: false
                },
                {
                    config: {
                        name: 'usuario_ai',
                        fieldLabel: 'Funcionaro AI',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 300
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'noti.usuario_ai', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'usr_mod',
                        fieldLabel: 'Modificado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'usu2.cuenta', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'fecha_mod',
                        fieldLabel: 'Fecha Modif.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y H:i:s') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'noti.fecha_mod', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                }
            ],
            tam_pag: 50,
            title: 'Notificaciones',
            ActSave: '../../sis_parametros/control/Notificaciones/insertarNotificaciones',
            ActDel: '../../sis_parametros/control/Notificaciones/eliminarNotificaciones',
            ActList: '../../sis_parametros/control/Notificaciones/listarNotificaciones',
            id_store: 'id',
            fields: [
                {name: 'id', type: 'numeric'},
                {name: 'estado_reg', type: 'string'},
                {name: 'id_funcionario_emisor', type: 'numeric'},
                {name: 'id_funcionario_receptor', type: 'numeric'},
                {name: 'id_proceso_wf', type: 'numeric'},
                {name: 'id_estado_wf', type: 'numeric'},
                {name: 'modulo', type: 'string'},
                {name: 'esquema', type: 'string'},
                {name: 'id_usuario_reg', type: 'numeric'},
                {name: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'id_usuario_ai', type: 'numeric'},
                {name: 'usuario_ai', type: 'string'},
                {name: 'id_usuario_mod', type: 'numeric'},
                {name: 'fecha_mod', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'usr_reg', type: 'string'},
                {name: 'usr_mod', type: 'string'},
                {name: 'enviado', type: 'string'},
                {name: 'desc_fun_emisor', type: 'string'},
                {name: 'desc_fun_receptor', type: 'string'},
                {name: 'nombre_vista', type: 'string'}

            ],
            sortInfo: {
                field: 'id',
                direction: 'ASC'
            },
            bdel: true,
            bsave: true
        }
    )
</script>
        
        