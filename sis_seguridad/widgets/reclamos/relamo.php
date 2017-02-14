<?php
/**
 *@package pXP
 *@file gen-Depto.php
 *@author  )
 *@date 24-11-2011 15:52:20
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Ext.define('Phx.vista.widget.UsuariosLogin',{
        extend: 'Ext.util.Observable',
        constructor: function(config){
            console.log('config', config)

            Ext.apply(this, config)

            this.callParent(arguments);
            this.panel = Ext.getCmp(this.idContenedor);


            this.panel.add({
                autoHeight: true,
                autoScroll : true,
                text: 'Loading...',
                html : 	'<iframe id:"iframe" src="../../../sis_seguridad/widgets/reclamos/index.html"  scrolling="no"  align="center" width = "100%" height="400px" frameborder="0" onload="resizeIframe(this)"></iframe>'

            });

            this.panel.on('refresh', this.onRefresh, this);



        },
        init:function() {
            this.panel.doLayout();
            //this.panel.show();

        } ,
        onRefresh: function(){
            this.panel.getEl().child('iframe').dom.contentWindow.location.reload()

        }

    });
</script>
