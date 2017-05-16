<?php
/**
 *@package pXP
 *@file    SubirArchivo.php
 *@author  favio figueroa
 *@date    05-12-2016
 *@description permites subir archivos a la tabla de documento_sol
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.subirArchivo=Ext.extend(Phx.frmInterfaz,{
            ActSave:'../../sis_parametros/control/Archivo/subirArchivo',

            constructor:function(config)
            {
                Phx.vista.subirArchivo.superclass.constructor.call(this,config);

                this.init();
                this.loadValoresIniciales();
            },
            loadValoresIniciales:function()
            {
                Phx.vista.subirArchivo.superclass.loadValoresIniciales.call(this);
                this.getComponente('tabla').setValue(this.datos_extras_tabla);
                this.getComponente('id_tabla').setValue(this.datos_extras_id);
                this.getComponente('id_tipo_archivo').setValue(this.datos_extras_id_tipo_archivo);

                //si la ruta perzonalizada se envia desde la vista entonces debemos agregarlo al submit
                this.argumentExtraSubmit={'ruta_perzonalizada':this.datos_extras_ruta_personalizada};


                this.Cmp.id_tipo_archivo.hide();
                this.Cmp.nombre_descriptivo.hide();

                if(this.datos_extras_multiple == 'si'){

                    this.Cmp.id_tipo_archivo.show();
                    this.Cmp.nombre_descriptivo.show();

                    this.Cmp.multiple.setValue('si');

                    this.Cmp.id_tipo_archivo.store.baseParams.tabla = this.datos_extras_tabla;
                    this.Cmp.id_tipo_archivo.store.baseParams.multiple = 'si';

                }else{
                    this.Cmp.id_tipo_archivo.hide();
                    this.Cmp.nombre_descriptivo.hide();

                    this.getComponente('id_tipo_archivo').setValue(this.datos_extras_id_tipo_archivo);

                }
            },
            successSave:function(resp)
            {
                console.log('resp',resp);
                Phx.CP.loadingHide();
                Phx.CP.getPagina(this.idContenedorPadre).reload();
                this.panel.close();
            },
            Atributos:[
                {
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_tabla'
                    },
                    type:'Field',
                    form:true
                },


                {
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'tabla'
                    },
                    type:'Field',
                    form:true
                },


                {
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'multiple'
                    },
                    type:'Field',
                    form:true
                },
                {
                    config: {
                        name: 'id_tipo_archivo',
                        fieldLabel: 'Tipo Archivo',
                        allowBlank: true,
                        emptyText: 'Elija una opción...',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_parametros/control/TipoArchivo/listarTipoArchivo',
                            id: 'id_tipo_archivo',
                            root: 'datos',
                            sortInfo: {
                                field: 'nombre',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_tipo_archivo', 'tabla','codigo','nombre','multiple'],
                            remoteSort: true,
                            baseParams: {par_filtro: 'tipar.nombre'}
                        }),
                        valueField: 'id_tipo_archivo',
                        displayField: 'nombre',
                        gdisplayField: 'desc_marca',
                        hiddenName: 'id_tipo_archivo',
                        forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '100%',
                        gwidth: 150,
                        minChars: 2,
                        renderer : function(value, p, record) {
                            return String.format('{0}', record.data['desc_marca']);
                        }
                    },
                    type: 'ComboBox',
                    id_grupo: 0,
                    filters: {pfiltro: 'marc.nombre',type: 'string'},
                    grid: true,
                    form: true
                },

                {
                    config:{
                        name: 'nombre_descriptivo',
                        fieldLabel: 'Nombre Descriptivo',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength:255,
                        renderer:function (value, p, record, rowIndex, colIndex){
                            return value;

                        },
                    },
                    type:'TextField',
                    filters:{pfiltro:'tipar.nombre_descriptivo',type:'string'},
                    id_grupo:1,
                    grid:false,
                    form:true
                },


                {
                    config:{
                        fieldLabel: "Documento (depende de tu configuracion)",
                        gwidth: 130,
                        inputType: 'file',
                        name: 'archivo',
                        allowBlank: false,
                        buttonText: '',
                        maxLength: 150,
                        anchor:'100%'
                    },
                    type:'Field',
                    form:true
                },
            ],
            title:'Subir Archivo',
            fileUpload:true

        }
    )
</script>