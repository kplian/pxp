<?php
/**
 *@package pXP
 *@file    subirArchivoMultiple.php
 *@author  favio figueroa
 *@date    05-12-2016
 *@description permites subir archivos a la tabla de documento_sol
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.subirArchivoMultiple=Ext.extend(Phx.frmInterfaz,{
            ActSave:'../../sis_parametros/control/Archivo/subirArchivoMultiple',
            constructor:function(config)
            {
                Phx.vista.subirArchivoMultiple.superclass.constructor.call(this,config);
                this.init();
                this.loadValoresIniciales();
            },
            loadValoresIniciales:function()
            {
                Phx.vista.subirArchivoMultiple.superclass.loadValoresIniciales.call(this);
                this.getComponente('tabla').setValue(this.datos_extras_tabla);
                this.getComponente('id_tabla').setValue(this.datos_extras_id);
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
                    config: {
                        fieldLabel: "Documento (archivo)",
                        gwidth: 130,
                        inputType: 'file',
                        name: 'archivo[]',
                        allowBlank: false,
                        buttonText: '',
                        maxLength: 150,
                        anchor: '100%',
                        listeners: {
                            render: function (me, eOpts) {

                                var el = Ext.get(me.id);
                                console.log(el)
                                el.set({
                                    multiple: 'multiple'
                                });

                            }
                        }

                    },
                    type: 'Field',
                    form: true
                },

            ],
            title:'Subir Archivos',
            fileUpload:true

        }
    )
</script>