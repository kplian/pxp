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
                        name: 'id_tipo_archivo'
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