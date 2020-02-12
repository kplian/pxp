<?php
/**
 *@package pXP
 *@file FormGitHub.php
 *@author  MMV
 *@date 21/01/2019
 *@description permites registrar licencias
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.FormGitHub=Ext.extend(Phx.frmInterfaz,{

            constructor:function(config) {
                this.maestro = config;
                //llama al constructor de la clase padre
                Phx.vista.FormGitHub.superclass.constructor.call(this,config);
                this.init();
                // this.loadValoresIniciales();
            },
            loadValoresIniciales:function() {
                Phx.vista.FormGitHub.superclass.loadValoresIniciales.call(this);
                Ext.Ajax.request({
                    url: '../../sis_seguridad/control/Subsistema/obtenerFechaUltimoRegistro',
                    params: {
                        'id_subsistema': this.maestro.id_subsistema
                    },
                    success: this.respuestaValidacion,
                    failure: this.conexionFailure,
                    timeout: this.timeout,
                    scope: this
                });

            },
            respuestaValidacion: function (s){
              
                var response = s.responseText.split('%');
                var fecha = new Date(response[1]);
                this.Cmp.desde.setValue(new Date(response[1]));
                this.Cmp.desde.fireEvent('change');
                //obtener dia actual
                this.Cmp.hasta.setValue(new Date());
                this.Cmp.hasta.fireEvent('change');
            },
            successSave:function(resp){
                Phx.CP.loadingHide();
                Phx.CP.getPagina(this.idContenedorPadre).reload();
                this.panel.close();
            },
            Atributos:[
                {
                    //configuracion del componente
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_subsistema'
                    },
                    type:'Field',
                    form:true
                },
                {
                    config:{
                        name: 'desde',
                        fieldLabel: 'Desde',
                        allowBlank: false,
                        width: 130,
                        gwidth: 100,
                        format: 'd/m/Y'
                    },
                    type:'DateField',
                    form:true
                },
                {
                    config:{
                        name: 'hasta',
                        fieldLabel: 'Hasta',
                        allowBlank: false,
                        width: 130,
                        gwidth: 100,
                        format: 'd/m/Y'
                    },
                    type:'DateField',
                    id_grupo:1,
                    form:true
                }
            ],
            tam_pag:50,
            title:'Formulario',
            ActSave:'../../sis_seguridad/control/Subsistema/importarApiGitHub'
        }
    )

</script>