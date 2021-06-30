<?php
/****************************************************************************************
 * @package pXP
 * @file FuncionarioDispositivo.php
 * @author  (valvarado)
 * @date 30-03-2021 15:11:51
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 *
 * HISTORIAL DE MODIFICACIONES:
 * #ISSUE                FECHA                AUTOR                DESCRIPCION
 * #0                30-03-2021 15:11:51    valvarado            Creacion
 * #
 *******************************************************************************************/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.FuncionarioDispositivo = Ext.extend(Phx.gridInterfaz, {

            constructor: function (config) {
                this.maestro = config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.FuncionarioDispositivo.superclass.constructor.call(this, config);
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
                        name: 'estado_reg',
                        fieldLabel: 'Estado Reg.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 10
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'fundisp.estado_reg', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'desc_funcionario1',
                        fieldLabel: 'Funcionario',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 100
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'fun_ad.desc_funcionario1', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false,
                    bottom_filter: true,
                },
                {
                    config: {
                        name: 'id_funcionario',
                        hiddenName: 'id_funcionario',
                        origen: 'FUNCIONARIO',
                        fieldLabel: 'Funcionario',
                        allowBlank: false,
                        width: '100%',
                        anchor: '100%',
                        valueField: 'id_funcionario',
                        gdisplayField: 'desc_funcionario',
                        baseParams: {par_filtro: 'FUNCIO.id_funcionario#desc_funcionario1'},
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
                        name: 'token',
                        fieldLabel: 'token',
                        allowBlank: false,
                        anchor: '100%',
                        gwidth: 100,
                    },
                    type: 'TextArea',
                    filters: {pfiltro: 'fundisp.token', type: 'string'},
                    id_grupo: 1,
                    grid: true,
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
                    filters: {pfiltro: 'fundisp.fecha_reg', type: 'date'},
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
                    filters: {pfiltro: 'fundisp.id_usuario_ai', type: 'numeric'},
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
                    filters: {pfiltro: 'fundisp.usuario_ai', type: 'string'},
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
                    filters: {pfiltro: 'fundisp.fecha_mod', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                }
            ],
            tam_pag: 50,
            title: 'Dispositivos',
            ActSave: '../../sis_parametros/control/FuncionarioDispositivo/insertarFuncionarioDispositivo',
            ActDel: '../../sis_parametros/control/FuncionarioDispositivo/eliminarFuncionarioDispositivo',
            ActList: '../../sis_parametros/control/FuncionarioDispositivo/listarFuncionarioDispositivo',
            id_store: 'id',
            fields: [
                {name: 'id', type: 'numeric'},
                {name: 'estado_reg', type: 'string'},
                {name: 'id_funcionario', type: 'numeric'},
                {name: 'token', type: 'string'},
                {name: 'id_usuario_reg', type: 'numeric'},
                {name: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'id_usuario_ai', type: 'numeric'},
                {name: 'usuario_ai', type: 'string'},
                {name: 'id_usuario_mod', type: 'numeric'},
                {name: 'fecha_mod', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'usr_reg', type: 'string'},
                {name: 'usr_mod', type: 'string'},
                {name: 'desc_funcionario1', type: 'string'},

            ],
            sortInfo: {
                field: 'id',
                direction: 'ASC'
            },
            bdel: true,
            bsave: true,
            onButtonEdit: function () {
                Phx.vista.FuncionarioDispositivo.superclass.onButtonEdit.call(this);
                var data = this.getSelectedData();
                this.Cmp.id_funcionario.store.baseParams.query = data.desc_funcionario1;
                this.Cmp.id_funcionario.store.load({
                    params: {start: 0, limit: this.tam_pag},
                    callback: function (r) {
                        if (r.length > 0) {
                            this.Cmp.id_funcionario.setValue(r[0].data.id_funcionario);
                            this.Cmp.id_funcionario.fireEvent('select', this.Cmp.id_funcionario, r[0].data.id_funcionario, 0)
                        }

                    }, scope: this
                });
            },
        }
    )
</script>
        
        