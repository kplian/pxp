<?php
/**
*@package pXP
*@file gen-CertificadoPlanilla.php
*@author  (MMV)
*@date 24-07-2017 14:48:34
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.CertificadoPlanilla = {
        require: '../../../sis_organigrama/vista/certificado_planilla/Certificado.php',
        requireclase: 'Phx.vista.Certificado',
        title: 'Certificado',
        nombreVista: 'CertificadoPlanilla',
        constructor: function (config) {
            Phx.vista.CertificadoPlanilla.superclass.constructor.call(this, config);
            this.store.baseParams={tipo_interfaz:this.nombreVista};
            this.store.baseParams.pes_estado = 'borrador';
            this.load({params:{start:0, limit:this.tam_pag}});
            this.getBoton('ant_estado').setVisible(false);
            this.finCons = true;
        },
        gruposBarraTareas:[
            {name:'borrador',title:'<H1 align="center"><i class="fa fa-list-ul"></i> Borrador</h1>',grupo:0,height:0},
            {name:'emitido',title:'<H1 align="center"><i class="fa fa-list-ul"></i> Emitido</h1>',grupo:2,height:0}
        ],

        actualizarSegunTab: function(name, indice){
            if(this.finCons){
                this.store.baseParams.pes_estado = name;
                if(name == 'emitido' ){
                    this.getBoton('ant_estado').setVisible(true);
                }else{
                    this.getBoton('ant_estado').setVisible(false);
                }
                this.load({params:{start:0, limit:this.tam_pag}});
            }
        },
        beditGroups: [0,2],
        bdelGroups:  [0,2],
        bactGroups:  [0,2],
        bexcelGroups: [0,2]
    }
</script>

