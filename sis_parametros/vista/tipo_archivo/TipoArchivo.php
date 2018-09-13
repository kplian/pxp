<?php
/**
 * @package pXP
 * @file gen-TipoArchivo.php
 * @author  (admin)
 * @date 05-12-2016 15:03:38
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.TipoArchivo = Ext.extend(Phx.gridInterfaz, {

            constructor: function (config) {
                this.maestro = config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.TipoArchivo.superclass.constructor.call(this, config);


                this.addButton('archivo', {
                    argument: {imprimir: 'archivo'},
                    text: '<i class="fa fa-thumbs-o-up fa-2x"></i> archivo', /*iconCls:'' ,*/
                    disabled: false,
                    handler: this.archivo
                });

                this.addButton('exportar', {
                    argument: {imprimir: 'exportar'},
                    text: '<i class="fa fa-file fa-2x"></i> exportar', /*iconCls:'' ,*/
                    disabled: false,
                    handler: this.exportar
                });


                this.init();
                this.load({params: {start: 0, limit: this.tam_pag}})
            },

            Atributos: [
                {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'id_tipo_archivo'
                    },
                    type: 'Field',
                    form: true
                },
                {
                    config: {
                        name: 'tabla',
                        fieldLabel: 'Tabla',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 255
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'tipar.tabla', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },

                {
                    config: {
                        name: 'nombre_id',
                        fieldLabel: 'Nombre ID',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 255
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'tipar.nombre_id', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },


                {
                    config: {
                        name: 'tipo_archivo',
                        fieldLabel: 'Tipo Archivo',
                        typeAhead: true,
                        allowBlank: false,
                        triggerAction: 'all',
                        emptyText: 'Seleccione Opcion...',
                        selectOnFocus: true,
                        width: 250,
                        mode: 'local',
                        store: new Ext.data.ArrayStore({
                            fields: ['ID', 'valor'],
                            data: [['imagen', 'Imagen'],
                                ['documento', 'Documento']]
                        }),
                        valueField: 'ID',
                        displayField: 'valor'
                    },
                    type: 'ComboBox',
                    valorInicial: 'imagen',
                    filters: {pfiltro: 'tipar.tipo_archivo', type: 'string'},
                    id_grupo: 0,
                    grid: true,
                    form: true
                },


                {
                    config: {
                        name: 'codigo',
                        fieldLabel: 'Codigo',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 255
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'tipar.codigo', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },

                {
                    config: {
                        name: 'nombre',
                        fieldLabel: 'Nombre',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 230,
                        maxLength: 255
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'tipar.nombre', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },

                {
                    config: {
                        name: 'multiple',
                        fieldLabel: 'Multiple',
                        typeAhead: true,
                        allowBlank: false,
                        triggerAction: 'all',
                        emptyText: 'Seleccione Opcion...',
                        selectOnFocus: true,
                        width: 250,
                        mode: 'local',
                        store: new Ext.data.ArrayStore({
                            fields: ['ID', 'valor'],
                            data: [['si', 'Si'],
                                ['no', 'No']]
                        }),
                        valueField: 'ID',
                        displayField: 'valor'
                    },
                    type: 'ComboBox',
                    valorInicial: 'no',
                    filters: {pfiltro: 'tipar.multiple', type: 'string'},
                    id_grupo: 0,
                    grid: true,
                    form: true
                },

                {
                    config: {
                        name: 'extensiones_permitidas',
                        fieldLabel: 'Extensiones Permitidas',
                        typeAhead: true,
                        allowBlank: false,
                        triggerAction: 'all',
                        emptyText: 'Seleccione Opcion...',
                        selectOnFocus: true,
                        width: 250,
                        mode: 'local',
                        //('doc','pdf','docx','jpg','jpeg','bmp','gif','png','PDF','DOC','DOCX','xls','xlsx','XLS','XLSX','rar'),

                        store: new Ext.data.ArrayStore({
                            fields: ['ID', 'valor'],
                            data: [
                                ['doc', 'doc'],
                                ['docx', 'docx'],
                                ['pdf', 'pdf'],
                                ['jpg', 'jpg'],
                                ['jpeg', 'jpeg'],
                                ['bmp', 'bmp'],
                                ['gif', 'gif'],
                                ['png', 'png'],
                                ['PDF', 'PDF'],
                                ['DOC', 'DOC'],
                                ['DOCX', 'DOCX'],
                                ['xls', 'xls'],
                                ['xlsx', 'xlsx'],
                                ['XLS', 'XLS'],
                                ['XLSX', 'XLSX'],
                                ['rar', 'rar'],
                                ['mp4', 'mp4'],
                                ['MP4', 'MP4'],
                            ]
                        }),
                        valueField: 'ID',
                        displayField: 'valor',

                        enableMultiSelect: true
                    },
                    type: 'AwesomeCombo',
                    //valorInicial: 'imagen',
                    filters: {pfiltro: 'tipar.extensiones_permitidas', type: 'string'},
                    id_grupo: 0,
                    grid: true,
                    form: true
                },


                {
                    config: {
                        name: 'obligatorio',
                        fieldLabel: 'Obligatorio',
                        typeAhead: true,
                        allowBlank: false,
                        triggerAction: 'all',
                        emptyText: 'Seleccione Opcion...',
                        selectOnFocus: true,
                        width: 250,
                        mode: 'local',
                        store: new Ext.data.ArrayStore({
                            fields: ['ID', 'valor'],
                            data: [['si', 'Si'],
                                ['no', 'No']]
                        }),
                        valueField: 'ID',
                        displayField: 'valor'
                    },
                    type: 'ComboBox',
                    valorInicial: 'no',
                    filters: {pfiltro: 'tipar.obligatorio', type: 'string'},
                    id_grupo: 0,
                    grid: true,
                    form: true
                },

                {
                    config: {
                        name: 'tamano',
                        fieldLabel: 'Tamaño en Megas',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 1179654,
                        decimalPrecision: 0
                    },
                    type: 'NumberField',
                    filters: {pfiltro: 'tipar.tamano', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },


                {
                    config: {
                        name: 'ruta_guardar',
                        fieldLabel: 'Ruta Para Guardar (Puede ser vacio)',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 255
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'tipar.nombre', type: 'string'},
                    id_grupo: 1,
                    grid: true,
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
                    filters: {pfiltro: 'tipar.estado_reg', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'id_usuario_ai',
                        fieldLabel: '',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'tipar.id_usuario_ai', type: 'numeric'},
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
                    filters: {pfiltro: 'tipar.usuario_ai', type: 'string'},
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
                    filters: {pfiltro: 'tipar.fecha_reg', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
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
                    filters: {pfiltro: 'tipar.fecha_mod', type: 'date'},
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
                        name: 'orden',
                        fieldLabel: 'Orden',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 1179654,
                        decimalPrecision: 0
                    },
                    type: 'NumberField',
                    filters: {pfiltro: 'tipar.orden', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
            ],
            tam_pag: 50,
            title: 'Tipo Archivo',
            ActSave: '../../sis_parametros/control/TipoArchivo/insertarTipoArchivo',
            ActDel: '../../sis_parametros/control/TipoArchivo/eliminarTipoArchivo',
            ActList: '../../sis_parametros/control/TipoArchivo/listarTipoArchivo',
            id_store: 'id_tipo_archivo',
            fields: [
                {name: 'id_tipo_archivo', type: 'numeric'},
                {name: 'nombre_id', type: 'string'},
                {name: 'multiple', type: 'string'},
                {name: 'codigo', type: 'string'},
                {name: 'tipo_archivo', type: 'string'},
                {name: 'tabla', type: 'string'},
                {name: 'nombre', type: 'string'},
                {name: 'estado_reg', type: 'string'},
                {name: 'id_usuario_ai', type: 'numeric'},
                {name: 'usuario_ai', type: 'string'},
                {name: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'id_usuario_reg', type: 'numeric'},
                {name: 'fecha_mod', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'id_usuario_mod', type: 'numeric'},
                {name: 'usr_reg', type: 'string'},
                {name: 'usr_mod', type: 'string'},
                {name: 'extensiones_permitidas', type: 'string'},
                {name: 'ruta_guardar', type: 'string'},
                {name: 'tamano', type: 'string'},
                {name: 'orden', type: 'string'},
                {name: 'obligatorio', type: 'string'},

            ],
            sortInfo: {
                field: 'id_tipo_archivo',
                direction: 'ASC'
            },
            bdel: true,
            bsave: true,


            archivo: function () {


                var rec = this.getSelectedData();

                //enviamos el id seleccionado para cual el archivo se deba subir
                rec.datos_extras_id = rec.id_tipo_archivo;
                //enviamos el nombre de la tabla
                rec.datos_extras_tabla = 'ttipo_archivo';
                //enviamos el codigo ya que una tabla puede tener varios archivos diferentes como ci,pasaporte,contrato,slider,fotos,etc
                rec.datos_extras_codigo = 'archivo prueba';

                //esto es cuando queremos darle una ruta personalizada
                //rec.datos_extras_ruta_personalizada = './../../../uploaded_files/favioVideos/videos/';

                Phx.CP.loadWindows('../../../sis_parametros/vista/archivo/Archivo.php',
                    'Archivo',
                    {
                        width: 900,
                        height: 400
                    }, rec, this.idContenedor, 'Archivo');

            },

            exportar: function () {


                var rec = this.getSelectedData();

                alert( rec.id_tipo_archivo);
                Ext.Ajax.request({
                    url:'../../sis_parametros/control/TipoArchivo/exportarConfiguracion',
                    params:{id_tipo_archivo:rec.id_tipo_archivo},
                    success: this.successExport,

                    failure: this.conexionFailure,
                    timeout:this.timeout,
                    scope:this
                });


            },
        exportarSuccess : function (resp) {
            console.log(resp)
        },

            tabeast: [
                {
                    url: '../../../sis_parametros/vista/tipo_archivo_join/TipoArchivoJoin.php',
                    title: 'Join',
                    width: '40%',
                    cls: 'TipoArchivoJoin'
                },
                {
                    url: '../../../sis_parametros/vista/tipo_archivo_campo/TipoArchivoCampo.php',
                    title: 'Campos',
                    width: '40%',
                    cls: 'TipoArchivoCampo'
                },
                {
                    url: '../../../sis_parametros/vista/field_tipo_archivo/FieldTipoArchivo.php',
                    title: 'Field Tipo Archivo',
                    width: '40%',
                    cls: 'FieldTipoArchivo'
                },


            ],


        }
    )
</script>
		
		