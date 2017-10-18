<?php
/**
 *@package pXP
 *@file gen-CertificadoEmetido.php
 *@author  (MMV)
 *@date 24-07-2017 14:48:34
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.CertificadoEmetido = {
        require: '../../../sis_organigrama/vista/certificado_planilla/Certificado.php',
        requireclase: 'Phx.vista.Certificado',
        title: 'CertificadoPlanilla',
        nombreVista: 'CertificadoEmitido',
        constructor: function (config) {

            Phx.vista.CertificadoEmetido.superclass.constructor.call(this, config);
            this.store.baseParams={tipo_interfaz:this.nombreVista};
            this.load({params:{start:0, limit:this.tam_pag}});

        },


        preparaMenu:function(n){
            var data = this.getSelectedData();
            var tb =this.tbar;
            Phx.vista.CertificadoEmetido.superclass.preparaMenu.call(this,n);

            if( data['impreso'] ==  'no'){
                this.getBoton('btnImprimir').enable();
                this. enableTabDetalle();
            }
            return tb;
        },

        liberaMenu:function(){
            var tb = Phx.vista.CertificadoEmetido.superclass.liberaMenu.call(this);
            if(tb){
                this.getBoton('btnImprimir').disable();
                this.getBoton('btnChequeoDocumentosWf').setVisible(false);
                this.getBoton('ant_estado').setVisible(false);
                this.getBoton('sig_estado').setVisible(false);

            }
            return tb;
        },

        imprimirNota: function(){
            var rec = this.sm.getSelected(),
                data = rec.data,
                me = this;
            if(confirm("¿Esta seguro de Imprimir el Certificado?") ){
                Phx.CP.loadingShow();
                Ext.Ajax.request({
                    url : '../../sis_organigrama/control/CertificadoPlanilla/reporteCertificadoHtml',
                    params : {
                        'id_proceso_wf' : data.id_proceso_wf,
                        'impreso':'si'
                    },
                    success : me.successExportHtml,
                    failure : me.conexionFailure,
                    timeout : me.timeout,
                    scope : me
                });
            }

            this.load({params:{start:0, limit:this.tam_pag}});
        },
        successExportHtml: function (resp) {
            Phx.CP.loadingHide();
            var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            var objetoDatos = (objRes.ROOT == undefined)?objRes.datos:objRes.ROOT.datos;
            var wnd = window.open("about:blank", "", "_blank");
            wnd.document.write(objetoDatos.html);

        },
        bnew:false,
        bedit:false,
        bdel:false
    }
</script>